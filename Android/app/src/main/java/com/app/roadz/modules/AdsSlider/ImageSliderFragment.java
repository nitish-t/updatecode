package com.app.roadz.modules.AdsSlider;


import android.widget.ImageView;
import android.widget.ProgressBar;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.model.TSlider;
import com.app.roadz.modules.base.BaseFragment;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.EFragment;
import org.androidannotations.annotations.FragmentArg;
import org.androidannotations.annotations.ViewById;


@EFragment(R.layout.fragment_image_slider)
public class ImageSliderFragment extends BaseFragment {


    @FragmentArg
    TSlider tSlider;

    @ViewById(R.id.image)
    ImageView image;

    @ViewById(R.id.progress_bar)
    ProgressBar progress_bar;

//    @ViewById(R.id.title)
//    TextView title;


    @AfterViews
    protected void AfterViews() {
        if (tSlider != null)
            Utils.loadImage(tSlider.getImage(), image, progress_bar);
//        if (Pos == 0) {
//            image.setImageResource(R.drawable.ic_ads_image_test);
//            title.setText("\" Find out the best Car Maintenance that match your Requirement \"");
//        } else if (Pos == 1) {
//            image.setImageResource(R.drawable.ic_slider_test);
//            title.setVisibility(View.GONE);
//        } else if (Pos == 2) {
//            image.setImageResource(R.drawable.ic_ads_image_test3);
//            title.setText("\" Find out the best Car Maintenance that match your  Requirement \"");
//        }

    }

}
