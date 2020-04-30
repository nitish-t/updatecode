package com.app.roadz.modules.Notification;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.app.roadz.R;
import com.app.roadz.Utils.UImagePauseOnScrollListener;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.controller.UserController;
import com.app.roadz.model.BaseModel.ListBaseResponse;
import com.app.roadz.model.TNotification;
import com.app.roadz.modules.base.BaseActivity;
import com.app.roadz.recyclerview.DataAdapter;
import com.malinskiy.superrecyclerview.SuperRecyclerView;
import com.nostra13.universalimageloader.core.ImageLoader;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;


@EActivity(R.layout.activity_notificcation_list)
public class NotificationsListActivity extends BaseActivity implements SwipeRefreshLayout.OnRefreshListener {

    @SystemService
    LayoutInflater mLayoutInflater;


    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;

    @ViewById(R.id.recycler)
    public SuperRecyclerView recycler;


    private DataAdapter adapter;
    List<TNotification> list_data;


    @AfterViews
    protected void AfterViews() {

        toolbar_title.setText(getString(R.string.notifications));
        InitRecyclerView();

    }

    private void InitRecyclerView() {

        recycler.getRecyclerView().addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));
        recycler.getRecyclerView().setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(this);
        recycler.getRecyclerView().setItemAnimator(null);
        recycler.getRecyclerView().setLayoutManager(linearLayoutManager);
        list_data = new ArrayList<>();
        adapter = new DataAdapter(R.layout.row_notification_list, list_data, recycler.getRecyclerView());
        recycler.setAdapter(adapter);
        recycler.showProgress();
        recycler.setRefreshListener(this);
        recycler.setRefreshingColorResources(R.color.colorAccent, R.color.colorAccent, R.color.colorAccent, R.color.colorAccent);
        recycler.getRecyclerView().addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));
        loadData();
    }

    private void loadData() {
        RetrofitHelper.getRetrofit().create(UserController.class).getNotification().enqueue(new BaseCallback<ListBaseResponse<TNotification>>() {
            @Override
            public void onResponse(Call<ListBaseResponse<TNotification>> call, retrofit2.Response<ListBaseResponse<TNotification>> response) {
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

                List<TNotification> ObjectList = response.body().getList();

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
            public void onFailure(Call<ListBaseResponse<TNotification>> call, Throwable t) {
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

}
