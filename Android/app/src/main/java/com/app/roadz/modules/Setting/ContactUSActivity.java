package com.app.roadz.modules.Setting;

import android.content.Intent;
import android.net.Uri;
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
import com.app.roadz.controller.BaseController;
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


@EActivity(R.layout.activity_contactus)
public class ContactUSActivity extends BaseActivity {

    @ViewById(R.id.toolbar_title)
    TextView toolbar_title;

    @ViewById(R.id.edtName)
    EditText edtName;

    @ViewById(R.id.edtEmail)
    EditText edtEmail;

    @ViewById(R.id.edtMobileNumber)
    EditText edtMobileNumber;

    @ViewById(R.id.edtMessage)
    EditText edtMessage;

    @ViewById(R.id.infoPhone)
    TextView infoPhone;

    @ViewById(R.id.infoEmail)
    TextView infoEmail;


    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(R.string.menu_contact_us);
        infoEmail.setText(MainApplication.sMyPrefs.info_email().get());
        infoPhone.setText(MainApplication.sMyPrefs.mobile().get());
        if (MainApplication.sMyPrefs.ISLogin().get()) {
            edtName.setText(MainApplication.sMyPrefs.UserName().get());
            edtEmail.setText(MainApplication.sMyPrefs.UserEmail().get());
            edtMobileNumber.setText(MainApplication.sMyPrefs.UserMobile().get());
        }
    }


    @Click(R.id.actionBtn)
    protected void actionBtn() {
        if (!Utils.Valed(this, edtName, null, Utils.Type.general)) {
            return;
        }
        if (!Utils.Valed(this, edtEmail, null, Utils.Type.email)) {
            return;
        }

        if (!Utils.Valed(this, edtMobileNumber, null, Utils.Type.general)) {
            return;
        }

        if (!Utils.Valed(this, edtMessage, null, Utils.Type.general)) {
            return;
        }

        Map<String, String> map = new HashMap<>();

        map.put("name", edtName.getText().toString());
        map.put("email", edtEmail.getText().toString());
        map.put("phone", edtMobileNumber.getText().toString());
        map.put("message", edtMessage.getText().toString());
        SendTOServer(map);
    }

    private void SendTOServer(Map<String, String> Data) {
        ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).ContactUs(Data).enqueue(new BaseCallback<ObjectBaseResponse<TUser>>() {

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

                String msg = getString(R.string.message_send_successfully);
                if (!TextUtils.isEmpty(response.body().getMessage())) {
                    msg = response.body().getMessage();
                }
                MainApplication.Toast(msg, SweetAlertDialog.SUCCESS_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        ContactUSActivity.super.onBackPressed();
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

    @Click(R.id.phoneLayout)
    protected void phoneLayout() {
        if (TextUtils.isEmpty(MainApplication.sMyPrefs.mobile().get())) return;
        Intent intent = new Intent(Intent.ACTION_DIAL, Uri.fromParts("tel", MainApplication.sMyPrefs.mobile().get(), null));
        startActivity(intent);
    }

    @Click(R.id.emailLayout)
    protected void emailLayout() {
        if (TextUtils.isEmpty(MainApplication.sMyPrefs.info_email().get())) return;

        Intent emailIntent = new Intent(Intent.ACTION_SENDTO, Uri.fromParts(
                "mailto", MainApplication.sMyPrefs.info_email().get(), null));
        emailIntent.putExtra(Intent.EXTRA_SUBJECT, "");
        emailIntent.putExtra(Intent.EXTRA_TEXT, "");
        startActivity(Intent.createChooser(emailIntent, getString(R.string.send_email)));


    }
}
