package com.nunc.wisp.web.restservices;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.nunc.wisp.beans.ServiceStatusUpdateRequestBean;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.services.AdminApplicationServices;
import com.nunc.wisp.services.exception.WISPServiceException;
import com.nunc.wisp.web.restservices.exception.handler.ResourceNotFoundException;

@Controller
@RequestMapping("/admin")
public class AdminServicesController {
	
	protected static final Logger LOG_R = Logger.getLogger(AdminServicesController.class);
	
	@Autowired
	@Qualifier("AdminApplicationServices")
	private AdminApplicationServices adminApplicationServices;
	
	@RequestMapping(value = "/access", method = RequestMethod.GET)
	public String showLoginForm(@RequestParam(value = "error", required = false) boolean error,
			Model model, HttpServletRequest request) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
		    return "redirect:/admin/dashboard";
		}
		if (error == true) {
			model.addAttribute("errors", "invalid username or password!");
		} else {
			model.addAttribute("errors", "");
		}
		String referrer = request.getHeader("Referer");
		if (referrer != null) {
			request.getSession().setAttribute("url_prior_login", referrer);
		}
		return "admin/login";
	}
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String index(Model model , Integer offset, Integer maxResults) throws WISPServiceException {
		Long count = adminApplicationServices.getCountOfServicesToVerify();
		List<ServiceListEntity>  vendor_service_list = adminApplicationServices.getListOfServicesToVerify(offset, maxResults);
		model.addAttribute("count", count);
		model.addAttribute("services", vendor_service_list);
		return "admin/admin_service_list";
	}
	
	@RequestMapping(value = "/{token}/{service_id}/service_details", method = RequestMethod.GET)
	public String showServiceIndetailed(@PathVariable(value="token") String token, @PathVariable(value="service_id") Long service_id, Model model) throws WISPServiceException{
		ServiceListEntity service_details = adminApplicationServices.getServiceIndetailed(ServiceType.getNameByCode(token),service_id);
		if(service_details == null) {
			throw new ResourceNotFoundException();
		}
		else {
			model.addAttribute("service_details", service_details);
			return "admin/admin_service_details";
		}
	}
	
	@RequestMapping(value = "/update_status", method = RequestMethod.DELETE)
	@ResponseStatus(value = HttpStatus.OK)
	public void updateServiceStatus(@Valid @RequestBody ServiceStatusUpdateRequestBean bean) throws WISPServiceException {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			adminApplicationServices.updateServiceStatus(bean);
		}
	}
}
