package com.app.roadz.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;
import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TCarOption implements Serializable {

    @JsonProperty("car_model_id")
    private int carModelId;

    @JsonProperty("car_maker_id")
    private int carMakerId;

    @JsonProperty("id")
    private int id;

    @JsonProperty("title")
    private String title;

    @JsonProperty("car_models")
    private List<TCarOption> car_models;

    @JsonProperty("car_years")
    private List<TCarOption> car_years;

    public void setCarModelId(int carModelId) {
        this.carModelId = carModelId;
    }

    public int getCarModelId() {
        return carModelId;
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

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public List<TCarOption> getCar_models() {
        return car_models;
    }

    public void setCar_models(List<TCarOption> car_models) {
        this.car_models = car_models;
    }

    public List<TCarOption> getCar_years() {
        return car_years;
    }

    public void setCar_years(List<TCarOption> car_years) {
        this.car_years = car_years;
    }

    @Override
    public String toString() {
        return
                "TCarOption{" +
                        "car_model_id = '" + carModelId + '\'' +
                        ",car_maker_id = '" + carMakerId + '\'' +
                        ",id = '" + id + '\'' +
                        ",title = '" + title + '\'' +
                        "}";
    }
}