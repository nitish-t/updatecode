package com.app.roadz.modules.MySubscriptions;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.model.TSubscription;
import com.app.roadz.recyclerview.ViewBinder;

import net.cachapa.expandablelayout.ExpandableLayout;

import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.ViewById;


@EView
public class MySubscriptionsListRow extends LinearLayout implements ViewBinder<Object>, View.OnClickListener {


    @ViewById(R.id.tv_title)
    protected TextView tv_title;

    @ViewById(R.id.tv_OrderID)
    protected TextView tv_OrderID;

    @ViewById(R.id.tv_CarModel)
    protected TextView tv_CarModel;

    @ViewById(R.id.tv_StartDate)
    protected TextView tv_StartDate;

    @ViewById(R.id.tv_EndDate)
    protected TextView tv_EndDate;

    @ViewById(R.id.tv_Amount)
    protected TextView tv_Amount;

    @ViewById(R.id.expandable_layout)
    protected ExpandableLayout expandable_layout;

    @ViewById(R.id.indicatorIcon)
    protected ImageView indicatorIcon;

    TSubscription object;
    Context context;

    public MySubscriptionsListRow(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.context = context;
        Init();
    }

    public MySubscriptionsListRow(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        Init();
    }

    private void Init() {
        this.setOnClickListener(this);
    }


    @Override
    public void bindViews(Object obj, int position, RecyclerView recyclerView) {
        object = (TSubscription) obj;
        if (object == null) return;

        if (object.getTpackage() != null) {
            tv_title.setText(object.getTpackage().getType());
        } else {
            tv_title.setText("");
        }
        tv_OrderID.setText(object.getRef_id());
        if (object.getCar() != null) {
            tv_CarModel.setText(object.getCar().getCarName());
        } else {
            tv_CarModel.setText("");
        }

        tv_StartDate.setText(Constants.GetStringDateFromString(object.getSubscriptionStart(), "yyyy-MM-dd", "dd / MM / yyyy"));
        tv_EndDate.setText(Constants.GetStringDateFromString(object.getSubscriptionEnd(), "yyyy-MM-dd", "dd / MM / yyyy"));
        tv_Amount.setText(Constants.GetPrise(Utils.doublefmt(object.getFinalTotal()), getContext()));
    }

    @Click(R.id.titleView)
    protected void titleView() {
        if (expandable_layout.isExpanded()) {
            expandable_layout.collapse();
            indicatorIcon.animate().rotation(0).setDuration(500).start();
        } else {
            expandable_layout.expand();
            indicatorIcon.animate().rotation(MainApplication.ISlocaleArabic(context) ? -180 : 180).setDuration(500).start();
        }

    }


    @Override
    public void onClick(View v) {
    }
}
