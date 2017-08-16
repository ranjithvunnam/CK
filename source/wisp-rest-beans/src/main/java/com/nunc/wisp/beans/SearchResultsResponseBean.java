package com.nunc.wisp.beans;

import java.io.Serializable;

public class SearchResultsResponseBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8315123400952335042L;
	
	private Long service_id;
	
	private String service_name;
	
	private String service_type;

	public Long getService_id() {
		return service_id;
	}

	public void setService_id(Long service_id) {
		this.service_id = service_id;
	}

	public String getService_name() {
		return service_name;
	}

	public void setService_name(String service_name) {
		this.service_name = service_name;
	}

	public String getService_type() {
		return service_type;
	}

	public void setService_type(String service_type) {
		this.service_type = service_type;
	}
	
	
}
