package com.nunc.wisp.beans;

import java.io.Serializable;

public class ServiceFeedBackBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2760324268423458241L;
	
	private String email;
	
	private Long service_id;
	
	private Float rating;
	
	private String comment_desc;
	
	private String ip_address;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Long getService_id() {
		return service_id;
	}

	public void setService_id(Long service_id) {
		this.service_id = service_id;
	}

	public Float getRating() {
		return rating;
	}

	public void setRating(Float rating) {
		this.rating = rating;
	}

	public String getComment_desc() {
		return comment_desc;
	}

	public void setComment_desc(String comment_desc) {
		this.comment_desc = comment_desc;
	}

	public String getIp_address() {
		return ip_address;
	}

	public void setIp_address(String ip_address) {
		this.ip_address = ip_address;
	}
}
