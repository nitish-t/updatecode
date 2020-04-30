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


@EFragment(R.layout.fragment_ads)
public class AdsImageFragment extends BaseFragment {


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

    }

}
