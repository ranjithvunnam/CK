package com.nunc.wisp.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.Type;


@Entity(name = "ServiceAmenitiyEntity")
@Table(name = "wisp_services_amenities")
public class ServiceAmenitiyEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7237081242370934930L;
	
	@GenericGenerator(name = "generator", strategy = "foreign",
			parameters = @Parameter(name = "property", value = "service_list_amenities"))
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "amenity_id")
	private Long amenity_id;
	
	@Column(name = "capacity", updatable = true, nullable = true)
	private String capacity;
	
	@Column(name = "rooms", updatable = true, nullable = true)
	private Integer rooms;
	
	@Column(name = "price", updatable = true, nullable = true)
	private Float price;
	
	@Column(name = "parking", updatable = true, nullable = true)
	@Type(type = "org.hibernate.type.NumericBooleanType")
	private boolean parking;
	
	@Column(name = "liquor", updatable = true, nullable = true)
	@Type(type = "org.hibernate.type.NumericBooleanType")
	private boolean liquor;
	
	@Column(name = "air_conditioning", updatable = true, nullable = true)
	@Type(type = "org.hibernate.type.NumericBooleanType")
	private boolean air_condition;
	
	@Column(name = "wifi", updatable = true, nullable = true)
	@Type(type = "org.hibernate.type.NumericBooleanType")
	private boolean wifi;
	
	@Column(name = "type", updatable = true, nullable = true)
	private String type;
	
	@Column(name = "cusine", updatable = true, nullable = true)
	private String cusine;
	
	@Column(name = "occasion", updatable = true, nullable = true)
	private String occasion;
	
	@Column(name = "gender", updatable = true, nullable = true)
	private String gender;
	
	@Column(name = "dance_style", updatable = true, nullable = true)
	private String dance_style;
	
	@Column(name = "fleet", updatable = true, nullable = true)
	private String fleet;
	
	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	private ServiceListEntity service_list_amenities;

	public Long getAmenity_id() {
		return amenity_id;
	}

	public void setAmenity_id(Long amenity_id) {
		this.amenity_id = amenity_id;
	}

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

	public ServiceListEntity getService_list_amenities() {
		return service_list_amenities;
	}

	public void setService_list_amenities(ServiceListEntity service_list_amenities) {
		this.service_list_amenities = service_list_amenities;
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
