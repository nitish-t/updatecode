package com.app.roadz.modules.OurServices;

import android.text.Html;
import android.text.TextUtils;
import android.widget.TextView;

import com.app.roadz.R;
import com.app.roadz.app.MainApplication;
import com.app.roadz.modules.User.LoginActivity_;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;


@EActivity(R.layout.activity_emergancy_without_login)
public class EmergencyWithoutLoginActivity extends BaseActivity {


    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;

    @ViewById(R.id.tv_data)
    protected TextView tv_data;

    String emergencyData;

    @AfterViews
    protected void AfterViews() {
        toolbar_title.setText(getString(R.string.emergency_details));

        emergencyData = MainApplication.sMyPrefs.service_emergency_guest().get();

        if (!TextUtils.isEmpty(emergencyData))
            tv_data.setText(Html.fromHtml(emergencyData));

    }


    @Click(R.id.loginBtn)
    protected void loginBtn() {
        LoginActivity_.intent(this).start();
    }


 @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        super.onBackPressed();
    }

}
