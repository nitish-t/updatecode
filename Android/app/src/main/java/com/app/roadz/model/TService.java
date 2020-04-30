package com.app.roadz.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TService implements Serializable {

    @JsonProperty("image")
    private String image;

    @JsonProperty("id")
    private int id;

    @JsonProperty("package_id")
    private int packageId;

    @JsonProperty("title")
    private String title;

    @JsonIgnore
    private String details;

    @JsonIgnore
    private int icon;

    @JsonIgnore
    private boolean demo;

    public void setImage(String image) {
        this.image = image;
    }

    public String getImage() {
        return image;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public int getPackageId() {
        return packageId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public int getIcon() {
        return icon;
    }

    public void setIcon(int icon) {
        this.icon = icon;
    }

    public boolean isDemo() {
        return demo;
    }

    public void setDemo(boolean demo) {
        this.demo = demo;
    }

    @Override
    public String toString() {
        return
                "TService{" +
                        "image = '" + image + '\'' +
                        ",id = '" + id + '\'' +
                        ",package_id = '" + packageId + '\'' +
                        ",title = '" + title + '\'' +
                        "}";
    }
}