package com.app.roadz.modules.Emergency.CarSevies;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.widget.TextView;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.modules.Emergency.LocationOnMapActivity_;
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

import java.io.IOException;
import java.util.List;

import okhttp3.internal.Util;

@EActivity(R.layout.activity_location_on_map)
public class SelectLocationOnMapActivity extends BaseActivity implements OnMapReadyCallback, LocationListener {


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

    @ViewById(R.id.actionBtn)
    TextView actionBtn;

    public static final int PERMISSION_REQUEST_CODE = 5;
    private GoogleMap mMap;
    LocationManager mLocationManager;

    boolean isSelected;
    boolean isGPSEnabled;
    boolean isNetworkEnabled;
    private GoogleMap.OnCameraIdleListener onCameraIdleListener;
    LatLng latLng;
    @AfterViews
    void AfterViews() {
        SupportMapFragment mapFragment =
                (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map);
        mapFragment.getMapAsync(SelectLocationOnMapActivity.this);

        configureCameraIdle();
        txtLocationName.setText("");
        actionBtn.setText(getString(R.string.confirm_location));
        actionBtn.setBackgroundResource(R.drawable.btn_location_grad);
    }

    private void configureCameraIdle() {
        onCameraIdleListener = new GoogleMap.OnCameraIdleListener() {
            @Override
            public void onCameraIdle() {

                latLng = mMap.getCameraPosition().target;
                Geocoder geocoder = new Geocoder(SelectLocationOnMapActivity.this);

                try {
                    List<Address> addressList = geocoder.getFromLocation(latLng.latitude, latLng.longitude, 1);
                    if (addressList != null && addressList.size() > 0) {
                        String locality = addressList.get(0).getAddressLine(0);
                        String country = addressList.get(0).getCountryName();
                        if (locality != null && !locality.isEmpty() && country != null && !country.isEmpty()) {
                            txtLocationName.setText(locality);
                        }else{
                            txtLocationName.setText(Utils.doublefmt(latLng.latitude)+" - "+Utils.doublefmt(latLng.longitude));
                        }
                    }

                } catch (IOException e) {
                    e.printStackTrace();
                }

            }
        };
    }


    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;
        mMap.setOnCameraIdleListener(onCameraIdleListener);
        askLocationPermission();
//        LatLng latLng = new LatLng(latitude, longitude);
//        mMap.addMarker(new MarkerOptions().position(latLng));
//        mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(latLng, 17));
    }

    public void askLocationPermission() {

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED
                || ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {

            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION
                    , Manifest.permission.ACCESS_FINE_LOCATION
            }, PERMISSION_REQUEST_CODE);


        } else {
            checkNetworkProviderEnable();
        }
    }

    public void checkNetworkProviderEnable() {
        mLocationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);


        isGPSEnabled = mLocationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
        isNetworkEnabled = mLocationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);

        if (!isGPSEnabled && !isNetworkEnabled) {

        } else {
            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                return;
            }

            Location location = mLocationManager.getLastKnownLocation(LocationManager.NETWORK_PROVIDER);
            if (location != null) {
                addMapMarker(new LatLng(location.getLatitude(), location.getLongitude()));

                if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                    // TODO: Consider calling
                    //    ActivityCompat#requestPermissions
                    // here to request the missing permissions, and then overriding
                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                    //                                          int[] grantResults)
                    // to handle the case where the user grants the permission. See the documentation
                    // for ActivityCompat#requestPermissions for more details.
                    return;
                }
            }

            mMap.setMyLocationEnabled(true);
//            mLocationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, MIN_TIME,
//                    MIN_DISTANCE, this);
//            mLocationManager.requestSingleUpdate(LocationManager.NETWORK_PROVIDER, this, null);

        }


    }

    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           String permissions[], int[] grantResults) {
        switch (requestCode) {
            case PERMISSION_REQUEST_CODE: {
                // If request is cancelled, the result arrays are empty.
                if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                    return;
                }
                checkNetworkProviderEnable();

            }
        }

    }

    private void addMapMarker(LatLng latLng) {
        mMap.clear();
//        mMap.addMarker(new MarkerOptions().position(latLng));
        mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(latLng, 17));
        isSelected = true;


    }


    @Override
    public void onResume() {
        super.onResume();
    }


    @Click(R.id.actionBtn)
    protected void MakeSubscription() {
        LocationOnMapActivity_.intent(this).car_id(car_id).
                package_id(package_id).service_id(service_id).
                latitude(latLng!=null?latLng.latitude:-1).longitude(latLng!=null?latLng.longitude:-1)
                .FromDemo(FromDemo).locationName(txtLocationName.getText().toString()).start();
//        if (FromDemo) {
//            DemoRequestServiesPaymentStatus_.intent(SelectLocationOnMapActivity.this).start();
//            return;
//        }
    }

    @Override
    public void onLocationChanged(Location location) {
        addMapMarker(new LatLng(location.getLatitude(), location.getLongitude()));
    }

    @Override
    public void onStatusChanged(String s, int i, Bundle bundle) {

    }

    @Override
    public void onProviderEnabled(String s) {

    }

    @Override
    public void onProviderDisabled(String s) {

    }
}
