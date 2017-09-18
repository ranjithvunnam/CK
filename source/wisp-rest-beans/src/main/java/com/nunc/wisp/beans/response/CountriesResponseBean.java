package com.nunc.wisp.beans.response;

import java.io.Serializable;

public class CountriesResponseBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3182950688180338546L;
	
	private Long country_id;
	
	private String country_name;

	public Long getCountry_id() {
		return country_id;
	}

	public void setCountry_id(Long country_id) {
		this.country_id = country_id;
	}

	public String getCountry_name() {
		return country_name;
	}

	public void setCountry_name(String country_name) {
		this.country_name = country_name;
	}
}
