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

@Entity(name="ServicesAddressEntity")
@Table(name="wisp_services_address")
public class ServicesAddressEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 9038652342812024438L;
	
	@GenericGenerator(name = "generator", strategy = "foreign",
			parameters = @Parameter(name = "property", value = "serviceListEntity"))
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "address_id")
	private Long address_id;
	
	@Column(name = "address_1", updatable = true, nullable = false)
	private String address_1;
	
	@Column(name = "address_2", updatable = true, nullable = false)
	private String address_2;
	
	@Column(name = "city", updatable = true, nullable = false)
	private String city;
	
	@Column(name = "country", updatable = true, nullable = false)
	private String country;
	
	@Column(name = "state", updatable = true, nullable = false)
	private String state;
	
	@Column(name = "pincode", updatable = true, nullable = false)
	private String pincode;
	
	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	private ServiceListEntity serviceListEntity;

	public Long getAddress_id() {
		return address_id;
	}

	public void setAddress_id(Long address_id) {
		this.address_id = address_id;
	}

	public String getAddress_1() {
		return address_1;
	}

	public void setAddress_1(String address_1) {
		this.address_1 = address_1;
	}

	public String getAddress_2() {
		return address_2;
	}

	public void setAddress_2(String address_2) {
		this.address_2 = address_2;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public ServiceListEntity getServiceListEntity() {
		return serviceListEntity;
	}

	public void setServiceListEntity(ServiceListEntity serviceListEntity) {
		this.serviceListEntity = serviceListEntity;
	}
}
