package com.app.roadz.modules.base;

import android.app.AlertDialog;
import android.content.Context;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;

import com.app.roadz.R;

import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.ViewById;

@EView
public class MessagePopup extends LinearLayout {


    @ViewById(R.id.title)
    protected TextView titleTxt;
    @ViewById(R.id.message)
    protected TextView message;

    @ViewById(R.id.noBtn)
    protected TextView noBtn;

    @ViewById(R.id.yesBtn)
    protected TextView yesBtn;

    @ViewById(R.id.iconImage)
    protected ImageView iconImage;

    AlertDialog alertDialog;
    Runnable runnable;

    boolean issamePackageSelected = false;

    public MessagePopup(Context context) {
        super(context);
    }

    public MessagePopup(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public MessagePopup(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }


    public void setDialogInstans(AlertDialog alertDialog, Runnable runnable) {

        this.alertDialog = alertDialog;
        this.runnable = runnable;

    }


    @Click(R.id.noBtn)
    void noBtn() {
        if (alertDialog != null)
            alertDialog.dismiss();
    }

    @Click(R.id.yesBtn)
    void yesBtn() {
        if (alertDialog != null)
            alertDialog.dismiss();
        if (runnable != null)
            runnable.run();
    }

    public void setMessage(String title, String msg, boolean showIcon) {
        titleTxt.setText(title);
        message.setText(msg);
        iconImage.setVisibility(showIcon ? VISIBLE : GONE);
        titleTxt.setVisibility(TextUtils.isEmpty(title) ? GONE : VISIBLE);
        message.setVisibility(TextUtils.isEmpty(msg) ? GONE : VISIBLE);

    }

    public void setMessage(String title, String msg,boolean showIcon, String okBtn, String cancelBtn) {
        setMessage(title, msg, showIcon);


        yesBtn.setText(okBtn);
        noBtn.setText(cancelBtn);
        yesBtn.setVisibility(TextUtils.isEmpty(okBtn) ? GONE : VISIBLE);
        noBtn.setVisibility(TextUtils.isEmpty(cancelBtn) ? GONE : VISIBLE);
    }
}
