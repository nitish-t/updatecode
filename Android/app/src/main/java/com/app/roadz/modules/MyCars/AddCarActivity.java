package com.app.roadz.modules.MyCars;

import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.widget.TextView;

import com.app.roadz.R;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.BaseController;
import com.app.roadz.model.BaseModel.BaseModel;
import com.app.roadz.modules.Emergency.EmergencyCheckOut_;
import com.app.roadz.modules.User.SignUp.SignUpActivity;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.Map;

import cn.pedant.SweetAlert.SweetAlertDialog;
import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_add_car_list)
public class AddCarActivity extends BaseActivity {

    @SystemService
    LayoutInflater mLayoutInflater;


    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;


    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(getString(R.string.add_car));

    }


    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        Intent returnIntent = new Intent();
        setResult(Activity.RESULT_CANCELED, returnIntent);
        finish();
    }

    @Override
    public void onBackPressed() {
        toolbar_back();
    }

    public void SendAction(Map<String, String> map) {
        ShowProgress();
        BaseCallback<BaseModel> callback = new BaseCallback<BaseModel>() {

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
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        if (response.body().getMessage().contains("plate number")) {
                            if (MainApplication.getLang(AddCarActivity.this).equals("ar")) {
                                MainApplication.Toast("رقم اللوحة مستخدم مسبقا");
                            } else {
                                MainApplication.Toast("The plate number is already exist");
                            }
                        } else {
                            MainApplication.Toast(response.body().getMessage());
                        }
                    } else {
                        MainApplication.ErrorToast();
                    }
                    return;
                }

                EmergencyCheckOut_.intent(AddCarActivity.this).
                        flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).fromRegister(true).start();

            /*    String msg = getString(R.string.car_added_successfully);
//                if (!TextUtils.isEmpty(response.body().getMessage())) {
//                    msg = response.body().getMessage();
//                }
                MainApplication.Toast(msg, SweetAlertDialog.SUCCESS_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        Intent returnIntent = new Intent();
                        setResult(Activity.RESULT_OK, returnIntent);
                        AddCarActivity.this.finish();
                    }
                });*/



            }

            @Override
            public void onFailure(Call<BaseModel> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        };

        RetrofitHelper.getRetrofit().create(BaseController.class).AddCar(map).enqueue(callback);

    }
}
