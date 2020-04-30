package com.app.roadz.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TConfig implements Serializable {

    @JsonProperty("service_maintenance")
    private String serviceMaintenance;

    @JsonProperty("address")
    private String address;

    @JsonProperty("facebook")
    private String facebook;

    @JsonProperty("latitude")
    private float latitude;

    @JsonProperty("skip_ads_timer")
    private int skipAdsTimer;

    @JsonProperty("mobile")
    private String mobile;

    @JsonProperty("youtube_maintenance")
    private String youtubeMaintenance;

    @JsonProperty("privacy")
    private String privacy;

    @JsonProperty("instagram")
    private String instagram;

    @JsonProperty("linkedin")
    private String linkedin;

    @JsonProperty("title")
    private String title;

    @JsonProperty("twitter")
    private String twitter;

    @JsonProperty("youtube_emergency")
    private String youtubeEmergency;

    @JsonProperty("about_us")
    private String aboutUs;

    @JsonProperty("terms")
    private String terms;

    @JsonProperty("service_emergency")
    private String serviceEmergency;

    @JsonProperty("logo")
    private String logo;

    @JsonProperty("info_email")
    private String infoEmail;

    @JsonProperty("service_emergency_guest")
    private String service_emergency_guest;

   @JsonProperty("emergancy_phone")
    private String emergancy_phone;

    @JsonProperty("id")
    private int id;

    @JsonProperty("longitude")
    private float longitude;

    public void setServiceMaintenance(String serviceMaintenance) {
        this.serviceMaintenance = serviceMaintenance;
    }

    public String getServiceMaintenance() {
        return serviceMaintenance;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddress() {
        return address;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public float getLatitude() {
        return latitude;
    }

    public void setSkipAdsTimer(int skipAdsTimer) {
        this.skipAdsTimer = skipAdsTimer;
    }

    public int getSkipAdsTimer() {
        return skipAdsTimer;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getMobile() {
        return mobile;
    }

    public void setYoutubeMaintenance(String youtubeMaintenance) {
        this.youtubeMaintenance = youtubeMaintenance;
    }

    public String getYoutubeMaintenance() {
        return youtubeMaintenance;
    }

    public void setPrivacy(String privacy) {
        this.privacy = privacy;
    }

    public String getPrivacy() {
        return privacy;
    }

    public void setInstagram(String instagram) {
        this.instagram = instagram;
    }

    public String getInstagram() {
        return instagram;
    }

    public void setLinkedin(String linkedin) {
        this.linkedin = linkedin;
    }

    public String getLinkedin() {
        return linkedin;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setTwitter(String twitter) {
        this.twitter = twitter;
    }

    public String getTwitter() {
        return twitter;
    }

    public void setYoutubeEmergency(String youtubeEmergency) {
        this.youtubeEmergency = youtubeEmergency;
    }

    public String getYoutubeEmergency() {
        return youtubeEmergency;
    }

    public void setAboutUs(String aboutUs) {
        this.aboutUs = aboutUs;
    }

    public String getAboutUs() {
        return aboutUs;
    }

    public void setTerms(String terms) {
        this.terms = terms;
    }

    public String getTerms() {
        return terms;
    }

    public void setServiceEmergency(String serviceEmergency) {
        this.serviceEmergency = serviceEmergency;
    }

    public String getServiceEmergency() {
        return serviceEmergency;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getLogo() {
        return logo;
    }

    public void setInfoEmail(String infoEmail) {
        this.infoEmail = infoEmail;
    }

    public String getInfoEmail() {
        return infoEmail;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public float getLongitude() {
        return longitude;
    }

    public String getService_emergency_guest() {
        return service_emergency_guest;
    }

    public void setService_emergency_guest(String service_emergency_guest) {
        this.service_emergency_guest = service_emergency_guest;
    }

    public String getEmergancy_phone() {
        return emergancy_phone;
    }

    public void setEmergancy_phone(String emergancy_phone) {
        this.emergancy_phone = emergancy_phone;
    }

    @Override
    public String toString() {
        return
                "TConfig{" +
                        "service_maintenance = '" + serviceMaintenance + '\'' +
                        ",address = '" + address + '\'' +
                        ",facebook = '" + facebook + '\'' +
                        ",latitude = '" + latitude + '\'' +
                        ",skip_ads_timer = '" + skipAdsTimer + '\'' +
                        ",mobile = '" + mobile + '\'' +
                        ",youtube_maintenance = '" + youtubeMaintenance + '\'' +
                        ",privacy = '" + privacy + '\'' +
                        ",instagram = '" + instagram + '\'' +
                        ",linkedin = '" + linkedin + '\'' +
                        ",title = '" + title + '\'' +
                        ",twitter = '" + twitter + '\'' +
                        ",youtube_emergency = '" + youtubeEmergency + '\'' +
                        ",about_us = '" + aboutUs + '\'' +
                        ",terms = '" + terms + '\'' +
                        ",service_emergency = '" + serviceEmergency + '\'' +
                        ",logo = '" + logo + '\'' +
                        ",info_email = '" + infoEmail + '\'' +
                        ",id = '" + id + '\'' +
                        ",longitude = '" + longitude + '\'' +
                        "}";
    }
}