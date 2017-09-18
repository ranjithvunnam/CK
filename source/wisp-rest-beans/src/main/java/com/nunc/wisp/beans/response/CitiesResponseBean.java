package com.nunc.wisp.beans.response;

import java.io.Serializable;

public class CitiesResponseBean implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4697470574081767275L;

	private Long city_id;
	
	private String city_name;

	public Long getCity_id() {
		return city_id;
	}

	public void setCity_id(Long city_id) {
		this.city_id = city_id;
	}

	public String getCity_name() {
		return city_name;
	}

	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}
}
