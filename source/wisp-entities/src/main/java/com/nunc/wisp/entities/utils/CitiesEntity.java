package com.nunc.wisp.entities.utils;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name = "CitiesEntity")
@Table(name = "wisp_city_list")
public class CitiesEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7282091093334337369L;
	
	@Id
	@GeneratedValue
	@Column(name = "city_id")
	private Long city_id;
	
	@Column(name = "city_name", updatable = true, nullable = false)
	private String city_name;
	
	@ManyToOne
    @JoinColumn(name = "state_id")
	private StatesEntity state_entity;

	public Long getCity_id() {
		return city_id;
	}

	public void setCity_id(Long city_id) {
		this.city_id = city_id;
	}

	public String getCity_name() {
		return city_name;
	}

	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}

	public StatesEntity getState_entity() {
		return state_entity;
	}

	public void setState_entity(StatesEntity state_entity) {
		this.state_entity = state_entity;
	}
}
