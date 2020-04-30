package com.app.roadz.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TCoupon implements Serializable {

    @JsonProperty("end_date")
    private String endDate;

    @JsonProperty("coupon")
    private String coupon;

    @JsonProperty("id")
    private int id;

    @JsonProperty("discount_percentage")
    private int discountPercentage;

    @JsonProperty("customer_id")
    private int customerId;

    @JsonProperty("start_date")
    private String startDate;

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setCoupon(String coupon) {
        this.coupon = coupon;
    }

    public String getCoupon() {
        return coupon;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setDiscountPercentage(int discountPercentage) {
        this.discountPercentage = discountPercentage;
    }

    public int getDiscountPercentage() {
        return discountPercentage;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getStartDate() {
        return startDate;
    }

    @Override
    public String toString() {
        return
                "TCoupon{" +
                        "end_date = '" + endDate + '\'' +
                        ",coupon = '" + coupon + '\'' +
                        ",id = '" + id + '\'' +
                        ",discount_percentage = '" + discountPercentage + '\'' +
                        ",customer_id = '" + customerId + '\'' +
                        ",start_date = '" + startDate + '\'' +
                        "}";
    }
}