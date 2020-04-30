package com.app.roadz.Utils;

import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;

public class NumberTextWatcher implements TextWatcher {

    private static final String space = " - ";

    @Override
    public void onTextChanged(CharSequence s, int start, int before, int count) {
    }

    @Override
    public void beforeTextChanged(CharSequence s, int start, int count, int after) {
    }

    @Override
    public void afterTextChanged(Editable s) {

        // Remove spacing char
        if (s.length() > 0 && s.length() == 3) {
            final char c = s.charAt(s.length() - 1);
            if (' ' == c || '-' == c) {
                s.delete(s.length() - 1, s.length());
            }
        }

        // Insert char where needed.
        if (s.length() == 3) {
            char c = s.charAt(s.length() - 1);
            // Only if its a digit where there should be a space we insert a space
            if (c != ' ' && c != '-' && TextUtils.split(s.toString(), String.valueOf(space)).length <= 4) {
                s.insert(s.length() - 1, String.valueOf(space));
            }
        }
    }


}