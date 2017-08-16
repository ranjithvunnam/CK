package com.nunc.wisp.entities;

import java.io.Serializable;
import java.util.Date;
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

@Entity(name="UserEntity")
@Table(name="wisp_users")
public class UserEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
	@Column(name = "user_id")
	private Long id;
	
	@Column(name = "first_name", updatable = true, nullable = false)
	private String first_name;
	
	@Column(name = "last_name", updatable = true, nullable = false)
	private String last_name;
	
	@Column(name = "phone_primary", updatable = true, nullable = false)
	private String phone_primary;
	
	@Column(name = "phone_secondary", updatable = true, nullable = false)
	private String phone_secondary;
	
	@Column(name = "email", updatable = true, nullable = false)
	private String email;
	
	@Column(name = "password", updatable = true, nullable = false)
	private String password;
	
	@Column(name = "created_date", updatable = true, nullable = false)
	private Date createdDate;
	
	@Column(name = "updated_date", updatable = true, nullable = false)
	private Date updatedDate;
	
	@OneToMany(mappedBy = "user_comments_entity", cascade =CascadeType.ALL, fetch = FetchType.LAZY)
	private Set<ServiceCommentsEntity> serviceCommentsEntity;
	
	@OneToMany(mappedBy = "user_fav_entity", cascade =CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<UserFavoritesEntity> favoritesEntities;
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "role_id" , referencedColumnName = "role_id") 
	private UserRoleEntity user_role_entity;
	
	@OneToMany(mappedBy = "user_service_entity", cascade =CascadeType.ALL, fetch = FetchType.LAZY)
	private Set<ServiceListEntity> service_user_ListEntity;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getPhone_primary() {
		return phone_primary;
	}

	public void setPhone_primary(String phone_primary) {
		this.phone_primary = phone_primary;
	}

	public String getPhone_secondary() {
		return phone_secondary;
	}

	public void setPhone_secondary(String phone_secondary) {
		this.phone_secondary = phone_secondary;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	public Set<UserFavoritesEntity> getFavoritesEntities() {
		return favoritesEntities;
	}

	public void setFavoritesEntities(Set<UserFavoritesEntity> favoritesEntities) {
		this.favoritesEntities = favoritesEntities;
	}

	public Set<ServiceCommentsEntity> getServiceCommentsEntity() {
		return serviceCommentsEntity;
	}

	public void setServiceCommentsEntity(
			Set<ServiceCommentsEntity> serviceCommentsEntity) {
		this.serviceCommentsEntity = serviceCommentsEntity;
	}

	public UserRoleEntity getUser_role_entity() {
		return user_role_entity;
	}

	public void setUser_role_entity(UserRoleEntity user_role_entity) {
		this.user_role_entity = user_role_entity;
	}

	public Set<ServiceListEntity> getService_user_ListEntity() {
		return service_user_ListEntity;
	}

	public void setService_user_ListEntity(
			Set<ServiceListEntity> service_user_ListEntity) {
		this.service_user_ListEntity = service_user_ListEntity;
	}
}
