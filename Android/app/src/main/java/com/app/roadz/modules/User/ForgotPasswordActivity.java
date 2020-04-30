package com.app.roadz.modules.User;

import android.text.TextUtils;
import android.util.Log;
import android.widget.EditText;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.UserController;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.TUser;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;

import java.util.HashMap;
import java.util.Map;

import cn.pedant.SweetAlert.SweetAlertDialog;
import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_forgot_password)
public class ForgotPasswordActivity extends BaseActivity {


    @ViewById(R.id.edtEmail)
    protected EditText edtEmail;

    @AfterViews
    protected void AfterViews() {

    }


    @Click(R.id.actionBtn)
    protected void sendBtn() {
        if (!Utils.Valed(this, edtEmail, null, Utils.Type.email)) {
            return;
        }

        Map<String, String> map = new HashMap<>();

        map.put("email", edtEmail.getText().toString());
        SendTOServer(map);
    }

    private void SendTOServer(Map<String, String> Data) {
        ShowProgress();
        RetrofitHelper.getRetrofit().create(UserController.class).ForgetPassword(Data).enqueue(new BaseCallback<ObjectBaseResponse<TUser>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<TUser>> call, Response<ObjectBaseResponse<TUser>> response) {
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

                String msg = getString(R.string.Password_reset_msg);
//                if (!TextUtils.isEmpty(response.body().getMessage())) {
//                    msg = response.body().getMessage();
//                }
                MainApplication.Toast(msg, SweetAlertDialog.SUCCESS_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        ForgotPasswordActivity.super.onBackPressed();
                    }
                });
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        });
    }

    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        super.onBackPressed();
    }

    @Click(R.id.loginBtn)
    protected void loginBtn() {
        toolbar_back();
    }

}
