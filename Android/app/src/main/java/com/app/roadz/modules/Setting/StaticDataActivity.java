package com.app.roadz.modules.Setting;

import android.graphics.Color;
import android.text.Html;
import android.util.Log;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ScrollView;
import android.widget.TextView;

import com.app.roadz.R;
import com.app.roadz.app.MainApplication;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.ViewById;


@EActivity(R.layout.activity_static_data)
public class StaticDataActivity extends BaseActivity {

    //1:About Us , 2:Terms & Conditions, 3:Privacy policy, 4:Payment URL
    @Extra
    int Type;
    @Extra
    String Url;
    @ViewById(R.id.toolbar_title)
    TextView toolbar_title;
    @ViewById(R.id.tv_data)
    TextView tv_data;
    @ViewById(R.id.scrollView)
    ScrollView scrollView;
    @ViewById(R.id.webView)
    WebView webView;

    @AfterViews
    protected void AfterViews() {
        String data = "";
        if (Type == 1) {
            toolbar_title.setText(R.string.menu_about);
            data = MainApplication.sMyPrefs.about_us().get();

        } else if (Type == 2) {
            toolbar_title.setText(R.string.terms_conditions);
            data = MainApplication.sMyPrefs.terms().get();

        } else if (Type == 3) {
            toolbar_title.setText(R.string.privacy_policy);
            data = MainApplication.sMyPrefs.privacy().get();

        } else if (Type == 4) {
            toolbar_title.setText(R.string.checkout);
            scrollView.setVisibility(View.GONE);
            webView.setVisibility(View.VISIBLE);
//            Log.d("url",Url);
            WebSettings settings = webView.getSettings();
            settings.setDefaultTextEncodingName("utf-8");
            settings.setJavaScriptEnabled(true);
            settings.setJavaScriptCanOpenWindowsAutomatically(true);
            webView.setWebViewClient(new WebViewClient());
            webView.setBackgroundColor(Color.TRANSPARENT);
            webView.loadUrl(Url);
            webView.setWebViewClient(new WebViewClient() {
                @Override
                public boolean shouldOverrideUrlLoading(WebView wView, String url) {
                    Log.d("vishnal", url);
                    if (url.equals("https://www.roadzco.com/")) {
                        onBackPressed();
                    } else {

                    }
                    return false;
                }
            });
        } else {
            data = "";
            toolbar_title.setText("");
        }
//        Utils.InitWebData(webView, data, this);
        tv_data.setText(Html.fromHtml(data));
    }


}
