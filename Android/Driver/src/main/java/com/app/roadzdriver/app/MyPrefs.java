package com.app.roadzdriver.app;

import org.androidannotations.annotations.sharedpreferences.DefaultBoolean;
import org.androidannotations.annotations.sharedpreferences.DefaultFloat;
import org.androidannotations.annotations.sharedpreferences.DefaultInt;
import org.androidannotations.annotations.sharedpreferences.DefaultString;
import org.androidannotations.annotations.sharedpreferences.SharedPref;


@SharedPref
public interface MyPrefs {


    @DefaultBoolean(false)
    boolean ISLogin();

    @DefaultInt(-1)
    int UserLoginID();

    @DefaultString("")
    String UserName();

    @DefaultString("")
    String UserMobile();

    @DefaultString("")
    String UserImage();

    @DefaultString("")
    String UserEmail();

    @DefaultString("")
    String AccessToken();

    @DefaultString("")
    String FcmToken();

    @DefaultBoolean(false)
    boolean ISFcmSend();

    @DefaultBoolean(false)
    boolean SelectLanguage();

    @DefaultInt(0)
    int Screenwidth();


    @DefaultString("")
    String ConfigLogo();

    @DefaultString("")
    String info_email();

    @DefaultString("")
    String facebook();

    @DefaultString("")
    String instagram();

    @DefaultString("")
    String twitter();

    @DefaultString("")
    String linkedin();

    @DefaultString("")
    String mobile();

    @DefaultFloat(0)
    float latitude();

    @DefaultFloat(0)
    float longitude();

    @DefaultString("")
    String ConfigTitle();

    @DefaultString("")
    String ConfigAddress();

    @DefaultString("")
    String about_us();

    @DefaultString("")
    String privacy();

    @DefaultString("")
    String terms();

    @DefaultString("youtube_emergency")
    String youtube_emergency();

    @DefaultString("youtube_maintenance")
    String youtube_maintenance();

    @DefaultInt(0)
    int skip_ads_timer();

    @DefaultString("")
    String service_maintenance();

    @DefaultString("")
    String service_emergency();

    @DefaultString("")
    String sliders();

    @DefaultString("")
    String ads();

    @DefaultString("")
    String car_makers();


}