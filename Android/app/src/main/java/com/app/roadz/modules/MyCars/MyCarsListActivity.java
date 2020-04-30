package com.app.roadz.modules.MyCars;

import android.app.Activity;
import android.content.Intent;
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
import com.app.roadz.controller.BaseController;
import com.app.roadz.model.BaseModel.ListBaseResponse;
import com.app.roadz.model.TCar;
import com.app.roadz.modules.base.BaseActivity;
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
import java.util.List;

import retrofit2.Call;


@EActivity(R.layout.activity_my_cars_list)
public class MyCarsListActivity extends BaseActivity implements SwipeRefreshLayout.OnRefreshListener {

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

        toolbar_title.setText(getString(R.string.menu_cars));
        InitRecyclerView();

    }

    private void InitRecyclerView() {

        recycler.getRecyclerView().addOnScrollListener(new UImagePauseOnScrollListener(ImageLoader.getInstance(), false, true));
        recycler.getRecyclerView().setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(this);
        recycler.getRecyclerView().setItemAnimator(null);
        recycler.getRecyclerView().setLayoutManager(linearLayoutManager);
        list_data = new ArrayList<>();
        adapter = new DataAdapter(R.layout.row_my_cars_list, list_data, recycler.getRecyclerView());
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


    @Click(R.id.actionBtn)
    protected void actionBtn() {
        AddCarActivity_.intent(this).startForResult(REQUEST_ADD_CAR);
    }

    @OnActivityResult(REQUEST_ADD_CAR)
    public void onResultMap(int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK) {
            onRefresh();
        }
    }
}
