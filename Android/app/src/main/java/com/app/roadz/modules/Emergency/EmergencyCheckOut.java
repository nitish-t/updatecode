package com.app.roadz.modules.Emergency;

import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.core.widget.NestedScrollView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.BaseController;
import com.app.roadz.model.BaseModel.BaseModel;
import com.app.roadz.model.BaseModel.ListBaseResponse;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.BaseModel.SubscribeResponse;
import com.app.roadz.model.TCar;
import com.app.roadz.model.TCoupon;
import com.app.roadz.model.TPackage;
import com.app.roadz.model.TSubscription;
import com.app.roadz.modules.Home.HomeActivity_;
import com.app.roadz.modules.Setting.StaticDataActivity_;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.pedant.SweetAlert.SweetAlertDialog;
import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_emergency_checkout)
public class EmergencyCheckOut extends BaseActivity {

    @Extra
    boolean fromRegister;
    @Extra
    String fromcar = "";
    @Extra
    String number = "";
    @Extra
    TCar tCar;
    @Extra
    TPackage tPackage;
    @SystemService
    LayoutInflater mLayoutInflater;
    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;
    @ViewById(R.id.car_model_txt)
    protected TextView car_model_txt;
    @ViewById(R.id.subscription_start_date_txt)
    protected TextView subscription_start_date_txt;
    @ViewById(R.id.subscription_end_date_txt)
    protected TextView subscription_end_date_txt;
    @ViewById(R.id.total_price_txt)
    protected TextView total_price_txt;
    @ViewById(R.id.priseTxt)
    protected TextView priseTxt;
    @ViewById(R.id.visaLayout)
    public LinearLayout visaLayout;
    @ViewById(R.id.knetLayout)
    public LinearLayout knetLayout;
    @ViewById(R.id.edtPromoCode)
    public EditText edtPromoCode;
    @ViewById(R.id.discountValue)
    public TextView discountValue;
    @ViewById(R.id.segmantView)
    public LinearLayout segmantView;
    @ViewById(R.id.scrollView)
    public NestedScrollView scrollView;

    Calendar subscriptionDate;
    Calendar subscriptionEndDate;

    float discount_percentage = 0;
    String coponSelect = null;
    double prise = 0;

    String OrderID;
    String OrderLink;
    TSubscription subscription;


    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(getString(R.string.checkout));

