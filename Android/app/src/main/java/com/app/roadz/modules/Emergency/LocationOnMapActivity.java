package com.app.roadz.modules.Emergency;

import android.util.Log;
import android.view.LayoutInflater;
import android.widget.TextView;

import com.app.roadz.R;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.BaseController;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.BaseModel.SubscribeResponse;
import com.app.roadz.modules.ServicesOverview.DemoRequestServiesPaymentStatus_;
import com.app.roadz.modules.base.BaseActivity;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.HashMap;
import java.util.Map;

import retrofit2.Call;
import retrofit2.Response;

@EActivity(R.layout.activity_location_on_map)
public class LocationOnMapActivity extends BaseActivity implements OnMapReadyCallback {

    @Extra
    double latitude;
    @Extra
    double longitude;
    @Extra
    String locationName;
    @Extra
    int service_id;
    @Extra
    int car_id;
    @Extra
    int package_id;
    @Extra
    boolean FromDemo;
    @SystemService
    LayoutInflater mLayoutInflater;
    @ViewById(R.id.locationName)
    TextView txtLocationName;

    private GoogleMap mMap;


    @AfterViews
    void AfterViews() {
        SupportMapFragment mapFragment =
                (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map);
        mapFragment.getMapAsync(LocationOnMapActivity.this);

        txtLocationName.setText(locationName);
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;

        LatLng latLng = new LatLng(latitude, longitude);
//        mMap.addMarker(new MarkerOptions().position(latLng));
        mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(latLng, 17));
    }

    @Override
    public void onResume() {
        super.onResume();
    }

    @Click(R.id.actionBtn)
    protected void MakeSubscription() {
        if (FromDemo) {
            DemoRequestServiesPaymentStatus_.intent(LocationOnMapActivity.this).start();
            return;
        }
        Map<String, String> stringStringMap = new HashMap<>();
        stringStringMap.put("package_id", package_id + "");
        stringStringMap.put("car_id", car_id + "");
        stringStringMap.put("address", txtLocationName.getText() + "");
        stringStringMap.put("latitude", latitude + "");
        stringStringMap.put("longitude", longitude + "");
        stringStringMap.put("service_id", service_id + "");
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
                    RequestServiesPaymentStatus_.intent(LocationOnMapActivity.this).IsSuccess(false).start();
                } else {
                    RequestServiesPaymentStatus_.intent(LocationOnMapActivity.this).IsSuccess(true).start();
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
