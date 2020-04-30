package com.app.roadz.modules.Setting;

import android.provider.Settings;
import android.util.Log;
import android.widget.TextView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.UserController;
import com.app.roadz.model.BaseModel.BaseModel;
import com.app.roadz.model.NotificationStatus;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;

import java.util.HashMap;
import java.util.Map;

import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_setting)
public class SettingActivity extends BaseActivity {

    @ViewById(R.id.toolbar_title)
    TextView toolbar_title;

    @ViewById(R.id.onTxt)
    TextView onTxt;

    @ViewById(R.id.offTxt)
    TextView offTxt;

    @ViewById(R.id.enTxt)
    TextView enTxt;

    @ViewById(R.id.arTxt)
    TextView arTxt;

    @AfterViews
    protected void AfterViews() {
        usernotification();
        toolbar_title.setText(R.string.menu_setting);
        enTxt.setSelected(!MainApplication.ISlocaleArabic(this));
        arTxt.setSelected(MainApplication.ISlocaleArabic(this));


    }


    @Click(R.id.languageLayout)
    protected void languageLayout() {
        Utils.ChangeLanguage(this, new Runnable() {
            @Override
            public void run() {
                MainApplication.changeLanguage(SettingActivity.this);
            }
        }, new Runnable() {
            @Override
            public void run() {
            }
        });
    }

    @Click(R.id.onTxt)
    protected void onTxt() {
        MakeNotificationRead("1");
    }

    @Click(R.id.offTxt)
    protected void offTxt() {
        MakeNotificationRead("0");
    }

    protected void MakeNotificationRead(String abc) {
//        ShowProgress();
        BaseCallback<BaseModel> callback = new BaseCallback<BaseModel>() {

            @Override
            public void onResponse(Call<BaseModel> call, Response<BaseModel> response) {
//                HideProgress();
                usernotification();
            }

            @Override
            public void onFailure(Call<BaseModel> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
//                HideProgress();
            }
        };
        String android_id = Settings.Secure.getString(SettingActivity.this.getContentResolver(),
                Settings.Secure.ANDROID_ID);
        Map<String, String> map = new HashMap<>();
        map.put("setting", abc);
        map.put("deviceId",  MainApplication.sMyPrefs.FcmToken().get());
        RetrofitHelper.getRetrofit().create(UserController.class).notificationsetting(map).enqueue(callback);

    }

    protected void usernotification() {
        ShowProgress();
        BaseCallback<NotificationStatus> callback = new BaseCallback<NotificationStatus>() {

            @Override
            public void onResponse(Call<NotificationStatus> call, Response<NotificationStatus> response) {
                HideProgress();
                try {
                    if (response.body().getCode().equals("200")) {
                        if (response.body().getItems().getNoty().equals("1")) {
                            onTxt.setSelected(true);
                            offTxt.setSelected(false);
                        } else {
                            onTxt.setSelected(false);
                            offTxt.setSelected(true);
                        }
                    }

                } catch (Exception e) {

                }
            }

            @Override
            public void onFailure(Call<NotificationStatus> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
             HideProgress();
            }
        };
        String android_id = Settings.Secure.getString(SettingActivity.this.getContentResolver(),
                Settings.Secure.ANDROID_ID);
        Map<String, String> map1 = new HashMap<>();
        map1.put("deviceId",  MainApplication.sMyPrefs.FcmToken().get());
        RetrofitHelper.getRetrofit().create(UserController.class).usernotification(map1).enqueue(callback);

    }


    @Click(R.id.privacy_policy)
    protected void privacy_policy() {
        StaticDataActivity_.intent(this).Type(3).start();
    }

    @Click(R.id.terms_conditions)
    protected void terms_conditions() {
        StaticDataActivity_.intent(this).Type(2).start();
    }


}
