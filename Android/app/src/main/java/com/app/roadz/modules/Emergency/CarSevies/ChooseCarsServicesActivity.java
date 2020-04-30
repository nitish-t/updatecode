package com.app.roadz.modules.Emergency.CarSevies;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.app.roadz.R;
import com.app.roadz.Utils.UImagePauseOnScrollListener;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.BaseController;
import com.app.roadz.model.BaseModel.BaseModel;
import com.app.roadz.model.BaseModel.ListBaseResponse;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.BaseModel.SubscribeResponse;
import com.app.roadz.model.TCar;
import com.app.roadz.model.TPackage;
import com.app.roadz.model.TService;
import com.app.roadz.model.TSubscription;
import com.app.roadz.modules.Emergency.EmergencyCheckOut_;
import com.app.roadz.modules.Emergency.EmergencyPaymentStatus_;
import com.app.roadz.modules.Emergency.EmergencySubscriptionActivity_;
import com.app.roadz.modules.MyCars.AddCarActivity_;
import com.app.roadz.modules.base.BaseActivity;
import com.app.roadz.recyclerview.DataAdapter;
import com.nostra13.universalimageloader.core.ImageLoader;

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


@EActivity(R.layout.activity_choose_cars_v2)
public class ChooseCarsServicesActivity extends BaseActivity implements SwipeRefreshLayout.OnRefreshListener {

    public final static int REQUEST_ADD_CAR = 10;
    public static final int REQUEST_Map_RESULT = 8000;
    @ViewById(R.id.viewSwipeRefresh)
    public SwipeRefreshLayout viewSwipeRefresh;
    @ViewById(R.id.carRecycler)
    public RecyclerView carRecycler;
    @ViewById(R.id.servicesRecycler)
    public RecyclerView servicesRecycler;
    @ViewById(R.id.tvtile)
    public TextView tvtile;
    @ViewById(R.id.proceedBtn)
    public TextView proceedBtn;
    @ViewById(R.id.progressLayout)
    public LinearLayout progressLayout;
    @ViewById(R.id.addNewCarBtn)
    public LinearLayout addNewCarBtn;
    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;
    @SystemService
    LayoutInflater mLayoutInflater;
    @Extra
    boolean FromDemo;
    @Extra
    ArrayList<TService> tServices;
    @Extra
    ArrayList<TCar> tCars;
    List<TCar> list_data;
    List<TService> services_list_data;
    double LocationLat = -1;
    double LocationLong = -1;
    TPackage tPackage;
    TCar tCarSelect;
    TSubscription tSubscription;
    String OrderID;
    String OrderLink;
    private DataAdapter adapter;
    private DataAdapter services_adapter;

    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(getString(R.string.choose_car));

