package com.nunc.wisp.beans.vendor;

import java.io.Serializable;
import java.util.Date;

public class ServiceAccessHitsDownlodResponseBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -631162574391589978L;
	
	public Long id;
	
	public String user_name;
	
	public String email;
	
	public String phone;
	
	public String service_name;
	
	public Date date;
	
	public String location;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getService_name() {
		return service_name;
	}

	public void setService_name(String service_name) {
		this.service_name = service_name;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
}
