package com.app.roadz.modules.User;

import android.text.TextUtils;
import android.util.Log;
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


@EActivity(R.layout.activity_update_password)
public class EditPasswordActivity extends BaseActivity {

    @ViewById(R.id.toolbar_title)
    TextView toolbar_title;


    @ViewById(R.id.edtCurrentPassword)
    public EditText edtCurrentPassword;

    @ViewById(R.id.edtNewPassword)
    public EditText edtNewPassword;

    @ViewById(R.id.edtConfirmNewPassword)
    public EditText edtConfirmNewPassword;

    TUser tUser;

    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(getString(R.string.change_password));
    }


    @Click(R.id.actionBtn)
    protected void actionBtn() {

        if (!Utils.Valed(this, edtCurrentPassword, null, Utils.Type.general)) {
            return;
        }

        if (!Utils.Valed(this, edtNewPassword, null, Utils.Type.general)) {
            return;
        }

        if (!Utils.Valed(this, edtConfirmNewPassword, edtNewPassword, Utils.Type.confirm_pass)) {
            return;
        }


        Map<String, String> map = new HashMap<>();
        map.put("old_password", edtCurrentPassword.getText().toString());
        map.put("password", edtNewPassword.getText().toString());
        map.put("password_confirmation", edtNewPassword.getText().toString());
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

                String msg = getString(R.string.password_update_successfully);
                if (!TextUtils.isEmpty(response.body().getMessage())) {
                    msg = response.body().getMessage();
                }
                MainApplication.Toast(msg, SweetAlertDialog.SUCCESS_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        EditPasswordActivity.super.onBackPressed();
                    }
                });


            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        };


        RetrofitHelper.getRetrofit().create(UserController.class).UpdatePassword(Data).enqueue(callback);


    }


}
