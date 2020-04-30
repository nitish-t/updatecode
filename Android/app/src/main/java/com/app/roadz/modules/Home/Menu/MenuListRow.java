package com.app.roadz.modules.Home.Menu;

import android.content.Context;
import android.content.Intent;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.UserController;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.TUser;
import com.app.roadz.modules.Home.HomeActivity_;
import com.app.roadz.modules.MyCars.MyCarsListActivity_;
import com.app.roadz.modules.MySubscriptions.MySubscriptionsListActivity_;
import com.app.roadz.modules.OurServices.OurServicesActivity_;
import com.app.roadz.modules.Setting.ContactUSActivity_;
import com.app.roadz.modules.Setting.SettingActivity_;
import com.app.roadz.modules.Setting.StaticDataActivity_;
import com.app.roadz.modules.User.EditProfileActivity_;
import com.app.roadz.modules.User.LoginActivity_;
import com.app.roadz.modules.base.BaseActivity;
import com.app.roadz.recyclerview.ViewBinder;

import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.ViewById;

import retrofit2.Call;
import retrofit2.Response;


@EView
public class MenuListRow extends LinearLayout implements ViewBinder<Object>, View.OnClickListener {


    @ViewById(R.id.menu_icon)
    protected ImageView menu_icon;

    @ViewById(R.id.title)
    protected TextView title;


    MenuItem menuItem;
    Context context;

    public MenuListRow(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.context = context;
        Init();
    }

    public MenuListRow(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        Init();
    }

    private void Init() {
        this.setOnClickListener(this);
    }


    @Override
    public void bindViews(Object obj, int position, RecyclerView recyclerView) {
        menuItem = (MenuItem) obj;
        if (menuItem == null) return;

        menu_icon.setImageResource(menuItem.getMenu_Icon());
        title.setText(menuItem.getMenu_Name());

    }


    @Override
    public void onClick(View v) {
        ((BaseActivity) getContext()).onBackPressed();
        if (menuItem == null) return;

        if (MenuItem.MenuEnum.LOGOUT.getValue().equalsIgnoreCase(menuItem.getMenu_Enum())) {
            if (MainApplication.sMyPrefs.ISLogin().get()) {
                Utils.LogoutDialog((BaseActivity) getContext(), new Runnable() {
                    @Override
                    public void run() {
                        SendTOServerLogout();
                    }
                });
            } else {
                LoginActivity_.intent(getContext()).start();
            }
        } else if (MenuItem.MenuEnum.PROFILE.getValue().equalsIgnoreCase(menuItem.getMenu_Enum())) {
            if (!MainApplication.sMyPrefs.ISLogin().get()) {
                Utils.LoginDialog((BaseActivity)getContext());
                return;
            }
            EditProfileActivity_.intent(getContext()).start();

        } else if (MenuItem.MenuEnum.SERVICES.getValue().equalsIgnoreCase(menuItem.getMenu_Enum())) {
            OurServicesActivity_.intent(getContext()).start();

        } else if (MenuItem.MenuEnum.ABOUT_US.getValue().equalsIgnoreCase(menuItem.getMenu_Enum())) {
            StaticDataActivity_.intent(getContext()).Type(1).start();

        } else if (MenuItem.MenuEnum.CONTACT_US.getValue().equalsIgnoreCase(menuItem.getMenu_Enum())) {
            ContactUSActivity_.intent(getContext()).start();

        } else if (MenuItem.MenuEnum.SETTINGS.getValue().equalsIgnoreCase(menuItem.getMenu_Enum())) {
            SettingActivity_.intent(getContext()).start();

        } else if (MenuItem.MenuEnum.CARS.getValue().equalsIgnoreCase(menuItem.getMenu_Enum())) {
            if (!MainApplication.sMyPrefs.ISLogin().get()) {
                Utils.LoginDialog((BaseActivity)getContext());
                return;
            }
            MyCarsListActivity_.intent(getContext()).start();

        } else if (MenuItem.MenuEnum.SUBSCRIPTIONS.getValue().equalsIgnoreCase(menuItem.getMenu_Enum())) {
            if (!MainApplication.sMyPrefs.ISLogin().get()) {
                Utils.LoginDialog((BaseActivity)getContext());
                return;
            }
            MySubscriptionsListActivity_.intent(getContext()).start();
        }
    }

    private void SendTOServerLogout() {
        ((BaseActivity) getContext()).ShowProgress();

        BaseCallback<ObjectBaseResponse<TUser>> callback = new BaseCallback<ObjectBaseResponse<TUser>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<TUser>> call, Response<ObjectBaseResponse<TUser>> response) {
                ((BaseActivity) getContext()).HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    Constants.ErrorMsg(response);
                    return;
                }

                if (!response.body().getStatus()) {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        MainApplication.Toast(response.body().getMessage());
                    } else {
                        MainApplication.ErrorToast();
                    }
                    return;
                }

                MainApplication.sMyPrefs.AccessToken().put("");
                MainApplication.sMyPrefs.UserName().put("");
                MainApplication.sMyPrefs.UserEmail().put("");
                MainApplication.sMyPrefs.UserMobile().put("");
                MainApplication.sMyPrefs.UserImage().put("");
                MainApplication.sMyPrefs.ISLogin().put(false);
                MainApplication.sMyPrefs.ISFcmSend().put(false);
                ((BaseActivity)getContext()).finish();
                HomeActivity_.intent(getContext()).
                        flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK ).start();
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                ((BaseActivity) getContext()).HideProgress();
            }
        };


        RetrofitHelper.getRetrofit().create(UserController.class).Logout().enqueue(callback);

    }

}
