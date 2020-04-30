package com.app.roadzdriver.app;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.Typeface;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.preference.PreferenceManager;
import android.text.TextUtils;
import android.util.Log;

import androidx.multidex.MultiDex;

import com.app.roadzdriver.R;
import com.app.roadzdriver.Utils.ContextWrapper;
import com.app.roadzdriver.Utils.FontsOverride;
import com.app.roadzdriver.Utils.Utils;
import com.app.roadzdriver.modules.Splash.SplashActivity_;
import com.app.roadzdriver.modules.base.BaseActivity;
import com.nostra13.universalimageloader.cache.disc.impl.UnlimitedDiskCache;
import com.nostra13.universalimageloader.cache.disc.naming.Md5FileNameGenerator;
import com.nostra13.universalimageloader.cache.memory.impl.LruMemoryCache;
import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.nostra13.universalimageloader.core.assist.ImageScaleType;
import com.nostra13.universalimageloader.core.display.FadeInBitmapDisplayer;
import com.nostra13.universalimageloader.utils.StorageUtils;

import org.androidannotations.annotations.EApplication;
import org.androidannotations.annotations.sharedpreferences.Pref;

import java.io.File;
import java.util.Locale;

import cn.pedant.SweetAlert.SweetAlertDialog;


@EApplication
public class MainApplication extends Application {


    public static Context sContext;

    public MainApplication() {
        Log.i("upGradeReceiver", " MainApplication");
    }

    public static int AppVersion;
    public static ImageLoader mImageLoader;
    public static DisplayImageOptions mItemUnviralImageOptions;

    public static Typeface typeface;
    public static Typeface typeface_semibold;
    public static Typeface typeface_bold;

    @Pref
    public static MyPrefs_ sMyPrefs;

//    public static List<TCurrency> currency=new ArrayList<>();

    @Override
    protected void attachBaseContext(Context base) {
        checkLocale(base);
        super.attachBaseContext(base);
        MultiDex.install(this);
    }


    @Override
    public void onCreate() {
        super.onCreate();
        Log.i("upGradeReceiver", " before onCreate");
        super.onCreate();
        Log.i("upGradeReceiver", " after onCreate");
        sContext = this;

        typeface = Typeface.createFromAsset(getAssets(), ISlocaleArabic(this) ? "fonts/cairo_regular.ttf" : "fonts/hkgrotesk_regular.ttf");
        typeface_semibold = Typeface.createFromAsset(getAssets(), ISlocaleArabic(this) ? "fonts/cairo_semibold.otf" : "fonts/hkgrotesk_semibold.otf");
        typeface_bold = Typeface.createFromAsset(getAssets(), ISlocaleArabic(this) ? "fonts/cairo_bold.ttf" : "fonts/hkgrotesk_bold.ttf");
//        typeface_semibold = Typeface.createFromAsset(getAssets(), "fonts/myriadpro_semibold.otf");
        new FontsOverride(this).loadFonts();
        initImageLoader();
        PackageInfo pInfo = null;
        try {
            pInfo = getPackageManager().getPackageInfo(getPackageName(), 0);
            AppVersion = pInfo.versionCode;

        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }


    }


    public static String GetImagePath(String s_image) {
        String ImagePath = s_image;
        return ImagePath;
    }

    public static BaseActivity baseActivity;

    public static BaseActivity getBaseActivity() {
        return baseActivity;
    }

    public static void setBaseActivity(BaseActivity baseActivity) {
        MainApplication.baseActivity = baseActivity;
    }


    public static void Toast(String msg) {
        Toast(msg, SweetAlertDialog.ERROR_TYPE);
    }

    public static void Toast(String msg, int type) {
        Utils.showOkDialog(MainApplication.getBaseActivity(), "", msg, type);
    }

    public static void Toast(String title, String msg, int type, final Runnable run) {
        Utils.showOkDialog(MainApplication.getBaseActivity(), title, msg, type, run);
    }

    public static void Toast(String msg, int type, final Runnable run) {
        Utils.showOkDialogWithAction(MainApplication.getBaseActivity(), run, msg, type);
    }

    public static void Toast2(String msg, int type, final Runnable run) {
        Utils.showOkDialogWithAction2(MainApplication.getBaseActivity(), run, msg, type);
    }

    public static void ToastWithCancel(String msg, int type, final Runnable run, final Runnable runCancel) {
        Utils.showOkDialogWithActionWithCancel(MainApplication.getBaseActivity(), run, runCancel, msg, type);
    }

