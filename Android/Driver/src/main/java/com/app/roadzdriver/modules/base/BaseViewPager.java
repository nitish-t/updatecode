package com.app.roadzdriver.modules.base;

import android.content.Context;
import android.util.AttributeSet;
import android.view.MotionEvent;

import androidx.viewpager.widget.ViewPager;


public class BaseViewPager extends ViewPager {

	private boolean isPagingEnabled = true;

	public BaseViewPager(Context context, AttributeSet attrs) {
		super(context, attrs);
		this.isPagingEnabled = true;
	}

	@Override
	public boolean onTouchEvent(MotionEvent event) {
		if (this.isPagingEnabled) {
			return super.onTouchEvent(event);
		}
		return false;
	}

	@Override
	public boolean onInterceptTouchEvent(MotionEvent event) {
		if (this.isPagingEnabled) {
			try {

				return super.onInterceptTouchEvent(event);
			}catch (Exception exc){
				exc.printStackTrace();
			}
		}
		return false;
	}

	public void setPagingEnabled(boolean b) {
		this.isPagingEnabled = b;
	}
}
