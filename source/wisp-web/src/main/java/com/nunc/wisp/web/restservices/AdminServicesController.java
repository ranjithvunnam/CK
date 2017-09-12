package com.nunc.wisp.web.restservices;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;

import com.nunc.wisp.beans.ServiceStatusUpdateRequestBean;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.MainSliderEntity;
import com.nunc.wisp.entities.MainSliderResponseBean;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.services.AdminApplicationServices;
import com.nunc.wisp.services.exception.WISPServiceException;
import com.nunc.wisp.services.handlers.FileUploadService;
import com.nunc.wisp.services.handlers.SessionCounter;
import com.nunc.wisp.web.restservices.exception.handler.ResourceNotFoundException;

@Controller
@RequestMapping("/admin")
public class AdminServicesController {
	
	protected static final Logger LOG_R = Logger.getLogger(AdminServicesController.class);
	
	private String UPLOAD_BANNER_DIRECTORY = "C:\\Apache24\\htdocs\\wisp\\banner_images";
	
	private String DOWNLOAD_BANNER_DIRECTORY = "http://202.53.86.14/wisp/banner_images";
	
	@Autowired
	@Qualifier("AdminApplicationServices")
	private AdminApplicationServices adminApplicationServices;
	
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
	
	@Autowired
	private SessionCounter sessionCounter;
	
	@Autowired
	private FileUploadService fileUploadService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String redirectToAdminDashBoard() throws WISPServiceException {
		return "redirect:/admin/access";
	}
	
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
		model.addAttribute("offset", offset);
		model.addAttribute("services", vendor_service_list);
		model.addAttribute("sessionCount",sessionCounter.getActiveSessionNumber());
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
	
	@RequestMapping(value = "/marketing", method = RequestMethod.GET)
	public String marketing(Model model) throws WISPServiceException {
		List<MainSliderEntity> results = adminApplicationServices.getHomePageSliderImages();
		MainSliderResponseBean mainSliderResponseBean = new MainSliderResponseBean();
		mainSliderResponseBean.setMainSlider(results);
		model.addAttribute("mainSliderResponseBean", mainSliderResponseBean);
		return "admin/marketing";
	}
	
	@RequestMapping(value = "/analytics", method = RequestMethod.GET)
	public String analytics(Model model) throws WISPServiceException {
		
		return "admin/analytics";
	}
	
	@RequestMapping(value="/uploadImage",method=RequestMethod.POST)
	@ResponseBody
	public MainSliderEntity upload(@RequestParam("file") MultipartFile multipartFile) throws WISPServiceException{
		MainSliderEntity entity = new MainSliderEntity();
		if (!multipartFile.isEmpty()) {
			try {
				byte[] bytes = multipartFile.getBytes();
				File dir = new File(UPLOAD_BANNER_DIRECTORY + File.separator);
				if (!dir.exists())
					dir.mkdirs();
				// Create the file on server
				String url = UUID.randomUUID().toString()+"."+multipartFile.getOriginalFilename().split("\\.")[1];
				File serverFile = new File(dir.getAbsolutePath() + File.separator +url);
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();
				entity = adminApplicationServices.createHomePageSliderImages(multipartFile.getOriginalFilename().split("\\.")[0],DOWNLOAD_BANNER_DIRECTORY+"/"+url,"");
			} catch (IOException e) {
				throw new WISPServiceException("File was empty.", 1000);
			}
		} else {
			throw new WISPServiceException("File was empty.", 1000);
		}
		return entity;
	}
	
	@RequestMapping(value="/removeBannerImage",method=RequestMethod.POST)
	@ResponseBody
	public void deleteTempFile(@RequestParam("id") Long id, @RequestParam("filePath") String filePath, HttpSession session) throws WISPServiceException{
		
		try {
			URL dl = new URL(filePath);
			File fileToDelete = new File(UPLOAD_BANNER_DIRECTORY + "/" + FilenameUtils.getName(dl.getPath()));
			if(fileToDelete.exists() && fileToDelete.isFile()) {
				FileUtils.forceDelete(fileToDelete);
				adminApplicationServices.deleteHomePageSlider(id);
			} else {
				throw new WISPServiceException("File can't be deleted.", 1000);
			}
		} catch (IOException e) {
			throw new WISPServiceException(e.getMessage(), 1000);
		}
	}
	
	@RequestMapping(value = "/update_banner_status", method = RequestMethod.POST)
	@ResponseStatus(value = HttpStatus.OK)
	public void updateBannerImageStatus(@RequestParam("id") Long id) throws WISPServiceException {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			adminApplicationServices.updateBannerImageStatus(id);
		}
	}
	
	@RequestMapping(value = "/updateMainSliderData", method = RequestMethod.POST)
	public String updateSliderData(@ModelAttribute("mainSliderResponseBean") MainSliderResponseBean mainSliderResponseBean) throws WISPServiceException {
		adminApplicationServices.updateMainSliderData(mainSliderResponseBean.getMainSlider());
		return "redirect:/admin/marketing";
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
