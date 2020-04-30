package com.daimajia.slider.library.SliderTypes;

import android.content.Context;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;

import com.daimajia.slider.library.R;
import com.nostra13.universalimageloader.cache.disc.impl.UnlimitedDiskCache;
import com.nostra13.universalimageloader.cache.disc.naming.Md5FileNameGenerator;
import com.nostra13.universalimageloader.cache.memory.impl.LruMemoryCache;
import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.nostra13.universalimageloader.core.assist.FailReason;
import com.nostra13.universalimageloader.core.assist.ImageScaleType;
import com.nostra13.universalimageloader.core.display.FadeInBitmapDisplayer;
import com.nostra13.universalimageloader.core.listener.ImageLoadingListener;
import com.nostra13.universalimageloader.utils.L;
import com.nostra13.universalimageloader.utils.StorageUtils;
import com.squareup.picasso.Picasso;
import com.squareup.picasso.RequestCreator;

import java.io.File;

/**
 * When you want to make your own slider view, you must extends from this class.
 * BaseSliderView provides some useful methods.
 * I provide two example: {@link com.daimajia.slider.library.SliderTypes.DefaultSliderView} and
 * {@link com.daimajia.slider.library.SliderTypes.TextSliderView}
 * if you want to show progressbar, you just need to set a progressbar id as @+id/loading_bar.
 */
public abstract class BaseSliderView {

    protected Context mContext;

    private Bundle mBundle;

    /**
     * Error place holder image.
     */
    private int mErrorPlaceHolderRes;

    /**vi
     * Empty imageView placeholder.
     */
    private int mEmptyPlaceHolderRes;

    private String mUrl;
    private String mSubUrl;
    private File mFile;
    private int mRes;

    protected OnSliderClickListener mOnSliderClickListener;

    private boolean mErrorDisappear;

    private ImageLoadListener mLoadListener;

    private String mTitle;
    private String mSubTitle;
    private String mPrise;
    private boolean ShowTitle=true;
    private boolean isVideo=false;

    private Picasso mPicasso;

    ImageLoader sImageLoader;
    DisplayImageOptions sItemUnviralImageOptions;
    /**
     * Scale type of the image.
     */
    private ScaleType mScaleType = ScaleType.Fit;

    public enum ScaleType {
        CenterCrop, CenterInside, Fit, FitCenterCrop
    }

    protected BaseSliderView(Context context) {
        mContext = context;
    }

    /**
     * the placeholder image when loading image from url or file.
     *
     * @param resId Image resource id
     * @return
     */
    public BaseSliderView empty(int resId) {
        mEmptyPlaceHolderRes = resId;
        return this;
    }

    /**
     * determine whether remove the image which failed to download or load from file
     *
     * @param disappear
     * @return
     */
    public BaseSliderView errorDisappear(boolean disappear) {
        mErrorDisappear = disappear;
        return this;
    }

    /**
     * if you set errorDisappear false, this will set a error placeholder image.
     *
     * @param resId image resource id
     * @return
     */
    public BaseSliderView error(int resId) {
        mErrorPlaceHolderRes = resId;
        return this;
    }

    /**
     * the description of a slider image.
     *
     * @param description
     * @return
     */
    public BaseSliderView title(String description) {
        mTitle = description;
        return this;
    }

    public BaseSliderView ShowTitle(boolean ShowTitle) {
        this.ShowTitle = ShowTitle;
        return this;
    }

    public BaseSliderView isVideo(boolean isVideo) {
        this.isVideo = isVideo;
        return this;
    }

    public BaseSliderView subTitle(String description) {
        mSubTitle = description;
        return this;
    }

    public BaseSliderView prise(String description) {
        mPrise = description;
        return this;
    }

    /**
     * set a url as a image that preparing to load
     *
     * @param url
     * @return
     */
    public BaseSliderView image(String url) {
        if (mFile != null || mRes != 0) {
            throw new IllegalStateException("Call multi image function," +
                    "you only have permission to call it once");
        }
        mUrl = url;
        return this;
    }

    public BaseSliderView Subimage(String url) {
        if (mFile != null || mRes != 0) {
            throw new IllegalStateException("Call multi image function," +
                    "you only have permission to call it once");
        }
        mSubUrl = url;
        return this;
    }

