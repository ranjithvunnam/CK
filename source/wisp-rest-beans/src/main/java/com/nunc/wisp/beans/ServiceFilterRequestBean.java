package com.nunc.wisp.beans;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.beans.request.ServiceAmenityRequestBean;

public class ServiceFilterRequestBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1126398041559783742L;
	
	@NotNull(message="Please select service")
	private ServiceType service_type;
	
	private String location;
	
	private ServiceAmenityRequestBean amenityBean;
	
	private String searchTerm = null;

	public ServiceType getService_type() {
		return service_type;
	}

	public void setService_type(ServiceType service_type) {
		this.service_type = service_type;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public ServiceAmenityRequestBean getAmenityBean() {
		return amenityBean;
	}

	public void setAmenityBean(ServiceAmenityRequestBean amenityBean) {
		this.amenityBean = amenityBean;
	}

	public String getSearchTerm() {
		return searchTerm;
	}

	public void setSearchTerm(String searchTerm) {
		this.searchTerm = searchTerm;
	}
}
