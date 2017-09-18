package com.nunc.wisp.beans.response;

import java.io.Serializable;

public class StatesResponseBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3591172219260090289L;
	
	private Long state_id;
	
	private String state_name;

	public Long getState_id() {
		return state_id;
	}

	public void setState_id(Long state_id) {
		this.state_id = state_id;
	}

	public String getState_name() {
		return state_name;
	}

	public void setState_name(String state_name) {
		this.state_name = state_name;
	}
}
