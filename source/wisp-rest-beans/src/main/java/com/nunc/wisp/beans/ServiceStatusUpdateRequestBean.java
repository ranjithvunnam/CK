package com.nunc.wisp.beans;

import java.io.Serializable;

public class ServiceStatusUpdateRequestBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4017171538975314666L;
	
	private Long service_id;
	
	private Integer status;

	public Long getService_id() {
		return service_id;
	}

	public void setService_id(Long service_id) {
		this.service_id = service_id;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
}
