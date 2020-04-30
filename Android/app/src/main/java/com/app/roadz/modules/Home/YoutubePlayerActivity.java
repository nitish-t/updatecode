package com.app.roadz.modules.Home;

import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.app.roadz.R;
import com.app.roadz.app.MainApplication;
import com.app.roadz.modules.base.BaseActivity;
import com.pierfrancescosoffritti.androidyoutubeplayer.core.player.YouTubePlayer;
import com.pierfrancescosoffritti.androidyoutubeplayer.core.player.listeners.AbstractYouTubePlayerListener;
import com.pierfrancescosoffritti.androidyoutubeplayer.core.player.views.YouTubePlayerView;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.Extra;
import org.androidannotations.annotations.ViewById;

@EActivity(R.layout.activity_youtube_player)
public class YoutubePlayerActivity extends BaseActivity {

    @Extra
    String youtubeID;

    @ViewById(R.id.youtube_player_view)
    protected YouTubePlayerView youTubePlayerView;

    @AfterViews
    protected void AfterViews() {
        getLifecycle().addObserver(youTubePlayerView);
        youTubePlayerView.addYouTubePlayerListener(new AbstractYouTubePlayerListener() {
            @Override
            public void onReady(@NonNull YouTubePlayer youTubePlayer) {
                String videoId = youtubeID;
                if (TextUtils.isEmpty(videoId)) {
                    MainApplication.Toast(getString(R.string.youtube_unavailable));
                    YoutubePlayerActivity.super.onBackPressed();
                    return;
                }
                youTubePlayer.loadVideo(videoId, 0f);
            }
        });
    }

    @Click(R.id.toolbar_back)
    protected void toolbar_back() {
        super.onBackPressed();
    }
}
