package com.app.roadz.modules.Notification;

import android.app.AlertDialog;
import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.app.Constants;
import com.app.roadz.model.TNotification;
import com.app.roadz.recyclerview.DataAdapter;
import com.app.roadz.recyclerview.ViewBinder;

import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.Date;


@EView
public class NotificationListRow extends LinearLayout implements ViewBinder<Object>, View.OnClickListener {

    @SystemService
    LayoutInflater mLayoutInflater;

    @ViewById(R.id.notificationTitle)
    protected TextView notificationTitle;

    @ViewById(R.id.notificationDate)
    protected TextView notificationDate;

    @ViewById(R.id.notificationBody)
    protected TextView notificationBody;

    @ViewById(R.id.contenerView)
    protected LinearLayout contenerView;


    TNotification object;
    DataAdapter adapter;
    Context context;

    public NotificationListRow(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.context = context;
        Init();
    }

    public NotificationListRow(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        Init();
    }

    private void Init() {
        this.setOnClickListener(this);
    }


    @Override
    public void bindViews(Object obj, int position, RecyclerView recyclerView) {
        adapter = (DataAdapter) recyclerView.getAdapter();
        object = (TNotification) obj;
        if (object == null) return;

        notificationTitle.setText(object.getTitle());
        notificationBody.setText(object.getBody());
//        notificationDate.setText(Constants.GetStringDateFromString(object.getCreatedAt(), "dd-MM-yyyy", Constants.DISPLAY_DATE_FORMAT));
        Date date = Constants.GetDateFromString(object.getCreatedAt(), "yyyy-MM-dd HH:mm:ss");
        notificationDate.setText(Utils.Ago(date));

        if (object.isIs_read()) {
            contenerView.setBackground(null);
        } else {
            contenerView.setBackgroundResource(R.drawable.notification_not_reed);
        }

    }


    @Override
    public void onClick(View v) {
        ShowPopup();
    }

    private void ShowPopup() {
        if (object == null) return;

        NotificationPopup notificationPopup = (NotificationPopup) mLayoutInflater.inflate(R.layout.popup_notification, null);
        AlertDialog.Builder filterBuilder2 = new AlertDialog.Builder(context);
        filterBuilder2.setView(notificationPopup);
        AlertDialog filterAlertDialog2 = filterBuilder2.create();
        filterAlertDialog2.setCancelable(true);
        filterAlertDialog2.setCanceledOnTouchOutside(true);
        filterAlertDialog2.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        filterAlertDialog2.show();
        notificationPopup.intiView(object);

        object.setIs_read(true);
        if (adapter != null) {
            adapter.notifyDataSetChanged();
        }
    }
}