    /**
     * set a file as a image that will to load
     *
     * @param file
     * @return
     */
    public BaseSliderView image(File file) {
        if (mUrl != null || mRes != 0) {
            throw new IllegalStateException("Call multi image function," +
                    "you only have permission to call it once");
        }
        mFile = file;
        return this;
    }

    public BaseSliderView image(int res) {
        if (mUrl != null || mFile != null) {
            throw new IllegalStateException("Call multi image function," +
                    "you only have permission to call it once");
        }
        mRes = res;
        return this;
    }

    /**
     * lets users add a bundle of additional information
     *
     * @param bundle
     * @return
     */
    public BaseSliderView bundle(Bundle bundle) {
        mBundle = bundle;
        return this;
    }

    public String getUrl() {
        return mUrl;
    }

    public String getSubUrl() {
        return mSubUrl;
    }

    public boolean isErrorDisappear() {
        return mErrorDisappear;
    }

    public int getEmpty() {
        return mEmptyPlaceHolderRes;
    }

    public int getError() {
        return mErrorPlaceHolderRes;
    }

    public String getTitle() {
        return mTitle;
    }

    public boolean ISShowTitle() {
        return ShowTitle;
    }

    public boolean ISShowVideo() {
        return isVideo;
    }

    public String getSubTitle() {
        return mSubTitle;
    }

    public String getPrise() {
        return mPrise;
    }

    public Context getContext() {
        return mContext;
    }

    /**
     * set a slider image click listener
     *
     * @param l
     * @return
     */
    public BaseSliderView setOnSliderClickListener(OnSliderClickListener l) {
        mOnSliderClickListener = l;
        return this;
    }

    /**
     * When you want to implement your own slider view, please call this method in the end in `getView()` method
     *
     * @param v               the whole view
     * @param targetImageView where to place image
     */
    protected void bindEventAndShow(final View v, ImageView targetImageView) {
        final BaseSliderView me = this;

        v.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mOnSliderClickListener != null) {
                    mOnSliderClickListener.onSliderClick(me);
                }
            }
        });

        if (targetImageView == null)
            return;

        if (mLoadListener != null) {
            mLoadListener.onStart(me);
        }

        Picasso p = (mPicasso != null) ? mPicasso : Picasso.get();
        RequestCreator rq = null;

        if (mUrl != null) {
            rq = p.load(mUrl);
        } else if (mFile != null) {
            rq = p.load(mFile);
        } else if (mRes != 0) {
            rq = p.load(mRes);
        } else {
            return;
        }

        if (sImageLoader == null) {
            initImageLoader();
        }

        if (rq == null) {
            return;
        }

        if (getEmpty() != 0) {
            rq.placeholder(getEmpty());
        }

        if (getError() != 0) {
            rq.error(getError());
        }

        targetImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
//        switch (mScaleType) {
//            case Fit:
//                rq.fit();
//                targetImageView.setScaleType(ImageView.ScaleType.FIT_CENTER);
//                break;
//            case CenterCrop:
//                rq.fit().centerCrop();
//                targetImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
//                break;
//            case CenterInside:
//                rq.fit().centerInside();
//                targetImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
//                break;
//        }

