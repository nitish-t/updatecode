package com.app.roadzdriver.Utils;

import android.widget.AbsListView;

import androidx.recyclerview.widget.RecyclerView;

import com.nostra13.universalimageloader.core.ImageLoader;

public  class UImagePauseOnScrollListener extends RecyclerView.OnScrollListener{

		private ImageLoader imageLoader;

		private final boolean pauseOnScroll;
		private final boolean pauseOnFling;
		private final RecyclerView.OnScrollListener externalListener;

		/**
		 * Constructor
		 *
		 * @param imageLoader   {@linkplain ImageLoader} instance for controlling
		 * @param pauseOnScroll Whether {@linkplain ImageLoader#pause() pause ImageLoader} during touch scrolling
		 * @param pauseOnFling  Whether {@linkplain ImageLoader#pause() pause ImageLoader} during fling
		 */
		public UImagePauseOnScrollListener(ImageLoader imageLoader, boolean pauseOnScroll, boolean pauseOnFling) {
			this(imageLoader, pauseOnScroll, pauseOnFling, null);
		}

		/**
		 * Constructor
		 *
		 * @param imageLoader    {@linkplain ImageLoader} instance for controlling
		 * @param pauseOnScroll  Whether {@linkplain ImageLoader#pause() pause ImageLoader} during touch scrolling
		 * @param pauseOnFling   Whether {@linkplain ImageLoader#pause() pause ImageLoader} during fling
		 * @param customListener Your custom {@link AbsListView.OnScrollListener} for {@linkplain AbsListView list view} which also
		 *                       will be get scroll events
		 */
		public UImagePauseOnScrollListener(ImageLoader imageLoader, boolean pauseOnScroll, boolean pauseOnFling,
                                           RecyclerView.OnScrollListener customListener) {
			this.imageLoader = imageLoader;
			this.pauseOnScroll = pauseOnScroll;
			this.pauseOnFling = pauseOnFling;
			externalListener = customListener;
		}

		@Override
		public void onScrollStateChanged(RecyclerView view, int scrollState) {
			switch (scrollState) {
				case AbsListView.OnScrollListener.SCROLL_STATE_IDLE:
					imageLoader.resume();
					break;
				case AbsListView.OnScrollListener.SCROLL_STATE_TOUCH_SCROLL:
					if (pauseOnScroll) {
						imageLoader.pause();
					}
					break;
				case AbsListView.OnScrollListener.SCROLL_STATE_FLING:
					if (pauseOnFling) {
						imageLoader.pause();
					}
					break;
			}
			if (externalListener != null) {
				externalListener.onScrollStateChanged(view, scrollState);
			}
		}

		@Override
		public void onScrolled(RecyclerView view, int dx, int dy) {
			if (externalListener != null) {
				externalListener.onScrolled(view, dx, dy);
			}
		}
	}