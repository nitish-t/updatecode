package com.app.roadz.modules.Home;

import android.os.Handler;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.BaseController;
import com.app.roadz.controller.UserController;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.THomeData;
import com.app.roadz.model.TUser;
import com.app.roadz.modules.Emergency.CarSevies.ChooseCarsServicesActivity_;
import com.app.roadz.modules.Home.Menu.MenuFragment;
import com.app.roadz.modules.Notification.NotificationsListActivity_;
import com.app.roadz.modules.ServicesOverview.ServicesOverviewActivity_;
import com.app.roadz.modules.User.EditProfileActivity_;
import com.app.roadz.modules.User.LoginActivity_;
import com.app.roadz.modules.User.SignUp.SignUpActivity_;
import com.app.roadz.modules.base.BaseActivity;
import com.yarolegovich.slidingrootnav.SlideGravity;
import com.yarolegovich.slidingrootnav.SlidingRootNav;
import com.yarolegovich.slidingrootnav.SlidingRootNavBuilder;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.SystemService;
import org.androidannotations.annotations.ViewById;

import java.util.HashMap;
import java.util.Map;

import retrofit2.Call;
import retrofit2.Response;

@EActivity(R.layout.activity_home)
public class HomeActivity extends BaseActivity {

    @SystemService
    LayoutInflater mLayoutInflater;

    @Extra
    boolean FromDemo;

    MenuFragment menuFragment;
    SlidingRootNav slidingRootNav;

    @ViewById(R.id.requestEmergencyLayout)
    Button requestEmergencyLayout;

    @ViewById(R.id.notification_count)
    TextView notification_count;

    @ViewById(R.id.youtubeBtn)
    ImageView youtubeBtn;

    Handler timerHandler;
    Runnable timerRunnable;

    @AfterViews
    protected void AfterViews() {

        if (MainApplication.sMyPrefs.ISLogin().get()) {
            youtubeBtn.setVisibility(View.GONE);
        }
        menuFragment = (MenuFragment) mLayoutInflater.inflate(R.layout.fragment_meun, null);
        notification_count.setVisibility(View.INVISIBLE);
        slidingRootNav = new SlidingRootNavBuilder(this)
                .withMenuView(menuFragment)
                .withDragDistance(240)
                .withRootViewScale(0.85f)
                .withGravity(MainApplication.ISlocaleArabic(this) ? SlideGravity.RIGHT : SlideGravity.LEFT)
                .withContentClickableWhenMenuOpened(false)
                .inject();
        SendFCMToken();

        if (MainApplication.sMyPrefs.ISLogin().get()) {
            requestEmergencyLayout.setText(R.string.request);
        } else if (FromDemo) {
            requestEmergencyLayout.setText(R.string.try_to_request);
        } else {
            requestEmergencyLayout.setText(R.string.sign_up);
        }

        timerHandler = new Handler();
        timerRunnable = new Runnable() {

            @Override
            public void run() {
                getNotificationCoutn();
                timerHandler.postDelayed(this, 10 * 1000);
            }
        };
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (timerHandler != null && timerRunnable != null) {
            timerHandler.removeCallbacks(timerRunnable);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (menuFragment != null) {
            menuFragment.UpdateData();
        }
        if (timerHandler != null && timerRunnable != null) {
            timerHandler.post(timerRunnable);
        }
    }

    @Override
    public void onBackPressed() {
        if (slidingRootNav.isMenuOpened()) {
            slidingRootNav.closeMenu();
        } else {
            MainApplication.sMyPrefs.ShowDemo().put(false);
            super.onBackPressed();
        }
    }

    @Click(R.id.toolbar_menu)
    protected void toolbar_menu() {
        if (slidingRootNav.isMenuClosed()) {
            slidingRootNav.openMenu();
        } else {
            slidingRootNav.closeMenu();
        }
    }


    @Click(R.id.requestEmergencyLayout)
    protected void emergencyLayout() {
        if (MainApplication.sMyPrefs.ISLogin().get()) {
            ChooseCarsServicesActivity_.intent(this).start();
        } else if (FromDemo) {
            ServicesOverviewActivity_.intent(this).start();
        } else {
            SignUpActivity_.intent(this).start();
        }

    }

    @Click(R.id.youtubeBtn)
    protected void youtubeBtn() {
        String youtubeID = Utils.extractYTId(MainApplication.sMyPrefs.youtube_emergency().get());
        if (TextUtils.isEmpty(youtubeID)) {
            MainApplication.Toast(getString(R.string.youtube_unavailable));
            return;
        }
        YoutubePlayerActivity_.intent(this).youtubeID(youtubeID).start();
    }

    @Click(R.id.toolbar_notification)
    protected void toolbar_notification() {
        if (!MainApplication.sMyPrefs.ISLogin().get()) {
            Utils.LoginDialog(this);
            return;
        }
        NotificationsListActivity_.intent(this).start();
    }

    @Click(R.id.toolbar_user)
    protected void toolbar_user() {
        if (!MainApplication.sMyPrefs.ISLogin().get()) {
            Utils.LoginDialog(this);
            return;
        }
        EditProfileActivity_.intent(this).start();
    }


    private void SendFCMToken() {
        if (TextUtils.isEmpty(MainApplication.sMyPrefs.FcmToken().get())) return;
        Map<String, String> Data = new HashMap<>();
        Data.put("token", MainApplication.sMyPrefs.FcmToken().get());
        Data.put("type", "2");
        RetrofitHelper.getRetrofit().create(UserController.class).SendFcmToken(Data).enqueue(new BaseCallback<ObjectBaseResponse<TUser>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<TUser>> call, Response<ObjectBaseResponse<TUser>> response) {
                if (response.body() != null && response.body().getStatus()) {
//                    MainApplication.sMyPrefs.ISFcmSend().put(true);
                }
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
            }
        });
    }

    private void getNotificationCoutn() {
        RetrofitHelper.getRetrofit().create(BaseController.class).getNotificationCount().enqueue(new BaseCallback<ObjectBaseResponse<THomeData>>() {
            @Override
            public void onResponse(Call<ObjectBaseResponse<THomeData>> call, Response<ObjectBaseResponse<THomeData>> response) {

                if (response.body() != null && response.body().getObject() != null) {

                    int notificationCount = response.body().getObject().getNot_read_notification_count();
                    if (notificationCount == 0) {
                        notification_count.setVisibility(View.INVISIBLE);
                    } else {
                        notification_count.setVisibility(View.VISIBLE);
                        notification_count.setText(notificationCount + "");
                    }

                }

            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<THomeData>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
            }
        });
    }

}
