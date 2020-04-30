package com.app.roadz.modules.Emergency;

import android.content.Intent;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.BaseController;
import com.app.roadz.model.BaseModel.ListBaseResponse;
import com.app.roadz.model.TCar;
import com.app.roadz.model.TPackage;
import com.app.roadz.model.TService;
import com.app.roadz.modules.Home.HomeActivity_;
import com.app.roadz.modules.base.BaseActivity;
import com.app.roadz.recyclerview.DataAdapter;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.ArrayList;
import java.util.List;

import cn.pedant.SweetAlert.SweetAlertDialog;
import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_emergency_subscription)
public class EmergencySubscriptionActivity extends BaseActivity {


    @Extra
    TCar tCar;
    @Extra
    boolean fromRegister;

    @SystemService
    LayoutInflater mLayoutInflater;

    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;

    @ViewById(R.id.carNameTxt)
    protected TextView carNameTxt;

    @ViewById(R.id.priseTxt)
    protected TextView priseTxt;

    @ViewById(R.id.recycler)
    public RecyclerView recycler;

    @ViewById(R.id.progressLayout)
    public LinearLayout progressLayout;

    private DataAdapter adapter;
    List<TService> list_data;

    TPackage tPackage;

    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(getString(R.string.emergency_subscription));
        if (fromRegister) {
            getCars();
        } else {
            GetPakageList();
        }
    }

    private void getCars() {
        progressLayout.setVisibility(View.VISIBLE);
        RetrofitHelper.getRetrofit().create(BaseController.class).getCars().enqueue(new BaseCallback<ListBaseResponse<TCar>>() {
            @Override
            public void onResponse(Call<ListBaseResponse<TCar>> call, retrofit2.Response<ListBaseResponse<TCar>> response) {
                if (response.body() != null) {
                    List<TCar> ObjectList = response.body().getList();
                    if (ObjectList != null && !ObjectList.isEmpty()) {
                        progressLayout.setVisibility(View.GONE);
                        tCar = ObjectList.get(0);
                        GetPakageList();
                        return;
                    }
                }

                MainApplication.Toast(getString(R.string.unexpected_error), SweetAlertDialog.ERROR_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        EmergencySubscriptionActivity.this.finish();
                        HomeActivity_.intent(EmergencySubscriptionActivity.this).
                                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
                    }
                });
            }

            @Override
            public void onFailure(Call<ListBaseResponse<TCar>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.Toast(getString(R.string.unexpected_error), SweetAlertDialog.ERROR_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        EmergencySubscriptionActivity.this.finish();
                        HomeActivity_.intent(EmergencySubscriptionActivity.this).
                                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
                    }
                });
            }
        });
    }

    private void GetPakageList() {
        progressLayout.setVisibility(View.VISIBLE);
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

                initViews();
            }

            @Override
            public void onFailure(Call<ListBaseResponse<TPackage>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                initViews();

            }
        });
    }

    private void initViews() {
        if (tPackage == null) {
            MainApplication.Toast(getString(R.string.unexpected_error), SweetAlertDialog.ERROR_TYPE, new Runnable() {
                @Override
                public void run() {
                    EmergencySubscriptionActivity.this.finish();
                    HomeActivity_.intent(EmergencySubscriptionActivity.this).
                            flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
                }
            });
            return;
        }
        progressLayout.setVisibility(View.GONE);
        InitRecyclerView();

        if (tCar != null) {
            carNameTxt.setText(tCar.getCarName());
        }
        priseTxt.setText(Constants.GetPrise(Utils.doublefmt(tPackage.getPrice()), this));
    }

    private void InitRecyclerView() {

        recycler.setHasFixedSize(true);
        GridLayoutManager gridLayoutManager = new GridLayoutManager(this, 3);
        recycler.setItemAnimator(null);
        recycler.setLayoutManager(gridLayoutManager);
        if (tPackage != null) {
            list_data = tPackage.getServices();
        }
        if (list_data == null)
            list_data = new ArrayList<>();

        adapter = new DataAdapter(R.layout.row_emergency_subscription_servies_list, list_data, recycler);
        recycler.setAdapter(adapter);

    }


    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        if (fromRegister) {
            EmergencySubscriptionActivity.this.finish();
            HomeActivity_.intent(EmergencySubscriptionActivity.this).
                    flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public void onBackPressed() {
        toolbar_back();
    }

    @Click(R.id.subscribeBtn)
    protected void subscribeBtn() {
        EmergencyCheckOut_.intent(this).tCar(tCar).tPackage(tPackage).start();
    }


}
