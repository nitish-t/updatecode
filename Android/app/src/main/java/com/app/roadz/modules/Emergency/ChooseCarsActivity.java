package com.app.roadz.modules.Emergency;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import androidx.recyclerview.widget.LinearLayoutManager;
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
import com.app.roadz.model.TSubscription;
import com.app.roadz.modules.MyCars.AddCarActivity_;
import com.app.roadz.modules.base.BaseActivity;
import com.app.roadz.modules.base.CallPopup;
import com.app.roadz.recyclerview.DataAdapter;
import com.malinskiy.superrecyclerview.SuperRecyclerView;
import com.nostra13.universalimageloader.core.ImageLoader;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
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


@EActivity(R.layout.activity_choose_cars)
public class ChooseCarsActivity extends BaseActivity implements SwipeRefreshLayout.OnRefreshListener {

    @SystemService
    LayoutInflater mLayoutInflater;


    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;

    @ViewById(R.id.recycler)
    public SuperRecyclerView recycler;


    private DataAdapter adapter;
    List<TCar> list_data;

    public final static int REQUEST_ADD_CAR = 10;


    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(getString(R.string.choose_car));
        InitRecyclerView();

    }

    private void InitRecyclerView() {

        recycler.getRecyclerView().addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));
        recycler.getRecyclerView().setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(this);
        recycler.getRecyclerView().setItemAnimator(null);
        recycler.getRecyclerView().setLayoutManager(linearLayoutManager);
        list_data = new ArrayList<>();
        adapter = new DataAdapter(R.layout.row_choose_cars_list, list_data, recycler.getRecyclerView());
        recycler.setAdapter(adapter);
        recycler.showProgress();
        recycler.setRefreshListener(this);
        recycler.setRefreshingColorResources(R.color.colorAccent, R.color.colorAccent, R.color.colorAccent, R.color.colorAccent);
        recycler.getRecyclerView().addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));
        loadData();
    }


    private void loadData() {
        RetrofitHelper.getRetrofit().create(BaseController.class).getCars().enqueue(new BaseCallback<ListBaseResponse<TCar>>() {
            @Override
            public void onResponse(Call<ListBaseResponse<TCar>> call, retrofit2.Response<ListBaseResponse<TCar>> response) {
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

                List<TCar> ObjectList = response.body().getList();

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
            public void onFailure(Call<ListBaseResponse<TCar>> call, Throwable t) {
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
        AddCarActivity_.intent(this).startForResult(REQUEST_ADD_CAR);
    }

    @OnActivityResult(REQUEST_ADD_CAR)
    public void onResultMap(int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK && data != null) {
            onRefresh();
        }

    }


    @Click(R.id.proceedBtn)
    protected void proceedBtn() {
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
                int package_id = -1;
                TSubscription tSubscription = null;
                if (response.body().getObject() != null)
                    tSubscription = response.body().getObject().getSubscription();
                if (tSubscription != null) {
                    package_id = tSubscription.getPackageId();
                }
                if (response.body().getCode() == 205) {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage(), SweetAlertDialog.NORMAL_TYPE);
                    } else {
                        MainApplication.ErrorToast();
                    }
                } else {
                    ActionView(response.body().getCode(), package_id);
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

    TCar tCarSelect = null;

    protected void ActionView(int Code, int packageId) {

//               202 => false , Subscription Expired اشترراك مخلص بقدر اعمل اشتراك جديد
//               201 => true , you can add new subscription ما عندي اشترراك اصلا وبقدر اعمل اشتراك جديد
//               200 => true , you make order now for one service مشترك وبقد اضيف خدمة
//               203 => false , Your request has been submitted to follow up please call مشترك وضايف خدمة يعني ما بقدر اسوي شي

        for (TCar tCar : (List<TCar>) adapter.getItem()) {
            if (tCar.getId() == adapter.lastCheckedPosition) {
                tCarSelect = tCar;
                break;
            }
        }
        if (Code == 202) {
            Utils.ShowMessagePopup(getResources().getString(R.string.error),
                    getString(R.string.subscription_expired_msg),
                    getString(R.string.renew_btn), getString(R.string.cancel_btn)
                    , this, mLayoutInflater, new Runnable() {
                        @Override
                        public void run() {
                            EmergencySubscriptionActivity_.intent(ChooseCarsActivity.this).tCar(tCarSelect).start();
                        }
                    });
        } else if (Code == 203) {
            CallUsbtn();
//            Utils.ShowMessagePopup(getString(R.string.call_us),
//                    getString(R.string.request_submitted),
//                    getString(R.string.call),
//                    getString(R.string.cancel_btn)
//                    , this, mLayoutInflater, new Runnable() {
//                        @Override
//                        public void run() {
//                            CallUsbtn();
//                        }
//                    });
        } else if (Code == 200) {
            BreakdownServiceActivity_.intent(this).packageId(packageId).tCar(tCarSelect).start();
        } else {
            EmergencySubscriptionActivity_.intent(this).tCar(tCarSelect).start();
        }

    }

    protected void CallUsbtn() {
        final String phoneNumber = MainApplication.sMyPrefs.mobile().get();
        CallPopup messagePopup = (CallPopup) mLayoutInflater.inflate(R.layout.popup_call, null);
        AlertDialog.Builder filterBuilder2 = new AlertDialog.Builder(this);
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
                startActivity(intent);
            }
        });
//        Utils.ShowMessagePopup("",
//                phoneNumber,
//                getString(R.string.call),
//                getString(R.string.cancel_btn)
//                , this, mLayoutInflater, new Runnable() {
//                    @Override
//                    public void run() {
//                        Intent intent = new Intent(Intent.ACTION_DIAL, Uri.fromParts("tel", phoneNumber, null));
//                        startActivity(intent);
//                    }
//                });
    }

}
