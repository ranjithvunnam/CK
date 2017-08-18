package com.nunc.wisp.entities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name = "ContactUsEntity")
@Table(name = "wisp_contactus")
public class ContactUsEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6938385605471173541L;
	
	@Id
	@GeneratedValue
	@Column(name = "contact_id")
	private Long id;
	
	@Column(name = "name", updatable = true, nullable = false)
	private String name;
	
	@Column(name = "email", updatable = true, nullable = false)
	private String email;
	
	@Column(name = "phone", updatable = true, nullable = false)
	private String phone;
	
	@Column(name = "description", updatable = true, nullable = false)
	private String description;
	
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

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}
}
