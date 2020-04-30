package com.app.roadz.modules.User.SignUp;


import android.graphics.Color;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.TextPaint;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.widget.AppCompatCheckBox;

import com.app.roadz.R;
import com.app.roadz.Utils.Utils;
import com.app.roadz.app.MainApplication;
import com.app.roadz.model.TCarOption;
import com.app.roadz.modules.MyCars.AddCarActivity;
import com.app.roadz.modules.Setting.StaticDataActivity_;
import com.app.roadz.modules.base.BaseFragment;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.szagurskii.patternedtextwatcher.PatternedTextWatcher;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EFragment;
import org.androidannotations.annotations.ViewById;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import in.galaxyofandroid.spinerdialog.OnSpinerItemClick;
import in.galaxyofandroid.spinerdialog.SpinnerDialog;


@EFragment(R.layout.fragment_sign_up_page2)
public class SignUpPage2Fragment extends BaseFragment {


    private static Comparator<String> ALPHABETICAL_ORDER = new Comparator<String>() {
        public int compare(String str1, String str2) {
            int res = String.CASE_INSENSITIVE_ORDER.compare(str1, str2);
            if (res == 0) {
                res = str1.compareTo(str2);
            }
            return res;
        }
    };
    @ViewById(R.id.txtCarMaker)
    protected TextView txtCarMaker;
    @ViewById(R.id.txtCarMakerRedMark)
    protected TextView txtCarMakerRedMark;
    @ViewById(R.id.txtCarModel)
    protected TextView txtCarModel;
    @ViewById(R.id.txtCarModelRedMark)
    protected TextView txtCarModelRedMark;
    @ViewById(R.id.txtCarYear)
    protected TextView txtCarYear;
    @ViewById(R.id.txtCarYearRedMark)
    protected TextView txtCarYearRedMark;
    @ViewById(R.id.checkbox)
    protected AppCompatCheckBox checkbox;
    @ViewById(R.id.edtCarPlateNumber)
    protected EditText edtCarPlateNumber;
    @ViewById(R.id.edtCarColor)
    protected EditText edtCarColor;
    @ViewById(R.id.submitTxt)
    protected TextView submitTxt;
    @ViewById(R.id.submiticon)
    protected ImageView submiticon;
    SpinnerDialog carMakerSpinnerDialog;
    SpinnerDialog carModelSpinnerDialog;
    SpinnerDialog selectYearSpinnerDialog;
    private List<TCarOption> carMakerData;
    private ArrayList<String> carMakerList;
    private ArrayList<String> carModelList;
    private ArrayList<String> selectYearList;
    private TCarOption carMakerSelect;
    private TCarOption carModelSelect;
    private TCarOption selectYearSelect;

