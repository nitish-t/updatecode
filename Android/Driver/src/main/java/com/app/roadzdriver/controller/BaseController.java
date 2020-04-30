package com.app.roadzdriver.controller;

import com.app.roadzdriver.model.BaseModel.BaseModel;
import com.app.roadzdriver.model.BaseModel.ListBaseResponse;
import com.app.roadzdriver.model.BaseModel.ObjectBaseResponse;
import com.app.roadzdriver.model.TOrder;
import com.app.roadzdriver.model.TUser;

import java.util.Map;

import retrofit2.Call;
import retrofit2.http.FieldMap;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.QueryMap;

public interface BaseController {

    @FormUrlEncoded
    @POST("vendor/login")
    public Call<ObjectBaseResponse<TUser>> Login(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("user/token")
    public Call<ObjectBaseResponse<TUser>> SendFcmToken(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("vendor/order")
    public Call<BaseModel> ChangeOrderStatus(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("vendor/order/cancel")
    public Call<BaseModel> CancelOrder(@FieldMap Map<String, String> params);

    @GET("vendor/orders")
    public Call<ListBaseResponse<TOrder>> getOrders(
            @QueryMap Map<String, String> params
    );

    @POST("vendor/logout")
    public Call<ObjectBaseResponse<TUser>> Logout();

}