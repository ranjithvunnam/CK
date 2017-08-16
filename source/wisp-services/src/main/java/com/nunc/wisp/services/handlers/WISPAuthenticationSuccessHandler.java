package com.nunc.wisp.services.handlers;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class WISPAuthenticationSuccessHandler implements
		AuthenticationSuccessHandler {

	protected static final Logger LOG_R = Logger
			.getLogger(WISPAuthenticationSuccessHandler.class);
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		handle(request, response, authentication);
		//TODO Need to store session details in DB
		/*LOG_R.info("IP ADD "+request.getRemoteAddr());
		LOG_R.info("SESSION ID "+request.getSession().getId());
		LOG_R.info("SESSION Created At "+request.getSession().getCreationTime());*/
		clearAuthenticationAttributes(request);
	}

	protected void handle(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws IOException {
		//String targetUrl = null;
		String targetUrl = determineTargetUrl(authentication);
		/*HttpSession session = request.getSession(false);
		if (session != null) {
			targetUrl = (String) request.getSession().getAttribute("url_prior_login");
		}*/
		if (response.isCommitted()) {
			LOG_R.debug("Response has already been committed. Unable to redirect to "
					+ targetUrl);
			return;
		}
		if(!targetUrl.contains("registration.do") && !targetUrl.contains("forgotpassword.do")
				&& !targetUrl.contains("resetpassword")){
			redirectStrategy.sendRedirect(request, response, targetUrl);
		}
	}
	
	protected String determineTargetUrl(Authentication authentication) {
		boolean isUser = false;
		boolean isVendor = false;
		boolean isAdmin = false;
		Collection<? extends GrantedAuthority> authorities = authentication
				.getAuthorities();
		for (GrantedAuthority grantedAuthority : authorities) {
			if (grantedAuthority.getAuthority().equals("ROLE_CLIENT")) {
				isUser = true;
				break;
			} else if (grantedAuthority.getAuthority().equals("ROLE_VENDOR")) {
				isVendor = true;
				break;
			}else if (grantedAuthority.getAuthority().equals("ROLE_SUPERUSER")) {
				isAdmin = true;
				break;
			}
		}

		if (isUser) {
			return "/home.do";
		} else if (isVendor) {
			return "/vendor/home.do";
		} else if (isAdmin) {
			return "/admin/dashboard.do";
		} else {
			throw new IllegalStateException();
		}
	}
	
	protected void clearAuthenticationAttributes(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}

	public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
		this.redirectStrategy = redirectStrategy;
	}

	protected RedirectStrategy getRedirectStrategy() {
		return redirectStrategy;
	}
}
