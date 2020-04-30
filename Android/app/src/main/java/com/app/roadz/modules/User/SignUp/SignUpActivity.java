package com.app.roadz.modules.User.SignUp;

import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentStatePagerAdapter;
import androidx.viewpager.widget.ViewPager;

import com.app.roadz.R;
import com.app.roadz.Utils.NonSwipeableViewPager;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.app.MainApplication;
import com.app.roadz.controller.UserController;
import com.app.roadz.model.BaseModel.ObjectBaseResponse;
import com.app.roadz.model.TUser;
import com.app.roadz.modules.Emergency.EmergencyCheckOut_;
import com.app.roadz.modules.Home.HomeActivity_;
import com.app.roadz.modules.MyCars.AddCarActivity;
import com.app.roadz.modules.base.BaseActivity;
import com.app.roadz.modules.base.BaseFragment;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.ViewById;

import java.util.HashMap;
import java.util.Map;

import retrofit2.Call;
import retrofit2.Response;


@EActivity(R.layout.activity_sign_up)
public class SignUpActivity extends BaseActivity {

    @ViewById(R.id.toolbar_title)
    protected TextView toolbar_title;
    @ViewById(R.id.pager)
    protected NonSwipeableViewPager viewPager;
    @ViewById(R.id.sign_up_page_numbers)
    protected ImageView sign_up_page_numbers;
    @Extra
    boolean backToHome;
    ViewPagerAdapter adapter;
    Map<String, String> map;

    SignUpPage1Fragment signUpPage1Fragment;
    SignUpPage2Fragment signUpPage2Fragment;

    @AfterViews
    protected void AfterViews() {
        adapter = new ViewPagerAdapter(getSupportFragmentManager());
        viewPager.setAdapter(adapter);
        toolbar_title.setText(R.string.add_personal_details);
        sign_up_page_numbers.setImageResource(R.drawable.ic_signup_page1);
        viewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                if (position == 0) {
                    toolbar_title.setText(R.string.add_personal_details);
                    sign_up_page_numbers.setImageResource(R.drawable.ic_signup_page1);
                } else {
                    toolbar_title.setText(R.string.add_car_details);
                    sign_up_page_numbers.setImageResource(R.drawable.ic_signup_page2);
                }
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
    }

    protected void next_btn(Map<String, String> map) {
        this.map = map;
        CheckUserData();
    }

    public void SendAction(Map<String, String> map) {
        if (map == null) map = new HashMap<>();
        this.map.putAll(map);
        SendTOServer();
    }

    private void CheckUserData() {
        ShowProgress();
        RetrofitHelper.getRetrofit().create(UserController.class).checkRegisterData(map).enqueue(new BaseCallback<ObjectBaseResponse<TUser>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<TUser>> call, Response<ObjectBaseResponse<TUser>> response) {
                HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                    return;
                }

                if (!response.body().getStatus()) {
                    if (signUpPage1Fragment != null && response.body().getError() != null) {
                        signUpPage1Fragment.ShowValidationError(response.body().getError());
                    } else {
                        if (!TextUtils.isEmpty(response.body().getMessage())) {
                            MainApplication.Toast(response.body().getMessage());
                        } else {
                            MainApplication.ErrorToast();
                        }
                    }
                    return;
                }
                viewPager.setCurrentItem(viewPager.getCurrentItem() + 1, true);

            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        });
    }

    private void SendTOServer() {
        ShowProgress();
        RetrofitHelper.getRetrofit().create(UserController.class).SignUp(map).enqueue(new BaseCallback<ObjectBaseResponse<TUser>>() {

            @Override
            public void onResponse(Call<ObjectBaseResponse<TUser>> call, Response<ObjectBaseResponse<TUser>> response) {
                HideProgress();
                if (!response.isSuccessful() || response.body() == null) {
                    if (response.body() == null) {
                        Constants.ErrorMsg(response);
                        return;
                    }
                    return;
                }

                if (!response.body().getStatus()) {
                    if (!TextUtils.isEmpty(response.body().getMessage())) {
                        if (response.body().getError().containsKey("plate_number")) {
                            if (MainApplication.getLang(SignUpActivity.this).equals("ar")) {
                                MainApplication.Toast("رقم اللوحة مستخدم مسبقا");
                            } else {
                                MainApplication.Toast("The plate number is already exist");
                            }
                        } else {
                            MainApplication.Toast(response.body().getMessage());
                        }
                    } else {
                        MainApplication.ErrorToast();
                    }
                    return;
                }
                TUser tUser = response.body().getObject();
                MainApplication.sMyPrefs.AccessToken().put(tUser.getAccessToken());
                MainApplication.sMyPrefs.UserName().put(tUser.getFullName());
                MainApplication.sMyPrefs.UserEmail().put(tUser.getEmail());
                MainApplication.sMyPrefs.UserMobile().put(tUser.getMobile());
                MainApplication.sMyPrefs.UserImage().put(tUser.getProfileImage());
                MainApplication.sMyPrefs.ISLogin().put(true);
                SignUpActivity.this.finish();
                EmergencyCheckOut_.intent(SignUpActivity.this).
                        flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).fromRegister(true).start();
            }

            @Override
            public void onFailure(Call<ObjectBaseResponse<TUser>> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
                MainApplication.ErrorToast();
                HideProgress();
            }
        });
    }

    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        if (viewPager.getCurrentItem() != 0) {
            viewPager.setCurrentItem(0, true);
        } else {
            if (backToHome) {
                this.finish();
                HomeActivity_.intent(this).
                        flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK).start();
            } else {
                super.onBackPressed();
            }

        }
    }

    @Override
    public void onBackPressed() {
        toolbar_back();
    }

    public class ViewPagerAdapter extends FragmentStatePagerAdapter {


        public ViewPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public BaseFragment getItem(int i) {
            if (i == 0) {
                return signUpPage1Fragment = SignUpPage1Fragment_.builder().build();
            } else {
                return signUpPage2Fragment = SignUpPage2Fragment_.builder().build();

            }
        }

        @Override
        public int getCount() {
            return 2;
        }
    }
}
