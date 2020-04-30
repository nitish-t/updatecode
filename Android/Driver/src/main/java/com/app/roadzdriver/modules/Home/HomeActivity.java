package com.app.roadzdriver.modules.Home;

import android.content.res.Configuration;
import android.os.Bundle;
import android.os.Handler;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.EditorInfo;
import android.widget.EditText;
import android.widget.TextView;

import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.app.roadzdriver.R;
import com.app.roadzdriver.Utils.UImagePauseOnScrollListener;
import com.app.roadzdriver.api.BaseCallback;
import com.app.roadzdriver.api.RetrofitHelper;
import com.app.roadzdriver.app.Constants;
import com.app.roadzdriver.app.MainApplication;
import com.app.roadzdriver.controller.BaseController;
import com.app.roadzdriver.model.BaseModel.ListBaseResponse;
import com.app.roadzdriver.model.BaseModel.ObjectBaseResponse;
import com.app.roadzdriver.model.TOrder;
import com.app.roadzdriver.model.TUser;
import com.app.roadzdriver.modules.base.BaseActivity;
import com.app.roadzdriver.recyclerview.DataAdapter;
import com.malinskiy.superrecyclerview.SuperRecyclerView;
import com.nostra13.universalimageloader.core.ImageLoader;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import retrofit2.Call;
import retrofit2.Response;

@EActivity(R.layout.activity_home)
public class HomeActivity extends BaseActivity implements SwipeRefreshLayout.OnRefreshListener {

    @ViewById(R.id.drowarLayout)
    public DrawerLayout drawerLayout;

    @ViewById(R.id.recycler)
    public SuperRecyclerView recycler;

    @ViewById(R.id.previous_requests)
    protected TextView previous_requests;

    @ViewById(R.id.editText)
    protected EditText editText;


    public DataAdapter adapter;
    List<TOrder> list_data;

    Handler handler;
    Runnable runnable;
    int delay;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);
    }

    @AfterViews
    protected void AfterViews() {

        SendFCMToken();
        previous_requests.setText("");
        InitRecyclerView();

        editText.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                    onRefresh();
                    return true;
                }
                return false;
            }
        });

        handler = new Handler();
        delay = 15 * 1000; //milliseconds

        runnable = new Runnable() {
            @Override
            public void run() {
                loadData();
                handler.postDelayed(this, delay);
            }
        };
        handler.postDelayed(runnable, delay);

    }

    @Override
    protected void onPause() {
        super.onPause();
        if (handler != null && runnable != null) {
            handler.removeCallbacks(runnable);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (handler != null && runnable != null) {
            handler.postDelayed(runnable, 1000);
        }
    }

    private void InitRecyclerView() {

        recycler.getRecyclerView().addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));
        recycler.getRecyclerView().setHasFixedSize(true);
        int orientation = this.getResources().getConfiguration().orientation;
        int spanCount;
        if (orientation == Configuration.ORIENTATION_PORTRAIT) {
            // code for portrait mode
            spanCount = 2;
        } else {
            // code for landscape mode
            spanCount = 3;
        }
        GridLayoutManager linearLayoutManager = new GridLayoutManager(this, spanCount);
        recycler.getRecyclerView().setItemAnimator(null);
        recycler.getRecyclerView().setLayoutManager(linearLayoutManager);
        list_data = new ArrayList<>();
        adapter = new DataAdapter(R.layout.row_home_list, list_data, recycler.getRecyclerView());
        recycler.setAdapter(adapter);
        recycler.showProgress();
        recycler.setRefreshListener(this);
        recycler.setRefreshingColorResources(R.color.colorAccent, R.color.colorAccent, R.color.colorAccent, R.color.colorAccent);
        recycler.getRecyclerView().addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));
        loadData();
    }

    private void loadData() {
        Map<String, String> map = new HashMap<>();
        map.put("status", "waiting");
        if (!TextUtils.isEmpty(editText.getText().toString()))
            map.put("mobile", editText.getText().toString());
        RetrofitHelper.getRetrofit().create(BaseController.class).getOrders(map).enqueue(new BaseCallback<ListBaseResponse<TOrder>>() {
            @Override
            public void onResponse(Call<ListBaseResponse<TOrder>> call, retrofit2.Response<ListBaseResponse<TOrder>> response) {
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

                List<TOrder> ObjectList = response.body().getList();

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
                UpdarePreviousRequest();
            }

            @Override
            public void onFailure(Call<ListBaseResponse<TOrder>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                recycler.hideProgress();
                if (adapter.getItem().isEmpty()) {
                    recycler.getEmptyView().setVisibility(View.VISIBLE);
                }
                UpdarePreviousRequest();
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

    private void SendFCMToken() {
        if (TextUtils.isEmpty(MainApplication.sMyPrefs.FcmToken().get())) return;
//        if (MainApplication.sMyPrefs.ISFcmSend().get()) return;
        Map<String, String> Data = new HashMap<>();
        Data.put("token", MainApplication.sMyPrefs.FcmToken().get());
        Data.put("type", "2");
        RetrofitHelper.getRetrofit().create(BaseController.class).SendFcmToken(Data).enqueue(new BaseCallback<ObjectBaseResponse<TUser>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<TUser>> call, Response<ObjectBaseResponse<TUser>> response) {
                if (response.body() != null && response.body().getStatus()) {
//                    MainApplication.sMyPrefs.ISFcmSend().put(true);
                }
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
            }
        });
    }


    @Click(R.id.toolbar_menu)
    protected void toolbar_menu() {
        drawerLayout.openDrawer(GravityCompat.START);
    }

    protected void UpdarePreviousRequest() {
        if (adapter.getItemCount() == 0) {
            previous_requests.setText("");
        } else {
            previous_requests.setText(String.format(getResources().getString(R.string.pending_requests), adapter.getItemCount() + ""));
        }
    }


}
