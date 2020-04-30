package com.app.roadzdriver.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TUser implements Serializable {

    @JsonProperty("access_token")
    private String accessToken;

    @JsonProperty("profile_image")
    private String profileImage;

    @JsonProperty("full_name")
    private String fullName;

    @JsonProperty("mobile")
    private String mobile;

    @JsonProperty("device_type")
    private String deviceType;

    @JsonProperty("id")
    private int id;

    @JsonProperty("email")
    private String email;

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }

    public String getProfileImage() {
        return profileImage;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getFullName() {
        return fullName;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getMobile() {
        return mobile;
    }

    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType;
    }

    public String getDeviceType() {
        return deviceType;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    @Override
    public String toString() {
        return
                "TUser{" +
                        "access_token = '" + accessToken + '\'' +
                        ",profile_image = '" + profileImage + '\'' +
                        ",full_name = '" + fullName + '\'' +
                        ",mobile = '" + mobile + '\'' +
                        ",device_type = '" + deviceType + '\'' +
                        ",id = '" + id + '\'' +
                        ",email = '" + email + '\'' +
                        "}";
    }
}