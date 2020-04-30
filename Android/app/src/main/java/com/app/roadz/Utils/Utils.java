package com.app.roadz.Utils;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.ShapeDrawable;
import android.media.ExifInterface;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ProgressBar;

import com.app.roadz.R;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.modules.User.LoginActivity_;
import com.app.roadz.modules.base.MessagePopup;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nostra13.universalimageloader.core.assist.FailReason;
import com.nostra13.universalimageloader.core.listener.ImageLoadingListener;

import java.io.File;
import java.io.FileNotFoundException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import cn.pedant.SweetAlert.SweetAlertDialog;
import okhttp3.MediaType;
import okhttp3.RequestBody;


public abstract class Utils {


    public static int getDp(Context ctx, float pixel) {
        return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, pixel, ctx.getResources().getDisplayMetrics());
    }

    public static int getPx(Context ctx, int dp) {

        return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_PX, dp, ctx.getResources().getDisplayMetrics());


    }

    public static boolean isNetworkAvailableAndConnected(Context context) {
        ConnectivityManager manager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);

        NetworkInfo nInfo = manager.getActiveNetworkInfo();

        if (nInfo != null) {

            return nInfo.isAvailable() && nInfo.isConnectedOrConnecting();
        } else return false;
    }


    public static String doublefmt(double value) {

//        NumberFormat nf = new DecimalFormat("##.###");
//        return nf.format(value);

        DecimalFormat precision = new DecimalFormat("0.000");
// dblVariable is a number variable and not a String in this case
        return precision.format(value);

//        return String.format("%.3f", value);
    }


    public static String md5(String s) {
        final String MD5 = "MD5";
        try {
            // Create MD5 Hash
            MessageDigest digest = MessageDigest
                    .getInstance(MD5);
            digest.update(s.getBytes());
            byte messageDigest[] = digest.digest();

            // Create Hex String
            StringBuilder hexString = new StringBuilder();
            for (byte aMessageDigest : messageDigest) {
                String h = Integer.toHexString(0xFF & aMessageDigest);
                while (h.length() < 2)
                    h = "0" + h;
                hexString.append(h);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }

    public final static boolean isValidEmail(CharSequence target) {
        if (target == null) {
            return false;
        } else {
            return android.util.Patterns.EMAIL_ADDRESS.matcher(target).matches();
        }
    }

    public static void showOkDialog(final Activity activity, String title, String msg, int dialogType) {
        if (activity == null) return;
        new SweetAlertDialog(activity, dialogType)
                .setTitleText(title)
                .setConfirmText(activity.getString(R.string.dialog_ok))
                .setContentText(msg)
                .setContentTextSize(14)
                .setConfirmClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                    }
                })
                .show();
    }

    public static void showOkDialog(final Activity activity, String title, String msg, int dialogType, final Runnable runnable) {
        if (activity == null) return;
        new SweetAlertDialog(activity, dialogType)
                .setTitleText(title)
                .setConfirmText(activity.getString(R.string.dialog_ok))
                .setContentText(msg)
                .setConfirmClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                        runnable.run();
                    }
                })
                .show();
    }


    public static void hideSoftKeyboard(Activity activity) {
        if (activity != null) {
            InputMethodManager inputMethodManager = (InputMethodManager) activity.getSystemService(Activity.INPUT_METHOD_SERVICE);
            if (activity.getCurrentFocus() != null)
                inputMethodManager.hideSoftInputFromWindow(activity.getCurrentFocus().getWindowToken(), 0);
        }
    }

    public static boolean isTablet(Context context) {
        return (context.getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK) >= Configuration.SCREENLAYOUT_SIZE_LARGE;
    }

    public static void InitWebData(WebView webview, String Data, Context context) {
        InitWebData(webview, Data, context, false);
    }

    public static void InitWebData(WebView webview, String Data, Context context, boolean fontSmall) {
        WebSettings settings = webview.getSettings();
        settings.setDefaultTextEncodingName("utf-8");
        settings.setJavaScriptEnabled(true);
        settings.setJavaScriptCanOpenWindowsAutomatically(true);
        webview.setWebChromeClient(new WebChromeClient());
        webview.setBackgroundColor(Color.TRANSPARENT);

        String Dir = MainApplication.ISlocaleArabic(context) ? "rtl" : "ltr";
        String fontSize = fontSmall ? "small" : "normal";
        String fontname = MainApplication.ISlocaleArabic(context) ? "cairo_regular.ttf" : "hkgrotesk_regular.ttf";


        String pish = "<html dir=\"" + Dir + "\"><head> <style type=\"text/css\" >@font-face {font-family: MyFont;src: url(\"file:///android_asset/fonts/" + fontname + "\")}body {font-family: MyFont;font-size: " + fontSize + ";} a {color:#F24b4b4b; text-decoration:none}" + "iframe,embed{" +
                " width:95% !important;" +
                " height:auto !important;" +
                "margin-right: auto !important;" +
                " margin-left: auto !important;" +
                " }" +
                " img{" +
                " max-width:95% !important;" +
                " height:auto !important;" +
                "margin-right: auto !important;" +
                " margin-left: auto !important;" +
                " }" +
                " table{" +
                " max-width:95% !important;" +
                " height:auto !important;" +
                "margin-right: auto !important;" +
                " margin-left: auto !important;" +
                " }" + "</style></head><body style=\";margin:0 12px\">";
        String pas = "</body></html>";

        String map = pish + Data + pas;
        webview.loadDataWithBaseURL(Constants.URL, pish + Data + pas, "text/html", "UTF-8", null);
    }

    public static void InitWebData(WebView webview, String url) {
        WebSettings settings = webview.getSettings();
        settings.setDefaultTextEncodingName("utf-8");
        settings.setJavaScriptEnabled(true);
        settings.setJavaScriptCanOpenWindowsAutomatically(true);
        webview.setWebViewClient(new WebViewClient());
        webview.setBackgroundColor(Color.TRANSPARENT);
        webview.loadUrl(url);
        webview.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView wView, String url) {
                Log.d("vishnal", url);

                return false;
            }
        });
    }

    public static void showOkDialogWithAction(final Activity activity, final Runnable run, String msg, int dialogType) {
        if (activity == null) return;
        new SweetAlertDialog(activity, dialogType)
                .setTitleText("")
                .setConfirmText(activity.getString(R.string.dialog_ok))
                .setContentText(msg)
                .setConfirmClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                        if (run != null)
                            run.run();
                    }
                })
                .show();
    }

    public static void showOkDialogWithAction2(final Activity activity, final Runnable run, String msg, int dialogType) {
        if (activity == null) return;
        new SweetAlertDialog(activity, dialogType)
                .setTitleText("")
                .setConfirmText(activity.getString(R.string.ok))
                .setContentText(msg)
                .setCancelText(activity.getString(R.string.cancel2))
                .setConfirmClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                        if (run != null)
                            run.run();
                    }
                })
                .setCancelClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                    }
                })
                .show();
    }

    public static Bitmap GetMapBitMap(Drawable ic_map_my_location) {
        int height = 80;
        int width = 80;
        BitmapDrawable bitmapdraw = (BitmapDrawable) ic_map_my_location;
        Bitmap b = bitmapdraw.getBitmap();
        Bitmap smallMarker = Bitmap.createScaledBitmap(b, width, height, false);
        return smallMarker;
    }

    public static void LoginDialog(final Activity activity) {
        if (activity == null) return;
        new SweetAlertDialog(activity, SweetAlertDialog.NORMAL_TYPE)
                .setTitleText(activity.getResources().getString(R.string.login_required))
                .setContentText(activity.getResources().getString(R.string.login_required_msg))
                .setConfirmText(activity.getResources().getString(R.string.yes))
                .setCancelText(activity.getResources().getString(R.string.cancel))
                .setConfirmClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                        LoginActivity_.intent(activity).start();
                    }
                })
                .setCancelClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                    }
                })
                .show();
    }


    public static void LogoutDialog(final Activity activity, final Runnable runnable) {
        if (activity == null) return;
        new SweetAlertDialog(activity, SweetAlertDialog.NORMAL_TYPE)
                .setTitleText(activity.getResources().getString(R.string.logout_required))
                .setContentText(activity.getResources().getString(R.string.logout_required_msg))
                .setConfirmText(activity.getResources().getString(R.string.yes))
                .setCancelText(activity.getResources().getString(R.string.cancel))
                .setConfirmClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                        runnable.run();
                        ;
                    }
                })
                .setCancelClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                    }
                })
                .show();
    }

    public static void ChangeLanguage(final Activity activity, final Runnable okRunnable, final Runnable CancelRunnable) {
        if (activity == null) return;
        new SweetAlertDialog(activity, SweetAlertDialog.NORMAL_TYPE)
                .setTitleText(activity.getResources().getString(R.string.change_language))
                .setContentText(activity.getResources().getString(R.string.change_language_msg))
                .setConfirmText(activity.getResources().getString(R.string.yes))
                .setCancelText(activity.getResources().getString(R.string.cancel))
                .setConfirmClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                        okRunnable.run();
                    }
                })
                .setCancelClickListener(new SweetAlertDialog.OnSweetClickListener() {
                    @Override
                    public void onClick(SweetAlertDialog sweetAlertDialog) {
                        sweetAlertDialog.dismissWithAnimation();
                        CancelRunnable.run();
                    }
                })
                .show();
    }

    public static Bitmap Rotate(String photoPath) {

//        BitmapFactory.Options bmOptions = new BitmapFactory.Options();
//        bmOptions.inJustDecodeBounds = true;
//        BitmapFactory.decodeFile(photoPath, bmOptions);
//
//        bmOptions.inJustDecodeBounds = false;
        File file = new File(photoPath);
        Uri uri = Uri.fromFile(file);

        Bitmap bitmap = null;
        try {
            bitmap = decodeUri(MainApplication.sContext, uri);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        if (bitmap != null) {
            Matrix matrix = new Matrix();
            matrix.postRotate(GetRotate(photoPath));
            return Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, true);
        }
        return null;
    }


    public static int GetRotate(String imagePath) {
        File imageFile = new File(imagePath);
        try {
            ExifInterface exif = new ExifInterface(imageFile.getAbsolutePath());
            int orientation = exif.getAttributeInt(
                    ExifInterface.TAG_ORIENTATION,
                    ExifInterface.ORIENTATION_NORMAL);

            switch (orientation) {
                case ExifInterface.ORIENTATION_ROTATE_270:
                    return 270;
                case ExifInterface.ORIENTATION_ROTATE_180:
                    return 180;
                case ExifInterface.ORIENTATION_ROTATE_90:
                    return 90;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static Bitmap decodeUri(Context com, Uri selectedImage) throws FileNotFoundException {

        // Decode image size
        BitmapFactory.Options o = new BitmapFactory.Options();
        o.inJustDecodeBounds = true;
        BitmapFactory.decodeStream(com.getContentResolver().openInputStream(selectedImage), null, o);

        // The new size we want to scale to
        final int REQUIRED_SIZE = 200;

        // Find the correct scale value. It should be the power of 2.
        int width_tmp = o.outWidth, height_tmp = o.outHeight;
        int scale = 1;
        while (true) {
            if (width_tmp / 2 < REQUIRED_SIZE
                    || height_tmp / 2 < REQUIRED_SIZE) {
                break;
            }
            width_tmp /= 2;
            height_tmp /= 2;
            scale *= 2;
        }

        // Decode with inSampleSize
        BitmapFactory.Options o2 = new BitmapFactory.Options();
        o2.inSampleSize = scale;

        return BitmapFactory.decodeStream(com.getContentResolver().openInputStream(selectedImage), null, o2);

    }

    public static boolean Valed(Context context, EditText et_fild, EditText et_fild2, Type type) {
        switch (type) {
            case general:
                if (TextUtils.isEmpty(et_fild.getText().toString().trim())) {
                    et_fild.setError(context.getResources().getString(R.string.required_field));
                    return false;
                }
                break;
            case pass:
                if (TextUtils.isEmpty(et_fild.getText().toString().trim()) || et_fild.getText().length() < 6) {
                    et_fild.setError(context.getResources().getString(R.string.too_small));
                    return false;
                }
                break;
            case phone:
                if (TextUtils.isEmpty(et_fild.getText().toString().trim()) || et_fild.getText().length() != 8) {
                    et_fild.setError(context.getResources().getString(R.string.add_correct_phone_num));
                    return false;
                }
                break;
            case confirm_pass:
                if (!et_fild.getText().toString().equalsIgnoreCase(et_fild2.getText().toString())) {
                    et_fild.setError(context.getResources().getString(R.string.similar_pass));
                    return false;
                }
                break;
            case email:
                if (TextUtils.isEmpty(et_fild.getText().toString().trim()) || !Utils.isValidEmail(et_fild.getText())) {
                    et_fild.setError(context.getResources().getString(R.string.correct_email));
                    return false;
                }
                break;
        }
        return true;
    }

    public static String ConvertToString(List data) {
        ObjectMapper mapper = new ObjectMapper();
        String jsonInString = null;
        try {
            jsonInString = mapper.writeValueAsString(data);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return jsonInString;
    }

    public enum Type {
        general,
        pass,
        phone,
        confirm_pass,
        email;
    }

    public static String Ago(Date dt_last_message_date) {
        if (dt_last_message_date == null) return "";
        TimeAgo timeAgo = new TimeAgo(MainApplication.sContext);
        return timeAgo.timeAgo(dt_last_message_date, 100, Constants.DISPLAY_DATE_FORMAT);

    }

    public static void loadImage(String imgPath, final ImageView imgItem, final ProgressBar progres_view) {
        MainApplication.mImageLoader.displayImage(imgPath, imgItem, new ImageLoadingListener() {
            @Override
            public void onLoadingStarted(String imageUri, View view) {
                if (progres_view == null) return;
                progres_view.setVisibility(View.VISIBLE);
            }

            @Override
            public void onLoadingFailed(String imageUri, View view, FailReason failReason) {
                if (progres_view == null) return;
                progres_view.setVisibility(View.GONE);
            }

            @Override
            public void onLoadingComplete(String imageUri, View view, Bitmap loadedImage) {
                if (progres_view == null) return;
                progres_view.setVisibility(View.GONE);
            }

            @Override
            public void onLoadingCancelled(String imageUri, View view) {
                if (progres_view == null) return;
                progres_view.setVisibility(View.GONE);
            }
        });
    }

    public static void changeDrawableColor(Drawable mDrawable, String color) {
        int colorValue;
        try {

            colorValue = Color.parseColor(color);
        } catch (Exception ex) {
            colorValue = Color.parseColor("#cccc10");
        }
        if (mDrawable instanceof ShapeDrawable) {
            ((ShapeDrawable) mDrawable).getPaint().setColor(colorValue);
        } else if (mDrawable instanceof GradientDrawable) {
            ((GradientDrawable) mDrawable).setColor(colorValue);
        } else if (mDrawable instanceof ColorDrawable) {
            ((ColorDrawable) mDrawable).setColor(colorValue);
        }
    }

    public static RequestBody createRequestBody(String s) {
        if (s == null) s = "";
        return RequestBody.create(
                MediaType.parse("text/plain"), s);
    }

    public static void OpenLink(Context context, String url) {
        if (TextUtils.isEmpty(url)) return;
        if (!url.contains("http")) {
            url = "http://" + url;
        }
        try {
            Intent i = new Intent(Intent.ACTION_VIEW);
            i.setData(Uri.parse(url));
            context.startActivity(i);
        } catch (Exception ex) {

        }

    }


    public static void ShowMessagePopup(String title, String Msg, Context context, LayoutInflater mLayoutInflater, final Runnable runnable) {
        ShowMessagePopup(title, Msg, false, context.getResources().getString(R.string.yes_msg), context.getResources().getString(R.string.no), context, mLayoutInflater, runnable);
    }

    public static void ShowMessagePopup(boolean showIcon, String Msg, Context context, LayoutInflater mLayoutInflater, final Runnable runnable) {
        ShowMessagePopup("", Msg, showIcon, context.getResources().getString(R.string.yes_msg), context.getResources().getString(R.string.no), context, mLayoutInflater, runnable);
    }

    public static void ShowMessagePopup(String title, String Msg, String okBtn, String CancelBtn, Context context, LayoutInflater mLayoutInflater, final Runnable runnable) {
        ShowMessagePopup(title, Msg, false, okBtn, CancelBtn, context, mLayoutInflater, runnable);
    }

    public static void ShowMessagePopup(String title, String Msg, boolean showIcon, String okBtn, String CancelBtn, Context context, LayoutInflater mLayoutInflater, final Runnable runnable) {
        MessagePopup messagePopup = (MessagePopup) mLayoutInflater.inflate(R.layout.popup_message, null);
        AlertDialog.Builder filterBuilder2 = new AlertDialog.Builder(context);
        filterBuilder2.setView(messagePopup);
        AlertDialog filterAlertDialog2 = filterBuilder2.create();
        filterAlertDialog2.setCancelable(false);
        filterAlertDialog2.setCanceledOnTouchOutside(true);
        filterAlertDialog2.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        filterAlertDialog2.show();
        messagePopup.setDialogInstans(filterAlertDialog2, new Runnable() {
            @Override
            public void run() {
                runnable.run();
            }
        });
        messagePopup.setMessage(title, Msg, showIcon, okBtn, CancelBtn);
    }


    public static String extractYTId(String ytUrl) {
        String vId = null;
        Pattern pattern = Pattern.compile(".*(?:youtu.be\\/|v\\/|u\\/\\w\\/|embed\\/|watch\\?v=)([^#\\&\\?]*).*");
        Matcher matcher = pattern.matcher(ytUrl);
        if (matcher.matches()) {
            vId = matcher.group(1);
        }
        return vId;
    }


}
