package com.app.roadzdriver.modules.Home.Menu;


import com.app.roadzdriver.R;
import com.app.roadzdriver.modules.Home.HomeActivity;
import com.app.roadzdriver.modules.PreviousRequests.PreviousRequestsActivity_;
import com.app.roadzdriver.modules.Setting.SettingActivity_;
import com.app.roadzdriver.modules.base.BaseFragment;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EFragment;


@EFragment(R.layout.fragment_meun)
public class MenuFragment extends BaseFragment {


    @AfterViews
    protected void AfterViews() {

    }


    @Click(R.id.previous_requests)
    protected void previous_requests() {
        int count = 0;
        if (getActivity() instanceof HomeActivity) {
            if (((HomeActivity) getActivity()).adapter != null)
                count = ((HomeActivity) getActivity()).adapter.getItemCount();
        }
        PreviousRequestsActivity_.intent(getActivity()).reqestCount(count).start();
    }

    @Click(R.id.settings)
    protected void settings() {
        int count = 0;
        if (getActivity() instanceof HomeActivity) {
            if (((HomeActivity) getActivity()).adapter != null)
                count = ((HomeActivity) getActivity()).adapter.getItemCount();
        }
        SettingActivity_.intent(getActivity()).reqestCount(count).start();
    }

}
