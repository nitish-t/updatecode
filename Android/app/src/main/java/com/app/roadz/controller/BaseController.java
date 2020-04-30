package com.app.roadz.controller;

import com.app.roadz.model.BaseModel.BaseModel;
import com.app.roadz.model.BaseModel.ListBaseResponse;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.BaseModel.SubscribeResponse;
import com.app.roadz.model.TCar;
import com.app.roadz.model.TCoupon;
import com.app.roadz.model.THomeData;
import com.app.roadz.model.TPackage;
import com.app.roadz.model.TService;
import com.app.roadz.model.TSubscription;
import com.app.roadz.model.TUser;

import java.util.Map;

import retrofit2.Call;
import retrofit2.http.FieldMap;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.HTTP;
import retrofit2.http.POST;
import retrofit2.http.Path;

public interface BaseController {

    @GET("getHomeData")
    public Call<ObjectBaseResponse<THomeData>> getHomeData();

    @FormUrlEncoded
    @POST("ContactUs")
    public Call<ObjectBaseResponse<TUser>> ContactUs(@FieldMap Map<String, String> params);

    ////CAR
    @GET("cars")
    public Call<ListBaseResponse<TCar>> getCars();

    @HTTP(method = "DELETE", path = "cars/{id}", hasBody = true)
    public Call<BaseModel> DeleteCar(@Path("id") int id);

    @FormUrlEncoded
    @POST("cars")
    public Call<BaseModel> AddCar(@FieldMap Map<String, String> params);


    ////SUBSCRIPTIONS
    @GET("subscriptions")
    public Call<ListBaseResponse<TSubscription>> getSubscriptions();

    @FormUrlEncoded
    @POST("check_subscription")
    public Call<ObjectBaseResponse<SubscribeResponse>> CheckSubscription(@FieldMap Map<String, String> params);

    @GET("packages")
    public Call<ListBaseResponse<TPackage>> getPackages();

    @FormUrlEncoded
    @POST("check_coupon")
    public Call<ObjectBaseResponse<TCoupon>> CheckCoupon(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("subscription")
    public Call<ObjectBaseResponse<SubscribeResponse>> MakeSubscription(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("payment/check")
    public Call<BaseModel> CheckPayment(@FieldMap Map<String, String> params);


    @GET("packages/{id}/services")
    public Call<ListBaseResponse<TService>> getPackages(@Path("id") int id);

    @GET("user/notification/not_read_count")
    public Call<ObjectBaseResponse<THomeData>> getNotificationCount();
}