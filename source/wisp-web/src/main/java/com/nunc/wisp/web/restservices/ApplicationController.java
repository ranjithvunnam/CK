package com.nunc.wisp.web.restservices;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nunc.wisp.beans.AjaxResponseBean;
import com.nunc.wisp.beans.ChangePasswordBean;
import com.nunc.wisp.beans.ContactUsBean;
import com.nunc.wisp.beans.ForgotPasswordBeans;
import com.nunc.wisp.beans.ResetPasswordBeans;
import com.nunc.wisp.beans.SearchResultsResponseBean;
import com.nunc.wisp.beans.ServiceCommentsResponseBeans;
import com.nunc.wisp.beans.ServiceEnquiryBean;
import com.nunc.wisp.beans.ServiceFeedBackBean;
import com.nunc.wisp.beans.ServiceFilterRequestBean;
import com.nunc.wisp.beans.UserRegistrationBean;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.beans.enums.SocialLoginProviders;
import com.nunc.wisp.entities.MainSliderEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.entities.UserFavoritesEntity;
import com.nunc.wisp.services.ApplicationServices;
import com.nunc.wisp.services.VendorAppServices;
import com.nunc.wisp.services.exception.WISPServiceException;
import com.nunc.wisp.web.restservices.exception.handler.MethodNotAllowedException;
import com.nunc.wisp.web.restservices.exception.handler.ResourceNotFoundException;

/**
 * @author Ranjith
 * 
 */

@Controller
@SessionAttributes("location")
public class ApplicationController {

	protected static final Logger LOG_R = Logger.getLogger(ApplicationController.class);

	@Autowired
	@Qualifier("ApplicationServices")
	private ApplicationServices applicationServices;
	
	@Autowired
	@Qualifier("VendorAppServices")
	private VendorAppServices vendorAppServices;
	
	@Autowired
	@Qualifier("authenticationManager")
	AuthenticationManager authenticationManager;
	
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
	
	@ExceptionHandler(ResourceNotFoundException.class)
	public String handleResourceNotFoundException() {
		return "404";
	}
	
	@RequestMapping(value = "/404", method = RequestMethod.GET)
	public String pageNotFound() {
		throw new ResourceNotFoundException();
	}
	
