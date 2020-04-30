package com.app.roadz.controller;


import com.app.roadz.model.BaseModel.BaseModel;
import com.app.roadz.model.BaseModel.ListBaseResponse;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.NotificationStatus;
import com.app.roadz.model.TNotification;
import com.app.roadz.model.TUser;
import com.app.roadz.model.UpdatePlateModel;

import java.util.Map;

import retrofit2.Call;
import retrofit2.http.FieldMap;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.POST;

public interface UserController {

    @FormUrlEncoded
    @POST("user/login")
    Call<ObjectBaseResponse<TUser>> Login(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("user")
    Call<ObjectBaseResponse<TUser>> SignUp(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("user/check_register_data")
    Call<ObjectBaseResponse<TUser>> checkRegisterData(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("user/resend_verify_email")
    Call<ObjectBaseResponse<TUser>> resendVerifyEmail(@FieldMap Map<String, String> params);


    @FormUrlEncoded
    @POST("password/email")
    Call<ObjectBaseResponse<TUser>> ForgetPassword(@FieldMap Map<String, String> params);

    @GET("user")
    Call<ObjectBaseResponse<TUser>> GetProfile();


    @POST("user/logout")
    Call<ObjectBaseResponse<TUser>> Logout();

    @FormUrlEncoded
    @POST("user/update")
    Call<ObjectBaseResponse<TUser>> UpdateProfile(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("user/password")
    Call<ObjectBaseResponse<TUser>> UpdatePassword(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("user/token")
    Call<ObjectBaseResponse<TUser>> SendFcmToken(@FieldMap Map<String, String> params);

    @GET("user/notification")
    Call<ListBaseResponse<TNotification>> getNotification();

    @FormUrlEncoded
    @POST("user/notification/read")
    Call<BaseModel> MakeNotificationRead(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("user/notificationsetting")
    Call<BaseModel> notificationsetting(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("user/usernotification")
    Call<NotificationStatus> usernotification(@FieldMap Map<String, String> params);

    @FormUrlEncoded
    @POST("/api/UpdatePlate")
    Call<UpdatePlateModel> UpdatePlate(@FieldMap Map<String, String> params);
}