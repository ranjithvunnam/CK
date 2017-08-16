package com.nunc.wisp.beans.request;

import java.io.Serializable;

public class ServiceVideosRequestBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7718177206297545307L;

	private Long video_id;
	
	private String video_url;
	
	private String video_thumbnail;
	
	private String video_desc;

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

	public String getVideo_thumbnail() {
		return video_thumbnail;
	}

	public void setVideo_thumbnail(String video_thumbnail) {
		this.video_thumbnail = video_thumbnail;
	}

	public String getVideo_desc() {
		return video_desc;
	}

	public void setVideo_desc(String video_desc) {
		this.video_desc = video_desc;
	}
}
