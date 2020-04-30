package com.app.roadz.modules.Notification;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.api.BaseCallback;
import com.app.roadz.api.RetrofitHelper;
import com.app.roadz.app.Constants;
import com.app.roadz.controller.UserController;
import com.app.roadz.model.BaseModel.BaseModel;
import com.app.roadz.model.TNotification;
import com.app.roadz.modules.base.BaseActivity;

import org.androidannotations.annotations.EView;
import org.androidannotations.annotations.ViewById;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import retrofit2.Call;
import retrofit2.Response;

@EView
public class NotificationPopup extends LinearLayout {


    @ViewById(R.id.notificationTitle)
    protected TextView notificationTitle;

    @ViewById(R.id.notificationDate)
    protected TextView notificationDate;

    @ViewById(R.id.notificationBody)
    protected TextView notificationBody;


    public NotificationPopup(Context context) {
        super(context);
    }

    public NotificationPopup(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public NotificationPopup(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }


    public void intiView(TNotification object) {
        notificationTitle.setText(object.getTitle());
        notificationBody.setText(object.getBody());
//        notificationDate.setText(Constants.GetStringDateFromString(object.getCreatedAt(), "dd-MM-yyyy", Constants.DISPLAY_DATE_FORMAT));
        Date date = Constants.GetDateFromString(object.getCreatedAt(), "yyyy-MM-dd HH:mm:ss");
        notificationDate.setText(Utils.Ago(date));

        MakeNotificationRead(object.getId());
    }

    protected void MakeNotificationRead(int id) {
//        ((BaseActivity) getContext()).ShowProgress();
        BaseCallback<BaseModel> callback = new BaseCallback<BaseModel>() {

            @Override
            public void onResponse(Call<BaseModel> call, Response<BaseModel> response) {
//                ((BaseActivity) getContext()).HideProgress();
            }

            @Override
            public void onFailure(Call<BaseModel> call, Throwable t) {
                Log.d("TAG", "onFailure : " + t.getMessage());
//                ((BaseActivity) getContext()).HideProgress();
            }
        };

        Map<String, String> map = new HashMap<>();
        map.put("id", id + "");
        RetrofitHelper.getRetrofit().create(UserController.class).MakeNotificationRead(map).enqueue(callback);

    }


}
