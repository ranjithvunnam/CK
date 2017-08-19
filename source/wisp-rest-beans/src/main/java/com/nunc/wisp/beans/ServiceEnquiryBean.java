package com.nunc.wisp.beans;

import java.io.Serializable;
import java.util.Date;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

public class ServiceEnquiryBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4788999970266598234L;
	
	@NotBlank(message = "Please enter your name.")
	private String name;
	
	@Email(message="Invalid e-mail")
	@NotBlank(message = "Please enter your email.")
	private String email;
	
	@NotBlank(message = "Please enter your phone number")
	private String phone;
	
	@NotBlank(message = "Please enter message description.")
	private String description;
	
	private Long service_id;
	
	private Date enquiry_date;
	
	private Date created_date;

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
