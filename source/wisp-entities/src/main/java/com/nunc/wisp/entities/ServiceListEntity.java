package com.nunc.wisp.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.nunc.wisp.beans.enums.ServiceType;

@Entity(name="ServiceListEntity")
@Table(name="wisp_services_details")
public class ServiceListEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4099560980707642221L;
	
	@Id
	@GeneratedValue
	@Column(name = "service_id")
	private Long service_id;
	
	@Column(name = "service_type", updatable = true, nullable = false)
	@Enumerated (value = EnumType.STRING)
	private ServiceType service_type;
	
	@Column(name = "service_name", updatable = true, nullable = false)
	private String service_name;
	
	@Column(name = "service_description", updatable = true, nullable = false)
	private String service_description;
	
	@Column(name = "service_website", updatable = true, nullable = false)
	private String service_website;
	
	@Column(name = "service_phone", updatable = true, nullable = false)
	private String service_phone;
	
	@Column(name = "service_email", updatable = true, nullable = false)
	private String service_email;
	
	@Column(name = "service_banner_url", updatable = true, nullable = false)
	private String service_banner_url;
	
	@Column(name = "service_avg_rating", updatable = true, nullable = false)
	private Float service_avg_rating;
	
	@Column(name = "service_created", updatable = false, nullable = false)
	private Date service_created;
	
	@Column(name = "service_updated", updatable = true, nullable = false)
	private Date service_updated;
	
	@Column(name = "approval_status", updatable = true, nullable = false)
	/*@Type(type = "org.hibernate.type.NumericBooleanType")*/
	private Integer approval_status = 0;
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id") 
	private UserEntity user_service_entity;
	
	@OneToOne(fetch = FetchType.LAZY, mappedBy = "serviceListEntity", cascade = CascadeType.ALL)
	private ServicesAddressEntity addressEntity;
	
	@OneToMany(mappedBy ="service_image_list_entity", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private Set<ServiceImagesEntity> imagesEntities;
	
	@OneToMany(mappedBy ="service_video_list_entity", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private Set<ServiceVideosEntity> videosEntities;
	
	@OneToMany(mappedBy ="service_comments_list_entity", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@OrderBy("comment_created DESC")
	private Set<ServiceCommentsEntity> commentsEntities;
	
	@OneToMany(mappedBy = "service_fav_list_entity", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<UserFavoritesEntity> favoritesEntities;
	
	@OneToMany(mappedBy = "service_list_hits_entity",cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private Set<ServiceHitsEntity> serviceHitsEntities;
	
	@OneToOne(fetch = FetchType.LAZY, mappedBy = "service_list_amenities", cascade = CascadeType.ALL)
	private ServiceAmenitiyEntity amenitiyEntity;

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

	public String getService_banner_url() {
		return service_banner_url;
	}

	public void setService_banner_url(String service_banner_url) {
		this.service_banner_url = service_banner_url;
	}

	public Float getService_avg_rating() {
		return service_avg_rating;
	}

	public void setService_avg_rating(Float service_avg_rating) {
		this.service_avg_rating = service_avg_rating;
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

	public ServicesAddressEntity getAddressEntity() {
		return addressEntity;
	}

	public void setAddressEntity(ServicesAddressEntity addressEntity) {
		this.addressEntity = addressEntity;
	}

	public Set<ServiceImagesEntity> getImagesEntities() {
		return imagesEntities;
	}

	public void setImagesEntities(Set<ServiceImagesEntity> imagesEntities) {
		this.imagesEntities = imagesEntities;
	}

	public Set<ServiceVideosEntity> getVideosEntities() {
		return videosEntities;
	}

	public void setVideosEntities(Set<ServiceVideosEntity> videosEntities) {
		this.videosEntities = videosEntities;
	}

	public Set<ServiceCommentsEntity> getCommentsEntities() {
		return commentsEntities;
	}

	public void setCommentsEntities(Set<ServiceCommentsEntity> commentsEntities) {
		this.commentsEntities = commentsEntities;
	}

	public Set<UserFavoritesEntity> getFavoritesEntities() {
		return favoritesEntities;
	}

	public void setFavoritesEntities(Set<UserFavoritesEntity> favoritesEntities) {
		this.favoritesEntities = favoritesEntities;
	}

	
	public Integer getApproval_status() {
		return approval_status;
	}

	public void setApproval_status(Integer approval_status) {
		this.approval_status = approval_status;
	}

	public UserEntity getUser_service_entity() {
		return user_service_entity;
	}

	public void setUser_service_entity(UserEntity user_service_entity) {
		this.user_service_entity = user_service_entity;
	}

	public Set<ServiceHitsEntity> getServiceHitsEntities() {
		return serviceHitsEntities;
	}

	public void setServiceHitsEntities(Set<ServiceHitsEntity> serviceHitsEntities) {
		this.serviceHitsEntities = serviceHitsEntities;
	}

	public ServiceAmenitiyEntity getAmenitiyEntity() {
		return amenitiyEntity;
	}

	public void setAmenitiyEntity(ServiceAmenitiyEntity amenitiyEntity) {
		this.amenitiyEntity = amenitiyEntity;
	}
}
