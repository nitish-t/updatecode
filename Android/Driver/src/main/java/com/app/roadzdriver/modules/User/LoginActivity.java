package com.app.roadzdriver.modules.User;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.widget.EditText;

import com.app.roadzdriver.R;
import com.app.roadzdriver.Utils.Utils;
import com.app.roadzdriver.api.BaseCallback;
import com.app.roadzdriver.api.RetrofitHelper;
import com.app.roadzdriver.app.Constants;
import com.app.roadzdriver.app.MainApplication;
import com.app.roadzdriver.controller.BaseController;
import com.app.roadzdriver.model.BaseModel.ObjectBaseResponse;
import com.app.roadzdriver.model.TUser;
import com.app.roadzdriver.modules.Home.HomeActivity_;
import com.app.roadzdriver.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;

import java.util.HashMap;
import java.util.Map;

import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_login)
public class LoginActivity extends BaseActivity {


    @ViewById(R.id.edtEmail)
    protected EditText edtEmail;

    @ViewById(R.id.edtPassword)
    protected EditText edtPassword;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }


    @AfterViews
    protected void AfterViews() {
        edtPassword.setTypeface(MainApplication.typeface);
    }


    @Click(R.id.loginBtn)
    protected void sendAction() {

        if (!Utils.Valed(this, edtEmail, null, Utils.Type.email)) {
            return;
        }
        if (!Utils.Valed(this, edtPassword, null, Utils.Type.pass)) {
            return;
        }

        Map<String, String> map = new HashMap<>();

        map.put("email", edtEmail.getText().toString());
        map.put("password", edtPassword.getText().toString());
        SendTOServer(map);
    }

    private void SendTOServer(Map<String, String> Data) {
        ShowProgress();

        BaseCallback<ObjectBaseResponse<TUser>> objectBaseResponseBaseCallback = new BaseCallback<ObjectBaseResponse<TUser>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<TUser>> call, Response<ObjectBaseResponse<TUser>> response) {
                HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                }

                if (!response.body().getStatus() || response.body().getObject() == null) {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage());
                    } else {
                        MainApplication.ErrorToast();
                    }
                    return;
                }

                TUser tUser = response.body().getObject();

                MainApplication.sMyPrefs.AccessToken().put(tUser.getAccessToken());
                MainApplication.sMyPrefs.UserName().put(tUser.getFullName());
                MainApplication.sMyPrefs.UserEmail().put(tUser.getEmail());
                MainApplication.sMyPrefs.UserMobile().put(tUser.getMobile());
                MainApplication.sMyPrefs.UserImage().put(tUser.getProfileImage());
                MainApplication.sMyPrefs.ISLogin().put(true);
                LoginActivity.this.finish();
                HomeActivity_.intent(LoginActivity.this).
                        flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK ).start();


            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        };

        RetrofitHelper.getRetrofit().create(BaseController.class).Login(Data).enqueue(objectBaseResponseBaseCallback);

    }

}
