package com.nunc.wisp.entities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name = "ServiceHitsEntity")
@Table(name = "wisp_service_hits")
public class ServiceHitsEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8094091815954482805L;
	
	@Id
	@GeneratedValue
	@Column(name = "hit_id")
	private Long hit_id;
	
	@Column(name = "ip_address", updatable = false, nullable = false)
	private String ip_address;
	
	@Column(name = "timestamp", updatable = false, nullable = false)
	private Date timestamp;
	
	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "wisp_services_details_service_id")
	private ServiceListEntity service_list_hits_entity;
	

	public Long getHit_id() {
		return hit_id;
	}

	public void setHit_id(Long hit_id) {
		this.hit_id = hit_id;
	}

	public String getIp_address() {
		return ip_address;
	}

	public void setIp_address(String ip_address) {
		this.ip_address = ip_address;
	}

	public Date getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	public ServiceListEntity getService_list_hits_entity() {
		return service_list_hits_entity;
	}

	public void setService_list_hits_entity(
			ServiceListEntity service_list_hits_entity) {
		this.service_list_hits_entity = service_list_hits_entity;
	}
}