    @AfterViews
    protected void AfterViews() {
        try {
            carMakerData = Arrays.asList(new ObjectMapper().readValue(MainApplication.sMyPrefs.car_makers().get(), TCarOption[].class));
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (carMakerData == null) carMakerData = new ArrayList<>();


        InitCarMakerSpinner();
        InitCarModelSpinner();
        InitSelectYearSpinner();
        SetTermsAndConditionsText();

//        edtCarPlateNumber.addTextChangedListener(new NumberTextWatcher());
        edtCarPlateNumber.addTextChangedListener(new PatternedTextWatcher("## - ###############################################################"));
        if (getActivity() instanceof SignUpActivity) {
            submitTxt.setText(R.string.next);
            submiticon.setVisibility(View.VISIBLE);
        } else if (getActivity() instanceof AddCarActivity) {
            submitTxt.setText(R.string.add);
            submiticon.setVisibility(View.GONE);
        }

    }

    private void InitCarMakerSpinner() {

        carMakerList = new ArrayList<>();
        for (TCarOption tCarOption : carMakerData) {
            carMakerList.add(tCarOption.getTitle());
        }
        carMakerSelect = null;
        txtCarMaker.setText(getString(R.string.car_maker));
        txtCarMakerRedMark.setVisibility(View.VISIBLE);
        txtCarMaker.setTextColor(Color.parseColor("#848384"));
        Collections.sort(carMakerList, ALPHABETICAL_ORDER);
        carMakerSpinnerDialog = new SpinnerDialog(getActivity(), carMakerList, getString(R.string.car_maker), R.style.DialogAnimations_SmileWindow, getString(R.string.cancel2));// With 	Animation
        carMakerSpinnerDialog.setCancellable(false); // for cancellable
        carMakerSpinnerDialog.setShowKeyboard(false);
        carMakerSpinnerDialog.bindOnSpinerListener(new OnSpinerItemClick() {
            @Override
            public void onClick(String item, int position) {
                for (int i = 0; i < carMakerData.size(); i++) {
                    if (item.equals(carMakerData.get(i).getTitle())) {
                        carMakerSelect = carMakerData.get(i);
                        txtCarMaker.setText(item);
                        txtCarMakerRedMark.setVisibility(View.GONE);
                        txtCarMaker.setTextColor(Color.parseColor("#333132"));
                        InitCarModelSpinner();
                    }
                }
            }
        });

    }

    private void InitCarModelSpinner() {

        carModelList = new ArrayList<>();
        List<TCarOption> tCarOptions = new ArrayList<>();
        tCarOptions.add(carMakerSelect);

        if (carMakerSelect != null && carMakerSelect.getCar_models() != null) {
            for (TCarOption tCarOption : carMakerSelect.getCar_models()) {
                carModelList.add(tCarOption.getTitle());
            }
        }

        carModelSelect = null;
        txtCarModel.setText(getString(R.string.car_model));
        txtCarModelRedMark.setVisibility(View.VISIBLE);
        txtCarModel.setTextColor(Color.parseColor("#848384"));
//        Collections.sort(carModelList, String.CASE_INSENSITIVE_ORDER);
        Collections.sort(carModelList, ALPHABETICAL_ORDER);
        carModelSpinnerDialog = new SpinnerDialog(getActivity(), carModelList, getString(R.string.car_model), R.style.DialogAnimations_SmileWindow, getString(R.string.cancel2));// With 	Animation
        carModelSpinnerDialog.setCancellable(false); // for cancellable
        carModelSpinnerDialog.setShowKeyboard(false);
        carModelSpinnerDialog.bindOnSpinerListener(new OnSpinerItemClick() {
            @Override
            public void onClick(String item, int position) {

                for (int i = 0; i < carMakerSelect.getCar_models().size(); i++) {
                    if (item.equals(carMakerSelect.getCar_models().get(i).getTitle())) {
                        carModelSelect = carMakerSelect.getCar_models().get(i);
                        txtCarModel.setText(item);
                        txtCarModelRedMark.setVisibility(View.GONE);
                        txtCarModel.setTextColor(Color.parseColor("#333132"));
                    }
                }


                InitSelectYearSpinner();
            }
        });


    }

    private void InitSelectYearSpinner() {
        selectYearList = new ArrayList<>();
        if (carModelSelect != null && carModelSelect.getCar_years() != null) {
            for (TCarOption tCarOption : carModelSelect.getCar_years()) {
                selectYearList.add(tCarOption.getTitle());
            }
        }
        selectYearSelect = null;
        txtCarYear.setText(getString(R.string.select_year));
        txtCarYearRedMark.setVisibility(View.VISIBLE);
        txtCarYear.setTextColor(Color.parseColor("#848384"));

        selectYearSpinnerDialog = new SpinnerDialog(getActivity(), selectYearList, getString(R.string.select_service), R.style.DialogAnimations_SmileWindow, getString(R.string.cancel2));// With 	Animation
        selectYearSpinnerDialog.setCancellable(false); // for cancellable
        selectYearSpinnerDialog.setShowKeyboard(false);
        selectYearSpinnerDialog.bindOnSpinerListener(new OnSpinerItemClick() {
            @Override
            public void onClick(String item, int position) {

                selectYearSelect = carModelSelect.getCar_years().get(position);
                txtCarYear.setText(item);
                txtCarYearRedMark.setVisibility(View.GONE);
                txtCarYear.setTextColor(Color.parseColor("#333132"));
            }
        });
    }

    //    private void InitCarMakerSpinner() {
//        carMakerList = new ArrayList<>();
//        carMakerList.add(getString(R.string.car_maker));
//        for (TCarOption tCarOption : carMakerData) {
//            carMakerList.add(tCarOption.getTitle());
//        }
//
//        SpinnerAdapter customSpinnerAdapter = new SpinnerAdapter(getActivity(), carMakerList, carMakerSpinner);
//        carMakerSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
//            @Override
//            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
//                if (position == 0) {
//                    carMakerSelect = null;
//                } else {
//                    carMakerSelect = carMakerData.get(position - 1);
//                }
//                InitCarModelSpinner();
//            }
//
//            @Override
//            public void onNothingSelected(AdapterView<?> parent) {
//            }
//        });
//
//    }
//
//    private void InitCarModelSpinner() {
//        carModelList = new ArrayList<>();
//        carModelList.add(getString(R.string.car_model));
//        if (carMakerSelect != null && carMakerSelect.getCar_models() != null) {
//            for (TCarOption tCarOption : carMakerSelect.getCar_models()) {
//                carModelList.add(tCarOption.getTitle());
//            }
//        }
//        SpinnerAdapter customSpinnerAdapter = new SpinnerAdapter(getActivity(), carModelList, carModelSpinner, carMakerSelect == null);
//        carModelSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
//            @Override
//            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
//                if (position == 0) {
//                    carModelSelect = null;
//                } else {
//                    carModelSelect = carMakerSelect.getCar_models().get(position - 1);
//                }
//                InitSelectYearSpinner();
//            }
//
//            @Override
//            public void onNothingSelected(AdapterView<?> parent) {
//            }
//        });
//
//    }
//
//    private void InitSelectYearSpinner() {
//        selectYearList = new ArrayList<>();
//        selectYearList.add(getString(R.string.select_year));
//        if (carModelSelect != null && carModelSelect.getCar_years() != null) {
//            for (TCarOption tCarOption : carModelSelect.getCar_years()) {
//                selectYearList.add(tCarOption.getTitle());
//            }
//        }
//        SpinnerAdapter customSpinnerAdapter = new SpinnerAdapter(getActivity(), selectYearList, selectYearSpinner, carModelSelect == null);
//        selectYearSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
//            @Override
//            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
//                if (position == 0) {
//                    selectYearSelect = null;
//                } else {
//                    selectYearSelect = carModelSelect.getCar_years().get(position - 1);
//                }
//            }
//
//            @Override
//            public void onNothingSelected(AdapterView<?> parent) {
//            }
//        });
//
//    }
    private void SetTermsAndConditionsText() {
        if (getContext() instanceof AddCarActivity) {
            checkbox.setVisibility(View.GONE);
            return;
        }

        String termsAndConditions = getResources().getString(R.string.agree_terms_conditions);
        int startPos = MainApplication.ISlocaleArabic(getActivity()) ? 10 : 14;
        int endPos = termsAndConditions.length();

        SpannableString spannableString = new SpannableString(termsAndConditions);

        ClickableSpan clickableSpan = new ClickableSpan() {
            @Override
            public void onClick(@NonNull View view) {
                StaticDataActivity_.intent(SignUpPage2Fragment.this).Type(2).start();
            }

            @Override
            public void updateDrawState(@NonNull TextPaint ds) {
                super.updateDrawState(ds);

                ds.setColor(Color.parseColor("#333132"));
                ds.setUnderlineText(true);
            }
        };

        spannableString.setSpan(clickableSpan, startPos, endPos, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);


        checkbox.setText(spannableString);
        checkbox.setMovementMethod(LinkMovementMethod.getInstance());
        checkbox.setTypeface(MainApplication.typeface_bold);
    }

    @Click(R.id.submitBtn)
    protected void submitBtn() {
        if (carMakerSelect == null) {
            MainApplication.Toast(getString(R.string.You_must_choose) + " " + getString(R.string.car_maker));
            return;
        }
        if (carModelSelect == null) {
            MainApplication.Toast(getString(R.string.You_must_choose) + " " + getString(R.string.car_model));
            return;
        }
        if (selectYearSelect == null) {
            MainApplication.Toast(getString(R.string.You_must_choose) + " " + getString(R.string.car_years));
            return;
        }

//        if (!Utils.Valed(getActivity(), edtCarPlateNumber, null, Utils.Type.general)) {
//            return;
//        }

        if (!Utils.Valed(getActivity(), edtCarColor, null, Utils.Type.general)) {
            return;
        }

        if (getActivity() instanceof SignUpActivity)
            if (!checkbox.isChecked()) {
                MainApplication.Toast(getString(R.string.tc_approved_msg));
                return;
            }


        Map<String, String> map = new HashMap<>();
        map.put("car_maker_id", carMakerSelect.getId() + "");
        map.put("car_model_id", carModelSelect.getId() + "");
        map.put("car_year_id", selectYearSelect.getId() + "");
        map.put("plate_number", edtCarPlateNumber.getText().toString());
        map.put("color", edtCarColor.getText().toString());

        if (getActivity() instanceof SignUpActivity) {
            ((SignUpActivity) getActivity()).SendAction(map);
        } else if (getActivity() instanceof AddCarActivity) {
            ((AddCarActivity) getActivity()).SendAction(map);
        }
    }


    @Click(R.id.carMakerLayout)
    protected void carMakerLayout() {

        carMakerSpinnerDialog.showSpinerDialog();
    }

    @Click(R.id.carModelLayout)
    protected void carModelLayout() {
        if (carMakerSelect == null) {
            MainApplication.Toast(getString(R.string.You_must_choose) + " " + getString(R.string.car_maker));
            return;
        }
        carModelSpinnerDialog.showSpinerDialog();
    }

    @Click(R.id.carYearLayout)
    protected void carYearLayout() {
        if (carModelSelect == null) {
            MainApplication.Toast(getString(R.string.You_must_choose) + " " + getString(R.string.car_model));
            return;
        }

        selectYearSpinnerDialog.showSpinerDialog();
    }
}
