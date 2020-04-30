package com.app.roadz.modules.User.SignUp;


import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.app.MainApplication;
import com.app.roadz.modules.base.BaseFragment;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EFragment;
import org.androidannotations.annotations.ViewById;

import java.util.HashMap;
import java.util.Map;


@EFragment(R.layout.fragment_sign_up_page1)
public class SignUpPage1Fragment extends BaseFragment {

    @ViewById(R.id.edtFullName)
    protected EditText edtFullName;

    @ViewById(R.id.edtEmail)
    protected EditText edtEmail;

    @ViewById(R.id.edtPassword)
    protected EditText edtPassword;

    @ViewById(R.id.edtConfirmPassword)
    protected EditText edtConfirmPassword;

    @ViewById(R.id.edtMobileNumber)
    protected EditText edtMobileNumber;

    @ViewById(R.id.edtFullNameValidation)
    protected ImageView edtFullNameValidation;

    @ViewById(R.id.edtEmailValidation)
    protected ImageView edtEmailValidation;

    @ViewById(R.id.edtPasswordValidation)
    protected ImageView edtPasswordValidation;

    @ViewById(R.id.edtConfirmPasswordValidation)
    protected ImageView edtConfirmPasswordValidation;

    @ViewById(R.id.edtMobileNumberValidation)
    protected ImageView edtMobileNumberValidation;

    @AfterViews
    protected void AfterViews() {


    }

    @Click(R.id.nextBtn)
    protected void nextBtn() {
        HideShowValidationError(true);
        if (!Utils.Valed(getActivity(), edtFullName, null, Utils.Type.general)) {
            return;
        }

        if (!Utils.Valed(getActivity(), edtEmail, null, Utils.Type.email)) {

            return;
        }

        if (!Utils.Valed(getActivity(), edtPassword, null, Utils.Type.pass)) {

            return;
        }

        if (!Utils.Valed(getActivity(), edtConfirmPassword, edtPassword, Utils.Type.confirm_pass)) {

            return;
        }

        if (!Utils.Valed(getActivity(), edtMobileNumber, null, Utils.Type.phone)) {
            return;
        }

        Map<String, String> map = new HashMap<>();
        map.put("full_name", edtFullName.getText().toString());
        map.put("mobile", edtMobileNumber.getText().toString());
        map.put("email", edtEmail.getText().toString());
        map.put("password", edtPassword.getText().toString());
        map.put("device_type", "android");

        if (getActivity() instanceof SignUpActivity) {
            ((SignUpActivity) getActivity()).next_btn(map);
        }
    }

    public void ShowValidationError(HashMap<String, String> error) {
        if (error == null) return;
        if (error.containsKey("full_name")) {
            edtFullNameValidation.setImageResource(R.drawable.ic_validation_fails);
        } else {
            edtFullNameValidation.setImageResource(R.drawable.ic_validation_success);
        }
        if (error.containsKey("mobile")) {
            if (MainApplication.getLang(getActivity()).equals("ar")){
                MainApplication.Toast("رقم الجوال مستخدم مسبقا");
            }else{
                MainApplication.Toast("The mobile number is already exist");
            }
            edtMobileNumberValidation.setImageResource(R.drawable.ic_validation_fails);
        } else {
            edtMobileNumberValidation.setImageResource(R.drawable.ic_validation_success);
        }
        if (error.containsKey("email")) {
            if (MainApplication.getLang(getActivity()).equals("ar")){
                MainApplication.Toast("البريد الالكتروني مستخدم مسبقا");
            }else{
                MainApplication.Toast("The Email is already exist.");
            }
            edtEmailValidation.setImageResource(R.drawable.ic_validation_fails);
        } else {
            edtEmailValidation.setImageResource(R.drawable.ic_validation_success);
        }
        if (error.containsKey("password")) {
            edtPasswordValidation.setImageResource(R.drawable.ic_validation_fails);
            edtConfirmPasswordValidation.setImageResource(R.drawable.ic_validation_fails);
        } else {
            edtPasswordValidation.setImageResource(R.drawable.ic_validation_success);
            edtConfirmPasswordValidation.setImageResource(R.drawable.ic_validation_success);
        }

        HideShowValidationError(false);

        String msg = null;
        for (Map.Entry<String, String> entry : error.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();

            if (TextUtils.isEmpty(msg)) {
                msg = value;
            } else {
                msg = msg + System.getProperty("line.separator") + value;
            }
        }
        if (!TextUtils.isEmpty(msg)) {
//            MainApplication.Toast(msg);
        }


    }

    public void HideShowValidationError(boolean hide) {
        edtFullNameValidation.setVisibility(hide ? View.GONE : View.VISIBLE);
        edtEmailValidation.setVisibility(hide ? View.GONE : View.VISIBLE);
        edtPasswordValidation.setVisibility(hide ? View.GONE : View.VISIBLE);
        edtConfirmPasswordValidation.setVisibility(hide ? View.GONE : View.VISIBLE);
        edtMobileNumberValidation.setVisibility(hide ? View.GONE : View.VISIBLE);
    }
}
