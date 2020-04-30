package com.app.roadz.modules.base;

import android.app.AlertDialog;
import android.content.Context;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;

import com.app.roadz.R;

import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.ViewById;

@EView
public class CallPopup extends LinearLayout {




    AlertDialog alertDialog;
    Runnable runnable;

    boolean issamePackageSelected = false;

    public CallPopup(Context context) {
        super(context);
    }

    public CallPopup(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public CallPopup(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
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
}
