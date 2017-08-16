package com.nunc.wisp.entities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name="UserFavoritesEntity")
@Table(name="wisp_user_favorites")
public class UserFavoritesEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8620073156251048587L;
	
	@Id
	@GeneratedValue
	@Column(name = "favorite_id")
	private Long favorite_id;
	
	@Column(name = "created_date", updatable = false, nullable = false)
	private Date created_date;
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id") 
	private UserEntity user_fav_entity;
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "service_id") 
	private ServiceListEntity service_fav_list_entity;

	public Long getFavorite_id() {
		return favorite_id;
	}

	public void setFavorite_id(Long favorite_id) {
		this.favorite_id = favorite_id;
	}

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}

	public UserEntity getUser_fav_entity() {
		return user_fav_entity;
	}

	public void setUser_fav_entity(UserEntity user_fav_entity) {
		this.user_fav_entity = user_fav_entity;
	}

	public ServiceListEntity getService_fav_list_entity() {
		return service_fav_list_entity;
	}

	public void setService_fav_list_entity(ServiceListEntity service_fav_list_entity) {
		this.service_fav_list_entity = service_fav_list_entity;
	}
}
