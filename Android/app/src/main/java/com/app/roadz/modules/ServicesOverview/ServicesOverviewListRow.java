package com.app.roadz.modules.ServicesOverview;

import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.app.roadz.R;
import com.app.roadz.app.MainApplication;
import com.app.roadz.model.TCar;
import com.app.roadz.model.TService;
import com.app.roadz.modules.Emergency.CarSevies.ChooseCarsServicesActivity;
import com.app.roadz.modules.base.CallPopup;
import com.app.roadz.recyclerview.DataAdapter;
import com.app.roadz.recyclerview.ViewBinder;

import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;


@EView
public class ServicesOverviewListRow extends LinearLayout implements ViewBinder<Object>, View.OnClickListener {

    @SystemService
    LayoutInflater mLayoutInflater;



    @ViewById(R.id.image)
    protected ImageView image;

    @ViewById(R.id.tv_title)
    protected TextView tv_title;

    @ViewById(R.id.main_title)
    protected TextView main_title;

    TService object;
    Context context;

    public ServicesOverviewListRow(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.context = context;
        Init();
    }

    public ServicesOverviewListRow(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        Init();
    }

    private void Init() {
        this.setOnClickListener(this);
    }

    @Override
    public void bindViews(Object obj, final int position, RecyclerView recyclerView) {
        object = (TService) obj;
        if (object == null) return;
        try {
            tv_title.setText(object.getTitle());
            tv_title.setVisibility(GONE);
            main_title.setText(object.getDetails());
            image.setImageResource(object.getIcon());
        }catch (Exception ex){
        }
    }
    @Override
    public void onClick(View v) {

    }
}
