package com.app.roadz.modules.Emergency;

import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.widget.ImageView;
import android.widget.TextView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.BaseController;
import com.app.roadz.model.BaseModel.BaseModel;
import com.app.roadz.model.TSubscription;
import com.app.roadz.modules.Home.HomeActivity_;
import com.app.roadz.modules.MyCars.AddCarActivity;
import com.app.roadz.modules.Setting.StaticDataActivity_;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.HashMap;
import java.util.Map;

import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_emergency_payment_status)
public class EmergencyPaymentStatus extends BaseActivity {

    @Extra
    boolean IsSuccess = true;

    @Extra
    TSubscription tSubscription;

    @SystemService
    LayoutInflater mLayoutInflater;

    @Extra
    String OrderID;

    @Extra
    String OrderLink;


    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;

    @ViewById(R.id.image)
    protected ImageView image;

    @ViewById(R.id.actionBtn)
    protected TextView actionBtn;

    @ViewById(R.id.order_id_txt)
    protected TextView order_id_txt;

    @ViewById(R.id.car_model_txt)
    protected TextView car_model_txt;

    @ViewById(R.id.subscription_date_txt)
    protected TextView subscription_date_txt;

    @ViewById(R.id.subscription_expiry_date_txt)
    protected TextView subscription_expiry_date_txt;

    @ViewById(R.id.total_price_txt)
    protected TextView total_price_txt;

    String OrderIDToCheck;


    @AfterViews
    protected void AfterViews() {

        if (IsSuccess) {
            image.setImageResource(R.drawable.ic_payment_sucsses);
            toolbar_title.setText(getString(R.string.payment_success));
            actionBtn.setText(R.string.done);
            actionBtn.setBackgroundResource(R.drawable.btn_bg);
        } else {
            image.setImageResource(R.drawable.ic_payment_fail);
            toolbar_title.setText(getString(R.string.payment_decline));
            actionBtn.setText(getString(R.string.try_again));
            actionBtn.setBackgroundResource(R.drawable.decline_btn_bg);
        }

        if (tSubscription != null) {
            InitData();
        }

    }

    private void InitData() {

        order_id_txt.setText(OrderID);
        if (tSubscription.getCar() != null) {
            car_model_txt.setText(tSubscription.getCar().getCarName());
        } else {
            car_model_txt.setText("");
        }

        subscription_date_txt.setText(Constants.GetStringDateFromString(tSubscription.getSubscriptionStart(), "yyyy-MM-dd", "dd / MM / yyyy"));
        subscription_expiry_date_txt.setText(Constants.GetStringDateFromString(tSubscription.getSubscriptionEnd(), "yyyy-MM-dd", "dd / MM / yyyy"));
        total_price_txt.setText(Constants.GetPrise(Utils.doublefmt(tSubscription.getFinalTotal()), this));
        Log.d("vusgfk",tSubscription.getFinalTotal()+"");
    }


    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
//        goHome();
        finish();
        EmergencyCheckOut_.intent(EmergencyPaymentStatus.this).
                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).fromRegister(true).start();
    }

    @Override
    public void onBackPressed() {
        /*goHome();*/
        EmergencyCheckOut_.intent(EmergencyPaymentStatus.this).
                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).fromRegister(true).start();
    }

    @Click(R.id.actionBtn)
    protected void actionBtn() {
        if (IsSuccess) {
            goHome();
        } else {
           /* OrderIDToCheck = OrderID;
            StaticDataActivity_.intent(this).Type(4).Url(OrderLink).start();*/
            EmergencyCheckOut_.intent(EmergencyPaymentStatus.this).
                    flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).fromRegister(true).start();
        }
    }

    private void goHome(){
        this.finish();
        HomeActivity_.intent(this).
                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (!IsSuccess && !TextUtils.isEmpty(OrderIDToCheck)) {
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

                IsSuccess = response.body().getStatus();
                OrderIDToCheck = null;
                AfterViews();


            }

            @Override
            public void onFailure(Call<BaseModel> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        });
    }


}
