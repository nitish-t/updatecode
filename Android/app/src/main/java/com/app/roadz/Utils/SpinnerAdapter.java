package com.app.roadz.Utils;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.app.roadz.R;
import com.app.roadz.app.MainApplication;

import java.util.List;

public class SpinnerAdapter extends ArrayAdapter<String> {

    Context context;
    CustomSpinner customSpinner;
    LayoutInflater inflater;
    List<String> strings;
    boolean disable = false;

    public SpinnerAdapter(Context context, List<String> strings, CustomSpinner customSpinner) {
        super(context, R.layout.spiner_text, strings);
        this.context = context;
        this.customSpinner = customSpinner;
        this.strings = strings;
        SpinnerAdapter.this.setDropDownViewResource(R.layout.spinner_text_dropdown);
        customSpinner.setAdapter(SpinnerAdapter.this);
        inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    }

    public SpinnerAdapter(Context context, List<String> strings, CustomSpinner customSpinner, boolean disable) {
        this(context, strings, customSpinner);
        this.disable = disable;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        View view = inflater.inflate(R.layout.spiner_text, parent, false);

        TextView title = view.findViewById(R.id.title);
        TextView requiredIcon = view.findViewById(R.id.requiredIcon);
        title.setTypeface(MainApplication.typeface_bold);
        title.setText(strings.get(position));
        if (position == 0) {
            title.setTextColor(Color.parseColor(disable ? "#848384" : "#333132"));
            requiredIcon.setVisibility(View.VISIBLE);
        } else {
            title.setTextColor(Color.parseColor(disable ? "#848384" : "#333132"));
            requiredIcon.setVisibility(View.GONE);
        }
        return view;
    }

    public View getDropDownView(int position, View convertView, ViewGroup parent) {
        View v = super.getDropDownView(position, convertView, parent);
        if (position == 0) {
            ((TextView) v).setBackgroundResource(R.color.white);
            ((TextView) v).setTextColor(Color.parseColor("#333132"));
        } else if (position == customSpinner.getSelectedItemPosition()) {
            ((TextView) v).setBackgroundResource(R.color.white);
            ((TextView) v).setTextColor(Color.parseColor("#009BA2"));
        } else {
            ((TextView) v).setBackgroundResource(R.color.white);
            ((TextView) v).setTextColor(Color.parseColor("#848384"));
        }
        return v;
    }
}