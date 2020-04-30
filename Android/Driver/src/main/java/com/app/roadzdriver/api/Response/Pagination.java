package com.app.roadzdriver.api.Response;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;


@JsonIgnoreProperties(ignoreUnknown=true)
public class Pagination{

    @JsonProperty("total_items")
    public int i_per_page;

    @JsonProperty("total_pages")
    public int i_total_pages;


    @JsonProperty("current_page")
    public int i_current_page;

    @JsonProperty("current_page_items")
    public int i_total_objects;

    public Pagination(){

    }

    public int getI_per_page() {
        return i_per_page;
    }

    public int getI_total_pages() {
        return i_total_pages;
    }

    public int getI_current_page() {
        return i_current_page;
    }

    public int getI_total_objects() {
        return i_total_objects;
    }
}
