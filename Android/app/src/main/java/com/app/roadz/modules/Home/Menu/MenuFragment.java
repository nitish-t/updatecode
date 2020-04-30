package com.app.roadz.modules.Home.Menu;


import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.app.MainApplication;
import com.app.roadz.modules.User.EditProfileActivity_;
import com.app.roadz.modules.base.BaseActivity;
import com.app.roadz.recyclerview.DataAdapter;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.ViewById;

import java.util.ArrayList;
import java.util.List;


@EView
public class MenuFragment extends LinearLayout {


    @ViewById(R.id.recycler)
    RecyclerView recycler;

    @ViewById(R.id.txtName)
    TextView txtName;

    @ViewById(R.id.txtEmail)
    TextView txtEmail;

    @ViewById(R.id.loginLayout)
    LinearLayout loginLayout;

    @ViewById(R.id.notLoginLayout)
    LinearLayout notLoginLayout;


    List<MenuItem> menuItems;
    DataAdapter adapter;
    Context context;

    public MenuFragment(Context context) {
        super(context);
        this.context = context;
    }

    public MenuFragment(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
    }

    public MenuFragment(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        this.context = context;
    }

    @AfterViews
    protected void AfterViews() {
        initMenuItem();
        InitRecyclerView();
        if (MainApplication.sMyPrefs.ISLogin().get()) {
            loginLayout.setVisibility(VISIBLE);
            notLoginLayout.setVisibility(GONE);
        } else {
            loginLayout.setVisibility(GONE);
            notLoginLayout.setVisibility(VISIBLE);
        }
        UpdateData();
    }

    public void UpdateData() {
        if (txtName == null) return;
        if (MainApplication.sMyPrefs.ISLogin().get()) {
            txtName.setText(MainApplication.sMyPrefs.UserName().getOr(""));
            txtEmail.setText(MainApplication.sMyPrefs.UserEmail().getOr(""));
        } else {
            txtName.setText("");
            txtEmail.setText("");
        }
    }


    private void InitRecyclerView() {

        recycler.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getContext());
        recycler.setItemAnimator(null);
        recycler.setLayoutManager(linearLayoutManager);

        adapter = new DataAdapter(R.layout.row_menu_list, menuItems, recycler);
        recycler.setAdapter(adapter);

    }

    private void initMenuItem() {

        menuItems = new ArrayList<>();
//        menuItems.add(new MenuItem(getContext().getString(R.string.menu_home), R.drawable.ic_menu_home, MenuItem.MenuEnum.HOME));
        if (MainApplication.sMyPrefs.ISLogin().get()) {
//            menuItems.add(new MenuItem(getContext().getString(R.string.menu_profile), R.drawable.ic_menu_user, MenuItem.MenuEnum.PROFILE));
            menuItems.add(new MenuItem(getContext().getString(R.string.menu_cars), R.drawable.ic_menu_car, MenuItem.MenuEnum.CARS));
//            menuItems.add(new MenuItem(getContext().getString(R.string.menu_subscriptions), R.drawable.ic_menu_mysubscriptions, MenuItem.MenuEnum.SUBSCRIPTIONS));
            menuItems.add(new MenuItem(getContext().getString(R.string.menu_services), R.drawable.ic_menu_services, MenuItem.MenuEnum.SERVICES));
        } else {
            menuItems.add(new MenuItem(getContext().getString(R.string.Log_in_Register), R.drawable.ic_menu_user, MenuItem.MenuEnum.LOGOUT));
        }
        menuItems.add(new MenuItem(getContext().getString(R.string.menu_about), R.drawable.icmenu_about_logo, MenuItem.MenuEnum.ABOUT_US));
        menuItems.add(new MenuItem(getContext().getString(R.string.menu_contact_us), R.drawable.ic_menu_contact_us, MenuItem.MenuEnum.CONTACT_US));
        menuItems.add(new MenuItem(getContext().getString(R.string.menu_setting), R.drawable.ic_menu_settings, MenuItem.MenuEnum.SETTINGS));
        if (MainApplication.sMyPrefs.ISLogin().get()) {
            menuItems.add(new MenuItem(getContext().getString(R.string.menu_logout), R.drawable.ic_menu_logout, MenuItem.MenuEnum.LOGOUT));
        }


    }


    @Click(R.id.loginLayout)
    protected void loginLayout() {
        if (!MainApplication.sMyPrefs.ISLogin().get()) {
            Utils.LoginDialog((BaseActivity)getContext());
            return;
        }
        EditProfileActivity_.intent(getContext()).start();
    }

    @Click(R.id.facebookBtn)
    protected void facebookBtn() {
        OpenLink(MainApplication.sMyPrefs.facebook().get());
    }

    @Click(R.id.twitterBtn)
    protected void twitterBtn() {
        OpenLink(MainApplication.sMyPrefs.twitter().get());
    }

    @Click(R.id.instagramBtn)
    protected void instagramBtn() {
        OpenLink(MainApplication.sMyPrefs.instagram().get());
    }

    @Click(R.id.poweredByLineBtn)
    protected void poweredByLineBtn() {
        OpenLink("http://linekw.com");
    }

    private void OpenLink(String url) {
        if (TextUtils.isEmpty(url)) return;
        if (!url.contains("http")) {
            url = "http://" + url;
        }
        try {
            Intent i = new Intent(Intent.ACTION_VIEW);
            i.setData(Uri.parse(url));
            getContext().startActivity(i);
        } catch (Exception ex) {

        }

    }

}
