package com.nunc.wisp.beans.vendor;

import java.io.Serializable;

public class ServiceAccessHitsResponseBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1651864112902026881L;
	
	private Integer day;
	
	private Integer month;
	
	private Integer year;
	
	private Integer hits_count;

	public Integer getDay() {
		return day;
	}

	public void setDay(Integer day) {
		this.day = day;
	}

	public Integer getMonth() {
		return month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Integer getHits_count() {
		return hits_count;
	}

	public void setHits_count(Integer hits_count) {
		this.hits_count = hits_count;
	}
}
