package com.app.roadz.modules.AdsSlider;

import android.content.Intent;

import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentStatePagerAdapter;

import com.app.roadz.R;
import com.app.roadz.Utils.RtlViewPager.RtlViewPager;
import com.app.roadz.app.MainApplication;
import com.app.roadz.model.TSlider;
import com.app.roadz.modules.base.BaseActivity;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rd.PageIndicatorView;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;


@EActivity(R.layout.activity_images_sliding)
public class ImageSliderActivity extends BaseActivity {

    @ViewById(R.id.pager)
    protected RtlViewPager viewPager;

    @ViewById(R.id.pageIndicatorView)
    protected PageIndicatorView mIndicator;

    IntroductionViewPagerAdapter adapter;

    List<TSlider> itemList;


    @AfterViews
    protected void AfterViews() {


        try {
            itemList = Arrays.asList(new ObjectMapper().readValue(MainApplication.sMyPrefs.sliders().get(), TSlider[].class));
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (itemList == null) {
            getStartedBtn();
            return;
        }


        adapter = new IntroductionViewPagerAdapter(getSupportFragmentManager());
        viewPager.setAdapter(adapter);
        mIndicator.setViewPager(viewPager);


    }

    @Click(R.id.getStartedBtn)
    protected void getStartedBtn() {
        this.finish();
        AdsActivity_.intent(this).
                flags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK ).start();
    }


    public class IntroductionViewPagerAdapter extends FragmentStatePagerAdapter {


        public IntroductionViewPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public ImageSliderFragment getItem(int i) {

            return ImageSliderFragment_.builder().tSlider(itemList.get(i)).build();
        }

        @Override
        public int getCount() {
            return itemList.size();
        }
    }

}
