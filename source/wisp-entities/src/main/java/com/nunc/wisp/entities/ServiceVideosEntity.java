package com.nunc.wisp.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name="ServiceVideosEntity")
@Table(name="wisp_services_videos")
public class ServiceVideosEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2184084817353199712L;
	
	@Id
	@GeneratedValue
	@Column(name = "video_id")
	private Long video_id;
	
	@Column(name = "video_url", updatable = true, nullable = false)
	private String video_url;
	
	@Column(name = "video_thumbnail", updatable = true, nullable = false)
	private String video_thumbnail;
	
	@Column(name = "video_description", updatable = true, nullable = false)
	private String video_description;
	
	@ManyToOne
    @JoinColumn(name = "service_id")
	private ServiceListEntity service_video_list_entity;

	public Long getVideo_id() {
		return video_id;
	}

	public void setVideo_id(Long video_id) {
		this.video_id = video_id;
	}

	public String getVideo_url() {
		return video_url;
	}

	public void setVideo_url(String video_url) {
		this.video_url = video_url;
	}

	public String getVideo_description() {
		return video_description;
	}

	public void setVideo_description(String video_description) {
		this.video_description = video_description;
	}

	public ServiceListEntity getService_video_list_entity() {
		return service_video_list_entity;
	}

	public void setService_video_list_entity(
			ServiceListEntity service_video_list_entity) {
		this.service_video_list_entity = service_video_list_entity;
	}

	public String getVideo_thumbnail() {
		return video_thumbnail;
	}

	public void setVideo_thumbnail(String video_thumbnail) {
		this.video_thumbnail = video_thumbnail;
	}
	
	@Override
	public boolean equals(Object obj) {
		return (obj instanceof ServiceVideosEntity) && video_url.equals(this.getVideo_url());
	}
	
	@Override
	public int hashCode() {
		return video_url.hashCode();
	}
}