    public void initImageLoader() {
        File cacheDir = StorageUtils.getCacheDirectory(this);
        mItemUnviralImageOptions = new DisplayImageOptions.Builder().considerExifParams(true).showImageOnFail(R.drawable.ic_launcher).resetViewBeforeLoading(true).showImageOnFail(R.drawable.ic_launcher).showImageForEmptyUri(R.drawable.ic_launcher).cacheInMemory(true).cacheOnDisk(true).imageScaleType(ImageScaleType.IN_SAMPLE_POWER_OF_2).bitmapConfig(Bitmap.Config.ARGB_8888).displayer(new FadeInBitmapDisplayer(300)).build();
        ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(sContext).threadPoolSize(6).denyCacheImageMultipleSizesInMemory().memoryCache(new LruMemoryCache(10 * 1024 * 1024)).diskCache(new UnlimitedDiskCache(cacheDir)).defaultDisplayImageOptions(mItemUnviralImageOptions).threadPriority(Thread.NORM_PRIORITY - 2).diskCacheFileNameGenerator(new Md5FileNameGenerator()).build();
        mImageLoader = ImageLoader.getInstance();
        mImageLoader.init(config);
//        L.disableLogging();
    }


    public static void ErrorToast() {
        MainApplication.Toast(sContext.getString(R.string.unexpected_error));
    }


    ///Language Section

    public static void changeLanguage(Context ctx) {
        if (ISlocaleArabic(ctx)) {
            MainApplication.saveLang("en");
        } else {
            MainApplication.saveLang("ar");
        }
        changeLang((BaseActivity) ctx);

    }

    public static void changeLanguage(Context ctx, String lang) {

        MainApplication.saveLang(lang);

        changeLang((BaseActivity) ctx);

    }

    public static void changeLanguage(Context ctx, String lang, Class<?> cls) {

        MainApplication.saveLang(lang);

        changeLang((BaseActivity) ctx, cls);

    }

    public static boolean ISlocaleArabic(Context ctx) {
        String lang = getLang(ctx);
        if (lang.equalsIgnoreCase("ar")) {
            return true;
        } else {
            return false;
        }
    }

    public static void checkLocale(Context ctx) {
        String lang = getLang(ctx);
//        String lang = "en";
        Configuration config = new Configuration();

//        if (TextUtils.isEmpty(lang)) {
//            lang = "en";
////            saveLang(lang);
//        }

        // Configuration config = ctx.getResources().getConfiguration();
        // Locale currentLocale = SystemLocale(config);
        if (!TextUtils.isEmpty(lang)) {
            Locale myLocale = new Locale(lang);
            Locale.setDefault(myLocale);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                config.setLocale(myLocale);
                config.locale = myLocale;
            } else {
                try {
                    config.setLocale(myLocale);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                config.locale = myLocale;
            }
            ctx.getResources().updateConfiguration(config, ctx.getResources().getDisplayMetrics());

        } else {
            Configuration config2 = ctx.getResources().getConfiguration();
            Locale currentLocale = ContextWrapper.SystemLocale(config2);
            SharedPreferences mSharedPreferences = PreferenceManager.getDefaultSharedPreferences(ctx);
            SharedPreferences.Editor edit = mSharedPreferences.edit();
            edit.putString("Language", currentLocale.getLanguage().toLowerCase());
            edit.apply();

        }
    }

    public static String getLang(Context ctx) {
        SharedPreferences mSharedPreferences = PreferenceManager.getDefaultSharedPreferences(ctx);
        String lang = mSharedPreferences.getString("Language", "");
        return lang;
    }

    public static void saveLang(String lang) {
        SharedPreferences mSharedPreferences = PreferenceManager.getDefaultSharedPreferences(MainApplication.sContext);
        SharedPreferences.Editor edit = mSharedPreferences.edit();
        edit.putString("Language", lang);
        edit.apply();
    }

    public static void changeLang(final Activity act) {

        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            @Override
            public void run() {
                Intent refresh = new Intent(act, SplashActivity_.class);
                act.overridePendingTransition(0, 0);
                refresh.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
                act.finish();
                act.overridePendingTransition(0, 0);
                act.startActivity(refresh);
                Runtime.getRuntime().exit(0);

            }
        }, 300);

    }

    public static void changeLang(final Activity act, final Class<?> cls) {

        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            @Override
            public void run() {
                Intent refresh = new Intent(act, cls);
                act.overridePendingTransition(0, 0);
                refresh.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
                act.finish();
                act.overridePendingTransition(0, 0);
                act.startActivity(refresh);
                Runtime.getRuntime().exit(0);

            }
        }, 300);

    }
}