        segmantView.setVisibility(View.INVISIBLE);
        scrollView.setVisibility(View.INVISIBLE);
        if (fromRegister) {
            getCars();
        }else if (!fromcar.isEmpty()) {
            getCars();
        } else {
            initViews();
        }

    }

    private void getCars() {
        ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).getCars().enqueue(new BaseCallback<ListBaseResponse<TCar>>() {
            @Override
            public void onResponse(Call<ListBaseResponse<TCar>> call, retrofit2.Response<ListBaseResponse<TCar>> response) {
                HideProgress();
                if (response.body() != null) {
                    List<TCar> ObjectList = response.body().getList();
                    if (ObjectList != null && !ObjectList.isEmpty()) {
                        if (fromcar.isEmpty()) {
                            tCar = ObjectList.get(0);
                        }else {
                            for(int  i = 0; i<ObjectList.size();i++){
                                if (String.valueOf(ObjectList.get(i).getCarMakerId()).equals(fromcar)){
                                    tCar = ObjectList.get(i);
                                }
                            }
                        }
                        GetPakageList();
                        return;
                    }
                }

                MainApplication.Toast(getString(R.string.unexpected_error), SweetAlertDialog.ERROR_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        EmergencyCheckOut.this.finish();
                        HomeActivity_.intent(EmergencyCheckOut.this).
                                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
                    }
                });
            }

            @Override
            public void onFailure(Call<ListBaseResponse<TCar>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                HideProgress();
                EmergencyCheckOut.this.finish();
                MainApplication.Toast(getString(R.string.unexpected_error), SweetAlertDialog.ERROR_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        HomeActivity_.intent(EmergencyCheckOut.this).
                                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
                    }
                });
            }
        });
    }

    private void GetPakageList() {
        ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).getPackages().enqueue(new BaseCallback<ListBaseResponse<TPackage>>() {
            @Override
            public void onResponse(Call<ListBaseResponse<TPackage>> call, Response<ListBaseResponse<TPackage>> response) {
                HideProgress();
                if (response.body() != null) {
                    List<TPackage> tPackages = response.body().getList();
                    for (TPackage object : tPackages) {
                        if ("emergency".equalsIgnoreCase(object.getType())) {
                            tPackage = object;
                            break;
                        }
                    }
                }
                initViews();
            }

            @Override
            public void onFailure(Call<ListBaseResponse<TPackage>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                HideProgress();
                initViews();
            }
        });
    }

    private void initViews() {

        segmantView.setVisibility(fromRegister ? View.VISIBLE : View.GONE);
        scrollView.setVisibility(View.VISIBLE);

        if (tCar != null) {
            car_model_txt.setText(tCar.getCarName());
            Log.d("qwerty",tCar.getCarName());
        } else {
            car_model_txt.setText("");
        }
        subscriptionDate = Calendar.getInstance();
        subscriptionDate.add(Calendar.DAY_OF_MONTH, 2);
        subscriptionEndDate = Calendar.getInstance();
        subscriptionEndDate.add(Calendar.DAY_OF_MONTH ,+1);
        subscriptionEndDate.add(Calendar.YEAR, 1);
        subscription_start_date_txt.setText(Constants.GetDateString(subscriptionDate.getTime(), "dd/MM/yyyy"));
        subscription_end_date_txt.setText(Constants.GetDateString(subscriptionEndDate.getTime(), "dd/MM/yyyy"));

        if (tPackage != null) {
            prise = tPackage.getPrice();
            total_price_txt.setText(Constants.GetPrise(Utils.doublefmt(tPackage.getPrice()), this));
            Log.d("vusgfk","asdfqwre");
        } else {
            total_price_txt.setText("");
            Log.d("vusgfk","asdf");

        }
        UpdatePrise();
    }


    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        if (fromRegister) {
            this.finish();
            HomeActivity_.intent(this).
                    flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public void onBackPressed() {
        toolbar_back();
    }

    @Click(R.id.payBtn)
    protected void payBtn() {
//        MainApplication.Toast2(getString(R.string.subscribe_Package_confirm), SweetAlertDialog.NORMAL_TYPE, new Runnable() {
//            @Override
//            public void run() {
//                MakeSubscription();
//            }
//        });

        MakeSubscription();

    }

    private void MakeSubscription() {
        Map<String, String> stringStringMap = new HashMap<>();
        if (!TextUtils.isEmpty(coponSelect))
            stringStringMap.put("coupon", edtPromoCode.getText().toString());
        if (tPackage != null)
            stringStringMap.put("package_id", tPackage.getId() + "");
        if (tCar != null)
            stringStringMap.put("car_id", tCar.getId() + "");
        ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).MakeSubscription(stringStringMap).enqueue(new BaseCallback<ObjectBaseResponse<SubscribeResponse>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<SubscribeResponse>> call, Response<ObjectBaseResponse<SubscribeResponse>> response) {
                HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                    return;
                }

                if (!response.body().getStatus()) {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage());
                    } else {
                        MainApplication.ErrorToast();
                    }
                    return;
                }

                SubscribeResponse subscribeResponse = response.body().getObject();
                if (subscribeResponse != null) {
                    OrderID = subscribeResponse.getOrderId();
                    OrderLink = subscribeResponse.getLink();
                    subscription = subscribeResponse.getSubscription();
                    ShowWebDialog(false);
                } else {
                    MainApplication.ErrorToast();
                }
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<SubscribeResponse>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        });
    }

    private void ShowWebDialog(boolean isOld) {
//        MainApplication.Toast(getResources().getString(R.string.Complete_checkout), isOld ? getResources().getString(R.string.complete_checkout_previous_order_msg) : getResources().getString(R.string.Complete_checkout_msg), SweetAlertDialog.NORMAL_TYPE, new Runnable() {
//            @Override
//            public void run() {
//                try {
                    StaticDataActivity_.intent(EmergencyCheckOut.this).Type(4).Url(OrderLink).start();
//                    Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(OrderLink));
//                    startActivity(intent);
//                } catch (Exception ex) {
//                    MainApplication.ErrorToast();
//                }
//            }
//        });
    }

    @Override
    protected void onResume() {
        super.onResume();

        if (!TextUtils.isEmpty(OrderID)) {
            CheckPayment();
        }
    }

    public void CheckPayment() {
        Map<String, String> stringStringMap = new HashMap<>();
        stringStringMap.put("order_id", OrderID);
        ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).CheckPayment(stringStringMap).enqueue(new BaseCallback<BaseModel>() {

            @Override
            public void onResponse(Call<BaseModel> call, Response<BaseModel> response) {
                HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                    return;
                }

                if (!response.body().getStatus()) {
//                    ShowWebDialog(true);
//                    EmergencyPaymentStatus_.intent(EmergencyCheckOut.this).tSubscription(subscription).OrderID(OrderID).OrderLink(OrderLink).IsSuccess(false).start();
                } else {
                    EmergencyPaymentStatus_.intent(EmergencyCheckOut.this).tSubscription(subscription).OrderID(OrderID).OrderLink(OrderLink).IsSuccess(true).start();
                }


            }

            @Override
            public void onFailure(Call<BaseModel> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        });
    }


