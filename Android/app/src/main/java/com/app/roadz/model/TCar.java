package com.app.roadz.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TCar implements Serializable {

    @JsonProperty("car_maker")
    private TCarOption carMaker;

    @JsonProperty("car_model")
    private TCarOption carModel;

    @JsonProperty("car_model_id")
    private int carModelId;

    @JsonProperty("color")
    private String color;

    @JsonProperty("car_year")
    private TCarOption carYear;

    @JsonProperty("car_year_id")
    private int carYearId;

    @JsonProperty("car_maker_id")
    private int carMakerId;

    @JsonProperty("id")
    private int id;

    @JsonProperty("plate_number")
    private String plateNumber;

    @JsonProperty("customer_id")
    private int customerId;

    @JsonProperty("has_open_request")
    private boolean has_open_request;

    @JsonProperty("demo")
    private boolean demo;

   @JsonProperty("subscription")
    private TSubscription subscription;

    public void setCarMaker(TCarOption carMaker) {
        this.carMaker = carMaker;
    }

    public TCarOption getCarMaker() {
        return carMaker;
    }

    public void setCarModel(TCarOption carModel) {
        this.carModel = carModel;
    }

    public TCarOption getCarModel() {
        return carModel;
    }

    public void setCarModelId(int carModelId) {
        this.carModelId = carModelId;
    }

    public int getCarModelId() {
        return carModelId;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getColor() {
        return color;
    }

    public void setCarYear(TCarOption carYear) {
        this.carYear = carYear;
    }

    public TCarOption getCarYear() {
        return carYear;
    }

    public void setCarYearId(int carYearId) {
        this.carYearId = carYearId;
    }

    public int getCarYearId() {
        return carYearId;
    }

    public void setCarMakerId(int carMakerId) {
        this.carMakerId = carMakerId;
    }

    public int getCarMakerId() {
        return carMakerId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public boolean isHas_open_request() {
        return has_open_request;
    }

    public void setHas_open_request(boolean has_open_request) {
        this.has_open_request = has_open_request;
    }

    public TSubscription getSubscription() {
        return subscription;
    }

    public void setSubscription(TSubscription subscription) {
        this.subscription = subscription;
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
                "TCar{" +
                        "car_maker = '" + carMaker + '\'' +
                        ",car_model = '" + carModel + '\'' +
                        ",car_model_id = '" + carModelId + '\'' +
                        ",color = '" + color + '\'' +
                        ",car_year = '" + carYear + '\'' +
                        ",car_year_id = '" + carYearId + '\'' +
                        ",car_maker_id = '" + carMakerId + '\'' +
                        ",id = '" + id + '\'' +
                        ",plate_number = '" + plateNumber + '\'' +
                        ",customer_id = '" + customerId + '\'' +
                        "}";
    }

    public String getCarName() {
        String Name = "";
        if (getCarMaker() != null)
            Name = Name + getCarMaker().getTitle() + " ";
        if (getCarModel() != null)
            Name = Name + getCarModel().getTitle() + " ";
        if (getCarYear() != null)
            Name = Name + getCarYear().getTitle();
        return Name;
    }
}