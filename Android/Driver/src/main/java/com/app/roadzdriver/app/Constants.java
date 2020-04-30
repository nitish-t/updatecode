package com.app.roadzdriver.app;

import android.content.Context;
import android.text.TextUtils;

import com.app.roadzdriver.R;

import org.json.JSONObject;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import retrofit2.Response;

/**
 * Created by Mohamed on 4/27/17.
 */

public class Constants {
    public static final int PAGE_SIZE = 20;

    public static final String URL = "https://roadzco.com/";
//    public static final String URL = "http://sample.jploft.com/";
//    public static final String URL = "http://light-fix.icode.codes/";
    public static final String BASE_URL = URL + "api/";


    public static final String GeolocApiKey = "AIzaSyBzifbPnfPW4wMwv6e5U5VPM7q7cF3cz4I";


    public static final String DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss";
    public static final String DATE_FORMAT2 = "yyyy-MM-dd HH:mm:ss";
    public static final String DISPLAYDATE_FORMAT2 = "dd MMMM yyyy hh:mm a";
    public static final String REQUEST_TIME_FORMAT = "HH:mm:ss";
    public static final String REQUEST_TIME_FORMAT2 = "HH:mm";
    public static final String DISPLAY_TIME_FORMAT = "hh:mm a";

    public static final String REQUEST_DATE_FORMAT = "yyyy-MM-dd";
    public static final String DISPLAY_DATE_FORMAT = "dd MMMM yyyy";
    public static final String DISPLAY_DATE_FORMAT2 = "dd MMMM";

    public static final String DATE_LOCALE = "US";
    public static final int DAY_TO_SHEFT = 3;


    public static String GetDateString(Date date, String Format) {
        if (date == null) return "";
        SimpleDateFormat format = new SimpleDateFormat(Format, Locale.getDefault());
        return format.format(date);

    }

    public static String GetDateStringForAPI(Date date, String Format) {
        if (date == null) return "";
        SimpleDateFormat format = new SimpleDateFormat(Format, new Locale("en"));
        return format.format(date);

    }

    public static Date GetDateFromString(String date_str, String Format) {
        if (TextUtils.isEmpty(date_str)) return null;

        SimpleDateFormat format = new SimpleDateFormat(Format, new Locale("en"));
        try {
            Date date = format.parse(date_str);
            return date;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }


    public static Date GetDateFromString2(String date_str, String Format) {
        if (TextUtils.isEmpty(date_str)) return null;

        SimpleDateFormat format = new SimpleDateFormat(Format, new Locale("en"));
        format.setTimeZone(TimeZone.getTimeZone("UTC"));
        try {
            Date date = format.parse(date_str);
            return date;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }


    public static String GetStringDateFromString(String date_str, String FormatFrom, String FormatTo) {
        return GetDateString(GetDateFromString(date_str, FormatFrom), FormatTo);
    }

    public static void ErrorMsg(Response response) {
        try {
            if (response == null || response.errorBody() == null) {
                MainApplication.ErrorToast();
                return;
            }
            String errorBody = response.errorBody().string();
            JSONObject jsonObject = new JSONObject(errorBody);
            if (jsonObject.has("error_description")) {
                MainApplication.Toast(jsonObject.getString("error_description"));
            } else {
                MainApplication.ErrorToast();
            }
        } catch (Exception e) {
            e.printStackTrace();
            MainApplication.ErrorToast();
        }
    }

    public static String GetPrise(String prise, Context context) {
        return prise + " " + (MainApplication.ISlocaleArabic(context) ? "د.ك" : context.getResources().getString(R.string.KD));
    }

//    public static String GetPrise(String value, List<TCurrency> currencyList, Context context) {
//        String currency = "";
//        for (TCurrency tCurrency : currencyList) {
//            if (tCurrency.getRequestName().equalsIgnoreCase(MainApplication.sMyPrefs.CurrentCurrency().get())) {
//                currency = MainApplication.ISlocaleArabic(context) ? tCurrency.getArName() : tCurrency.getEnName();
//                break;
//            }
//        }
//        return value + " " + currency;
//
//    }
}
