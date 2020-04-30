package com.app.roadzdriver.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TOrder implements Serializable {

    @JsonProperty("subscriber_id")
    private int subscriberId;
    @JsonProperty("address")
    private String address;

    @JsonProperty("service")
    private TService service;

    @JsonProperty("service_id")
    private int serviceId;

    @JsonProperty("latitude")
    private double latitude;

    @JsonProperty("id")
    private int id;

    @JsonProperty("subscription")
    private TSubscription subscription;

    @JsonProperty("vendor")
    private TVendor vendor;

    @JsonProperty("customer_id")
    private int customerId;

    @JsonProperty("created_at")
    private String created_at;
    @JsonProperty("end_time")
    private String end_time;

    @JsonProperty("longitude")
    private double longitude;

    @JsonProperty("status")
    private String status;
    @JsonProperty("customer")
    private TUser customer;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public int getSubscriberId() {
        return subscriberId;
    }

    public void setSubscriberId(int subscriberId) {
        this.subscriberId = subscriberId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public TService getService() {
        return service;
    }

    public void setService(TService service) {
        this.service = service;
    }

    public TSubscription getSubscription() {
        return subscription;
    }

    public void setSubscription(TSubscription subscription) {
        this.subscription = subscription;
    }

    public TVendor getVendor() {
        return vendor;
    }

    public void setVendor(TVendor vendor) {
        this.vendor = vendor;
    }

    public TUser getCustomer() {
        return customer;
    }

    public void setCustomer(TUser customer) {
        this.customer = customer;
    }

    @Override
    public String toString() {
        return
                "TOrder{" +
                        "address = '" + address + '\'' +
                        "subscriber_id = '" + subscriberId + '\'' +
                        ",service = '" + service + '\'' +
                        ",service_id = '" + serviceId + '\'' +
                        ",latitude = '" + latitude + '\'' +
                        ",id = '" + id + '\'' +
                        ",subscription = '" + subscription + '\'' +
                        ",vendor = '" + vendor + '\'' +
                        ",customer_id = '" + customerId + '\'' +
                        ",created_at = '" + created_at + '\'' +
                        ",end_time = '" + created_at + '\'' +
                        ",longitude = '" + longitude + '\'' +
                        ",status = '" + status + '\'' +
                        ",customer = '" + customer + '\'' +
                        "}";
    }
}