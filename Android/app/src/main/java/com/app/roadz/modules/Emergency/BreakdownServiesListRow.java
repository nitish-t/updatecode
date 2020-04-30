package com.app.roadz.modules.Emergency;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.model.TService;
import com.app.roadz.recyclerview.DataAdapter;
import com.app.roadz.recyclerview.ViewBinder;

import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;


@EView
public class BreakdownServiesListRow extends LinearLayout implements ViewBinder<Object>, View.OnClickListener {

    @SystemService
    LayoutInflater mLayoutInflater;

    @ViewById(R.id.image)
    protected ImageView image;

    @ViewById(R.id.tv_title)
    protected TextView tv_title;

    @ViewById(R.id.progress)
    protected ProgressBar progress;

    @ViewById(R.id.image_bg)
    protected LinearLayout image_bg;

    TService object;
    Context context;
    DataAdapter adapter;
    RecyclerView recyclerView;
    int position;

    public BreakdownServiesListRow(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.context = context;
        Init();
    }

    public BreakdownServiesListRow(Context context, AttributeSet attrs) {
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
        object = (TService) obj;
        adapter = (DataAdapter) recyclerView.getAdapter();
        if (object == null) return;

        if (adapter != null) {
            if (object.getId() == adapter.lastCheckedPosition) {
                image_bg.setSelected(true);
//                image.setColorFilter(ContextCompat.getColor(context, R.color.white), android.graphics.PorterDuff.Mode.SRC_IN);
            } else {
                image_bg.setSelected(false);
//                image.setColorFilter(null);
            }
        }

        if (object.isDemo()){
            image.setImageResource(object.getIcon());
        }else {
            Utils.loadImage(object.getImage(), image, progress);
        }
        tv_title.setText(object.getTitle());

    }


    @Override
    public void onClick(View v) {
        adapter.lastCheckedPosition = object.getId();
        BreakdownServiesListRow.this.recyclerView.post(new Runnable() {
            @Override
            public void run() {
                adapter.notifyDataSetChanged();
            }
        });
    }


}
