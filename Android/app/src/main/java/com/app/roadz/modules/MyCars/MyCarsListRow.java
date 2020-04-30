package com.app.roadz.modules.MyCars;

import android.annotation.SuppressLint;
import android.content.Context;
import android.text.Editable;
import android.text.InputType;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.recyclerview.widget.RecyclerView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.BaseController;
import com.app.roadz.controller.UserController;
import com.app.roadz.model.BaseModel.BaseModel;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.BaseModel.SubscribeResponse;
import com.app.roadz.model.TCar;
import com.app.roadz.model.UpdatePlateModel;
import com.app.roadz.modules.Emergency.EmergencyCheckOut_;
import com.app.roadz.modules.base.BaseActivity;
import com.app.roadz.recyclerview.ViewBinder;
import com.szagurskii.patternedtextwatcher.PatternedTextWatcher;

import net.cachapa.expandablelayout.ExpandableLayout;

import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.HashMap;
import java.util.Map;

import cn.pedant.SweetAlert.SweetAlertDialog;
import retrofit2.Call;
import retrofit2.Response;

@EView
public class MyCarsListRow extends LinearLayout implements ViewBinder<Object>, View.OnClickListener {

    @ViewById(R.id.tv_title)
    protected TextView tv_title;
    @ViewById(R.id.btn_pay)
    protected Button btn_pay;
    @ViewById(R.id.tv_status)
    protected TextView tv_status;
    @ViewById(R.id.tv_plate_number)
    protected TextView tv_plate_number;
    @ViewById(R.id.tv_car_color)
    protected TextView tv_car_color;
    @ViewById(R.id.tv_subscription_started)
    protected TextView tv_subscription_started;
    @ViewById(R.id.tv_subscription_end)
    protected TextView tv_subscription_end;
    @ViewById(R.id.tv_OrderID)
    protected TextView tv_OrderID;
    @ViewById(R.id.expandable_layout)
    protected ExpandableLayout expandable_layout;
    @ViewById(R.id.indicatorIcon)
    protected ImageView indicatorIcon;
    @ViewById(R.id.no_subscription_layout)
    protected LinearLayout no_subscription_layout;
    @ViewById(R.id.subscription_layout)
    protected LinearLayout subscription_layout;


    @ViewById(R.id.llcardplate)
    protected LinearLayout llcardplate;

    @ViewById(R.id.etcarplatenumb)
    protected EditText etcarplatenumb;

    @ViewById(R.id.btn_add)
    protected Button btn_add;


    @SystemService
    LayoutInflater mLayoutInflater;
    TCar object;
    Context context;

    public MyCarsListRow(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.context = context;
        Init();
    }

    public MyCarsListRow(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        Init();
    }

    private void Init() {
        this.setOnClickListener(this);
    }

    @SuppressLint("SetTextI18n")
    @Override
    public void bindViews(Object obj, int position, RecyclerView recyclerView) {
        object = (TCar) obj;
        if (object == null) return;
        if (object.getPlateNumber() == null) {
            tv_plate_number.setVisibility(GONE);
            llcardplate.setVisibility(VISIBLE);
        } else {
            tv_plate_number.setVisibility(VISIBLE);
            llcardplate.setVisibility(GONE);
            tv_plate_number.setText(object.getPlateNumber());
        }
        tv_title.setText(object.getCarName());
        tv_car_color.setText(object.getColor());

        if (object.getSubscription() != null) {
            if (object.getSubscription().getB_payed().equals("1")) {
                Log.d("vishal;", object.getSubscription().getB_payed() + "123");
                if (object.getSubscription().getStatus().equals("not_active")) {
                    tv_status.setText(R.string.not_active);
                    tv_status.setTextColor(getResources().getColor(R.color.edt_color));
                } else {
                    Log.d("vishal;", object.getSubscription().getB_payed() + "12345");
                    tv_status.setText(R.string.active);
                    tv_status.setTextColor(getResources().getColor(R.color.colorAccent));
                }

                btn_pay.setVisibility(GONE);
                no_subscription_layout.setVisibility(GONE);
                subscription_layout.setVisibility(VISIBLE);
                tv_OrderID.setVisibility(VISIBLE);
//                tv_status.setText(object.getSubscription().getStatus());
                tv_OrderID.setText(object.getSubscription().getRef_id());
                tv_subscription_started.setText(Constants.GetStringDateFromString(object.getSubscription().getSubscriptionStart(), "yyyy-MM-dd", "dd / MM / yyyy"));
                tv_subscription_end.setText(Constants.GetStringDateFromString(object.getSubscription().getSubscriptionEnd(), "yyyy-MM-dd", "dd / MM / yyyy"));
            } else {
                btn_pay.setVisibility(VISIBLE);
                tv_status.setText(R.string.notpaid);
                tv_status.setTextColor(getResources().getColor(R.color.main_red_color));
                no_subscription_layout.setVisibility(VISIBLE);
                subscription_layout.setVisibility(GONE);
                tv_OrderID.setVisibility(GONE);
            }
        } else {
            btn_pay.setVisibility(VISIBLE);
            tv_status.setText(R.string.notpaid);
            tv_status.setTextColor(getResources().getColor(R.color.main_red_color));
            no_subscription_layout.setVisibility(VISIBLE);
            subscription_layout.setVisibility(GONE);
            tv_OrderID.setVisibility(GONE);
        }

        etcarplatenumb.addTextChangedListener(new PatternedTextWatcher("## - ###############################################################"));
       /* etcarplatenumb.addTextChangedListener(new TextWatcher() {
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                if (s.length() > 2) {
                    etcarplatenumb.setInputType(InputType.TYPE_CLASS_NUMBER);
                } else {
                    etcarplatenumb.setInputType(InputType.TYPE_CLASS_TEXT);
                }

                // TODO Auto-generated method stub
            }

            @Override
            public void beforeTextChanged(CharSequence charSequence, int start, int count, int after) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                // TODO Auto-generated method stub
            }
        });*/
    }

