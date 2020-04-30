package com.app.roadz.modules.Splash;

import android.content.Intent;
import android.util.Log;
import android.widget.LinearLayout;

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
import com.app.roadz.modules.AdsSlider.ImageSliderActivity_;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;

import java.util.List;

import cn.pedant.SweetAlert.SweetAlertDialog;
import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_select_language)
public class SelectLanguageActivity extends BaseActivity {

    @ViewById(R.id.languageLayout)
    protected LinearLayout languageLayout;

    @AfterViews
    protected void AfterViews() {
    }

    private void NextScreenAction() {
        this.finish();
        ImageSliderActivity_.intent(SelectLanguageActivity.this).
                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
    }

    @Click(R.id.englishBtn)
    protected void englishBtn() {
        MainApplication.sMyPrefs.SelectLanguage().put(true);
        if (MainApplication.ISlocaleArabic(this)) {

            MainApplication.changeLanguage(this, "en", ImageSliderActivity_.class);

        } else {
            NextScreenAction();
        }
    }


    @Click(R.id.arabicBtn)
    protected void arabicBtn() {
        MainApplication.sMyPrefs.SelectLanguage().put(true);
        if (!MainApplication.ISlocaleArabic(this)) {
            MainApplication.saveLang("ar");
            getHomeData();
//            MainApplication.changeLanguage(this, "en", ImageSliderActivity_.class);
//            NextScreenAction();
        } else {
            NextScreenAction();
        }

    }

    private void getHomeData() {
        final SweetAlertDialog pDialog = new SweetAlertDialog(this, SweetAlertDialog.PROGRESS_TYPE);
        pDialog.getProgressHelper().setBarColor(getResources().getColor(R.color.colorAccent));
        pDialog.setTitleText("");
        pDialog.setCancelable(false);
        pDialog.show();
        RetrofitHelper.getRetrofit().create(BaseController.class).getHomeData().enqueue(new BaseCallback<ObjectBaseResponse<THomeData>>() {
            @Override
            public void onResponse(Call<ObjectBaseResponse<THomeData>> call, Response<ObjectBaseResponse<THomeData>> response) {
                pDialog.dismiss();
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


                NextScreenAction();

            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<THomeData>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                pDialog.dismiss();
            }
        });
    }
}
