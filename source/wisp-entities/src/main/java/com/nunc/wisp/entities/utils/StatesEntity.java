package com.nunc.wisp.entities.utils;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;

@Entity(name = "StatesEntity")
@Table(name = "wisp_state_list")
public class StatesEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1217865742852262482L;
	
	@Id
	@GeneratedValue
	@Column(name = "state_id")
	private Long state_id;
	
	@Column(name = "state_name", updatable = true, nullable = false)
	private String state_name;
	
	@ManyToOne
    @JoinColumn(name = "country_id")
	private CountriesEntity country_entity;
	
	@OneToMany(mappedBy ="state_entity", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@Sort(type = SortType.COMPARATOR, comparator = CityComparator.class)
	private Set<CitiesEntity> cities;

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

	public CountriesEntity getCountry_entity() {
		return country_entity;
	}

	public void setCountry_entity(CountriesEntity country_entity) {
		this.country_entity = country_entity;
	}

	public Set<CitiesEntity> getCities() {
		return cities;
	}

	public void setCities(Set<CitiesEntity> cities) {
		this.cities = cities;
	}
}
