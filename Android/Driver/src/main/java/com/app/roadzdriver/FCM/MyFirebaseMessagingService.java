/**
 * Copyright 2016 Google Inc. All Rights Reserved.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.app.roadzdriver.FCM;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;
import android.text.Html;
import android.text.TextUtils;
import android.util.Log;

import androidx.core.app.NotificationCompat;

import com.app.roadzdriver.R;
import com.app.roadzdriver.app.MainApplication;
import com.app.roadzdriver.modules.Home.HomeActivity;
import com.app.roadzdriver.modules.Splash.SplashActivity_;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import java.util.Random;

public class MyFirebaseMessagingService extends FirebaseMessagingService {

    private static final String TAG = "MyFirebaseMsgService";
    private static final int WEAR_REQUEST_CODE = 236;
    private static final String CHANNEL_ID = "roadz";

    /**
     * Called when message is received.
     *
     * @param remoteMessage Object representing the message received from Firebase Cloud Messaging.
     */
    // [START receive_message]
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        // [START_EXCLUDE]
        // There are two types of messages data messages and notification messages. Data messages are handled
        // here in onMessageReceived whether the app is in the foreground or background. Data messages are the type
        // traditionally used with GCM. Notification messages are only received here in onMessageReceived when the app
        // is in the foreground. When the app is in the background an automatically generated notification is displayed.
        // When the user taps on the notification they are returned to the app. Messages containing both notification
        // and data payloads are treated as notification messages. The Firebase console always sends notification
        // messages. For more see: https://firebase.google.com/docs/cloud-messaging/concept-options
        // [END_EXCLUDE]

        // TODO(developer): Handle FCM messages here.
        // Not getting messages here? See why this may be: https://goo.gl/39bRNJ
        Log.d(TAG, "From: " + remoteMessage.getFrom());
        Log.d(TAG, "Data: " + remoteMessage.getData() + "");
        int post_id = 0;
        String post_type = null;
        String body = null;

        if (!TextUtils.isEmpty(remoteMessage.getNotification().getBody())) {
            sendNotification(remoteMessage.getNotification().getBody());
            return;
        }
        if (remoteMessage.getData() != null) {
//            Log.d(TAG, "Message Notification Body: " + remoteMessage.getNotification().getBody());
//            if (remoteMessage.getData().size() > 0) {
//                JSONObject jsonObj = new JSONObject(remoteMessage.getData());
//                try {
//                    if (jsonObj.has("post_id"))
//                        post_id = jsonObj.getInt("post_id");
//
//                    if (jsonObj.has("post_type"))
//                        post_type = jsonObj.getString("post_type");
//
//                    if (jsonObj.has("body"))
//                        body = jsonObj.getString("body");
//                } catch (JSONException e) {
//                    e.printStackTrace();
//                }
//            }
            sendNotification(remoteMessage.getData().toString());
            return;
        }

    }


    private void sendNotification(String messageBody) {
        if (messageBody == null || messageBody.isEmpty()) return;
        try {
            if (MainApplication.getBaseActivity() != null) {
                MainApplication.Toast(getString(R.string.new_order));
                if (MainApplication.getBaseActivity() instanceof HomeActivity) {
                    ((HomeActivity) MainApplication.getBaseActivity()).onRefresh();
                }
            }
        } catch (Exception ex) {

        }

        Intent intent = new Intent(this, SplashActivity_.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        intent.setAction(Long.toString(System.currentTimeMillis()));


        PendingIntent pendingIntent = PendingIntent.getActivity(this, new Random().nextInt() /* Request code */, intent,
                PendingIntent.FLAG_ONE_SHOT);

        NotificationManager notificationManager =
                (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        Uri alarmSound = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);

        int currentapiVersion = Build.VERSION.SDK_INT;
        if (currentapiVersion >= Build.VERSION_CODES.JELLY_BEAN) {
            NotificationCompat.Builder builder = new NotificationCompat.Builder(this, CHANNEL_ID);
            builder.setSmallIcon(R.drawable.icmenu_about_logo)
                    .setColor(getResources().getColor(R.color.white))
                    .setContentTitle(getString(R.string.app_name))
                    .setContentIntent(pendingIntent)
                    .setContentText(String.format(messageBody))
                    .setAutoCancel(true)
                    .setDefaults(Notification.DEFAULT_ALL)
                    .setStyle(new NotificationCompat.BigTextStyle()
                            .bigText(messageBody))
                    .setPriority(Notification.PRIORITY_HIGH);


            Intent notifyNextTimeIntent = new Intent(this, SplashActivity_.class);
            PendingIntent pendingIntentNotify = PendingIntent.getBroadcast(this, WEAR_REQUEST_CODE, notifyNextTimeIntent, PendingIntent.FLAG_UPDATE_CURRENT);
            NotificationCompat.Action actionNotifyNextTime = new NotificationCompat.Action.Builder(R.drawable.icmenu_about_logo, messageBody, pendingIntentNotify).build();

            NotificationCompat.WearableExtender extender = new NotificationCompat.WearableExtender();
            extender.addAction(actionNotifyNextTime);

            //Extend Notification builder
            builder.extend(extender);

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                CharSequence name = getString(R.string.channel_name);
                String description = getString(R.string.channel_description);
                int importance = NotificationManager.IMPORTANCE_DEFAULT;
                NotificationChannel channel = new NotificationChannel(CHANNEL_ID, name, importance);
                channel.setDescription(description);
                notificationManager.createNotificationChannel(channel);
                notificationManager.notify(14, builder.build());
            } else {
                notificationManager.notify((int) System.nanoTime(), builder.build());
            }

            //  notificationManager.notify((int) System.nanoTime(), builder.build());
        } else {
            NotificationCompat.Builder mBuilder = new NotificationCompat.Builder(this).setSmallIcon(R.drawable.icmenu_about_logo).setTicker(Html.fromHtml(messageBody)).setContentTitle(getString(R.string.app_name))
                    .setContentText(Html.fromHtml(messageBody))
                    .setOnlyAlertOnce(true).setAutoCancel(true)
                    .setSound(alarmSound);
            // mBuilder.setContentIntent(contentIntent);
            mBuilder.setContentIntent(pendingIntent);
            notificationManager.notify((int) System.nanoTime(), mBuilder.build());
        }
    }
}