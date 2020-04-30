package com.app.roadz.modules.OurServices;

import android.text.Html;
import android.widget.ScrollView;
import android.widget.TextView;

import com.app.roadz.R;
import com.app.roadz.app.MainApplication;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.ViewById;


@EActivity(R.layout.activity_our_services)
public class OurServicesActivity extends BaseActivity {

    @Extra
    boolean ShowEmergency = false;

    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;

//    @ViewById(R.id.tv_maintenance)
//    protected TextView tv_maintenance;

    @ViewById(R.id.tv_emergency)
    protected TextView tv_emergency;

    @ViewById(R.id.tv_data)
    protected TextView tv_data;

    @ViewById(R.id.scrollView)
    protected ScrollView scrollView;

    String maintenanceData;
    String emergencyData;

    @AfterViews
    protected void AfterViews() {
        toolbar_title.setText(R.string.menu_services);

        maintenanceData = MainApplication.sMyPrefs.service_maintenance().get();
        emergencyData = MainApplication.sMyPrefs.service_emergency().get();

        tv_data.setText(Html.fromHtml(emergencyData));

    }

    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        super.onBackPressed();
    }

}
