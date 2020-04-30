package com.app.roadz.model.BaseModel;

import com.app.roadz.model.TSubscription;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class SubscribeResponse {

	@JsonProperty("subscription")
	private TSubscription subscription;

	@JsonProperty("link")
	private String link;

	@JsonProperty("order_id")
	private String orderId;

	public void setLink(String link){
		this.link = link;
	}

	public String getLink(){
		return link;
	}

	public void setOrderId(String orderId){
		this.orderId = orderId;
	}

	public String getOrderId(){
		return orderId;
	}

	public TSubscription getSubscription() {
		return subscription;
	}

	public void setSubscription(TSubscription subscription) {
		this.subscription = subscription;
	}

	@Override
 	public String toString(){
		return 
			"SubscribeResponse{" + 
			"link = '" + link + '\'' + 
			",order_id = '" + orderId + '\'' + 
			"}";
		}
}