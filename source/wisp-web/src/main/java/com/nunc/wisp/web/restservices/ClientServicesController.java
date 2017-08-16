package com.nunc.wisp.web.restservices;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Ranjith
 * 
 */

@Controller
public class ClientServicesController {
	
	protected static final Logger LOG_R = Logger.getLogger(ClientServicesController.class);
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String adminPage() {
		return "dashboard";
	}
}
