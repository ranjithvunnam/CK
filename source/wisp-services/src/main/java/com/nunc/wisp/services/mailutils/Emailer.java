package com.nunc.wisp.services.mailutils;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;
import org.springframework.ui.velocity.VelocityEngineUtils;

@Component
public class Emailer {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private VelocityEngine velocityEngine;
	
	@Autowired
	ServletContext servletContext;
	
	
	/**
	 * This sends a mail message in HTML form.
	 * 
	 * @param subject
	 * @param message
	 * @throws MessagingException
	 */
	public void send(final String subject, final String token, final String to, final String userName)
			throws MessagingException {
		 MimeMessagePreparator messagePreparator = new MimeMessagePreparator() {
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
				message.setTo(to);
				message.setSubject(subject);
                message.setSentDate(new Date());
                message.setFrom("ranjithvunnam@gmail.com");
                Map<String, Object> model = new HashMap<String, Object>();
                model.put("token", "http://localhost:8080"+servletContext.getContextPath()+"/"+"resetpassword/"+token);
                model.put("userName", userName);

                String text = buildEmailText(model, velocityEngine, "passwordResetEmailTemplate");
                message.setText(text, true);
			}
		};
		
		this.mailSender.send(messagePreparator);
	}
	
	private String buildEmailText(Map<String, Object> model, VelocityEngine velocityEngine,
			String templateName) {
		String templateLocation = "velocity/" + templateName + ".vm";
		return VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, templateLocation, "UTF-8", model);
	}
}