//    @Click(R.id.visaLayout)
//    protected void visaLayout() {
//        visaLayout.setSelected(true);
//        knetLayout.setSelected(false);
//    }
//
//    @Click(R.id.knetLayout)
//    protected void knetLayout() {
//        visaLayout.setSelected(false);
//        knetLayout.setSelected(true);
//    }


    @Click(R.id.applyBtn)
    protected void applyBtn() {
        if (TextUtils.isEmpty(edtPromoCode.getText().toString())) {
            discount_percentage = 0;
            discountValue.setVisibility(View.GONE);
            coponSelect = null;
            UpdatePrise();
            return;
        }
        Map<String, String> stringStringMap = new HashMap<>();
        stringStringMap.put("coupon", edtPromoCode.getText().toString());
        ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).CheckCoupon(stringStringMap).enqueue(new BaseCallback<ObjectBaseResponse<TCoupon>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<TCoupon>> call, Response<ObjectBaseResponse<TCoupon>> response) {
                HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                    return;
                }
                if (!response.body().getStatus()) {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage());
                    } else {
                        MainApplication.ErrorToast();
                    }
                    return;
                }

                if (response.body().getObject() != null) {
                    discount_percentage = response.body().getObject().getDiscountPercentage();
                    coponSelect = response.body().getObject().getCoupon();
                    discountValue.setVisibility(View.VISIBLE);
                    discountValue.setText(String.format(getResources().getString(R.string.discount), discount_percentage + "") + "%");
                    UpdatePrise();
                } else {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage());
                    } else {
                        MainApplication.ErrorToast();
                    }
                }
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TCoupon>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        });

    }

    private void UpdatePrise() {
        double totlePrise = prise - (prise * (discount_percentage / 100));
        if (Utils.doublefmt(totlePrise).contains(".000")){
            String newString  =  Utils.doublefmt(totlePrise);
            String anewString = newString.replace(".000", "");
            priseTxt.setText(String.format(getResources().getString(R.string.Tota_prise_val), anewString)+" "+getResources().getString(R.string.KD));
        }else{
            priseTxt.setText(String.format(getResources().getString(R.string.Tota_prise_val), Utils.doublefmt(totlePrise))+" "+getResources().getString(R.string.KD));
        }

    }


}
