package com.nunc.wisp.beans;

import java.io.Serializable;

import com.nunc.wisp.beans.enums.ServiceType;

public class ServiceListBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4727553714167345043L;
	
	private Long id;
	
	private ServiceType service_type;
	
	private String name;
	
	private String description;
	
	private String website;
	
	private String phone;
	
	private String banner_url;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public ServiceType getService_type() {
		return service_type;
	}

	public void setService_type(ServiceType service_type) {
		this.service_type = service_type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBanner_url() {
		return banner_url;
	}

	public void setBanner_url(String banner_url) {
		this.banner_url = banner_url;
	}
}
