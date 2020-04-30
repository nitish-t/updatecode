package com.app.roadzdriver.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TSubscription implements Serializable {

    @JsonProperty("coupon_discount_percentage")
    private int couponDiscountPercentage;

    @JsonProperty("package")
    private TPackage tpackage;

    @JsonProperty("coupon")
    private String coupon;

    @JsonProperty("ref_id")
    private String ref_id;

    @JsonProperty("car")
    private TCar car;

    @JsonProperty("price")
    private double price;

    @JsonProperty("final_total")
    private double finalTotal;

    @JsonProperty("id")
    private int id;

    @JsonProperty("package_id")
    private int packageId;

    @JsonProperty("subscription_start")
    private String subscriptionStart;

    @JsonProperty("customer_id")
    private int customerId;

    @JsonProperty("car_id")
    private int carId;

    @JsonProperty("subscription_end")
    private String subscriptionEnd;

    public String getRef_id() {
        return ref_id;
    }

    public void setRef_id(String ref_id) {
        this.ref_id = ref_id;
    }

    public void setCouponDiscountPercentage(int couponDiscountPercentage) {
        this.couponDiscountPercentage = couponDiscountPercentage;
    }

    public int getCouponDiscountPercentage() {
        return couponDiscountPercentage;
    }


    public void setCoupon(String coupon) {
        this.coupon = coupon;
    }

    public String getCoupon() {
        return coupon;
    }

    public TPackage getTpackage() {
        return tpackage;
    }

    public void setTpackage(TPackage tpackage) {
        this.tpackage = tpackage;
    }

    public TCar getCar() {
        return car;
    }

    public void setCar(TCar car) {
        this.car = car;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getPrice() {
        return price;
    }

    public void setFinalTotal(double finalTotal) {
        this.finalTotal = finalTotal;
    }

    public double getFinalTotal() {
        return finalTotal;
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

    public void setSubscriptionStart(String subscriptionStart) {
        this.subscriptionStart = subscriptionStart;
    }

    public String getSubscriptionStart() {
        return subscriptionStart;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public int getCarId() {
        return carId;
    }

    public void setSubscriptionEnd(String subscriptionEnd) {
        this.subscriptionEnd = subscriptionEnd;
    }

    public String getSubscriptionEnd() {
        return subscriptionEnd;
    }

    @Override
    public String toString() {
        return
                "TSubscription{" +
                        "coupon_discount_percentage = '" + couponDiscountPercentage + '\'' +
                        ",coupon = '" + coupon + '\'' +
                        ",car = '" + car + '\'' +
                        ",ref_id = '" + ref_id + '\'' +
                        ",price = '" + price + '\'' +
                        ",final_total = '" + finalTotal + '\'' +
                        ",id = '" + id + '\'' +
                        ",package_id = '" + packageId + '\'' +
                        ",subscription_start = '" + subscriptionStart + '\'' +
                        ",customer_id = '" + customerId + '\'' +
                        ",car_id = '" + carId + '\'' +
                        ",subscription_end = '" + subscriptionEnd + '\'' +
                        "}";
    }
}