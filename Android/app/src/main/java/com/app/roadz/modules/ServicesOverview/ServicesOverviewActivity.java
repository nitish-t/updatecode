package com.app.roadz.modules.ServicesOverview;

import android.widget.TextView;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.app.roadz.R;
import com.app.roadz.Utils.UImagePauseOnScrollListener;
import com.app.roadz.model.TCar;
import com.app.roadz.model.TService;
import com.app.roadz.modules.Emergency.CarSevies.ChooseCarsServicesActivity_;
import com.app.roadz.modules.base.BaseActivity;
import com.app.roadz.recyclerview.DataAdapter;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nostra13.universalimageloader.core.ImageLoader;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@EActivity(R.layout.activity_services_overview)
public class ServicesOverviewActivity extends BaseActivity {

    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;

    @ViewById(R.id.recycler)
    protected RecyclerView recycler;


    ArrayList<TService> list_data;
    ArrayList<TCar> tCars;
    private DataAdapter adapter;

    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(getString(R.string.services_overview));

        SetData();
        SetCars();

        InitRecyclerView();


    }

    private void SetCars() {

        String CarsJson = "[{\n" +
                "\t\"id\": 15,\n" +
                "\t\"customer_id\": \"3\",\n" +
                "\t\"car_maker_id\": \"14\",\n" +
                "\t\"car_model_id\": \"74\",\n" +
                "\t\"car_year_id\": \"314\",\n" +
                "\t\"plate_number\": \"14 - 56788888\",\n" +
                "\t\"color\": \"1234555\",\n" +
                "\t\"has_open_request\": false,\n" +
                "\t\"demo\": true,\n" +
                "\t\"car_maker\": {\n" +
                "\t\t\"id\": 14,\n" +
                "\t\t\"title\": \"Toyota\"\n" +
                "\t},\n" +
                "\t\"car_model\": {\n" +
                "\t\t\"id\": 74,\n" +
                "\t\t\"car_maker_id\": \"14\",\n" +
                "\t\t\"title\": \"land cruiser\"\n" +
                "\t},\n" +
                "\t\"car_year\": {\n" +
                "\t\t\"id\": 314,\n" +
                "\t\t\"car_model_id\": \"74\",\n" +
                "\t\t\"title\": \"2020\"\n" +
                "\t},\n" +
                "\t\"subscription\": {\n" +
                "\t\t\"id\": 19,\n" +
                "\t\t\"ref_id\": null,\n" +
                "\t\t\"customer_id\": \"3\",\n" +
                "\t\t\"car_id\": \"15\",\n" +
                "\t\t\"package_id\": \"1\",\n" +
                "\t\t\"price\": \"15\",\n" +
                "\t\t\"coupon\": null,\n" +
                "\t\t\"coupon_discount_percentage\": \"0\",\n" +
                "\t\t\"final_total\": \"15\",\n" +
                "\t\t\"status\": \"active\",\n" +
                "\t\t\"subscription_start\": \"2019-07-29\",\n" +
                "\t\t\"subscription_end\": \"2020-07-29\"\n" +
                "\t}\n" +
                "}, {\n" +
                "\t\"id\": 35,\n" +
                "\t\"customer_id\": \"3\",\n" +
                "\t\"car_maker_id\": \"1\",\n" +
                "\t\"car_model_id\": \"41\",\n" +
                "\t\"car_year_id\": \"121\",\n" +
                "\t\"plate_number\": \"17 - 8999\",\n" +
                "\t\"color\": \"we\",\n" +
                "\t\"has_open_request\": false,\n" +
                "\t\"demo\": true,\n" +
                "\t\"car_maker\": {\n" +
                "\t\t\"id\": 1,\n" +
                "\t\t\"title\": \"Nissan\"\n" +
                "\t},\n" +
                "\t\"car_model\": {\n" +
                "\t\t\"id\": 41,\n" +
                "\t\t\"car_maker_id\": \"1\",\n" +
                "\t\t\"title\": \"Patrol\"\n" +
                "\t},\n" +
                "\t\"car_year\": {\n" +
                "\t\t\"id\": 121,\n" +
                "\t\t\"car_model_id\": \"41\",\n" +
                "\t\t\"title\": \"2020\"\n" +
                "\t},\n" +
                "\t\"subscription\": {\n" +
                "\t\t\"id\": 61,\n" +
                "\t\t\"ref_id\": \"#10061\",\n" +
                "\t\t\"customer_id\": \"3\",\n" +
                "\t\t\"car_id\": \"35\",\n" +
                "\t\t\"package_id\": \"1\",\n" +
                "\t\t\"price\": \"15\",\n" +
                "\t\t\"coupon\": null,\n" +
                "\t\t\"coupon_discount_percentage\": \"0\",\n" +
                "\t\t\"final_total\": \"15\",\n" +
                "\t\t\"status\": \"active\",\n" +
                "\t\t\"subscription_start\": \"2019-08-04\",\n" +
                "\t\t\"subscription_end\": \"2020-08-04\"\n" +
                "\t}\n" +
                "}, {\n" +
                "\t\"id\": 89,\n" +
                "\t\"customer_id\": \"3\",\n" +
                "\t\"car_maker_id\": \"14\",\n" +
                "\t\"car_model_id\": \"34\",\n" +
                "\t\"car_year_id\": \"194\",\n" +
                "\t\"plate_number\": \"12 - 6543\",\n" +
                "\t\"color\": \"cdrvvdvr\",\n" +
                "\t\"has_open_request\": false,\n" +
                "\t\"demo\": true,\n" +
                "\t\"car_maker\": {\n" +
                "\t\t\"id\": 14,\n" +
                "\t\t\"title\": \"Chevrolet\"\n" +
                "\t},\n" +
                "\t\"car_model\": {\n" +
                "\t\t\"id\": 34,\n" +
                "\t\t\"car_maker_id\": \"14\",\n" +
                "\t\t\"title\": \"Tahoe\"\n" +
                "\t},\n" +
                "\t\"car_year\": {\n" +
                "\t\t\"id\": 194,\n" +
                "\t\t\"car_model_id\": \"34\",\n" +
                "\t\t\"title\": \"2020\"\n" +
                "\t},\n" +
                "\t\"subscription\": {\n" +
                "\t\t\"id\": 62,\n" +
                "\t\t\"ref_id\": \"#10062\",\n" +
                "\t\t\"customer_id\": \"3\",\n" +
                "\t\t\"car_id\": \"89\",\n" +
                "\t\t\"package_id\": \"1\",\n" +
                "\t\t\"price\": \"15\",\n" +
                "\t\t\"coupon\": null,\n" +
                "\t\t\"coupon_discount_percentage\": \"0\",\n" +
                "\t\t\"final_total\": \"15\",\n" +
                "\t\t\"status\": \"active\",\n" +
                "\t\t\"subscription_start\": \"2019-08-04\",\n" +
                "\t\t\"subscription_end\": \"2020-08-04\"\n" +
                "\t}\n" +
                "}]";
        try {
            tCars = new ObjectMapper().readValue(CarsJson, new TypeReference<List<TCar>>() {
            });
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void SetData() {
        list_data = new ArrayList<>();
        TService tService1 = new TService();
        tService1.setId(1);
        tService1.setIcon(R.drawable.ic_car_battery);
        tService1.setTitle(getString(R.string.demo_title1));
        tService1.setDetails(getString(R.string.demo_details1));
        tService1.setDemo(true);
        list_data.add(tService1);

        TService tService2 = new TService();
        tService2.setId(2);
        tService2.setIcon(R.drawable.ic_demo2);
        tService2.setTitle(getString(R.string.demo_title2));
        tService2.setDetails(getString(R.string.demo_details2));
        tService2.setDemo(true);
        list_data.add(tService2);

        TService tService3 = new TService();
        tService3.setId(3);
        tService3.setIcon(R.drawable.ic_demo3);
        tService3.setTitle(getString(R.string.demo_title3));
        tService3.setDetails(getString(R.string.demo_details3));
        tService3.setDemo(true);
        list_data.add(tService3);

        TService tService4 = new TService();
        tService4.setId(4);
        tService4.setIcon(R.drawable.ic_demo4);
        tService4.setTitle(getString(R.string.demo_title4));
        tService4.setDetails(getString(R.string.demo_details4));
        tService4.setDemo(true);
        list_data.add(tService4);

        TService tService5 = new TService();
        tService5.setId(5);
        tService5.setIcon(R.drawable.ic_demo5);
        tService5.setTitle(getString(R.string.demo_title5));
        tService5.setDetails(getString(R.string.demo_details5));
        tService5.setDemo(true);
        list_data.add(tService5);
    }

    private void InitRecyclerView() {

        recycler.addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));
        recycler.setHasFixedSize(true);
        LinearLayoutManager gridLayoutManager = new LinearLayoutManager(this);
        recycler.setItemAnimator(null);
        recycler.setLayoutManager(gridLayoutManager);
        if (list_data == null)
            list_data = new ArrayList<>();
        adapter = new DataAdapter(R.layout.row_servies_overview, list_data, recycler);
        recycler.setAdapter(adapter);
    }

    @Click(R.id.nextBtn)
    protected void nextBtn() {
        ChooseCarsServicesActivity_.intent(this).FromDemo(true).tCars(tCars).tServices(list_data).start();
    }


}
