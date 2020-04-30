package com.app.roadzdriver.modules.Splash;

import android.content.Intent;

import com.app.roadzdriver.R;
import com.app.roadzdriver.app.MainApplication;
import com.app.roadzdriver.modules.User.LoginActivity_;
import com.app.roadzdriver.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;


@EActivity(R.layout.activity_select_language)
public class SelectLanguageActivity extends BaseActivity {


    @AfterViews
    protected void AfterViews() {


    }

    @Click(R.id.englishBtn)
    protected void englishBtn() {
        MainApplication.sMyPrefs.SelectLanguage().put(true);
        if (MainApplication.ISlocaleArabic(this)) {
            MainApplication.changeLanguage(this, "en", LoginActivity_.class);
        } else {
            NextScreenAction();
        }
    }

    @Click(R.id.arabicBtn)
    protected void arabicBtn() {
        MainApplication.sMyPrefs.SelectLanguage().put(true);
        if (!MainApplication.ISlocaleArabic(this)) {
            MainApplication.changeLanguage(this, "ar", LoginActivity_.class);
        } else {
            NextScreenAction();
        }

    }

    private void NextScreenAction() {

        SelectLanguageActivity.this.finish();
        LoginActivity_.intent(SelectLanguageActivity.this).
                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK  ).start();


    }

}
