package com.app.roadz.modules.Emergency;

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
import com.app.roadz.Utils.Utils;
import com.app.roadz.app.MainApplication;
import com.app.roadz.model.TCar;
import com.app.roadz.modules.Emergency.CarSevies.ChooseCarsServicesActivity;
import com.app.roadz.modules.base.CallPopup;
import com.app.roadz.recyclerview.DataAdapter;
import com.app.roadz.recyclerview.ViewBinder;

import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;


@EView
public class ChooseCarsListRow extends LinearLayout implements ViewBinder<Object>, View.OnClickListener {

    @SystemService
    LayoutInflater mLayoutInflater;

    @ViewById(R.id.mainView)
    protected LinearLayout mainView;

    @ViewById(R.id.callImage)
    protected ImageView callImage;

    @ViewById(R.id.tv_title)
    protected TextView tv_title;

    TCar object;
    Context context;
    DataAdapter adapter;
    RecyclerView recyclerView;
    int position;

    public ChooseCarsListRow(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.context = context;
        Init();
    }

    public ChooseCarsListRow(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        Init();
    }

    private void Init() {
        this.setOnClickListener(this);
    }


    @Override
    public void bindViews(Object obj, final int position, RecyclerView recyclerView) {
        this.position = position;
        this.recyclerView = recyclerView;
        object = (TCar) obj;
        adapter = (DataAdapter) recyclerView.getAdapter();
        if (object == null) return;

        tv_title.setText(object.getCarName());
        if (object.isHas_open_request()) {
            callImage.setVisibility(VISIBLE);
        } else {
            callImage.setVisibility(GONE);
        }
        if (adapter != null) {
            mainView.setSelected(object.getId() == adapter.lastCheckedPosition);
        }
    }


    @Override
    public void onClick(View v) {
        if (object == null) return;
        if (object.isHas_open_request()) {
            CallUsbtn();
//            Utils.ShowMessagePopup(getContext().getString(R.string.call_us),
//                    getContext().getString(R.string.request_submitted),
//                    getContext().getString(R.string.call),
//                    getContext().getString(R.string.cancel_btn)
//                    , getContext(), mLayoutInflater, new Runnable() {
//                        @Override
//                        public void run() {
//                            CallUsbtn();
//                        }
//                    });
        } else {
            if (!mainView.isSelected())

                UpdateLayout();
        }
    }

    protected void UpdateLayout() {
        if (object == null) return;
        adapter.lastCheckedPosition = object.getId();
        ChooseCarsListRow.this.recyclerView.post(new Runnable() {
            @Override
            public void run() {
                adapter.notifyDataSetChanged();
            }
        });
        if (getContext() instanceof ChooseCarsServicesActivity) {
            ((ChooseCarsServicesActivity) getContext()).UpdateMainView(object);
        }
    }

    protected void CallUsbtn() {
        final String phoneNumber = MainApplication.sMyPrefs.emergancy_phone().get();
        CallPopup messagePopup = (CallPopup) mLayoutInflater.inflate(R.layout.popup_call, null);
        AlertDialog.Builder filterBuilder2 = new AlertDialog.Builder(context);
        filterBuilder2.setView(messagePopup);
        AlertDialog filterAlertDialog2 = filterBuilder2.create();
        filterAlertDialog2.setCancelable(false);
        filterAlertDialog2.setCanceledOnTouchOutside(true);
        filterAlertDialog2.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        filterAlertDialog2.show();
        messagePopup.setDialogInstans(filterAlertDialog2, new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(Intent.ACTION_DIAL, Uri.fromParts("tel", phoneNumber, null));
                getContext().startActivity(intent);
            }
        });
    }
}
