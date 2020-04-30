package com.app.roadz.api;


import com.app.roadz.app.MainApplication;

import java.io.IOException;

import okhttp3.Request;
import okhttp3.Response;


public class HeaderInterceptor implements okhttp3.Interceptor {


    @Override
    public Response intercept(Chain chain) throws IOException {


        Request request = chain.request();

        request = request.newBuilder()
                .addHeader("Authorization", GetToken())
                .addHeader("Accept-Language", MainApplication.ISlocaleArabic(MainApplication.sContext) ? "ar" : "en")
                .addHeader("Accept", "application/json")
                .addHeader("Content-Type", "application/x-www-form-urlencoded")
                .build();
        Response response = chain.proceed(request);
        return response;
    }


    public String GetToken() {
        return MainApplication.sMyPrefs.AccessToken().get();
    }
}