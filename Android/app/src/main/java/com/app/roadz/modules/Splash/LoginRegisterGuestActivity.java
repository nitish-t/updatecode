package com.app.roadz.modules.Splash;

import android.content.Intent;
import android.widget.LinearLayout;

import com.app.roadz.R;
import com.app.roadz.app.MainApplication;
import com.app.roadz.modules.AdsSlider.ImageSliderActivity_;
import com.app.roadz.modules.Home.HomeActivity_;
import com.app.roadz.modules.User.LoginActivity_;
import com.app.roadz.modules.User.SignUp.SignUpActivity_;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;


@EActivity(R.layout.activity_login_register_guest)
public class LoginRegisterGuestActivity extends BaseActivity {

    @ViewById(R.id.languageLayout)
    protected LinearLayout languageLayout;

    @AfterViews
    protected void AfterViews() {
        MainApplication.sMyPrefs.ShowLoginType().put(false);
    }

    @Click(R.id.guestBtn)
    protected void guestBtn() {
        this.finish();
        HomeActivity_.intent(this).FromDemo(true).
                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
    }

    @Click(R.id.loginBtn)
    protected void loginBtn() {
        LoginActivity_.intent(this).start();
    }

    @Click(R.id.signUpBtn)
    protected void signUpBtn() {
        SignUpActivity_.intent(this).start();
    }

}
