package com.nunc.wisp.beans;

import java.io.Serializable;
import java.util.Date;

public class ServiceCommentsResponseBeans implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8361715216157201871L;
	
	private Float rating;
	
	private String comment_desc;
	
	private Date comment_created;
	
	private String first_name;

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

	public Date getComment_created() {
		return comment_created;
	}

	public void setComment_created(Date comment_created) {
		this.comment_created = comment_created;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
}
