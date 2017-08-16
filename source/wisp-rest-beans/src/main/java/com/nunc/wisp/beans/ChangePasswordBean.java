package com.nunc.wisp.beans;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotEmpty;

import com.nunc.wisp.beans.custom.validators.ScriptAssertFieldError;

@ScriptAssertFieldError(lang = "javascript", script = "_this.password.equals(_this.confirmPassword)" , 
message="Password and confirm password does not matched.", fieldName = "confirmPassword")
public class ChangePasswordBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5981212068066861106L;
	
	private String email;
	
	@NotEmpty
	private String oldPassword;
	
	@NotEmpty
	private String password;
	
	@NotEmpty
	private String confirmPassword;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
}
