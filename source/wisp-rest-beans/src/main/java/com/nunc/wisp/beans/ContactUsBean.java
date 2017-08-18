package com.nunc.wisp.beans;

import java.io.Serializable;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

public class ContactUsBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2456488699719763572L;
	
	@NotBlank(message = "Please enter your name.")
	private String name;
	
	@Email(message="Invalid e-mail")
	@NotBlank(message = "Please enter your email.")
	private String email;
	
	@NotBlank(message = "Please enter your phone number")
	private String phone;
	
	@NotBlank(message = "Please enter message description.")
	private String message;

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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
