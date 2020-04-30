package com.app.roadz.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;
import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class THomeData implements Serializable {

    @JsonProperty("not_read_notification_count")
    private int not_read_notification_count;

   @JsonProperty("sliders")
    private List<TSlider> sliders;

    @JsonProperty("ads")
    private List<TSlider> ads;

    @JsonProperty("car_makers")
    private List<TCarOption> car_makers;

    @JsonProperty("setting")
    private TConfig setting;

    public List<TSlider> getSliders() {
        return sliders;
    }

    public void setSliders(List<TSlider> sliders) {
        this.sliders = sliders;
    }

    public List<TSlider> getAds() {
        return ads;
    }

    public void setAds(List<TSlider> ads) {
        this.ads = ads;
    }

    public List<TCarOption> getCar_makers() {
        return car_makers;
    }

    public void setCar_makers(List<TCarOption> car_makers) {
        this.car_makers = car_makers;
    }

    public TConfig getSetting() {
        return setting;
    }

    public void setSetting(TConfig setting) {
        this.setting = setting;
    }

    public int getNot_read_notification_count() {
        return not_read_notification_count;
    }

    public void setNot_read_notification_count(int not_read_notification_count) {
        this.not_read_notification_count = not_read_notification_count;
    }
}