package com.nunc.wisp.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name="UserRoleEntity")
@Table(name="wisp_user_roles")
public class UserRoleEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7942174093489058856L;
	
	@Id
	@GeneratedValue
	@Column(name = "role_id", insertable= false, updatable = false)
	private Long role_id;
	
	@Column(name = "role_name", updatable = true, nullable = false)
	private String role_name;

	public Long getRole_id() {
		return role_id;
	}

	public void setRole_id(Long role_id) {
		this.role_id = role_id;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
}
