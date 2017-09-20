package com.nunc.wisp.entities.utils;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;

@Entity(name = "CountriesEntity")
@Table(name = "wisp_country_list")
public class CountriesEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8681237407131558719L;
	
	@Id
	@GeneratedValue
	@Column(name = "country_id")
	private Long country_id;
	
	@Column(name = "country_name", updatable = true, nullable = false)
	private String country_name;
	
	@OneToMany
	@JoinColumn(name="state_id", referencedColumnName="country_id")
	@Sort(type = SortType.COMPARATOR, comparator = StateComparator.class)
	private Set<StatesEntity> states;

	public Long getCountry_id() {
		return country_id;
	}

	public void setCountry_id(Long country_id) {
		this.country_id = country_id;
	}

	public String getCountry_name() {
		return country_name;
	}

	public void setCountry_name(String country_name) {
		this.country_name = country_name;
	}

	public Set<StatesEntity> getStates() {
		return states;
	}

	public void setStates(Set<StatesEntity> states) {
		this.states = states;
	}
}
