package com.nunc.wisp.entities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name = "ServiceEnquiryDetailsEntity")
@Table(name = "wisp_enquiry_details")
public class ServiceEnquiryDetailsEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2980734326843923425L;
	
	@Id
	@GeneratedValue
	@Column(name = "enquiry_id")
	private Long id;
	
	@Column(name = "name", updatable = false, nullable = false)
	private String name;
	
	@Column(name = "email", updatable = false, nullable = false)
	private String email;
	
	@Column(name = "phone", updatable = false, nullable = false)
	private String phone;
	
	@Column(name = "description", updatable = false, nullable = false)
	private String description;
	
	@Column(name = "service_id", updatable = false, nullable = false)
	private Long service_id;
	
	@Column(name = "enquiry_date", updatable = false, nullable = false)
	private Date enquiry_date;
	
	@Column(name = "created_date", updatable = false, nullable = false)
	private Date created_date;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Long getService_id() {
		return service_id;
	}

	public void setService_id(Long service_id) {
		this.service_id = service_id;
	}

	public Date getEnquiry_date() {
		return enquiry_date;
	}

	public void setEnquiry_date(Date enquiry_date) {
		this.enquiry_date = enquiry_date;
	}

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}
}
