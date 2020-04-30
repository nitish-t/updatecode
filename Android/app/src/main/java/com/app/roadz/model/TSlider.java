package com.app.roadz.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TSlider implements Serializable {

    @JsonProperty("image")
    private String image;

    @JsonProperty("order_number")
    private Object orderNumber;

    @JsonProperty("id")
    private int id;

    public void setImage(String image) {
        this.image = image;
    }

    public String getImage() {
        return image;
    }

    public void setOrderNumber(Object orderNumber) {
        this.orderNumber = orderNumber;
    }

    public Object getOrderNumber() {
        return orderNumber;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    @Override
    public String toString() {
        return
                "TSlider{" +
                        "image = '" + image + '\'' +
                        ",order_number = '" + orderNumber + '\'' +
                        ",id = '" + id + '\'' +
                        "}";
    }
}