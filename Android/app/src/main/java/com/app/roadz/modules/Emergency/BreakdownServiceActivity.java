package com.app.roadz.modules.Emergency;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import androidx.recyclerview.widget.GridLayoutManager;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.app.roadz.R;
import com.app.roadz.Utils.UImagePauseOnScrollListener;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.BaseController;
import com.app.roadz.model.BaseModel.ListBaseResponse;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.BaseModel.SubscribeResponse;
import com.app.roadz.model.TCar;
import com.app.roadz.model.TService;
import com.app.roadz.modules.MyCars.AddCarActivity_;
import com.app.roadz.modules.base.BaseActivity;
import com.app.roadz.recyclerview.DataAdapter;
import com.malinskiy.superrecyclerview.SuperRecyclerView;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.schibstedspain.leku.LocationPickerActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.OnActivityResult;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.pedant.SweetAlert.SweetAlertDialog;
import retrofit2.Call;
import retrofit2.Response;

import static com.schibstedspain.leku.LocationPickerActivityKt.LATITUDE;
import static com.schibstedspain.leku.LocationPickerActivityKt.LOCATION_ADDRESS;
import static com.schibstedspain.leku.LocationPickerActivityKt.LONGITUDE;


@EActivity(R.layout.activity_breakdown_service)
public class BreakdownServiceActivity extends BaseActivity implements SwipeRefreshLayout.OnRefreshListener {

    @SystemService
    LayoutInflater mLayoutInflater;

    @Extra
    TCar tCar;

    @Extra
    int packageId;

    public static final int REQUEST_Map_RESULT = 8000;

    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;

    @ViewById(R.id.recycler)
    public SuperRecyclerView recycler;


    private DataAdapter adapter;
    List<TService> list_data;

    double LocationLat = -1;
    double LocationLong = -1;

    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(getString(R.string.select_service));
        InitRecyclerView();

    }

    private void InitRecyclerView() {

        recycler.getRecyclerView().addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));
        recycler.getRecyclerView().setHasFixedSize(true);
        GridLayoutManager gridLayoutManager = new GridLayoutManager(this, 2);
        recycler.getRecyclerView().setItemAnimator(null);
        recycler.getRecyclerView().setLayoutManager(gridLayoutManager);
        list_data = new ArrayList<>();
        adapter = new DataAdapter(R.layout.row_emergency_select_servies, list_data, recycler.getRecyclerView());
        recycler.setAdapter(adapter);
        recycler.showProgress();
        recycler.setRefreshListener(this);
        recycler.setRefreshingColorResources(R.color.colorAccent, R.color.colorAccent, R.color.colorAccent, R.color.colorAccent);
        recycler.getRecyclerView().addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));


        loadData();
    }

    private void loadData() {
        RetrofitHelper.getRetrofit().create(BaseController.class).getPackages(packageId).enqueue(new BaseCallback<ListBaseResponse<TService>>() {
            @Override
            public void onResponse(Call<ListBaseResponse<TService>> call, retrofit2.Response<ListBaseResponse<TService>> response) {
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        recycler.hideProgress();
                        if (adapter.getItem().isEmpty()) {
                            recycler.getEmptyView().setVisibility(View.VISIBLE);
                        }
                        return;
                    }
                }

                List<TService> ObjectList = response.body().getList();

                if (ObjectList == null) ObjectList = new ArrayList<>();
//                if (isFirstPage) {
                adapter.setItems(ObjectList);
                recycler.setAdapter(adapter);
//                    recycler.setupMoreListener(FavoriteListActivity.this, 1);
//                } else {
//                    for (int i = 0; i < adapter.getItemCount(); i++) {
//                        if (!ObjectList.isEmpty() && ObjectList.contains(adapter.getItem(i))) {
//                            ObjectList.remove(adapter.getItem(i));
//                        }
//                    }
//                    adapter.addItems(ObjectList);
//                }

                if (ObjectList.isEmpty()) {
                    recycler.hideProgress();
                    recycler.setupMoreListener(null, 1);
                }
                if (adapter.getItem().isEmpty()) {
                    recycler.getEmptyView().setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onFailure(Call<ListBaseResponse<TService>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                recycler.hideProgress();
                if (adapter.getItem().isEmpty()) {
                    recycler.getEmptyView().setVisibility(View.VISIBLE);
                }
            }
        });
    }

    @Override
    public void onRefresh() {
        if (recycler != null) {
            recycler.showProgress();
        }
        loadData();
    }

    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        super.onBackPressed();
    }


    @Click(R.id.addNewCarBtn)
    protected void addNewCarBtn() {
        AddCarActivity_.intent(this).start();
    }

    @Click(R.id.continueBtn)
    protected void continueBtn() {
        if (adapter.lastCheckedPosition == -1) {
            Utils.ShowMessagePopup(getResources().getString(R.string.error),
                    getString(R.string.select_one_service),
                    getString(R.string.ok), ""
                    , this, mLayoutInflater, new Runnable() {
                        @Override
                        public void run() {

                        }
                    });
        } else {
            Intent locationPickerIntent = new LocationPickerActivity.Builder()
//                .withLocation(LocationLat == 0 ? MainApplication.sMyPrefs.Latitude().get() : LocationLat, LocationLong == 0 ? MainApplication.sMyPrefs.Longitud().get() : LocationLong)
                    .withGeolocApiKey(Constants.GeolocApiKey)
//                .withSearchZone("es_ES")
                    .withGooglePlacesEnabled()
//                .withGoogleTimeZoneEnabled()
                    .build(this);

            startActivityForResult(locationPickerIntent, REQUEST_Map_RESULT);
        }
    }


    @OnActivityResult(REQUEST_Map_RESULT)
    public void onResultMap(int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK && data != null) {
            LocationLat = data.getDoubleExtra(LATITUDE, 0.0);
            LocationLong = data.getDoubleExtra(LONGITUDE, 0.0);
            String address = data.getStringExtra(LOCATION_ADDRESS);
            if (address.contains("Unnamed") || address.contains("طريق"))
                address = "";
            if (LocationLat != 0 || LocationLong != 0) {
                MainApplication.Toast2(getString(R.string.subscribe_service_Package_confirm), SweetAlertDialog.NORMAL_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        MakeSubscription();
                    }
                });


            }
        }
    }

    private void MakeSubscription() {
        Map<String, String> stringStringMap = new HashMap<>();

        stringStringMap.put("package_id", packageId + "");
        if (tCar != null)
            stringStringMap.put("car_id", tCar.getId() + "");

        stringStringMap.put("latitude", LocationLat + "");
        stringStringMap.put("longitude", LocationLong + "");
        stringStringMap.put("service_id", adapter.lastCheckedPosition + "");
        ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).MakeSubscription(stringStringMap).enqueue(new BaseCallback<ObjectBaseResponse<SubscribeResponse>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<SubscribeResponse>> call, Response<ObjectBaseResponse<SubscribeResponse>> response) {
                HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                    return;
                }

                if (!response.body().getStatus()) {
                    RequestServiesPaymentStatus_.intent(BreakdownServiceActivity.this).IsSuccess(false).start();
                } else {
                    RequestServiesPaymentStatus_.intent(BreakdownServiceActivity.this).IsSuccess(true).start();
                }

            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<SubscribeResponse>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        });
    }

}
