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

@Entity(name="ServiceCommentsEntity")
@Table(name="wisp_services_comments")
public class ServiceCommentsEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7739285028817232542L;
	
	@Id
	@GeneratedValue
	@Column(name = "comment_id")
	private Long comment_id;
	
	@Column(name = "rating", updatable = true, nullable = false)
	private Float rating;
	
	@Column(name = "comment_desc", updatable = true, nullable = false)
	private String comment_desc;
	
	@Column(name = "ip_address", updatable = false, nullable = false)
	private String ip_address;
	
	@Column(name = "comment_created", updatable = false, nullable = false)
	private Date comment_created;
	
	@ManyToOne
    @JoinColumn(name = "service_id")
	private ServiceListEntity service_comments_list_entity;
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id") 
	private UserEntity user_comments_entity;

	public Long getComment_id() {
		return comment_id;
	}

	public void setComment_id(Long comment_id) {
		this.comment_id = comment_id;
	}

	public Float getRating() {
		return rating;
	}

	public void setRating(Float rating) {
		this.rating = rating;
	}

	public String getComment_desc() {
		return comment_desc;
	}

	public void setComment_desc(String comment_desc) {
		this.comment_desc = comment_desc;
	}

	public String getIp_address() {
		return ip_address;
	}

	public void setIp_address(String ip_address) {
		this.ip_address = ip_address;
	}

	public Date getComment_created() {
		return comment_created;
	}

	public void setComment_created(Date comment_created) {
		this.comment_created = comment_created;
	}

	public ServiceListEntity getService_comments_list_entity() {
		return service_comments_list_entity;
	}

	public void setService_comments_list_entity(
			ServiceListEntity service_comments_list_entity) {
		this.service_comments_list_entity = service_comments_list_entity;
	}

	public UserEntity getUser_comments_entity() {
		return user_comments_entity;
	}

	public void setUser_comments_entity(UserEntity user_comments_entity) {
		this.user_comments_entity = user_comments_entity;
	}
}