//        rq.into(targetImageView,new Callback() {
//            @Override
//            public void onSuccess() {
//                if(v.findViewById(R.id.loading_bar) != null){
//                    v.findViewById(R.id.loading_bar).setVisibility(View.INVISIBLE);
//                }
//            }
//
//            @Override
//            public void onError() {
//                if(mLoadListener != null){
//                    mLoadListener.onEnd(false,me);
//                }
//                if(v.findViewById(R.id.loading_bar) != null){
//                    v.findViewById(R.id.loading_bar).setVisibility(View.INVISIBLE);
//                }
//                if(v.findViewById(R.id.daimajia_slider_image) != null){
//                    ((ImageView)v.findViewById(R.id.daimajia_slider_image)).setImageResource(R.drawable.ic_dif);
//                }
//            }
//        });

        if (mRes!=0){
            targetImageView.setImageResource(mRes);
            if (v.findViewById(R.id.loading_bar) != null) {
                v.findViewById(R.id.loading_bar).setVisibility(View.GONE);
            }
            return;
        }

        sImageLoader.displayImage(getUrl(), targetImageView, new ImageLoadingListener() {
                    @Override
                    public void onLoadingStarted(String imageUri, View view) {
                        if (v.findViewById(R.id.loading_bar) != null) {
                            v.findViewById(R.id.loading_bar).setVisibility(View.VISIBLE);
                        }
                    }

                    @Override
                    public void onLoadingFailed(String imageUri, View view, FailReason failReason) {
                        if (v.findViewById(R.id.loading_bar) != null) {
                            v.findViewById(R.id.loading_bar).setVisibility(View.INVISIBLE);
                        }
                    }

                    @Override
                    public void onLoadingComplete(String imageUri, View view, Bitmap loadedImage) {
                        if (v.findViewById(R.id.loading_bar) != null) {
                            v.findViewById(R.id.loading_bar).setVisibility(View.INVISIBLE);
                        }
                    }

                    @Override
                    public void onLoadingCancelled(String imageUri, View view) {
                        if (v.findViewById(R.id.loading_bar) != null) {
                            v.findViewById(R.id.loading_bar).setVisibility(View.INVISIBLE);
                        }
                    }
                }
        );
    }

    protected void bindEventAndShowSub(final View v, ImageView targetImageView) {
        final BaseSliderView me = this;

        v.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mOnSliderClickListener != null) {
                    mOnSliderClickListener.onSliderClick(me);
                }
            }
        });

        if (targetImageView == null)
            return;

        if (mLoadListener != null) {
            mLoadListener.onStart(me);
        }

        Picasso p = (mPicasso != null) ? mPicasso : Picasso.get();
        RequestCreator rq = null;

        if (mSubUrl != null) {
            rq = p.load(mSubUrl);
        } else if (mFile != null) {
            rq = p.load(mFile);
        } else if (mRes != 0) {
            rq = p.load(mRes);
        } else {
            return;
        }

        if (sImageLoader == null) {
            initImageLoader();
        }

        if (rq == null) {
            return;
        }

        if (getEmpty() != 0) {
            rq.placeholder(getEmpty());
        }

        if (getError() != 0) {
            rq.error(getError());
        }
        targetImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
//        switch (mScaleType) {
//            case Fit:
//                rq.fit();
//                targetImageView.setScaleType(ImageView.ScaleType.FIT_CENTER);
//                break;
//            case CenterCrop:
//                rq.fit().centerCrop();
//                targetImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
//                break;
//            case CenterInside:
//                rq.fit().centerInside();
//                targetImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
//                break;
//        }

