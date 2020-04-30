package com.app.roadz.model.BaseModel;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;
import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ListBaseResponse<T> extends BaseModel implements Serializable {


    @JsonProperty("items")
    private List<T> items;


    public List<T> getList() {
        return items;
    }

    public void setList(List<T> list) {
        this.items = list;
    }
}