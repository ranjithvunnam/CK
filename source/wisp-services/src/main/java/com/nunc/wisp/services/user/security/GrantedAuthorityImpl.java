package com.nunc.wisp.services.user.security;

import org.springframework.security.core.GrantedAuthority;

public class GrantedAuthorityImpl implements GrantedAuthority {

	private static final long serialVersionUID = -5588742812922519390L;

	private String rolename;

	public GrantedAuthorityImpl(String rolename) {
		this.rolename = rolename;
	}

	@Override
	public String getAuthority() {
		return rolename;
	}
}