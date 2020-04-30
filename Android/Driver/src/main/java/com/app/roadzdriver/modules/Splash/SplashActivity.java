package com.app.roadzdriver.modules.Splash;

import android.annotation.TargetApi;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.DisplayMetrics;

import com.app.roadzdriver.R;
import com.app.roadzdriver.app.MainApplication;
import com.app.roadzdriver.modules.Home.HomeActivity_;
import com.app.roadzdriver.modules.User.LoginActivity_;
import com.app.roadzdriver.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.EActivity;


@EActivity(R.layout.activity_splash)
public class SplashActivity extends BaseActivity {


    private static final long SPLASH_TIME_OUT = 2000L;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }


    @AfterViews
    protected void AfterViews() {

        DisplayMetrics metrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(metrics);
        MainApplication.sMyPrefs.Screenwidth().put(metrics.widthPixels);


        new android.os.Handler().postDelayed(new Runnable() {

            @TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
            @Override
            public void run() {
                    NextScreenAction();

            }
        }, SPLASH_TIME_OUT);

    }

    private void NextScreenAction() {

        SplashActivity.this.finish();
        if (MainApplication.sMyPrefs.ISLogin().get()){
            HomeActivity_.intent(SplashActivity.this).
                    flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK ).start();
        }else if (MainApplication.sMyPrefs.SelectLanguage().get()){
            LoginActivity_.intent(SplashActivity.this).
                    flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK ).start();
        }else {
            SelectLanguageActivity_.intent(SplashActivity.this).
                    flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
        }

    }

}
