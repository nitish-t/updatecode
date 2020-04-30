package com.app.roadz.modules.Splash;

import android.annotation.TargetApi;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.BaseController;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.TCarOption;
import com.app.roadz.model.THomeData;
import com.app.roadz.model.TSlider;
import com.app.roadz.modules.AdsSlider.AdsActivity_;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.EActivity;

import java.util.List;

import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_splash)
public class SplashActivity extends BaseActivity {


    private static final long SPLASH_TIME_OUT = 2000L;
    boolean EndMinSplashTime = false;
    boolean requestEnd = false;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }


    @AfterViews
    protected void AfterViews() {
        DisplayMetrics metrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(metrics);
        MainApplication.sMyPrefs.Screenwidth().put(metrics.widthPixels);
        getHomeData();
        new android.os.Handler().postDelayed(new Runnable() {

            @TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
            @Override
            public void run() {
                EndMinSplashTime = true;
                if (requestEnd) {
                    NextScreenAction();
                }
            }
        }, SPLASH_TIME_OUT);
    }

    private void NextScreenAction() {
        SplashActivity.this.finish();
        if (MainApplication.sMyPrefs.SelectLanguage().get()) {
            this.finish();
            AdsActivity_.intent(SplashActivity.this).
                    flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK   ).start();
        }else{
            this.finish();
            SelectLanguageActivity_.intent(SplashActivity.this).
                    flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK  ).start();
        }

    }


    private void getHomeData() {
        RetrofitHelper.getRetrofit().create(BaseController.class).getHomeData().enqueue(new BaseCallback<ObjectBaseResponse<THomeData>>() {
            @Override
            public void onResponse(Call<ObjectBaseResponse<THomeData>> call, Response<ObjectBaseResponse<THomeData>> response) {

                if (response.body() != null && response.body().getObject() != null) {
                    THomeData tHomeData = response.body().getObject();
                    if (tHomeData.getSetting() != null) {
                        MainApplication.sMyPrefs.ConfigLogo().put(tHomeData.getSetting().getLogo());
                        MainApplication.sMyPrefs.info_email().put(tHomeData.getSetting().getInfoEmail());
                        MainApplication.sMyPrefs.facebook().put(tHomeData.getSetting().getFacebook());
                        MainApplication.sMyPrefs.instagram().put(tHomeData.getSetting().getInstagram());
                        MainApplication.sMyPrefs.twitter().put(tHomeData.getSetting().getTwitter());
                        MainApplication.sMyPrefs.linkedin().put(tHomeData.getSetting().getLinkedin());
                        MainApplication.sMyPrefs.mobile().put(tHomeData.getSetting().getMobile());
                        MainApplication.sMyPrefs.latitude().put(tHomeData.getSetting().getLatitude());
                        MainApplication.sMyPrefs.longitude().put(tHomeData.getSetting().getLongitude());
                        MainApplication.sMyPrefs.ConfigTitle().put(tHomeData.getSetting().getTitle());
                        MainApplication.sMyPrefs.ConfigAddress().put(tHomeData.getSetting().getAddress());
                        MainApplication.sMyPrefs.about_us().put(tHomeData.getSetting().getAboutUs());
                        MainApplication.sMyPrefs.privacy().put(tHomeData.getSetting().getPrivacy());
                        MainApplication.sMyPrefs.terms().put(tHomeData.getSetting().getTerms());
                        MainApplication.sMyPrefs.youtube_emergency().put(tHomeData.getSetting().getYoutubeEmergency());
                        MainApplication.sMyPrefs.youtube_maintenance().put(tHomeData.getSetting().getYoutubeMaintenance());
                        MainApplication.sMyPrefs.skip_ads_timer().put(tHomeData.getSetting().getSkipAdsTimer());
                        MainApplication.sMyPrefs.service_maintenance().put(tHomeData.getSetting().getServiceMaintenance());
                        MainApplication.sMyPrefs.service_emergency().put(tHomeData.getSetting().getServiceEmergency());
                        MainApplication.sMyPrefs.service_emergency_guest().put(tHomeData.getSetting().getService_emergency_guest());
                        MainApplication.sMyPrefs.emergancy_phone().put(tHomeData.getSetting().getEmergancy_phone());
                    }

                    List<TSlider> tSliders = tHomeData.getSliders();
                    if (tSliders != null && !tSliders.isEmpty()) {
                        String json = Utils.ConvertToString(tSliders);
                        MainApplication.sMyPrefs.sliders().put(json);
                    } else {
                        MainApplication.sMyPrefs.sliders().put("");
                    }

                    List<TSlider> tAds = tHomeData.getAds();
                    if (tAds != null && !tAds.isEmpty()) {
                        String json = Utils.ConvertToString(tAds);
                        MainApplication.sMyPrefs.ads().put(json);
                    } else {
                        MainApplication.sMyPrefs.ads().put("");
                    }

                    List<TCarOption> tCarOptions = tHomeData.getCar_makers();
                    if (tCarOptions != null && !tCarOptions.isEmpty()) {
                        String json = Utils.ConvertToString(tCarOptions);
                        MainApplication.sMyPrefs.car_makers().put(json);
                    } else {
                        MainApplication.sMyPrefs.car_makers().put("");
                    }

                }

                requestEnd = true;
                if (EndMinSplashTime) {
                    NextScreenAction();
                }
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<THomeData>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                requestEnd = true;
                if (EndMinSplashTime) {
                    NextScreenAction();
                }

            }
        });
    }

}
