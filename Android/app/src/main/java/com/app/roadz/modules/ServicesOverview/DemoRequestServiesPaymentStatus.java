package com.app.roadz.modules.ServicesOverview;

import android.content.Intent;
import android.widget.TextView;

import com.app.roadz.R;
import com.app.roadz.app.MainApplication;
import com.app.roadz.modules.Home.HomeActivity_;
import com.app.roadz.modules.User.SignUp.SignUpActivity_;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;


@EActivity(R.layout.activity_demo_request_servies_payment_status)
public class DemoRequestServiesPaymentStatus extends BaseActivity {


    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;


    @AfterViews
    protected void AfterViews() {
        toolbar_title.setText(getString(R.string.service_status));

        MainApplication.sMyPrefs.ShowDemo().put(false);
    }


    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        actionHome();
    }

    @Override
    public void onBackPressed() {
        toolbar_back();
    }

    @Click(R.id.actionHome)
    protected void actionHome() {
        this.finish();
        HomeActivity_.intent(this).
                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
    }

    @Click(R.id.actionSignup)
    protected void actionSignup() {
        this.finish();
        SignUpActivity_.intent(this).backToHome(true).
                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
    }


}
