package com.app.roadzdriver.api.Response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Map;


@JsonIgnoreProperties(ignoreUnknown=true)
public class StatusResponse {


	@JsonProperty("success")
	boolean status;

	@JsonProperty("message")
    String message;

	@JsonProperty("code")
	int code;

	@JsonProperty("result")
	int result;

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	@JsonProperty("errors")
	public Map<String,String> errors;

	public StatusResponse() {
	}

	public StatusResponse(StatusResponse response) {
		this.status = response.status;
		this.message = response.message;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}


	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}
}