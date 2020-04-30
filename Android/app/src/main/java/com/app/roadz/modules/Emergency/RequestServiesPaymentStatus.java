package com.app.roadz.modules.Emergency;

import android.content.Intent;
import android.graphics.Color;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.TextPaint;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.text.style.UnderlineSpan;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.app.roadz.R;
import com.app.roadz.app.MainApplication;
import com.app.roadz.modules.Home.HomeActivity_;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;


@EActivity(R.layout.activity_request_servies_payment_status)
public class RequestServiesPaymentStatus extends BaseActivity {

    @SystemService
    LayoutInflater mLayoutInflater;

    @Extra
    boolean IsSuccess;

    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;

    @ViewById(R.id.image)
    protected ImageView image;

    @ViewById(R.id.msg_title)
    protected TextView msg_title;


    @ViewById(R.id.actionHome)
    protected Button actionHome;

    @ViewById(R.id.txt_we_are_on_the_way)
    protected TextView txt_we_are_on_the_way;

    @ViewById(R.id.payment_sucsses_Layout)
    protected LinearLayout payment_sucsses_Layout;

    @ViewById(R.id.payment_fail_Layout)
    protected LinearLayout payment_fail_Layout;


    @AfterViews
    protected void AfterViews() {
        toolbar_title.setText(getString(R.string.service_status));


        SpannableString content = new SpannableString(getResources().getString(R.string.we_are_on_the_way));
        content.setSpan(new UnderlineSpan(), 0, content.length(), 0);
        txt_we_are_on_the_way.setText(content);

        if (IsSuccess) {
            payment_fail_Layout.setVisibility(View.GONE);
            payment_sucsses_Layout.setVisibility(View.VISIBLE);
            actionHome.setVisibility(View.VISIBLE);
        } else {
            payment_fail_Layout.setVisibility(View.VISIBLE);
            payment_sucsses_Layout.setVisibility(View.GONE);
            actionHome.setVisibility(View.GONE);
            SetErroeMesgText();
        }

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


    private void SetErroeMesgText() {
        String termsAndConditions = getResources().getString(R.string.request_failed);
        int startPos = MainApplication.ISlocaleArabic(this) ? 12 : 17;
        int endPos = termsAndConditions.length();

        SpannableString spannableString = new SpannableString(termsAndConditions);

        ClickableSpan clickableSpan = new ClickableSpan() {
            @Override
            public void onClick(@NonNull View view) {
                actionHome();
            }

            @Override
            public void updateDrawState(@NonNull TextPaint ds) {
                super.updateDrawState(ds);

                ds.setColor(Color.parseColor("#FF002B"));
                ds.setUnderlineText(true);
            }
        };

        spannableString.setSpan(clickableSpan, startPos, endPos, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);


        msg_title.setText(spannableString);
        msg_title.setMovementMethod(LinkMovementMethod.getInstance());
        msg_title.setTypeface(MainApplication.typeface_bold);
    }

}
