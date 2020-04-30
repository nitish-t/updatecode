package com.app.roadzdriver.modules.Order;

import android.content.Intent;
import android.widget.TextView;

import com.app.roadzdriver.R;
import com.app.roadzdriver.model.TOrder;
import com.app.roadzdriver.modules.base.BaseActivity;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.ViewById;

@EActivity(R.layout.activity_location_on_map)
public class OrderLocationOnMapActivity extends BaseActivity implements OnMapReadyCallback {

    @ViewById(R.id.previous_requests)
    protected TextView previous_requests;


    @ViewById(R.id.locationName)
    protected TextView locationName;
    @Extra
    TOrder tOrder;
    @Extra
    int reqestCount = 0;
    private GoogleMap mMap;


    @AfterViews
    void AfterViews() {
        SupportMapFragment mapFragment =
                (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map);
        mapFragment.getMapAsync(OrderLocationOnMapActivity.this);

        if (reqestCount == 0) {
            previous_requests.setText("");
        } else {
            previous_requests.setText(String.format(getResources().getString(R.string.pending_requests), reqestCount + ""));
        }
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;
        addMapMarker();
    }

    private void addMapMarker() {
        if (tOrder == null) return;
        mMap.clear();
        locationName.setText(tOrder.getAddress() + "");
        LatLng latLng = new LatLng(tOrder.getLatitude(), tOrder.getLongitude());
        mMap.addMarker(new MarkerOptions().position(latLng));
        mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(latLng, 17));
    }

    @Click(R.id.shareBtn)
    protected void shareBtn() {
        if (tOrder == null) return;
        String cusomerName = "";
        if (tOrder.getCustomer() != null)
            cusomerName = tOrder.getCustomer().getFullName();
        String Url = "http://maps.google.com/maps?q=loc:" + tOrder.getLatitude() + "," + tOrder.getLongitude();

        Intent sharingIntent = new Intent(android.content.Intent.ACTION_SEND);
        sharingIntent.setType("text/plain");
//        sharingIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, getString(R.string.Customer)cusomerName);
        sharingIntent.putExtra(android.content.Intent.EXTRA_TEXT, Url);
        startActivity(Intent.createChooser(sharingIntent, getResources().getString(R.string.share_using)));
    }
}
