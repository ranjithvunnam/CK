package com.nunc.wisp.services.handlers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

@Component
public class SessionCounter implements HttpSessionListener {
	
	protected static final Logger LOG_R = Logger.getLogger(SessionCounter.class);
	private static List<String> sessions = new ArrayList<>();
	public static final String COUNTER = "session-counter";

	public void sessionCreated(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		sessions.add(session.getId());
		session.setAttribute(SessionCounter.COUNTER, this);
	}

	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		sessions.remove(session.getId());
		session.setAttribute(SessionCounter.COUNTER, this);
	}

	public int getActiveSessionNumber() {
		return sessions.size();
	}
}
