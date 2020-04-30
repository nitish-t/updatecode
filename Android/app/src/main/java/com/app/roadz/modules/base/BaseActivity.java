package com.app.roadz.modules.base;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.Resources;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

import androidx.appcompat.app.AppCompatActivity;

import com.app.roadz.R;
import com.app.roadz.Utils.ContextWrapper;
import com.app.roadz.app.MainApplication;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.InstanceIdResult;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.App;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;

import java.util.Locale;

import cn.pedant.SweetAlert.SweetAlertDialog;


@EActivity
public abstract class BaseActivity extends AppCompatActivity {

    @ViewById(R.id.status_bar)
    protected View status_bar;


    @App
    protected MainApplication mApp;

    SweetAlertDialog pDialog;

    @Override
    protected void attachBaseContext(Context newBase) {
        super.attachBaseContext(ContextWrapper.wrap(newBase, new Locale(MainApplication.getLang(MainApplication.sContext))));
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        MainApplication.setBaseActivity(this);

        FirebaseInstanceId.getInstance().getInstanceId().addOnSuccessListener(this, new OnSuccessListener<InstanceIdResult>() {
            @Override
            public void onSuccess(InstanceIdResult instanceIdResult) {
                String newToken = instanceIdResult.getToken();
                MainApplication.sMyPrefs.FcmToken().put(newToken);
            }
        });


        pDialog = new SweetAlertDialog(this, SweetAlertDialog.PROGRESS_TYPE);
        pDialog.getProgressHelper().setBarColor(getResources().getColor(R.color.colorAccent));
        pDialog.setTitleText("");
        pDialog.setCancelable(false);


    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
//        MainApplication.setBaseActivity(null);
    }

    @Override
    protected void onResume() {
        super.onResume();
        MainApplication.setBaseActivity(this);
    }

    @AfterViews
    protected void onAfterViewsAnnotation() {
        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);
        getWindow().setSoftInputMode(
                WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);

        if (status_bar != null)
            status_bar.getLayoutParams().height = getStatusBarHeight();


        onAfterViews();
        postAfterViews();
    }

    protected void preAfterViews() {
    }

    protected void onAfterViews() {
    }

    protected void postAfterViews() {
    }


    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    public void statusbarColor(int res) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            Window window = getWindow();
            window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
            window.setStatusBarColor(res);
        }
    }

    public static String convertNumberToEN(String value) {
        String newValue =
                (((((((((((((value + "").
                        replaceAll("١", "1"))
                        .replaceAll("٢", "2"))
                        .replaceAll("٣", "3"))
                        .replaceAll("٤", "4"))
                        .replaceAll("٥", "5"))
                        .replaceAll("٦", "6"))
                        .replaceAll("٧", "7"))
                        .replaceAll("٨", "8"))
                        .replaceAll("٩", "9"))
                        .replaceAll("٠", "0"))
                        .replaceAll("/+/", "+"))
                        .replaceAll("،", "")
                        .replaceAll(",", ""));
        return newValue;
    }

    public int getStatusBarHeight() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            final Resources resources = getResources();
            final int resId = resources.getIdentifier(
                    "status_bar_height", "dimen", "android");
            if (resId > 0) {
                return resources.getDimensionPixelSize(resId);
            }
        }
        return 0;
    }

    public void ShowProgress() {
        if (pDialog != null)
            pDialog.show();
    }

    public void HideProgress() {
        if (pDialog != null && pDialog.isShowing())
            pDialog.dismiss();
    }

    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        super.onBackPressed();
    }
}
