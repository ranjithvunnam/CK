package com.nunc.wisp.beans;

import java.io.Serializable;
import java.sql.Timestamp;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import com.nunc.wisp.beans.custom.validators.ScriptAssertFieldError;

@ScriptAssertFieldError(lang = "javascript", script = "_this.password.equals(_this.confirm_password)" , 
message="Password and confirm password does not matched.", fieldName = "confirm_password")
public class UserRegistrationBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7197207416870857538L;

	private Long id;
	
	@NotBlank(message = "First name may not be empty.")
	@Length( min=1 ,max=40, message ="First name length must be between 2 and 40")
	private String first_name;
	
	@NotBlank(message = "Last name may not be empty.")
	@Length( min=1 ,max=40 ,message ="Last name length must be between 2 and 40")
	private String last_name;
	
	@NotBlank(message = "Phone number may not be empty.")
	private String phone_primary;

	private String phone_secondary;

	@Email(message="Invalid e-mail")
	@NotBlank(message = "Email may not be empty.")
	private String email;
	
	@NotBlank(message = "Password may not be empty.")
	@Length(min = 6 , max=12,message ="Password length must be between 6 and 12")
	private String password;
	
	@NotBlank(message = "Confirm Password may not be empty.")
	private String confirm_password;

	private Long role;

	private Timestamp createdDate;

	private Timestamp updatedDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getPhone_primary() {
		return phone_primary;
	}

	public void setPhone_primary(String phone_primary) {
		this.phone_primary = phone_primary;
	}

	public String getPhone_secondary() {
		return phone_secondary;
	}

	public void setPhone_secondary(String phone_secondary) {
		this.phone_secondary = phone_secondary;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirm_password() {
		return confirm_password;
	}

	public void setConfirm_password(String confirm_password) {
		this.confirm_password = confirm_password;
	}

	public Long getRole() {
		return role;
	}

	public void setRole(Long role) {
		this.role = role;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public Timestamp getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}
}