	@ExceptionHandler(MethodNotAllowedException.class)
	public String handleMethodNotAllowedException() {
		return "403";
	}
	
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public String Accessforbidden() {
		throw new MethodNotAllowedException();
	}
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(true);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
    }
	
	@RequestMapping(value = "/updateLocation", method = RequestMethod.GET)  
    public String updateLocation(@RequestParam("location") String location, HttpSession session, Model model){
		session.setAttribute("location", location);
		model.asMap().clear();
		return "redirect:home/"+location;  
    }  
	
	/*
	 * Home controller with out location
	 * */
	@RequestMapping(value = {"/home"}, method = RequestMethod.GET)
	public String home(Model model, HttpSession session) throws WISPServiceException {
		
		String location = (String) session.getAttribute("location");
		model.asMap().clear();
		if(location != null && !location.isEmpty()) {
			return "redirect:home/"+location;
		} else {
			List<ServiceListEntity> venue_list = null;
			List<ServiceListEntity> caterers_list = null;
			List<ServiceListEntity> photography_list = null;
			List<String> city_list = applicationServices.getListOfCities();
			List<MainSliderEntity> slider_images = applicationServices.getMainSliderImages();
			venue_list = applicationServices.getMainPageServiceList(ServiceType.SER_VENUE, null);
			caterers_list = applicationServices.getMainPageServiceList(ServiceType.SER_CATERERS, null);
			photography_list = applicationServices.getMainPageServiceList(ServiceType.SER_PHOTOGRAPHY, null);
			
			model.addAttribute("city_list", city_list);
			model.addAttribute("slider_images", slider_images);
			model.addAttribute("venue_list", venue_list);
			model.addAttribute("caterers_list", caterers_list);
			model.addAttribute("photography_list", photography_list);
			return "home";
		}
	}
	/*
	 * Home controller with location
	 * */
	@RequestMapping(value = {"/home/{location}"}, method = RequestMethod.GET)
	public ModelAndView index(@PathVariable Map<String, String> pathVariables, HttpSession session) throws WISPServiceException {
		
		ModelAndView mav = new ModelAndView();
		List<ServiceListEntity> venue_list = null;
		List<ServiceListEntity> caterers_list = null;
		List<ServiceListEntity> photography_list = null;
		List<String> city_list = applicationServices.getListOfCities();
		List<MainSliderEntity> slider_images = applicationServices.getMainSliderImages();
		
		if (pathVariables.containsKey("location")) {
			venue_list = applicationServices.getMainPageServiceList(ServiceType.SER_VENUE, pathVariables.get("location"));
			caterers_list = applicationServices.getMainPageServiceList(ServiceType.SER_CATERERS, pathVariables.get("location"));
			photography_list = applicationServices.getMainPageServiceList(ServiceType.SER_PHOTOGRAPHY, pathVariables.get("location"));
	    }
	    else {
			venue_list = applicationServices.getMainPageServiceList(ServiceType.SER_VENUE, null);
			caterers_list = applicationServices.getMainPageServiceList(ServiceType.SER_CATERERS, null);
			photography_list = applicationServices.getMainPageServiceList(ServiceType.SER_PHOTOGRAPHY, null);
	    }
		mav.addObject("city_list", city_list);
		mav.addObject("slider_images", slider_images);
		mav.addObject("venue_list", venue_list);
		mav.addObject("caterers_list", caterers_list);
		mav.addObject("photography_list", photography_list);
		mav.setViewName("home");
		return mav;
	}
	
	/*
	 * ServiceList controller with out location
	 * */
	@RequestMapping(value = "/{token}/service_listing", method = RequestMethod.GET)
	public String showListOfServices(@PathVariable(value="token") String token, Model model, Integer offset, Integer maxResults, HttpSession session) throws WISPServiceException {
		String location = (String) session.getAttribute("location");
		model.asMap().clear();
		token = ServiceType.contains(token) ? ServiceType.valueOf(token).getDescription() : token;
		if(location != null && !location.isEmpty()) {
			return "redirect:/"+location+"/"+token+"/service_listing";
		} else {
			ServiceFilterRequestBean bean = new ServiceFilterRequestBean();
			bean.setService_type(ServiceType.getNameByCode(token));
			List<ServiceListEntity> services = applicationServices.getListOfServices(bean, offset, maxResults);
			model.addAttribute("services", services);
			model.addAttribute("service_type", token);
			model.addAttribute("count", applicationServices.getServiceListCount(bean));
			model.addAttribute("offset", offset);
			model.addAttribute("service_list", ServiceType.values());
			List<String> city_list = applicationServices.getListOfCities();
			model.addAttribute("city_list", city_list);
			model.addAttribute("serviceFilterBean", bean);
			return "services/service_listing";
		}
	}
	
	/*
	 * ServiceList controller with location
	 * */
	@RequestMapping(value = "{location}/{token}/service_listing", method = RequestMethod.GET)
	public String showLocationBasedListOfServices(@ModelAttribute("serviceFilterBean") final ServiceFilterRequestBean bean,@PathVariable(value="location") String location,
			@PathVariable(value="token") String token, Model model, Integer offset, Integer maxResults) throws WISPServiceException {
		
		token = ServiceType.contains(token) ? ServiceType.valueOf(token).getDescription() : token;
		location = (bean.getLocation() != null && !bean.getLocation().isEmpty()) ? bean.getLocation() : location;
		ServiceType serv_type = (bean.getService_type() != null && !bean.getService_type().name().isEmpty()) ? bean.getService_type() : ServiceType.getNameByCode(token);
		bean.setService_type(serv_type);
		bean.setLocation(location);
		
		List<ServiceListEntity> services = applicationServices.getListOfServices(bean, offset, maxResults);
		model.addAttribute("services", services);
		model.addAttribute("service_type", token);
		model.addAttribute("count", applicationServices.getServiceListCount(bean));
		model.addAttribute("offset", offset);
		model.addAttribute("service_list", ServiceType.values());
		List<String> city_list = applicationServices.getListOfCities();
		model.addAttribute("city_list", city_list);
		bean.setService_type(ServiceType.getNameByCode(token));
		model.addAttribute("serviceFilterBean", bean);
		return "services/service_listing";
	}
	
	@RequestMapping(value = "/filterServices", method = RequestMethod.POST)
	public String filterServices(@ModelAttribute("serviceFilterBean") @Valid ServiceFilterRequestBean bean,
			BindingResult result, Errors errors, Model model, RedirectAttributes redirectAttributes) throws WISPServiceException {
		redirectAttributes.addFlashAttribute("serviceFilterBean", bean);
		return "redirect:/"+bean.getLocation()+"/"+bean.getService_type().getDescription()+"/service_listing";
	}
	
	@RequestMapping(value = {"/{token}/{service_id}/service_par_listing"}, method = RequestMethod.GET)
	public String showPartialListOfServices(@PathVariable(value="token") String token, Model model, @PathVariable(value="service_id") Long service_id, HttpServletRequest request) 
			throws WISPServiceException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			ServiceListEntity service_details = applicationServices.getServiceIndetailed(ServiceType.getNameByCode(token),service_id);
			if(service_details != null) {
				vendorAppServices.setAccessHistoryDetails(service_id, request.getRemoteAddr());
			}
			model.addAttribute("service_details", service_details);
			model.addAttribute("contactUs", new ContactUsBean());
			List<String> city_list = applicationServices.getListOfCities();
			model.addAttribute("city_list", city_list);
			return "services/service_details";
		} else {
			ServiceListEntity service_details = applicationServices.getServiceIndetailed(ServiceType.getNameByCode(token),service_id);
			if(service_details != null) {
				vendorAppServices.setAccessHistoryDetails(service_id, request.getRemoteAddr());
			}
			List<String> city_list = applicationServices.getListOfCities();
			model.addAttribute("city_list", city_list);
			model.addAttribute("service_details", service_details);
			model.addAttribute("service_type", token);
			return "services/service_par_listing";
		}
	}
	
	@RequestMapping(value = "/{token}/{service_id}/service_details", method = RequestMethod.GET)
	public String showServiceIndetailed(@PathVariable(value="token") String token, @PathVariable(value="service_id") Long service_id, Model model, HttpServletRequest request) throws WISPServiceException{
		ServiceListEntity service_details = applicationServices.getServiceIndetailed(ServiceType.getNameByCode(token),service_id);
		if(service_details != null) {
			vendorAppServices.setAccessHistoryDetails(service_id, request.getRemoteAddr());
		}
		ServiceFilterRequestBean bean = new ServiceFilterRequestBean();
		bean.setService_type(ServiceType.getNameByCode(token));
		model.addAttribute("serviceFilterBean", bean);
		List<String> city_list = applicationServices.getListOfCities();
		model.addAttribute("city_list", city_list);
		model.addAttribute("service_details", service_details);
		model.addAttribute("enquiryBean", new ServiceEnquiryBean());
		model.addAttribute("service_list", ServiceType.values());
		
		String referrer = request.getHeader("Referer");
		if (referrer != null) {
			request.getSession().setAttribute("previous_page", referrer);
		}
		return "services/service_details";
	}
	
	@RequestMapping(value = "/favorites", method = RequestMethod.GET)
	public String showUserFavorites(Model model, Integer offset, Integer maxResults) throws WISPServiceException{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			model.addAttribute("count", applicationServices.getUserFavServiceListCount(userDetails.getUsername()));
			model.addAttribute("offset", offset);
			List<UserFavoritesEntity> services= applicationServices.getUserFavoriteServices(userDetails.getUsername(), offset, maxResults);
			model.addAttribute("services", services);
			List<String> city_list = applicationServices.getListOfCities();
			model.addAttribute("city_list", city_list);
		}
		return "services/service_favorites";
	}
	
	@RequestMapping(value = "/submitFeedBack", method = RequestMethod.POST)
	public @ResponseBody ServiceFeedBackBean submitUserFeedBack(@Valid @RequestBody  ServiceFeedBackBean feedbackBean, HttpServletRequest request) throws WISPServiceException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			feedbackBean.setEmail(userDetails.getUsername());
		}
		feedbackBean.setIp_address(request.getRemoteAddr());
		applicationServices.addServiceFeedBack(feedbackBean);
		return feedbackBean;
	}
	
	@RequestMapping(value = "/rest/toggleFavorite", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	public @ResponseBody void toggleFavorite(@RequestParam(value = "service_id") Long service_id) throws WISPServiceException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			applicationServices.toggleFavorite(service_id, userDetails.getUsername());
		}
	}
	
	@RequestMapping(value = "/rest/getAllComments", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	public @ResponseBody List<ServiceCommentsResponseBeans> getAllComments(@RequestParam(value = "service_id") Long service_id) throws WISPServiceException {
		return applicationServices.getServiceComments(service_id);
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String showLoginForm(@RequestParam(value = "error", required = false) boolean error,
			Model model, HttpServletRequest request) {
		UserRegistrationBean userBean = new UserRegistrationBean();
		model.addAttribute("bean", userBean);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
		    return "redirect:home";
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
		return "login";
	}
	
	@RequestMapping(value = "/faceBookLogin", method = RequestMethod.POST)
	public @ResponseBody AjaxResponseBean faceBookLogin(@RequestBody UserRegistrationBean bean, 
			Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) throws WISPServiceException {
		UserEntity user = applicationServices.getUserByUserEmail(bean.getEmail());
		AjaxResponseBean responseBean = new AjaxResponseBean();
		if(user != null) {
			if(bean.getFb_login_id() != null 
					&& bean.getProvider() != null 
					&& bean.getProvider().equals(SocialLoginProviders.FACEBOOK.name())) {
				if(user.getFb_login_id() != null && !user.getFb_login_id().isEmpty()) {
					if(bean.getFb_login_id().equals(user.getFb_login_id())) {
						autoLogin(user, request);
						responseBean.setRedirectUrl("home");
					}else {
						redirectAttributes.addAttribute("errors", "Not register with any social sites.");
						responseBean.setRedirectUrl("login");
					}
				} else {
					applicationServices.updateUser(bean);
					autoLogin(user, request);
					responseBean.setRedirectUrl("home");
				}
			} else if (bean.getGoogle_id() != null 
					&& bean.getProvider() != null 
					&& bean.getProvider().equals(SocialLoginProviders.GOOGLE.name())) {
				if(user.getGoogle_id() != null && !user.getGoogle_id().isEmpty()) {
					if(bean.getGoogle_id().equals(user.getGoogle_id())) {
						autoLogin(user, request);
						responseBean.setRedirectUrl("home");
					} else {
						redirectAttributes.addAttribute("errors", "Not register with any social sites.");
						responseBean.setRedirectUrl("login");
					}
				} else {
					applicationServices.updateUser(bean);
					autoLogin(user, request);
					responseBean.setRedirectUrl("home");
				}
			}else {
				redirectAttributes.addAttribute("errors", "wrong provider");
				responseBean.setRedirectUrl("login");
			}
			
		} else {
			responseBean.setBean(bean);
			responseBean.setRedirectUrl(null);
		}
		return responseBean;
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String showRegistrationForm(Model model) {
		UserRegistrationBean userBean = new UserRegistrationBean();
		model.addAttribute("bean", userBean);
		return "register";
	}
	
	@RequestMapping(value = "/ContactUs", method = RequestMethod.GET)
	public String showContactUspage(Model model) throws WISPServiceException{
		
		model.addAttribute("contactUs", new ContactUsBean());
		return "contactus";
	}
	
	@RequestMapping(value = "/ContactUs", method = RequestMethod.POST)
	public String showContactUspage(@ModelAttribute("contactUs") @Valid ContactUsBean bean,
			BindingResult result, Errors errors, Model model, RedirectAttributes redirectAttributes) throws WISPServiceException{
		if (result.hasErrors()) {
			model.addAttribute("error", "Please provide all the mandatory fields.");
			model.addAttribute("contactUs", bean);
			return "contactus";
		}
		applicationServices.addContactUsDetails(bean);
		redirectAttributes.addFlashAttribute("success", "ContactUs submitted successfully");
		return "redirect:/ContactUs";
	}
	
	@RequestMapping(value = "/rest/sendEnquiry", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	public @ResponseBody void sendEnquiryDetails(@RequestParam(value = "service_id") Long service_id,
			@RequestParam(value = "name") String name,
			@RequestParam(value = "email") String email,
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "description") String description,
			@RequestParam(value = "enquiry_date") Date enquiry_date) throws WISPServiceException{
		ServiceEnquiryBean bean = new ServiceEnquiryBean();
		bean.setName(name);
		bean.setEmail(email);
		bean.setPhone(phone);
		bean.setDescription(description);
		bean.setService_id(service_id);
		bean.setEnquiry_date(enquiry_date);
		applicationServices.addEnquiryDetails(bean);
	}
	
	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public String registerUserAccount(@ModelAttribute("user") @Valid UserRegistrationBean bean,
			BindingResult result, Errors errors, Model model, RedirectAttributes redirectAttributes){
		if (result.hasErrors()) {
			model.addAttribute("error", "Your form contains errors");
			bean.setPassword("");
			bean.setConfirm_password("");
			model.addAttribute("bean", bean);
			return "register";
		}
		try {
			bean.setRole(1L);
			applicationServices.registerNewUserAccount(bean);
			redirectAttributes.addFlashAttribute("success","Registration completed successfully.");
			return "redirect:/login";
		} catch (WISPServiceException e) {
			if(e.getErrorCode() == 1000){
				model.addAttribute("error", e.getMessage());
			} else {
				model.addAttribute("error", "Problem communicating with servers..try again");
			}
			bean.setEmail("");
			bean.setPassword("");
			bean.setConfirm_password("");
			model.addAttribute("bean", bean);
			return "register";
		}
	}
	
	@RequestMapping(value = "/socialregistration", method = RequestMethod.POST)
	public String registerUserAccountWithSocialAccount(@ModelAttribute("user") @Valid UserRegistrationBean bean,
			BindingResult result, Errors errors, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request){
		if (result.hasErrors()) {
			model.addAttribute("error", "Your form contains errors");
			bean.setPassword("");
			bean.setConfirm_password("");
			model.addAttribute("bean", bean);
			return "register";
		}
		try {
			bean.setRole(1L);
			applicationServices.registerNewUserAccount(bean);
			UserEntity user = applicationServices.getUserByUserEmail(bean.getEmail());
			autoLogin(user, request);
			return "redirect:/home";
		} catch (WISPServiceException e) {
			if(e.getErrorCode() == 1000){
				model.addAttribute("error", e.getMessage());
			} else {
				model.addAttribute("error", "Problem communicating with servers..try again");
			}
			bean.setEmail("");
			bean.setPassword("");
			bean.setConfirm_password("");
			model.addAttribute("bean", bean);
			return "register";
		}
	}
	
	@RequestMapping(value = "/forgotpassword", method= RequestMethod.GET)
	public String forgotPassword(Model model) throws WISPServiceException{
		model.addAttribute("forgotPass", new ForgotPasswordBeans());
		return "forgotpassword";
	}
	
	@RequestMapping(value = "/forgotpassword", method= RequestMethod.POST)
	public String forgotPassword(@Valid ForgotPasswordBeans forgotPass,
            BindingResult result, Model model, RedirectAttributes redirectAttributes) throws WISPServiceException{
		model.addAttribute("forgotPass", forgotPass);
		if (result.hasErrors()) {
			model.addAttribute("error", "Your form contains errors");
            return "forgotpassword";
        } else {
        	UserEntity user= applicationServices.getUserByUserEmail(forgotPass.getEmail());
        	if(user == null){
        		model.addAttribute("error", "User do not exits.");
        		model.addAttribute("forgotPass", new ForgotPasswordBeans());
				return "forgotpassword";
        	}else {
        		applicationServices.generatePasswordResetLink(forgotPass.getEmail());
        		redirectAttributes.addFlashAttribute("success","Details Sent Successfully.");
				return "redirect:login";
        	}
        }
	}
	
	@RequestMapping(value = "/resetpassword/{token}", method= RequestMethod.GET)
	public String resetPassword(@PathVariable(value="token") String token, Model model, RedirectAttributes redirectAttributes) 
			throws WISPServiceException{
		boolean isValidToken = applicationServices.isPasswordResetTokenValid(token);
		if(isValidToken){
			ResetPasswordBeans resetPasswordBeans = new ResetPasswordBeans();
			resetPasswordBeans.setToken(token);
			model.addAttribute("resetPass", resetPasswordBeans);
			return "resetpassword";
		} else {
			model.addAttribute("error", "It looks like you clicked on an invalid password reset link. Please try again.");
    		model.addAttribute("forgotPass", new ForgotPasswordBeans());
			return "forgotpassword";
		}
	}
	
	@RequestMapping(value = "/resetpassword", method= RequestMethod.POST)
	public String resetPassword(@Valid ResetPasswordBeans resetPasswordBeans,
            BindingResult result, Model model) throws WISPServiceException{
		if (result.hasErrors()) {
			model.addAttribute("error", result.getAllErrors().get(0).getDefaultMessage());
			model.addAttribute("resetPass", resetPasswordBeans);
            return "resetpassword";
        } else {
        	applicationServices.updateUserCredentials(resetPasswordBeans);
        	return "redirect:/login";
        }
	}
	
	@RequestMapping(value = "/changepass", method = RequestMethod.GET)
	public String changePassword(Model model) throws WISPServiceException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			ChangePasswordBean changePass = new ChangePasswordBean();
			model.addAttribute("changePass", changePass);
			return "changepass";
		}
		return "redirect:/login";
	}
	
	@RequestMapping(value = "/changepass", method = RequestMethod.POST)
	public String changePassword(@Valid ChangePasswordBean changePasswordBean,
			BindingResult result, Model model)  throws WISPServiceException{
		if (result.hasErrors()) {
			model.addAttribute("error", result.getAllErrors().get(0).getDefaultMessage());
			model.addAttribute("changePass", changePasswordBean);
			return "changepass";
		} else {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (!(auth instanceof AnonymousAuthenticationToken)) {
				UserDetails userDetails = (UserDetails) auth.getPrincipal();
				LOG_R.info("Logged In Email "+userDetails.getUsername());
				changePasswordBean.setEmail(userDetails.getUsername());
				try {
					applicationServices.changeUserCredentials(changePasswordBean);
					model.addAttribute("changePass", new ChangePasswordBean());
					model.addAttribute("success", "Password has changed successfully.");
					return "changepass";
				} catch (WISPServiceException e) {
					model.addAttribute("error", e.getMessage());
					model.addAttribute("changePass", new ChangePasswordBean());
					return "changepass";
				}
			}
		}
		return "redirect:/login";
	}
	
	@RequestMapping(value = "/simulateSearch", method = RequestMethod.GET)
	public @ResponseBody List<SearchResultsResponseBean> simulateSearch(@RequestParam("term") String tagName)  throws WISPServiceException {
		return applicationServices.simulateSearchResult(tagName);
	}
	
	@RequestMapping(value = "/goPrevious", method = RequestMethod.GET)
	public String goPrevious(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String targetUrl = "/home";
		if (session != null) {
			targetUrl = (String) request.getSession().getAttribute("previous_page");
		}
	    return "redirect:"+ targetUrl;
	}
	
	private void autoLogin(UserEntity user, HttpServletRequest request) {
		UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(user.getEmail(),user.getPassword());
	    // Authenticate the user
	    Authentication authentication = authenticationManager.authenticate(authRequest);
	    SecurityContext securityContext = SecurityContextHolder.getContext();
	    securityContext.setAuthentication(authentication);
	    sessionRegistry.registerNewSession(request.getSession().getId(), authentication.getPrincipal());
	    // Create a new session and add the security context.
	    HttpSession session = request.getSession(true);
	    session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
	}
	
	@RequestMapping(value = "/estimates", method = RequestMethod.GET)
	public String showEstimatesPage(Model model) throws WISPServiceException {
		List<String> city_list = applicationServices.getListOfCities();
		model.addAttribute("city_list", city_list);
		return "estimates";
	}
	
	@RequestMapping(value = "/offers", method = RequestMethod.GET)
	public String showOffersPage(Model model) throws WISPServiceException {
		List<String> city_list = applicationServices.getListOfCities();
		model.addAttribute("city_list", city_list);
		return "offers";
	}
}