    @Click(R.id.titleView)
    protected void titleView() {
        if (expandable_layout.isExpanded()) {
            expandable_layout.collapse();
            indicatorIcon.animate().rotation(0).setDuration(500).start();
        } else {
            expandable_layout.expand();
            indicatorIcon.animate().rotation(MainApplication.ISlocaleArabic(context) ? -180 : 180).setDuration(500).start();
        }
    }

    @Click(R.id.btn_pay)
    protected void btn_pay() {
        EmergencyCheckOut_.intent(context).fromcar(String.valueOf(object.getCarMakerId())).start();
    }

    @Click(R.id.btn_add)
    protected void Btn_add() {
        if (etcarplatenumb.getText().toString().isEmpty()) {
            Toast.makeText(context, R.string.plate_number, Toast.LENGTH_LONG).show();
        } else {
            UpdatePlate(etcarplatenumb.getText().toString(), String.valueOf(object.getId()), tv_plate_number, llcardplate);
        }

    }

    public void CheckSubscription() {
        Map<String, String> stringStringMap = new HashMap<>();
        stringStringMap.put("car_id", object.getId() + "");
        ((BaseActivity) getContext()).ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).CheckSubscription(stringStringMap).enqueue(new BaseCallback<ObjectBaseResponse<SubscribeResponse>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<SubscribeResponse>> call, Response<ObjectBaseResponse<SubscribeResponse>> response) {
                ((BaseActivity) getContext()).HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                    return;
                }
//               202 => false , Subscription Expired اشترراك مخلص بقدر اعمل اشتراك جديد
//               201 => true , you can add new subscription ما عندي اشترراك اصلا وبقدر اعمل اشتراك جديد
//               200 => true , you make order now for one service مشترك وبقد اضيف خدمة
//               203 => false , Your request has been submitted to follow up please call مشترك وضايف خدمة يعني ما بقدر اسوي شي

                if (response.body().getCode() == 200 || response.body().getCode() == 203) {
                    DeleteMSg(true);
                } else {
                    DeleteMSg(false);
                }
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<SubscribeResponse>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                ((BaseActivity) getContext()).HideProgress();
            }
        });
    }

    @Click(R.id.deleteLLayout)
    protected void deleteLLayout() {
        CheckSubscription();

    }

    protected void DeleteMSg(boolean isSubscription) {
        if (isSubscription) {
            Utils.ShowMessagePopup(getResources().getString(R.string.error), getContext().getString(R.string.car_already_subscribed), getContext(), mLayoutInflater, new Runnable() {
                @Override
                public void run() {
                    DeleteCar();
                }
            });
        } else {
            Utils.ShowMessagePopup(true, getContext().getString(R.string.delete_car_confirm) + " " + object.getCarName() + " ?", getContext(), mLayoutInflater, new Runnable() {
                @Override
                public void run() {
                    DeleteCar();
                }
            });

//            MainApplication.Toast2(getContext().getString(R.string.delete_car_confirm), SweetAlertDialog.NORMAL_TYPE, new Runnable() {
//                @Override
//                public void run() {
//
//                    DeleteCar();
//                }
//            });
        }
    }

    public void DeleteCar() {
        ((BaseActivity) getContext()).ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).DeleteCar(object.getId()).enqueue(new BaseCallback<BaseModel>() {

            @Override
            public void onResponse(Call<BaseModel> call, Response<BaseModel> response) {
                ((BaseActivity) getContext()).HideProgress();
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

                String msg = getContext().getString(R.string.car_delete_successfully);
                if (!TextUtils.isEmpty(response.body().getMessage())) {
                    msg = response.body().getMessage();
                }
                MainApplication.Toast(msg, SweetAlertDialog.SUCCESS_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        if (getContext() instanceof MyCarsListActivity) {
                            ((MyCarsListActivity) getContext()).onRefresh();
                        }
                    }
                });
            }

            @Override
            public void onFailure(Call<BaseModel> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                ((BaseActivity) getContext()).HideProgress();
            }
        });
    }

    @Override
    public void onClick(View v) {
    }


    protected void UpdatePlate(final String platenumber, String id, final TextView tv_plate_number, final LinearLayout linearLayout) {
        ((BaseActivity) getContext()).ShowProgress();
        BaseCallback<UpdatePlateModel> callback = new BaseCallback<UpdatePlateModel>() {

            @Override
            public void onResponse(Call<UpdatePlateModel> call, Response<UpdatePlateModel> response) {
                ((BaseActivity) getContext()).HideProgress();
                try {
                    if (response.body().getCode().equals("200")) {
                      /*  linearLayout.setVisibility(GONE);
                        tv_plate_number.setVisibility(VISIBLE);
                        tv_plate_number.setText(platenumber);*/
                        ((MyCarsListActivity) getContext()).onRefresh();
                    }

                } catch (Exception e) {

                }
            }

            @Override
            public void onFailure(Call<UpdatePlateModel> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
//                HideProgress();
                ((BaseActivity) getContext()).HideProgress();
            }
        };

        Map<String, String> map1 = new HashMap<>();
        map1.put("plate_number", platenumber);
        map1.put("carId", id);
        RetrofitHelper.getRetrofit().create(UserController.class).UpdatePlate(map1).enqueue(callback);

    }
}