        InitRecyclerView();
        viewSwipeRefresh.setOnRefreshListener(this);
        addNewCarBtn.setVisibility(View.GONE);
//        if (FromDemo) {
//            InitServicesRecyclerView();
//        } else {
        GetPakageList();
//        }
    }

    private void InitRecyclerView() {

        carRecycler.addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));
        carRecycler.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(this);
        carRecycler.setItemAnimator(null);
        carRecycler.setLayoutManager(linearLayoutManager);
        list_data = new ArrayList<>();
        if (FromDemo) {
            list_data.clear();
            list_data.addAll(tCars);
        }
        adapter = new DataAdapter(R.layout.row_choose_cars_list, list_data, carRecycler);
        carRecycler.setAdapter(adapter);

        if (!FromDemo)
            loadData();
    }


    private void loadData() {
        progressLayout.setVisibility(View.VISIBLE);
        RetrofitHelper.getRetrofit().create(BaseController.class).getCars().enqueue(new BaseCallback<ListBaseResponse<TCar>>() {
            @Override
            public void onResponse(Call<ListBaseResponse<TCar>> call, Response<ListBaseResponse<TCar>> response) {
                progressLayout.setVisibility(View.GONE);
                viewSwipeRefresh.setRefreshing(false);
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                }

                List<TCar> ObjectList = response.body().getList();

                if (ObjectList == null) ObjectList = new ArrayList<>();

                adapter.setItems(ObjectList);
                carRecycler.setAdapter(adapter);

            }

            @Override
            public void onFailure(Call<ListBaseResponse<TCar>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                viewSwipeRefresh.setRefreshing(false);
                progressLayout.setVisibility(View.GONE);

            }
        });
    }

    private void GetPakageList() {
        RetrofitHelper.getRetrofit().create(BaseController.class).getPackages().enqueue(new BaseCallback<ListBaseResponse<TPackage>>() {
            @Override
            public void onResponse(Call<ListBaseResponse<TPackage>> call, Response<ListBaseResponse<TPackage>> response) {

                if (response.body() != null) {
                    List<TPackage> tPackages = response.body().getList();
                    for (TPackage object : tPackages) {
                        if ("emergency".equalsIgnoreCase(object.getType())) {
                            tPackage = object;
                            break;
                        }
                    }
                }

                InitServicesRecyclerView();
            }

            @Override
            public void onFailure(Call<ListBaseResponse<TPackage>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                InitServicesRecyclerView();

            }
        });
    }

    private void InitServicesRecyclerView() {

        servicesRecycler.setHasFixedSize(true);
        GridLayoutManager gridLayoutManager = new GridLayoutManager(this, 3);
        servicesRecycler.setItemAnimator(null);
        servicesRecycler.setLayoutManager(gridLayoutManager);
        if (tPackage != null) {
            services_list_data = tPackage.getServices();
        }
        if (services_list_data == null)
            services_list_data = new ArrayList<>();
//        if (FromDemo) {
//            services_list_data.clear();
//            services_list_data.addAll(tServices);
//        }

        if (tCarSelect != null && tCarSelect.getSubscription() != null) {
            services_adapter = new DataAdapter(R.layout.row_emergency_select_servies, services_list_data, servicesRecycler);
        } else {
            services_adapter = new DataAdapter(R.layout.row_emergency_subscription_servies_list, services_list_data, servicesRecycler);
        }
        servicesRecycler.setAdapter(services_adapter);

    }

    @Override
    public void onRefresh() {
        if (FromDemo) {
            viewSwipeRefresh.setRefreshing(false);
            return;
        }
        loadData();
    }

    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        super.onBackPressed();
    }


    @Click(R.id.addNewCarBtn)
    protected void addNewCarBtn() {
        AddCarActivity_.intent(this).startForResult(REQUEST_ADD_CAR);
    }

    @OnActivityResult(REQUEST_ADD_CAR)
    public void onResultAddCar(int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK && data != null) {
            onRefresh();
        }
    }


    @Click(R.id.nextBtn)
    protected void nextBtn() {
        if (adapter.lastCheckedPosition == -1) {
            Utils.ShowMessagePopup(getResources().getString(R.string.error),
                    getString(R.string.need_choose_car),
                    getString(R.string.ok), ""
                    , this, mLayoutInflater, new Runnable() {
                        @Override
                        public void run() {
                        }
                    });
        } else {
            if (FromDemo) {
                openMapToSelectLocation();
                return;
            }
            CheckSubscription();
        }
    }

    public void CheckSubscription() {
        Map<String, String> stringStringMap = new HashMap<>();
        stringStringMap.put("car_id", adapter.lastCheckedPosition + "");
        ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).CheckSubscription(stringStringMap).enqueue(new BaseCallback<ObjectBaseResponse<SubscribeResponse>>() {

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
//               202 => false , Subscription Expired اشترراك مخلص بقدر اعمل اشتراك جديد
//               201 => true , you can add new subscription ما عندي اشترراك اصلا وبقدر اعمل اشتراك جديد
//               200 => true , you make order now for one service مشترك وبقد اضيف خدمة
//               203 => false , Your request has been submitted to follow up please call مشترك وضايف خدمة يعني ما بقدر اسوي شي
//               205 => false , Your Subscription Is Not Active
                if (response.body().getObject() != null) {
                    tSubscription = response.body().getObject().getSubscription();
                    OrderID = response.body().getObject().getOrderId();
                    OrderLink = response.body().getObject().getLink();
                }
                if (response.body().getCode() == 202 || response.body().getCode() == 203
                        || response.body().getCode() == 201 || response.body().getCode() == 200 || response.body().getCode() == 207) {
                    ActionView(response.body().getCode());
                } else {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage(), SweetAlertDialog.NORMAL_TYPE);
                    } else {
                        MainApplication.ErrorToast();
                    }
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


    protected void ActionView(int Code) {

//               202 => false , Subscription Expired اشترراك مخلص بقدر اعمل اشتراك جديد
//               201 => true , you can add new subscription ما عندي اشترراك اصلا وبقدر اعمل اشتراك جديد
//               200 => true , you make order now for one service مشترك وبقد اضيف خدمة
//               203 => false , Your request has been submitted to follow up please call مشترك وضايف خدمة يعني ما بقدر اسوي شي

        if (tCarSelect == null) {
            for (TCar tCar : (List<TCar>) adapter.getItem()) {
                if (tCar.getId() == adapter.lastCheckedPosition) {
                    tCarSelect = tCar;
                    break;
                }
            }
        }
        if (Code == 202) {
            Utils.ShowMessagePopup(getResources().getString(R.string.error),
                    getString(R.string.subscription_expired_msg),
                    getString(R.string.renew_btn), getString(R.string.cancel_btn)
                    , this, mLayoutInflater, new Runnable() {
                        @Override
                        public void run() {
                            EmergencySubscriptionActivity_.intent(ChooseCarsServicesActivity.this).tCar(tCarSelect).start();
                        }
                    });
        } else if (Code == 203) {
            Utils.ShowMessagePopup(getString(R.string.call_us),
                    getString(R.string.request_submitted),
                    getString(R.string.call),
                    getString(R.string.cancel_btn)
                    , this, mLayoutInflater, new Runnable() {
                        @Override
                        public void run() {
                            CallUsbtn();
                        }
                    });
        } else if (Code == 200) {
//            BreakdownServiceActivity_.intent(this).packageId(packageId).tCar(tCarSelect).start();
            openMapToSelectLocation();
        } else if (Code == 207) {
//            StaticDataActivity_.intent(this).Type(4).Url(OrderLink).start();
            EmergencyCheckOut_.intent(this).tCar(tCarSelect).tPackage(tPackage).start();
        } else {
            EmergencyCheckOut_.intent(this).tCar(tCarSelect).tPackage(tPackage).start();
//            EmergencySubscriptionActivity_.intent(this).tCar(tCarSelect).start();
        }

    }

    @Override
    protected void onResume() {
        super.onResume();
        if (!TextUtils.isEmpty(OrderID)) {
            CheckPayment();
        }
    }

    public void CheckPayment() {
        Map<String, String> stringStringMap = new HashMap<>();
        stringStringMap.put("order_id", OrderID);
        ShowProgress();
        RetrofitHelper.getRetrofit().create(BaseController.class).CheckPayment(stringStringMap).enqueue(new BaseCallback<BaseModel>() {

            @Override
            public void onResponse(Call<BaseModel> call, Response<BaseModel> response) {
                HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                    return;
                }

                if (!response.body().getStatus()) {
//                    ShowWebDialog(true);
//                    EmergencyPaymentStatus_.intent(ChooseCarsServicesActivity.this).tSubscription(tSubscription).OrderID(OrderID).OrderLink(OrderLink).IsSuccess(false).start();
                } else {
                    EmergencyPaymentStatus_.intent(ChooseCarsServicesActivity.this).tSubscription(tSubscription).OrderID(OrderID).OrderLink(OrderLink).IsSuccess(true).start();
                }


            }

            @Override
            public void onFailure(Call<BaseModel> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        });
    }

//    public void CheckPayment() {
//        Map<String, String> stringStringMap = new HashMap<>();
//        stringStringMap.put("order_id", OrderID);
//        ShowProgress();
//        RetrofitHelper.getRetrofit().create(BaseController.class).CheckPayment(stringStringMap).enqueue(new BaseCallback<BaseModel>() {
//
//            @Override
//            public void onResponse(Call<BaseModel> call, Response<BaseModel> response) {
//                HideProgress();
//                if (!response.isSuccessful() || response.body() == null) {
//                    if (response.body() == null) {
//                        Constants.ErrorMsg(response);
//                        return;
//                    }
//                    return;
//                }
//
//                if (!response.body().getStatus()) {
//                    ShowWebDialog(true);
//                } else {
//                    EmergencyPaymentStatus_.intent(EmergencyCheckOut.this).tSubscription(subscription).IsSuccess(true).start();
//                }
//
//
//            }
//
//            @Override
//            public void onFailure(Call<BaseModel> call, Throwable t) {
//                Log.d("TAG", "onFailure : " + t.getMessage());
//                MainApplication.ErrorToast();
//                HideProgress();
//            }
//        });
//    }

    private void openMapToSelectLocation() {
        if (services_adapter.lastCheckedPosition == -1) {
            Utils.ShowMessagePopup(getResources().getString(R.string.error),
                    getString(R.string.select_one_service),
                    getString(R.string.ok), ""
                    , this, mLayoutInflater, new Runnable() {
                        @Override
                        public void run() {

                        }
                    });
        } else {
            SelectLocationOnMapActivity_.intent(this).car_id(adapter.lastCheckedPosition).
                    package_id(tPackage != null ? tPackage.getId() : -1)
                    .service_id(services_adapter.lastCheckedPosition).FromDemo(FromDemo).start();
//            Intent locationPickerIntent = new LocationPickerActivity.Builder()
////                .withLocation(LocationLat == 0 ? MainApplication.sMyPrefs.Latitude().get() : LocationLat, LocationLong == 0 ? MainApplication.sMyPrefs.Longitud().get() : LocationLong)
//                    .withGeolocApiKey(Constants.GeolocApiKey)
////                .withSearchZone("es_ES")
//                    .withGooglePlacesEnabled()
////                .withGoogleTimeZoneEnabled()
//                    .build(this);
//
//            startActivityForResult(locationPickerIntent, REQUEST_Map_RESULT);
        }
    }

//    @OnActivityResult(REQUEST_Map_RESULT)
//    public void onResultMap(int resultCode, Intent data) {
//        if (resultCode == Activity.RESULT_OK && data != null) {
//            LocationLat = data.getDoubleExtra(LATITUDE, 0.0);
//            LocationLong = data.getDoubleExtra(LONGITUDE, 0.0);
//            String address = data.getStringExtra(LOCATION_ADDRESS);
//            if (address.contains("Unnamed") || address.contains("طريق"))
//                address = LocationLat + " , " + LocationLong;
//            if (LocationLat != 0 || LocationLong != 0) {
//                LocationOnMapActivity_.intent(this).car_id(adapter.lastCheckedPosition).
//                        package_id(tPackage != null ? tPackage.getId() : -1).service_id(services_adapter.lastCheckedPosition).
//                        latitude(LocationLat).longitude(LocationLong).FromDemo(FromDemo).locationName(address).start();
//            }
//        }
//    }

    protected void CallUsbtn() {
        final String phoneNumber = MainApplication.sMyPrefs.mobile().get();
        Utils.ShowMessagePopup("",
                phoneNumber,
                getString(R.string.call),
                getString(R.string.cancel_btn)
                , this, mLayoutInflater, new Runnable() {
                    @Override
                    public void run() {
                        Intent intent = new Intent(Intent.ACTION_DIAL, Uri.fromParts("tel", phoneNumber, null));
                        startActivity(intent);
                    }
                });
    }

    public void UpdateMainView(TCar tCarSelect) {
        Log.d("vihalsd", "aldkishf");
        this.tCarSelect = tCarSelect;
        if (tCarSelect.getSubscription() == null) {
            proceedBtn.setText(R.string.subscribe);
            tvtile.setVisibility(View.GONE);
            servicesRecycler.setVisibility(View.GONE);
        } else {
            if (tCarSelect.getSubscription().getStatus().equals("active")) {
                tvtile.setVisibility(View.VISIBLE);
                servicesRecycler.setVisibility(View.VISIBLE);
            } else {
                tvtile.setVisibility(View.GONE);
                servicesRecycler.setVisibility(View.GONE);
            }
            proceedBtn.setText(R.string.proceed1);
        }
        InitServicesRecyclerView();
    }
}
