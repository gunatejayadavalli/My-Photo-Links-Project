package com.i_am_guna.entity;

public class CustomErrorResponse {
	
	private int status;
	private String message;
	private String details;
	private long timestamp;
	public CustomErrorResponse() {
	}
	public CustomErrorResponse(int status, String message, String details, long timestamp) {
		this.status = status;
		this.message = message;
		this.details = details;
		this.timestamp = timestamp;
	}
	public CustomErrorResponse(int status, String message, long timestamp) {
		this.status = status;
		this.message = message;
		this.timestamp = timestamp;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public long getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}
	
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	@Override
	public String toString() {
		return "CustomErrorResponse [status=" + status + ", message=" + message + ", details=" + details
				+ ", timestamp=" + timestamp + "]";
	}
}