//        rq.into(targetImageView,new Callback() {
//            @Override
//            public void onSuccess() {
//                if(v.findViewById(R.id.loading_bar) != null){
//                    v.findViewById(R.id.loading_bar).setVisibility(View.INVISIBLE);
//                }
//            }
//
//            @Override
//            public void onError() {
//                if(mLoadListener != null){
//                    mLoadListener.onEnd(false,me);
//                }
//                if(v.findViewById(R.id.loading_bar) != null){
//                    v.findViewById(R.id.loading_bar).setVisibility(View.INVISIBLE);
//                }
//                if(v.findViewById(R.id.daimajia_slider_image) != null){
//                    ((ImageView)v.findViewById(R.id.daimajia_slider_image)).setImageResource(R.drawable.ic_dif);
//                }
//            }
//        });

        if (mRes!=0){
            targetImageView.setImageResource(mRes);
            if (v.findViewById(R.id.loading_bar) != null) {
                v.findViewById(R.id.loading_bar).setVisibility(View.GONE);
            }
            return;
        }
        sImageLoader.displayImage(getSubUrl(), targetImageView, new ImageLoadingListener() {
                    @Override
                    public void onLoadingStarted(String imageUri, View view) {
                        if (v.findViewById(R.id.loading_bar) != null) {
                            v.findViewById(R.id.loading_bar).setVisibility(View.VISIBLE);
                        }
                    }

                    @Override
                    public void onLoadingFailed(String imageUri, View view, FailReason failReason) {
                        if (v.findViewById(R.id.loading_bar) != null) {
                            v.findViewById(R.id.loading_bar).setVisibility(View.INVISIBLE);
                        }
                    }

                    @Override
                    public void onLoadingComplete(String imageUri, View view, Bitmap loadedImage) {
                        if (v.findViewById(R.id.loading_bar) != null) {
                            v.findViewById(R.id.loading_bar).setVisibility(View.INVISIBLE);
                        }
                    }

                    @Override
                    public void onLoadingCancelled(String imageUri, View view) {
                        if (v.findViewById(R.id.loading_bar) != null) {
                            v.findViewById(R.id.loading_bar).setVisibility(View.INVISIBLE);
                        }
                    }
                }
        );
    }

    public BaseSliderView setScaleType(ScaleType type) {
        mScaleType = type;
        return this;
    }

    public ScaleType getScaleType() {
        return mScaleType;
    }

    /**
     * the extended class have to implement getView(), which is called by the adapter,
     * every extended class response to render their own view.
     *
     * @return
     */
    public abstract View getView();

    /**
     * set a listener to get a message , if load error.
     *
     * @param l
     */
    public void setOnImageLoadListener(ImageLoadListener l) {
        mLoadListener = l;
    }

    public interface OnSliderClickListener {
        public void onSliderClick(BaseSliderView slider);
    }

    /**
     * when you have some extra information, please put it in this bundle.
     *
     * @return
     */
    public Bundle getBundle() {
        return mBundle;
    }

    public interface ImageLoadListener {
        public void onStart(BaseSliderView target);

        public void onEnd(boolean result, BaseSliderView target);
    }

    /**
     * Get the last instance set via setPicasso(), or null if no user provided instance was set
     *
     * @return The current user-provided Picasso instance, or null if none
     */
    public Picasso getPicasso() {
        return mPicasso;
    }

    /**
     * Provide a Picasso instance to use when loading pictures, this is useful if you have a
     * particular HTTP cache you would like to share.
     *
     * @param picasso The Picasso instance to use, may be null to let the system use the default
     *                instance
     */
    public void setPicasso(Picasso picasso) {
        mPicasso = picasso;
    }

    public void initImageLoader() {
//        File cacheDir = StorageUtils.getCacheDirectory(mContext);
//        sItemUnviralImageOptions = new DisplayImageOptions.Builder().considerExifParams(true).showImageOnFail(R.drawable.ic_dif).resetViewBeforeLoading(true).showImageOnFail(R.drawable.ic_dif).showImageForEmptyUri(R.drawable.ic_dif).cacheInMemory(true).cacheOnDisc(true).imageScaleType(ImageScaleType.IN_SAMPLE_POWER_OF_2).bitmapConfig(Bitmap.Config.ARGB_8888).displayer(new FadeInBitmapDisplayer(300)).build();
//        ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(mContext).threadPoolSize(6).denyCacheImageMultipleSizesInMemory().memoryCache(new LruMemoryCache(10 * 1024 * 1024)).discCache(new UnlimitedDiscCache(cacheDir)).defaultDisplayImageOptions(sItemUnviralImageOptions).threadPriority(Thread.NORM_PRIORITY - 2).discCacheFileNameGenerator(new Md5FileNameGenerator()).build();
//        sImageLoader = ImageLoader.getInstance();
//        sImageLoader.init(config);
//        L.disableLogging();

        File cacheDir = StorageUtils.getCacheDirectory(mContext);
        sItemUnviralImageOptions = new DisplayImageOptions.Builder().considerExifParams(true).showImageOnFail(R.drawable.ic_dif).resetViewBeforeLoading(true).showImageOnFail(R.drawable.ic_dif).showImageForEmptyUri(R.drawable.ic_dif).cacheInMemory(true).cacheOnDisc(true).imageScaleType(ImageScaleType.IN_SAMPLE_POWER_OF_2).bitmapConfig(Bitmap.Config.ARGB_8888).displayer(new FadeInBitmapDisplayer(300)).build();
        ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(mContext).threadPoolSize(6).denyCacheImageMultipleSizesInMemory().memoryCache(new LruMemoryCache(10 * 1024 * 1024)).discCache(new UnlimitedDiskCache(cacheDir)).defaultDisplayImageOptions(sItemUnviralImageOptions).threadPriority(Thread.NORM_PRIORITY - 2).diskCacheFileNameGenerator(new Md5FileNameGenerator()).build();
        sImageLoader = ImageLoader.getInstance();
        sImageLoader.init(config);
        L.disableLogging();
    }
}
