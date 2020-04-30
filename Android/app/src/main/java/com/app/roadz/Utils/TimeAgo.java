package com.app.roadz.Utils;

import android.content.Context;
import android.content.res.Resources;

import com.app.roadz.R;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeAgo {

    protected Context context;

    public TimeAgo(Context context){
        this.context = context;
    }

    public String timeAgo(Date date, int afterDayToReturnDate, String pattern){
        if(date==null)return "";
        return timeAgo(date.getTime(), afterDayToReturnDate, pattern);
    }

    public String timeAgo(long millis, int dayToBegin, String pattern){
        long diff = new Date().getTime() - millis;

        Resources r = context.getResources();

        String prefix = r.getString(R.string.time_ago_prefix);
        String suffix = r.getString(R.string.time_ago_suffix);

        double seconds = Math.abs(diff) / 1000;
        double minutes = seconds / 60;
        double hours = minutes / 60;
        double days = hours / 24;
        double week = days / 7;
        double months = days / 30;
        double years = months / 12;

        String textTime = "";

        if(pattern != null && days > dayToBegin){
            return new SimpleDateFormat(pattern).format(new Date(millis));
        }

        if(((int)years)>0){
            textTime=r.getQuantityString(R.plurals.time_ago_year, (int) years, (int) years);
        }else   if(((int)months)>0){
            textTime=r.getQuantityString(R.plurals.time_ago_month, (int) months, (int) months);
        }else  if(((int)week)>0){
            textTime=r.getQuantityString(R.plurals.time_ago_week, (int) week, (int) week);
        }else if(((int)days)>0){
            textTime=r.getQuantityString(R.plurals.time_ago_days, (int) days, (int) days);
        }else if(((int)hours)>0){
            textTime=r.getQuantityString(R.plurals.time_ago_hours, (int) hours, (int) hours);
        }else if(((int)minutes)>0){
            textTime=r.getQuantityString(R.plurals.time_ago_minutes, (int) minutes, (int) minutes);
        }else if(((int)seconds)>=0){
            textTime=r.getQuantityString(R.plurals.time_ago_seconds, (int) seconds, (int) seconds);
        }else{
            textTime=context.getString(R.string.seconds);
        }


        StringBuilder sb = new StringBuilder();


        if(suffix != null && suffix.length() > 0){
            sb.append(suffix);
        }

        sb.append(" ").append(textTime);

        if(prefix != null && prefix.length() > 0){
            sb.append(" "+prefix+" ").append(" ");
        }


        return sb.toString();
    }
}
