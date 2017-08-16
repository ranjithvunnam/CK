package com.nunc.wisp.beans.request;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.nunc.wisp.beans.enums.ServiceType;

public class ServiceCreationRequestBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8309875484692039170L;
	
	private Long service_id;
	
	private ServiceType service_type;
	
	private String service_name;
	
	private String service_description;
	
	private String service_website;
	
	private String service_phone;
	
	private String service_email;
	
	private String service_address1;
	
	private String service_address2;
	
	private String service_city;
	
	private String service_state;
	
	private String service_country;
	
	private String service_pin;
	
	private List<ServiceImagesRequestBean> imagesBean = new ArrayList<ServiceImagesRequestBean>();
	
	private List<ServiceVideosRequestBean> videosBeans = new ArrayList<ServiceVideosRequestBean>();
	
	private ServiceAmenityRequestBean amenityBean;
	
	private boolean registrationComplete;
	
	private Date service_created;
	
	private Date service_updated;

	public Long getService_id() {
		return service_id;
	}

	public void setService_id(Long service_id) {
		this.service_id = service_id;
	}

	public ServiceType getService_type() {
		return service_type;
	}

	public void setService_type(ServiceType service_type) {
		this.service_type = service_type;
	}

	public String getService_name() {
		return service_name;
	}

	public void setService_name(String service_name) {
		this.service_name = service_name;
	}

	public String getService_description() {
		return service_description;
	}

	public void setService_description(String service_description) {
		this.service_description = service_description;
	}

	public String getService_website() {
		return service_website;
	}

	public void setService_website(String service_website) {
		this.service_website = service_website;
	}

	public String getService_phone() {
		return service_phone;
	}

	public void setService_phone(String service_phone) {
		this.service_phone = service_phone;
	}

	public String getService_email() {
		return service_email;
	}

	public void setService_email(String service_email) {
		this.service_email = service_email;
	}

	public String getService_address1() {
		return service_address1;
	}

	public void setService_address1(String service_address1) {
		this.service_address1 = service_address1;
	}

	public String getService_address2() {
		return service_address2;
	}

	public void setService_address2(String service_address2) {
		this.service_address2 = service_address2;
	}

	public String getService_city() {
		return service_city;
	}

	public void setService_city(String service_city) {
		this.service_city = service_city;
	}

	public String getService_state() {
		return service_state;
	}

	public void setService_state(String service_state) {
		this.service_state = service_state;
	}

	public String getService_country() {
		return service_country;
	}

	public void setService_country(String service_country) {
		this.service_country = service_country;
	}

	public String getService_pin() {
		return service_pin;
	}

	public void setService_pin(String service_pin) {
		this.service_pin = service_pin;
	}
	
	public List<ServiceImagesRequestBean> getImagesBean() {
		return imagesBean;
	}

	public void setImagesBean(List<ServiceImagesRequestBean> imagesBean) {
		this.imagesBean = imagesBean;
	}

	public ServiceAmenityRequestBean getAmenityBean() {
		return amenityBean;
	}

	public void setAmenityBean(ServiceAmenityRequestBean amenityBean) {
		this.amenityBean = amenityBean;
	}

	public boolean isRegistrationComplete() {
		return registrationComplete;
	}

	public void setRegistrationComplete(boolean registrationComplete) {
		this.registrationComplete = registrationComplete;
	}

	public Date getService_created() {
		return service_created;
	}

	public void setService_created(Date service_created) {
		this.service_created = service_created;
	}

	public Date getService_updated() {
		return service_updated;
	}

	public void setService_updated(Date service_updated) {
		this.service_updated = service_updated;
	}

	public List<ServiceVideosRequestBean> getVideosBeans() {
		return videosBeans;
	}

	public void setVideosBeans(List<ServiceVideosRequestBean> videosBeans) {
		this.videosBeans = videosBeans;
	}
}
