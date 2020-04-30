package com.app.roadz.modules.User;

import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

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


@EActivity(R.layout.activity_update_profile)
public class EditProfileActivity extends BaseActivity {

    @ViewById(R.id.toolbar_title)
    TextView toolbar_title;


    @ViewById(R.id.edtName)
    public EditText et_name;

    @ViewById(R.id.edtEmail)
    public EditText et_email;

    @ViewById(R.id.edtMobileNumber)
    public EditText et_mobile;

    @ViewById(R.id.verifiedStatus)
    public TextView verifiedStatus;

    @ViewById(R.id.reSendVerified)
    public TextView reSendVerified;

    TUser tUser;

    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(R.string.menu_profile);
        verifiedStatus.setVisibility(View.GONE);
        GetUserData();
    }

    private void GetUserData() {
        ShowProgress();
        RetrofitHelper.getRetrofit().create(UserController.class).GetProfile().enqueue(new BaseCallback<ObjectBaseResponse<TUser>>() {

            @Override
            public void onResponse(retrofit2.Call<ObjectBaseResponse<TUser>> call, Response<ObjectBaseResponse<TUser>> response) {
                HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    Constants.ErrorMsg(response);
                    InitUserData();
                    return;
                }

                if (!response.body().getStatus() || response.body().getObject() == null) {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage());
                    } else {
                        MainApplication.ErrorToast();
                    }
                    InitUserData();
                    return;
                }

                tUser = response.body().getObject();
                InitUserData();
            }

            @Override
            public void onFailure(retrofit2.Call<ObjectBaseResponse<TUser>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                InitUserData();
                HideProgress();
            }
        });
    }

    private void InitUserData() {

        if (tUser != null) {
            MainApplication.sMyPrefs.UserName().put(tUser.getFullName());
            MainApplication.sMyPrefs.UserEmail().put(tUser.getEmail());
            MainApplication.sMyPrefs.UserMobile().put(tUser.getMobile());
            verifiedStatus.setVisibility(View.VISIBLE);
            verifiedStatus.setText(tUser.isB_email_verified() ? R.string.verified : R.string.not_verified);
            reSendVerified.setVisibility(tUser.isB_email_verified() ? View.GONE : View.VISIBLE);

            et_email.setFocusable(!tUser.isB_email_verified());
            et_email.setEnabled(!tUser.isB_email_verified());
            et_email.setFocusableInTouchMode(!tUser.isB_email_verified());
        }

        et_name.setText(MainApplication.sMyPrefs.UserName().get());
        et_email.setText(MainApplication.sMyPrefs.UserEmail().get());
        et_mobile.setText(MainApplication.sMyPrefs.UserMobile().get());
    }


    @Click(R.id.reSendVerified)
    protected void reSendVerified() {
        ShowProgress();
        BaseCallback<ObjectBaseResponse<TUser>> callback = new BaseCallback<ObjectBaseResponse<TUser>>() {

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

                if (response.body().getStatus()) {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage(), SweetAlertDialog.SUCCESS_TYPE);
                    } else {
                        MainApplication.Toast(getString(R.string.verification_link_send_successfully), SweetAlertDialog.SUCCESS_TYPE);
                    }
                } else {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage());
                    } else {
                        MainApplication.ErrorToast();
                    }
                }
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        };

        Map<String, String> map = new HashMap<>();

        RetrofitHelper.getRetrofit().create(UserController.class).resendVerifyEmail(map).enqueue(callback);

    }

    @Click(R.id.actionBtn)
    protected void actionBtn() {

        if (!Utils.Valed(this, et_email, null, Utils.Type.email)) {
            return;
        }

        if (!Utils.Valed(this, et_name, null, Utils.Type.general)) {
            return;
        }

        if (!Utils.Valed(this, et_mobile, null, Utils.Type.general)) {
            return;
        }


        Map<String, String> map = new HashMap<>();
        map.put("full_name", et_name.getText().toString());
        map.put("email", et_email.getText().toString());
        map.put("mobile", et_mobile.getText().toString());
        map.put("device_type", "android");
        SendTOServer(map);
    }

    private void SendTOServer(Map<String, String> Data) {
        ShowProgress();
        BaseCallback<ObjectBaseResponse<TUser>> callback = new BaseCallback<ObjectBaseResponse<TUser>>() {

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

                String msg = getString(R.string.profile_update_successfully);
                if (!TextUtils.isEmpty(response.body().getMessage())) {
                    msg = response.body().getMessage();
                }
                MainApplication.Toast(msg, SweetAlertDialog.SUCCESS_TYPE);

                TUser tUser = response.body().getObject();
                if (tUser != null) {
                    MainApplication.sMyPrefs.UserName().put(tUser.getFullName());
                    MainApplication.sMyPrefs.UserEmail().put(tUser.getEmail());
                    MainApplication.sMyPrefs.UserMobile().put(tUser.getMobile());
                }

            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        };


        RetrofitHelper.getRetrofit().create(UserController.class).UpdateProfile(Data).enqueue(callback);


    }

    @Click(R.id.changePasswordBtn)
    protected void changePasswordBtn() {
        EditPasswordActivity_.intent(this).start();
    }

}
