package com.app.roadzdriver.modules.Home;

import android.content.Context;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.appcompat.widget.AppCompatCheckBox;
import androidx.recyclerview.widget.RecyclerView;

import com.app.roadzdriver.R;
import com.app.roadzdriver.api.BaseCallback;
import com.app.roadzdriver.api.RetrofitHelper;
import com.app.roadzdriver.app.Constants;
import com.app.roadzdriver.app.MainApplication;
import com.app.roadzdriver.controller.BaseController;
import com.app.roadzdriver.model.BaseModel.BaseModel;
import com.app.roadzdriver.model.TOrder;
import com.app.roadzdriver.modules.Order.OrderLocationOnMapActivity_;
import com.app.roadzdriver.modules.base.BaseActivity;
import com.app.roadzdriver.recyclerview.ViewBinder;

import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.HashMap;
import java.util.Map;

import cn.pedant.SweetAlert.SweetAlertDialog;
import retrofit2.Call;
import retrofit2.Response;


@EView
public class HomeListRow extends LinearLayout implements ViewBinder<Object>, View.OnClickListener {

    @ViewById(R.id.tv_name)
    protected TextView tv_name;
    @ViewById(R.id.tv_ref_Id)
    protected TextView tv_ref_Id;
    @ViewById(R.id.tv_number)
    protected TextView tv_number;
    @ViewById(R.id.tv_breakdown_services)
    protected TextView tv_breakdown_services;
    @ViewById(R.id.tv_plate)
    protected TextView tv_plate;
    @ViewById(R.id.tv_req)
    protected TextView tv_req;
    @ViewById(R.id.tv_breakdown_color)
    protected TextView tv_breakdown_color;
    @ViewById(R.id.tv_car_model)
    protected TextView tv_car_model;
    @ViewById(R.id.checkbox)
    protected AppCompatCheckBox checkbox;
    @SystemService
    LayoutInflater mLayoutInflater;
    Context context;
    TOrder object;
    int itemCount;

    public HomeListRow(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.context = context;
        Init();
    }

    public HomeListRow(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        Init();
    }

    private void Init() {
        this.setOnClickListener(this);
    }

    @Override
    public void bindViews(Object obj, int position, RecyclerView recyclerView) {
        this.object = (TOrder) obj;
        if (object == null) return;

        if (recyclerView != null && recyclerView.getAdapter() != null) {
            itemCount = recyclerView.getAdapter().getItemCount();
        }

        tv_req.setText(object.getId() + "");
        if (object.getCustomer() != null) {
            tv_name.setText(object.getCustomer().getFullName());
            tv_number.setText(object.getCustomer().getMobile());
        } else {
            tv_name.setText("");
            tv_number.setText("");
        }

        if (object.getService() != null) {
            tv_breakdown_services.setText(object.getService().getTitle());
        } else {
            tv_breakdown_services.setText("");
        }

        if (object.getSubscription() != null && object.getSubscription().getCar() != null) {
            tv_plate.setText(object.getSubscription().getCar().getPlateNumber());
            tv_car_model.setText(object.getSubscription().getCar().getCarName());
            tv_breakdown_color.setText(object.getSubscription().getCar().getColor());
            tv_ref_Id.setText(object.getSubscription().getRef_id());

        } else {
            tv_plate.setText("");
            tv_car_model.setText("");
        }

        checkbox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                if (b) {
                    MainApplication.ToastWithCancel(getContext().getString(R.string.sure_msg), SweetAlertDialog.NORMAL_TYPE, new Runnable() {
                        @Override
                        public void run() {
                            ChangeOrderStatus();
                        }
                    }, new Runnable() {
                        @Override
                        public void run() {
                            checkbox.setChecked(false);
                        }
                    });
                }
            }
        });


    }

    @Override
    public void onClick(View v) {
        OrderLocationOnMapActivity_.intent(getContext()).tOrder(object).reqestCount(itemCount).start();
    }

    @Click(R.id.deleteICon)
    protected void deleteICon() {
        MainApplication.Toast2(getContext().getString(R.string.cancel_conf), SweetAlertDialog.NORMAL_TYPE, new Runnable() {
            @Override
            public void run() {
                ((BaseActivity) getContext()).ShowProgress();
                Map<String, String> map = new HashMap<>();
                map.put("order_id", object.getId() + "");
                map.put("User_Email", MainApplication.sMyPrefs.UserEmail().getOr(""));
                RetrofitHelper.getRetrofit().create(BaseController.class).CancelOrder(map).enqueue(new BaseCallback<BaseModel>() {

                    @Override
                    public void onResponse(Call<BaseModel> call, Response<BaseModel> response) {
                        ((BaseActivity) getContext()).HideProgress();
                        if (!response.isSuccessful() || response.body() == null) {
                            if (response.body() == null) {
                                Constants.ErrorMsg(response);
                                return;
                            }
                            return;
                        }

                        if (!response.body().getStatus()) {
                            if (!TextUtils.isEmpty(response.body().getMessage())) {
                                MainApplication.Toast(response.body().getMessage());
                            } else {
                                MainApplication.ErrorToast();
                            }
                            return;
                        }

                        String msg = getContext().getString(R.string.order_status_successfully);
                        if (!TextUtils.isEmpty(response.body().getMessage())) {
                            msg = response.body().getMessage();
                        }
                        MainApplication.Toast(msg, SweetAlertDialog.SUCCESS_TYPE, new Runnable() {
                            @Override
                            public void run() {
                                if (getContext() instanceof HomeActivity) {
                                    ((HomeActivity) getContext()).onRefresh();
                                }
                            }
                        });
                    }

                    @Override
                    public void onFailure(Call<BaseModel> call, Throwable t) {
                        Log.d("TAG", "onFailure : " + t.getMessage());
                        MainApplication.ErrorToast();
                        ((BaseActivity) getContext()).HideProgress();
                    }
                });
            }
        });

    }

    public void ChangeOrderStatus() {
        ((BaseActivity) getContext()).ShowProgress();
        Map<String, String> map = new HashMap<>();
        map.put("order_id", object.getId() + "");
        map.put("User_Email", MainApplication.sMyPrefs.UserEmail().getOr(""));
        RetrofitHelper.getRetrofit().create(BaseController.class).ChangeOrderStatus(map).enqueue(new BaseCallback<BaseModel>() {

            @Override
            public void onResponse(Call<BaseModel> call, Response<BaseModel> response) {
                ((BaseActivity) getContext()).HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                    return;
                }

                if (!response.body().getStatus()) {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage());
                    } else {
                        MainApplication.ErrorToast();
                    }
                    return;
                }

                String msg = getContext().getString(R.string.order_status_successfully);
                if (!TextUtils.isEmpty(response.body().getMessage())) {
                    msg = response.body().getMessage();
                }
                MainApplication.Toast(msg, SweetAlertDialog.SUCCESS_TYPE, new Runnable() {
                    @Override
                    public void run() {
                        if (getContext() instanceof HomeActivity) {
                            ((HomeActivity) getContext()).onRefresh();
                        }
                    }
                });
            }

            @Override
            public void onFailure(Call<BaseModel> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                ((BaseActivity) getContext()).HideProgress();
            }
        });
    }

}
