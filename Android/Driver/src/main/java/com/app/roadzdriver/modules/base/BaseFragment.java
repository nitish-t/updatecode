package com.app.roadzdriver.modules.base;

import android.app.Activity;
import android.app.ProgressDialog;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.EFragment;


@EFragment
public class BaseFragment extends Fragment {

//    @ViewById(R.id.status_bar)
//    protected View status_bar;

    protected BaseActivity mActivity;
    private ProgressDialog mProgressDialog;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mProgressDialog = new ProgressDialog(getActivity());
        preAfterViews();
    }

    @AfterViews
    protected void onAfterViewsAnnotation() {

//        if (status_bar != null && getActivity() instanceof BaseActivity)
//            status_bar.getLayoutParams().height = ((BaseActivity) getActivity()).getStatusBarHeight();

        onAfterViews();
        postAfterViews();
    }

    protected void preAfterViews() {
    }

    protected void onAfterViews() {
    }

    protected void postAfterViews() {
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        if (activity instanceof BaseActivity) {
            mActivity = (BaseActivity) activity;
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mActivity = null;
    }


    protected void hideProgress() {
        if (mProgressDialog.isShowing()) mProgressDialog.dismiss();
    }

    public AppCompatActivity getBaseActivity() {
        return (AppCompatActivity) super.getActivity();
    }

}
