package com.daimajia.slider.library.SliderTypes;

import android.content.Context;
import android.graphics.Typeface;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.daimajia.slider.library.R;

/**
 * This is a slider with a description TextView.
 */
public class TextSliderView extends BaseSliderView {

    Context sContext;
    Typeface tf = null;

    public TextSliderView(Context context) {
        super(context);
        sContext = context;
    }

    @Override
    public View getView() {
        View v = LayoutInflater.from(getContext()).inflate(R.layout.render_type_text, null);
        LinearLayout description_layout = (LinearLayout) v.findViewById(R.id.description_layout);
        RelativeLayout main_image_layout = (RelativeLayout) v.findViewById(R.id.main_image_layout);
        ImageView target = (ImageView) v.findViewById(R.id.daimajia_slider_image);
        ImageView bg_image = (ImageView) v.findViewById(R.id.bg_image);
        ImageView bg_video = (ImageView) v.findViewById(R.id.bg_video);
        TextView title = (TextView) v.findViewById(R.id.title);
        TextView sup_title = (TextView) v.findViewById(R.id.sup_title);
        TextView prise = (TextView) v.findViewById(R.id.prise);


        RelativeLayout.LayoutParams relativeParams = (RelativeLayout.LayoutParams) main_image_layout.getLayoutParams();
        if (ISShowTitle()) {
            description_layout.setVisibility(View.VISIBLE);
            relativeParams.setMargins(convertDpToPixels(35, getContext()), 0, convertDpToPixels(35, getContext()), 0);  // left, top, right, bottom
            title.setText(getTitle());
            sup_title.setText(getSubTitle());
            prise.setText(getPrise());
        } else {
            relativeParams.setMargins(0, 0, 0, 0);  // left, top, right, bottom
            description_layout.setVisibility(View.GONE);
        }

        bg_video.setVisibility(ISShowVideo() ? View.VISIBLE : View.GONE);

        main_image_layout.setLayoutParams(relativeParams);

        bindEventAndShow(v, target);
        bindEventAndShowSub(v, bg_image);
        return v;
    }

    public static int convertDpToPixels(float dp, Context context) {
        int px = (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, dp, context.getResources().getDisplayMetrics());
        return px;
    }
}
