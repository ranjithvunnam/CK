package com.nunc.wisp.beans;

import java.io.Serializable;

public class AjaxResponseBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5462443507338376790L;
	
	private String redirectUrl;
	
	private UserRegistrationBean bean;

	public String getRedirectUrl() {
		return redirectUrl;
	}

	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}

	public UserRegistrationBean getBean() {
		return bean;
	}

	public void setBean(UserRegistrationBean bean) {
		this.bean = bean;
	}
}
