package com.nunc.wisp.beans;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotEmpty;

import com.nunc.wisp.beans.custom.validators.ScriptAssertFieldError;

@ScriptAssertFieldError(lang = "javascript", script = "_this.password.equals(_this.confirmPassword)" , 
message="Password and confirm password does not matched.", fieldName = "confirmPassword")
public class ResetPasswordBeans implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String token;
	
	@NotEmpty
	private String password;
	
	@NotEmpty
	private String confirmPassword;
	
	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
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
