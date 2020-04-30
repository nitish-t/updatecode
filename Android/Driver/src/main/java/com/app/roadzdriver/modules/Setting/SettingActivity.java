package com.app.roadzdriver.modules.Setting;

import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.widget.TextView;

import com.app.roadzdriver.R;
import com.app.roadzdriver.Utils.Utils;
import com.app.roadzdriver.api.BaseCallback;
import com.app.roadzdriver.api.RetrofitHelper;
import com.app.roadzdriver.app.Constants;
import com.app.roadzdriver.app.MainApplication;
import com.app.roadzdriver.controller.BaseController;
import com.app.roadzdriver.model.BaseModel.ObjectBaseResponse;
import com.app.roadzdriver.model.TUser;
import com.app.roadzdriver.modules.User.LoginActivity_;
import com.app.roadzdriver.modules.base.BaseActivity;
import com.suke.widget.SwitchButton;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_setting)
public class SettingActivity extends BaseActivity {

    @SystemService
    LayoutInflater mLayoutInflater;

    @Extra
    int reqestCount = 0;

    @ViewById(R.id.previous_requests)
    protected TextView previous_requests;

    @ViewById(R.id.changeLang)
    protected SwitchButton changeLang;

    boolean notificationFromCancel = false;

    @AfterViews
    protected void AfterViews() {

        changeLang.setChecked(!MainApplication.ISlocaleArabic(this));

        changeLang.setOnCheckedChangeListener(onCheckedChangeListener);

        if (reqestCount == 0) {
            previous_requests.setText("");
        } else {
            previous_requests.setText(String.format(getResources().getString(R.string.pending_requests), reqestCount + ""));
        }
    }

    SwitchButton.OnCheckedChangeListener onCheckedChangeListener = new SwitchButton.OnCheckedChangeListener() {
        @Override
        public void onCheckedChanged(SwitchButton view, boolean isChecked) {
            if (notificationFromCancel) {
                notificationFromCancel = false;
                return;
            }
            Utils.ChangeLanguage(SettingActivity.this, new Runnable() {
                @Override
                public void run() {
                    MainApplication.changeLanguage(SettingActivity.this);
                }
            }, new Runnable() {
                @Override
                public void run() {
                    notificationFromCancel = true;
                    changeLang.setChecked(!MainApplication.ISlocaleArabic(SettingActivity.this));

                }
            });
        }
    };


    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        super.onBackPressed();
    }


    @Click(R.id.logoutLayout)
    protected void logoutLayout() {
        if (MainApplication.sMyPrefs.ISLogin().get()) {
            Utils.LogoutDialog(this, new Runnable() {
                @Override
                public void run() {
                    SendTOServer();
                }
            });
        }
    }


    private void SendTOServer() {
        ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).Logout().enqueue(new BaseCallback<ObjectBaseResponse<TUser>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<TUser>> call, Response<ObjectBaseResponse<TUser>> response) {
                HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    Constants.ErrorMsg(response);
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

                MainApplication.sMyPrefs.AccessToken().put("");
                MainApplication.sMyPrefs.UserEmail().put("");
                MainApplication.sMyPrefs.UserMobile().put("");
                MainApplication.sMyPrefs.UserImage().put("");
                MainApplication.sMyPrefs.UserName().put("");
                MainApplication.sMyPrefs.ISLogin().put(false);
                MainApplication.sMyPrefs.ISFcmSend().put(false);
                SettingActivity.this.finish();
                LoginActivity_.intent(SettingActivity.this).
                        flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK  ).start();
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        });
    }
}
