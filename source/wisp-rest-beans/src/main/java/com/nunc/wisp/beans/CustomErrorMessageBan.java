package com.nunc.wisp.beans;

import java.io.Serializable;

public class CustomErrorMessageBan implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 519128554769391024L;
	
	private String message;
	
	private int error_code;
	
	public CustomErrorMessageBan(String message, int error_code) {
		this.message = message;
		this.error_code = error_code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getError_code() {
		return error_code;
	}

	public void setError_code(int error_code) {
		this.error_code = error_code;
	}
}
