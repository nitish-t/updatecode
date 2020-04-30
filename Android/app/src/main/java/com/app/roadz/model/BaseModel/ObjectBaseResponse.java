package com.app.roadz.model.BaseModel;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ObjectBaseResponse<T> extends BaseModel implements Serializable {


    @JsonProperty("items")
    private T items;




    public T getObject() {
        return items;
    }

    public void setObject(T object) {
        this.items = object;
    }

}