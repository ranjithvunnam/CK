package com.nunc.wisp.entities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity(name = "PasswordResetTokenEntity")
@Table(name = "wisp_user_tokens")
public class PasswordResetTokenEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
	@Column(name = "token_id", updatable = false, nullable = false)
	private long id;
	
	@Column(name = "email", updatable = false, nullable = false)
	private String email;
	
	@Column(name = "token", updatable = true, nullable = false)
	private String token;
	
	@Column(name = "expiry_date", updatable = true, nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date expiryDate;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Date getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}
}
