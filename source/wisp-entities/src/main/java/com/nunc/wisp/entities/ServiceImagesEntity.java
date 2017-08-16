package com.nunc.wisp.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name="ServiceImagesEntity")
@Table(name="wisp_services_images")
public class ServiceImagesEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 198800617767170337L;
	
	@Id
	@GeneratedValue
	@Column(name = "image_id")
	private Long image_id;
	
	@Column(name = "image_url", updatable = true, nullable = false)
	private String image_url;
	
	@Column(name = "image_description", updatable = true, nullable = true)
	private String image_description;
	
	@ManyToOne
    @JoinColumn(name = "service_id")
	private ServiceListEntity service_image_list_entity;
	
	public Long getImage_id() {
		return image_id;
	}

	public void setImage_id(Long image_id) {
		this.image_id = image_id;
	}

	public String getImage_url() {
		return image_url;
	}

	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}

	public String getImage_description() {
		return image_description;
	}

	public void setImage_description(String image_description) {
		this.image_description = image_description;
	}

	public ServiceListEntity getService_image_list_entity() {
		return service_image_list_entity;
	}

	public void setService_image_list_entity(
			ServiceListEntity service_image_list_entity) {
		this.service_image_list_entity = service_image_list_entity;
	}
	
	@Override
	public boolean equals(Object obj) {
		return (obj instanceof ServiceImagesEntity) && image_url.equals(this.getImage_url());
	}
	
	@Override
	public int hashCode() {
		return image_url.hashCode();
	}
}
