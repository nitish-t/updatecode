package com.app.roadzdriver.modules.PreviousRequests;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.app.roadzdriver.R;
import com.app.roadzdriver.model.TOrder;
import com.app.roadzdriver.recyclerview.ViewBinder;

import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.text.SimpleDateFormat;
import java.util.Date;


@EView
public class PreviousRequestsListRow extends LinearLayout implements ViewBinder<Object>, View.OnClickListener {

    @ViewById(R.id.tv_req)
    protected TextView tv_req;
    @ViewById(R.id.tv_name)
    protected TextView tv_name;
    @ViewById(R.id.tv_number)
    protected TextView tv_number;
    @ViewById(R.id.tv_breakdown_services)
    protected TextView tv_breakdown_services;
    @ViewById(R.id.tv_end_car_time)
    protected TextView tv_end_car_time;
    @ViewById(R.id.tv_endcar_date)
    protected TextView tv_endcar_date;
    @ViewById(R.id.tv_plate)
    protected TextView tv_plate;
    @ViewById(R.id.tv_car_time)
    protected TextView tv_car_time;
    @ViewById(R.id.tv_car_model)
    protected TextView tv_car_model;
    @ViewById(R.id.tv_vendor_name)
    protected TextView tv_vendor_name;
    @ViewById(R.id.tv_car_date)
    protected TextView tv_car_date;
    @ViewById(R.id.tv_car_status)
    protected TextView tv_car_status;
    @SystemService
    LayoutInflater mLayoutInflater;
    Context context;
    TOrder object;
    int itemCount;
    String date_parse;
    String end_date_parse;
    String time_parse;
    String end_time_parse;

    public PreviousRequestsListRow(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.context = context;
        Init();
    }

    public PreviousRequestsListRow(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        Init();
    }

    private void Init() {
        this.setOnClickListener(this);
    }

    @Override
    public void bindViews(Object obj, int position, RecyclerView recyclerView) {
        this.object = (TOrder) obj;
        if (object == null) return;

        tv_req.setText(object.getId() + "");
        tv_car_status.setText(object.getStatus() + "");
        try {
            tv_vendor_name.setText(object.getVendor().getName() + "");
        } catch (Exception e) {
            e.printStackTrace();

        }
        try {
            SimpleDateFormat sdfSource = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            date_parse = object.getCreated_at() + "";
            Date date = sdfSource.parse(date_parse + "");

            SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat sdfDestination1 = new SimpleDateFormat("hh:mm a");
            date_parse = sdfDestination.format(date);
            time_parse = sdfDestination1.format(date);

            System.out.println("Date is converted from dd/MM/yy format to MMMM dd,yyyy hh:mm a");
            System.out.println("Converted date is : " + date_parse);
            tv_car_time.setText(time_parse);

            tv_car_date.setText(date_parse + "");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        try {
            SimpleDateFormat sdfSource = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            end_date_parse = object.getEnd_time() + "";
            Date date = sdfSource.parse(end_date_parse + "");

            SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat sdfDestination1 = new SimpleDateFormat("hh:mm a");
            end_date_parse = sdfDestination.format(date);
            end_time_parse = sdfDestination1.format(date);

            System.out.println("Date is converted from dd/MM/yy format to MMMM dd,yyyy hh:mm a");
            System.out.println("Converted date is : " + end_date_parse);
            tv_end_car_time.setText(end_time_parse);

            tv_endcar_date.setText(end_date_parse + "");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        if (recyclerView != null && recyclerView.getAdapter() != null) {
            itemCount = recyclerView.getAdapter().getItemCount();
        }

        if (object.getCustomer() != null) {
            tv_name.setText(object.getCustomer().getFullName());
            tv_number.setText(object.getCustomer().getMobile());
        } else {
            tv_name.setText("");
            tv_number.setText("");
        }

        if (object.getService() != null) {
            tv_breakdown_services.setText(object.getService().getTitle());
        } else {
            tv_breakdown_services.setText("");
        }

        if (object.getSubscription() != null && object.getSubscription().getCar() != null) {
            tv_plate.setText(object.getSubscription().getCar().getPlateNumber());
            tv_car_model.setText(object.getSubscription().getCar().getCarName());
        } else {
            tv_plate.setText("");
            tv_car_model.setText("");
        }
    }

    @Override
    public void onClick(View v) {

    }


}
