package com.nunc.wisp.beans.request;

import java.io.Serializable;

public class ServiceAmenityRequestBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7727844268190185785L;
	
	private String capacity;
	
	private Integer rooms;
	
	private Float price;
	
	private boolean parking = false;
	
	private boolean liquor = false;
	
	private boolean air_condition = false;
	
	private boolean wifi = false;
	
	private String type;
	
	private String cusine;
	
	private String occasion;
	
	private String gender;
	
	private String dance_style;
	
	private String fleet;

	public String getCapacity() {
		return capacity;
	}

	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}

	public Integer getRooms() {
		return rooms;
	}

	public void setRooms(Integer rooms) {
		this.rooms = rooms;
	}

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public boolean isParking() {
		return parking;
	}

	public void setParking(boolean parking) {
		this.parking = parking;
	}

	public boolean isLiquor() {
		return liquor;
	}

	public void setLiquor(boolean liquor) {
		this.liquor = liquor;
	}

	public boolean isAir_condition() {
		return air_condition;
	}

	public void setAir_condition(boolean air_condition) {
		this.air_condition = air_condition;
	}

	public boolean isWifi() {
		return wifi;
	}

	public void setWifi(boolean wifi) {
		this.wifi = wifi;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCusine() {
		return cusine;
	}

	public void setCusine(String cusine) {
		this.cusine = cusine;
	}

	public String getOccasion() {
		return occasion;
	}

	public void setOccasion(String occasion) {
		this.occasion = occasion;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getDance_style() {
		return dance_style;
	}

	public void setDance_style(String dance_style) {
		this.dance_style = dance_style;
	}

	public String getFleet() {
		return fleet;
	}

	public void setFleet(String fleet) {
		this.fleet = fleet;
	}
}
