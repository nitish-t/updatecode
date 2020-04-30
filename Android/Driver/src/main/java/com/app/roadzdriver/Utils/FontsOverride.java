package com.app.roadzdriver.Utils;

import android.content.Context;
import android.graphics.Typeface;
import android.os.Build;
import android.util.Log;

import com.app.roadzdriver.app.MainApplication;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;


public class FontsOverride {
    private static final int BOLD = 1;
    private static final int BOLD_ITALIC = 2;
    private static final int ITALIC = 3;
    private static final int LIGHT = 4;
    private static final int CONDENSED = 5;
    private static final int THIN = 6;
    private static final int MEDIUM = 7;
    private static final int REGULAR = 8;

    String fontName = "hkgrotesk_regular.ttf";
    private Context context;

    public FontsOverride(Context context) {
        this.context = context;
        fontName = MainApplication.ISlocaleArabic(context) ? "cairo_regular.ttf" : "hkgrotesk_regular.ttf";
    }

    public void loadFonts() {
        Map<String, Typeface> fontsMap = new HashMap<>();
        fontsMap.put("sans", getTypeface(fontName, REGULAR));
        fontsMap.put("serif", getTypeface(fontName, REGULAR));
        fontsMap.put("sans-serif", getTypeface(fontName, REGULAR));
        fontsMap.put("sans-serif-bold", getTypeface(fontName, BOLD));
        fontsMap.put("sans-serif-italic", getTypeface(fontName, ITALIC));
        fontsMap.put("sans-serif-light", getTypeface(fontName, LIGHT));
        fontsMap.put("sans-serif-condensed", getTypeface(fontName, CONDENSED));
        fontsMap.put("sans-serif-thin", getTypeface(fontName, THIN));
        fontsMap.put("sans-serif-medium", getTypeface(fontName, MEDIUM));
        fontsMap.put("sans-serif-black", getTypeface(fontName, MEDIUM));
        overrideFonts(fontsMap);
    }

    private void overrideFonts(Map<String, Typeface> typefaces) {
        if (Build.VERSION.SDK_INT >= 21) {
            try {
                final Field field = Typeface.class.getDeclaredField("sSystemFontMap");
                field.setAccessible(true);
                Map<String, Typeface> oldFonts = (Map<String, Typeface>) field.get(null);
                if (oldFonts != null) {
                    oldFonts.putAll(typefaces);
                } else {
                    oldFonts = typefaces;
                }
                field.set(null, oldFonts);
                field.setAccessible(false);
            } catch (Exception e) {
                Log.e("TypefaceUtil", "Cannot set custom fonts");
            }
        } else {
            Map<String, Typeface> kitkatAndless = new HashMap<>();
            kitkatAndless.put("DEFAULT", getTypeface(fontName, REGULAR));
            kitkatAndless.put("MONOSPACE", getTypeface(fontName, REGULAR));
            kitkatAndless.put("SERIF", getTypeface(fontName, REGULAR));
            kitkatAndless.put("SANS_SERIF", getTypeface(fontName, REGULAR));
            kitkatAndless.put("DEFAULT_BOLD", getTypeface(fontName, BOLD));
            typefaces.putAll(kitkatAndless);
            for (Map.Entry<String, Typeface> entry : typefaces.entrySet()) {
                try {

                    final Field staticField = Typeface.class.getDeclaredField(entry.getKey());
                    staticField.setAccessible(true);
                    staticField.set(null, entry.getValue());


                } catch (NoSuchFieldException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }
        }
        try {
            final Field field = Typeface.class.getDeclaredField("DEFAULT");
            field.setAccessible(true);
            field.set(null, getTypeface(fontName, REGULAR));

            final Field field2 = Typeface.class.getDeclaredField("DEFAULT_BOLD");
            field2.setAccessible(true);
            field2.set(null, getTypeface(fontName, BOLD));

            final Field field3 = Typeface.class.getDeclaredField("SANS_SERIF");
            field3.setAccessible(true);
            field3.set(null, getTypeface(fontName, REGULAR));

            final Field field4 = Typeface.class.getDeclaredField("SERIF");
            field4.setAccessible(true);
            field4.set(null, getTypeface(fontName, REGULAR));

            final Field field5 = Typeface.class.getDeclaredField("MONOSPACE");
            field5.setAccessible(true);
            field5.set(null, getTypeface(fontName, REGULAR));

            Class clazz = Typeface.class;
            Method method = clazz.getDeclaredMethod("setDefault", Typeface.class);
            method.setAccessible(true);
            Object o = method.invoke(null, getTypeface(fontName, REGULAR));

        } catch (Exception e) {
            e.printStackTrace();
        }

        //setDefault
    }

    private Typeface getTypeface(String fontFileName, int fontType) {
        final Typeface tf = Typeface.createFromAsset(context.getAssets(), "fonts/" + fontFileName);
        return Typeface.create(tf, fontType);
    }
}