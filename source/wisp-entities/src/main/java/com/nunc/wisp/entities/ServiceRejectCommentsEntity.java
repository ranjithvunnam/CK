package com.nunc.wisp.entities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name = "ServiceRejectCommentsEntity")
@Table(name = "service_reject_comments")
public class ServiceRejectCommentsEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7401833765466244206L;
	
	@Id
	@GeneratedValue
	@Column(name = "contact_id")
	private Long reject_id;
	
	@Column(name = "reject_comment", updatable = true, nullable = false)
	private String reject_comment;
	
	@Column(name = "created_date", updatable = false, nullable = false)
	private Date created_date;
	
	@ManyToOne
    @JoinColumn(name = "service_id")
	private ServiceListEntity service_reject_comments;

	public Long getReject_id() {
		return reject_id;
	}

	public void setReject_id(Long reject_id) {
		this.reject_id = reject_id;
	}

	public String getReject_comment() {
		return reject_comment;
	}

	public void setReject_comment(String reject_comment) {
		this.reject_comment = reject_comment;
	}

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}

	public ServiceListEntity getService_reject_comments() {
		return service_reject_comments;
	}

	public void setService_reject_comments(ServiceListEntity service_reject_comments) {
		this.service_reject_comments = service_reject_comments;
	}
}
