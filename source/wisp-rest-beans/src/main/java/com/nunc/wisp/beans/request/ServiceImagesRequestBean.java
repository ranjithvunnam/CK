package com.nunc.wisp.beans.request;

import java.io.Serializable;

public class ServiceImagesRequestBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8357203383511997539L;
	
	private Long image_id;
	
	private String name;
	
	private String description;
	
	private String url;
	
	public Long getImage_id() {
		return image_id;
	}

	public void setImage_id(Long image_id) {
		this.image_id = image_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	@Override
	public boolean equals(Object obj) {
		return (obj instanceof ServiceImagesRequestBean) && url.equals(this.getUrl());
	}
	
	@Override
	public int hashCode() {
		return url.hashCode();
	}
}
