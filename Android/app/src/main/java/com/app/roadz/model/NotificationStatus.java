package com.app.roadz.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class NotificationStatus {


    @Expose
    @SerializedName("items")
    private Items items;
    @Expose
    @SerializedName("message")
    private String message;
    @Expose
    @SerializedName("code")
    private String code;
    @Expose
    @SerializedName("status")
    private String status;

    public Items getItems() {
        return items;
    }

    public void setItems(Items items) {
        this.items = items;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public static class Items {
        @Expose
        @SerializedName("noty")
        private String noty;
        @Expose
        @SerializedName("status")
        private String status;
        @Expose
        @SerializedName("token")
        private String token;
        @Expose
        @SerializedName("type")
        private String type;
        @Expose
        @SerializedName("customer_id")
        private String customer_id;
        @Expose
        @SerializedName("id")
        private String id;
        @Expose
        @SerializedName("vendor_id")
        private String vendor_id;
        @Expose
        @SerializedName("last_notification_status")
        private String last_notification_status;

        public String getLast_notification_status() {
            return last_notification_status;
        }

        public void setLast_notification_status(String last_notification_status) {
            this.last_notification_status = last_notification_status;
        }

        public String getVendor_id() {
            return vendor_id;
        }

        public void setVendor_id(String vendor_id) {
            this.vendor_id = vendor_id;
        }

        public String getNoty() {
            return noty;
        }

        public void setNoty(String noty) {
            this.noty = noty;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getToken() {
            return token;
        }

        public void setToken(String token) {
            this.token = token;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getCustomer_id() {
            return customer_id;
        }

        public void setCustomer_id(String customer_id) {
            this.customer_id = customer_id;
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }
    }
}
