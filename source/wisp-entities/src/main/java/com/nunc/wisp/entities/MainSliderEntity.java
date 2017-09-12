package com.nunc.wisp.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Convert;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name="MainSliderEntity")
@Table(name="wisp_main_slider")
public class MainSliderEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7814405480581112904L;
	
	@Id
	@GeneratedValue
	@Column(name = "slider_id")
	private Long id;
	
	@Column(name = "slider_url", updatable = true, nullable = false)
	private String slider_url;
	
	@Column(name = "slider_name", updatable = true, nullable = true)
	private String slider_name;
	
	@Column(name = "slider_description", updatable = true, nullable = false)
	private String slider_description;
	
	@Column(name = "slider_order", updatable = true, nullable = false)
	private Long slider_order;
	
	@Column(name = "slider_status", updatable = true, nullable = false)
	private Integer slider_status;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSlider_url() {
		return slider_url;
	}

	public void setSlider_url(String slider_url) {
		this.slider_url = slider_url;
	}

	public String getSlider_name() {
		return slider_name;
	}

	public void setSlider_name(String slider_name) {
		this.slider_name = slider_name;
	}

	public String getSlider_description() {
		return slider_description;
	}

	public void setSlider_description(String slider_description) {
		this.slider_description = slider_description;
	}

	public Long getSlider_order() {
		return slider_order;
	}

	public void setSlider_order(Long slider_order) {
		this.slider_order = slider_order;
	}

	public Integer getSlider_status() {
		return slider_status;
	}

	public void setSlider_status(Integer slider_status) {
		this.slider_status = slider_status;
	}
}
