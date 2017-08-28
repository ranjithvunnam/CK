package com.nunc.wisp.web.restservices;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.nunc.wisp.beans.AjaxResponseBean;
import com.nunc.wisp.beans.ChangePasswordBean;
import com.nunc.wisp.beans.ForgotPasswordBeans;
import com.nunc.wisp.beans.ResetPasswordBeans;
import com.nunc.wisp.beans.UserRegistrationBean;
import com.nunc.wisp.beans.custom.validators.ServiceDemoghraphicDetailsValidator;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.beans.enums.SocialLoginProviders;
import com.nunc.wisp.beans.request.ServiceAmenityRequestBean;
import com.nunc.wisp.beans.request.ServiceCreationRequestBean;
import com.nunc.wisp.beans.request.ServiceImagesRequestBean;
import com.nunc.wisp.beans.request.ServiceVideosRequestBean;
import com.nunc.wisp.beans.vendor.ServiceAccessHitsResponseBean;
import com.nunc.wisp.entities.ServiceAmenitiyEntity;
import com.nunc.wisp.entities.ServiceImagesEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.entities.ServiceVideosEntity;
import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.services.ApplicationServices;
import com.nunc.wisp.services.VendorAppServices;
import com.nunc.wisp.services.exception.WISPServiceException;
import com.nunc.wisp.services.handlers.FileUploadService;
import com.nunc.wisp.web.restservices.exception.handler.MethodNotAllowedException;
import com.nunc.wisp.web.restservices.exception.handler.ResourceNotFoundException;

@Controller
@RequestMapping("/vendor")
@SessionAttributes("service_creation_bean")
public class VendorServicesController {
	
	protected static final Logger LOG_R = Logger.getLogger(VendorServicesController.class);
	
	@Autowired
	@Qualifier("ApplicationServices")
	private ApplicationServices applicationServices;
	
	@Autowired
	@Qualifier("VendorAppServices")
	private VendorAppServices vendorAppServices;
	
	@Autowired
	private FileUploadService fileUploadService;

	private ServiceDemoghraphicDetailsValidator validator;
	
	@Autowired
	@Qualifier("authenticationManager")
	AuthenticationManager authenticationManager;
	
	private String UPLOAD_TEMP_IMAGES_DIRECTORY = "C:\\Apache24\\htdocs\\wisp\\service_temp_images";
	private String ACCESS_TEMP_IMAGES_DIRECTORY = "http://202.53.86.11/wisp/service_temp_images/";
	
	private String UPLOAD_TEMP_VIDEOS_DIRECTORY = "C:\\Apache24\\htdocs\\wisp\\service_temp_videos";
	private String ACCESS_TEMP_VIDEOS_DIRECTORY = "http://202.53.86.11/wisp/service_temp_videos/";
	
	private String ACCESS_DEFAULT_THUMBNAIL_URL = "http://202.53.86.11/wisp/service_video_thumbnail/default_video_m.jpg";
	
	private static final List<String> contentTypes = Arrays.asList("image/png", "image/jpeg", "image/gif");
	
	@Autowired
	public VendorServicesController(ServiceDemoghraphicDetailsValidator validator) {
		super();
		this.validator = validator;
	}
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String index(Model model , Integer offset, Integer maxResults) throws WISPServiceException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			Long count = vendorAppServices.getCountOfServicesByVendorID(userDetails.getUsername());
			if(count > 0){
				List<ServiceListEntity>  vendor_service_list = vendorAppServices.getListOfServicesByVendorID(userDetails.getUsername(), offset, maxResults);
				model.addAttribute("count", count);
				model.addAttribute("services", vendor_service_list);
				return "vendor/vendor_service_list";
			}else{
				return "redirect:/vendor/getSRCreationForm";
			}
		}else{
			return "redirect:/vendor/getSRCreationForm";
		}
	}
	
	@RequestMapping(value = "/getSRCreationForm", method = RequestMethod.GET)
	public String getServiceCreationForm(Model model)  throws WISPServiceException {
		model.addAttribute("service_list", ServiceType.values());
		model.addAttribute("service_creation_bean", new ServiceCreationRequestBean());
		return "vendor/create_service";
	}
	
	@RequestMapping(value = "/{token}/{service_id}/service_details", method = RequestMethod.GET)
	public String showServiceIndetailed(@PathVariable(value="token") String token, @PathVariable(value="service_id") Long service_id, Model model) throws WISPServiceException{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		ServiceListEntity service_details = vendorAppServices.getVendorServiceIndetailed(ServiceType.getNameByCode(token),service_id);
		if(service_details == null) {
			throw new ResourceNotFoundException();
		}
		if(!service_details.getUser_service_entity().getEmail().equals(userDetails.getUsername())){
			throw new MethodNotAllowedException();
		}else {
			model.addAttribute("service_details", service_details);
			return "vendor/vendor_service_details";
		}
	}
	
	@RequestMapping(value="/getAccessHistory/{service_id}/{from_date}/{to_date}", method = RequestMethod.GET)
	public @ResponseBody List<ServiceAccessHitsResponseBean> getAccessHistoryDetails(@PathVariable Long service_id,
			@PathVariable @DateTimeFormat(iso=ISO.DATE) String from_date, @PathVariable @DateTimeFormat(iso=ISO.DATE) String to_date) throws WISPServiceException {
		return vendorAppServices.getAccessHistoryDetails(service_id, from_date, to_date);
	}
	
	@RequestMapping(value = "/create_service", method = RequestMethod.POST)
	public String createServiceDemoghraphicDetails(HttpServletRequest request,
			HttpServletResponse response, @ModelAttribute("service_creation_bean") ServiceCreationRequestBean requestBean, 
			BindingResult result, Model model, RedirectAttributes redirectAttributes, SessionStatus status, @RequestParam("_page") int currentPage) throws WISPServiceException {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		
		Map<Integer, String> pageForms = new HashMap<Integer, String>();
		pageForms.put(0, "vendor/create_service");
		pageForms.put(1, "vendor/create_service_media");
		pageForms.put(2, "vendor/create_service_preview");
		
		if (userClickedCancel(request)) {
			status.setComplete();
			return "redirect:/vendor/home";
		} else if (userIsFinished(request)) {
			validator.validateServiceDemoghraphicDetails(requestBean, result);
			if (result.hasErrors()) {
				return pageForms.get(currentPage);
			} else {
				requestBean.setRegistrationComplete(true);
				if(requestBean.getService_id() != null && vendorAppServices.getVendorServiceDetailsByID(requestBean) != null){
					for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
						imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
					}
					for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
						videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
					}
					vendorAppServices.updateServiceDemoghraphicDetails(requestBean, 1);
				} else {
					for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
						imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
					}
					for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
						videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
					}
					vendorAppServices.createServiceDemoghraphicDetails(requestBean, userDetails.getUsername(), 1);
				}
				status.setComplete();
				return "redirect:/vendor/home";
			}
		} else {
			if(userClickedSave1(request)) {
				validator.validateServiceDemoghraphicDetails(requestBean, result);
				if (result.hasErrors()) {
					model.addAttribute("service_list", ServiceType.values());
					model.addAttribute("errors", "Your form contains errors");
					model.addAttribute("service_creation_bean", requestBean);
					return pageForms.get(currentPage);
				} else {
					int targetPage = WebUtils.getTargetPage(request, "_target",	currentPage);
					requestBean.setRegistrationComplete(false);
					if(requestBean.getService_id() != null && vendorAppServices.getVendorServiceDetailsByID(requestBean) != null){
						for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
							imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
						}
						for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
							videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
						}
						vendorAppServices.updateServiceDemoghraphicDetails(requestBean, 0);
						model.addAttribute("service_list", ServiceType.values());
						model.addAttribute("service_creation_bean", requestBean);
						return pageForms.get(targetPage);
					} else {
						for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
							imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
						}
						for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
							videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
						}
						Long service_id = vendorAppServices.createServiceDemoghraphicDetails(requestBean, userDetails.getUsername(), 0);
						requestBean.setService_id(service_id);
						model.addAttribute("service_list", ServiceType.values());
						model.addAttribute("service_creation_bean", requestBean);
						return pageForms.get(targetPage);
					}
				}
			} else if(userClickedSave2(request)){
				validator.validateServiceMediaDetails(requestBean, result);
				if (result.hasErrors()) {
					model.addAttribute("service_list", ServiceType.values());
					model.addAttribute("errors", "Your form contains errors");
					model.addAttribute("service_creation_bean", requestBean);
					return pageForms.get(currentPage);
				} else {
					int targetPage = WebUtils.getTargetPage(request, "_target",	currentPage);
					requestBean.setRegistrationComplete(false);
					if(requestBean.getService_id() != null && vendorAppServices.getVendorServiceDetailsByID(requestBean) != null){
						for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
							imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
						}
						for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
							videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
						}
						vendorAppServices.updateServiceDemoghraphicDetails(requestBean, 0);
						model.addAttribute("service_list", ServiceType.values());
						model.addAttribute("service_creation_bean", requestBean);
						return pageForms.get(targetPage);
					} else {
						for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
							imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
						}
						for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
							videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
						}
						Long service_id = vendorAppServices.createServiceDemoghraphicDetails(requestBean, userDetails.getUsername(), 0);
						requestBean.setService_id(service_id);
						model.addAttribute("service_list", ServiceType.values());
						model.addAttribute("service_creation_bean", requestBean);
						return pageForms.get(targetPage);
					}
				}
			} else {
				int targetPage = WebUtils.getTargetPage(request, "_target",	currentPage);
				if (userClickedPrevious(currentPage, targetPage)) {
					return pageForms.get(targetPage);
				} else {
					switch (currentPage) {
					case 0:
						validator.validateServiceDemoghraphicDetails(requestBean, result);
						break;
					case 1:
						model.addAttribute("service_creation_bean", requestBean);
						validator.validateServiceMediaDetails(requestBean, result);
						break;
					}
					if (result.hasErrors()) {
						List<ObjectError> errr = result.getAllErrors();
						for(ObjectError eer: errr){
							LOG_R.info("Errroror : "+eer.getDefaultMessage());
						}
						model.addAttribute("service_list", ServiceType.values());
						model.addAttribute("errors", "Your form contains errors");
						model.addAttribute("service_creation_bean", requestBean);
						return pageForms.get(currentPage);
					} else {
						return pageForms.get(targetPage);
					}
				}
			}
		}
	}
	
	@RequestMapping(value="/uploadImage",method=RequestMethod.POST)
	@ResponseBody
	public String upload(@RequestParam("file") MultipartFile multipartFile, HttpSession session) throws WISPServiceException{
		ServiceCreationRequestBean srCreationBean = (ServiceCreationRequestBean) session.getAttribute("service_creation_bean");
		String url = null;
		String fileContentType = multipartFile.getContentType();
	    if(contentTypes.contains(fileContentType)) {
	    	List<ServiceImagesRequestBean> images = srCreationBean.getImagesBean();
			try {
				url = createTempImageFile(UUID.randomUUID().toString(), "."+multipartFile.getOriginalFilename().split("\\.")[1], multipartFile);
			} catch (IOException e) {
				
			}
			if(images == null){
				images = new ArrayList<ServiceImagesRequestBean>();
			}
			ServiceImagesRequestBean image = new ServiceImagesRequestBean();
			image.setUrl(url);
			images.add(image);
			srCreationBean.setImagesBean(images);
	    } else if(fileContentType.contains("video/")) {
	    	List<ServiceVideosRequestBean> videos = srCreationBean.getVideosBeans();
	    	try {
	    		url = createTempVideoFile(UUID.randomUUID().toString(), "."+multipartFile.getOriginalFilename().split("\\.")[1], multipartFile);
	    	} catch (IOException e) {
				throw new WISPServiceException(e);
			}
	    	if(videos == null){
	    		videos = new ArrayList<ServiceVideosRequestBean>();
			}
	    	ServiceVideosRequestBean video = new ServiceVideosRequestBean();
			video.setVideo_url(url);
    		video.setVideo_thumbnail(ACCESS_DEFAULT_THUMBNAIL_URL);
			videos.add(video);
			srCreationBean.setVideosBeans(videos);
			url = ACCESS_DEFAULT_THUMBNAIL_URL;
	    }
		return url;
	}
	
	@RequestMapping(value="/removeImage",method=RequestMethod.POST)
	@ResponseBody
	public void deleteTempFile(@RequestParam("filePath") String filePath, HttpSession session) throws WISPServiceException{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		ServiceCreationRequestBean srCreationBean = (ServiceCreationRequestBean) session.getAttribute("service_creation_bean");
	    if(isImageFile(filePath)) {
	    	boolean isDeleted = fileUploadService.deleteImageFile(filePath);
	    	if(isDeleted) {
	    		ServiceImagesRequestBean bean = new ServiceImagesRequestBean();
		    	bean.setUrl(filePath);
		    	if(srCreationBean.getImagesBean() != null) {
		    		srCreationBean.getImagesBean().remove(bean);
		    	}
		    	if(srCreationBean.getService_id() != null){
		    		vendorAppServices.updateServiceDemoghraphicDetails(srCreationBean, 0);
		    	} else {
		    		vendorAppServices.createServiceDemoghraphicDetails(srCreationBean, userDetails.getUsername(), 0);
		    	}
	    	}else {
	    		throw new WISPServiceException();
	    	}
	    }else if(isVideoFile(filePath)) {
	    	
	    }
	}

	private boolean isImageFile(String path) {
		String mimeType = URLConnection.guessContentTypeFromName(path);
		return mimeType != null && mimeType.startsWith("image");
	}

	private boolean isVideoFile(String path) {
		String mimeType = URLConnection.guessContentTypeFromName(path);
		return mimeType != null && mimeType.startsWith("video");
	}
	private String createTempImageFile(String prefix, String suffix, MultipartFile file) throws IOException, WISPServiceException{
		OutputStream outputStream = null;
		File tempFile = null;
		String tempFilePath = null;
		try {
			InputStream inputStream =  file.getInputStream();  
			tempFile = File.createTempFile(prefix, suffix, new File(UPLOAD_TEMP_IMAGES_DIRECTORY));
			outputStream = new FileOutputStream(tempFile);
			int read = 0;
			byte[] bytes = new byte[1024];

			while ((read = inputStream.read(bytes)) != -1) {
				outputStream.write(bytes, 0, read);
			}
			tempFilePath = ACCESS_TEMP_IMAGES_DIRECTORY+tempFile.getName();
		} catch (FileNotFoundException e) {
			throw new WISPServiceException(e);
		} finally {
			if(outputStream != null)
			outputStream.close();
		}
		return tempFilePath;
	}
	
	private String createTempVideoFile(String prefix, String suffix, MultipartFile file) throws IOException, WISPServiceException{
		OutputStream outputStream = null;
		File tempFile = null;
		String tempFilePath = null;
		try {
			InputStream inputStream =  file.getInputStream();  
			tempFile = File.createTempFile(prefix, suffix, new File(UPLOAD_TEMP_VIDEOS_DIRECTORY));
			outputStream = new FileOutputStream(tempFile);
			int read = 0;
			byte[] bytes = new byte[1024];

			while ((read = inputStream.read(bytes)) != -1) {
				outputStream.write(bytes, 0, read);
			}
			tempFilePath = ACCESS_TEMP_VIDEOS_DIRECTORY+tempFile.getName();
		} catch (FileNotFoundException e) {
			throw new WISPServiceException(e);
		} finally {
			if(outputStream != null)
			outputStream.close();
		}
		return tempFilePath;
	}
	
	@RequestMapping(value = "/{service_id}/edit_service", method = RequestMethod.GET)
	public String updateServiceDemoghraphicDetails(@PathVariable(value="service_id") Long service_id, Model model) throws WISPServiceException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		model.addAttribute("service_list", ServiceType.values());
		ServiceCreationRequestBean requestBean = new ServiceCreationRequestBean();
		requestBean.setService_id(service_id);
		ServiceListEntity entity = vendorAppServices.getVendorServiceDetailsByID(requestBean);
		if(entity == null) {
			throw new ResourceNotFoundException();
		}
		if(entity != null & !entity.getUser_service_entity().getEmail().equals(userDetails.getUsername())){
			throw new MethodNotAllowedException();
		}
		ServiceCreationRequestBean service_creation_bean = createServiceCreationRequestBean(entity, requestBean);
		model.addAttribute("service_creation_bean", service_creation_bean);
		return "vendor/edit_service";
		
	}
	
	private ServiceCreationRequestBean createServiceCreationRequestBean(ServiceListEntity entity, ServiceCreationRequestBean requestBean) {
		requestBean.setService_id(entity.getService_id());
		requestBean.setService_type(entity.getService_type());
		requestBean.setService_name(entity.getService_name());
		requestBean.setService_description(entity.getService_description());
		requestBean.setService_website(entity.getService_website());
		requestBean.setService_phone(entity.getService_phone());
		requestBean.setService_email(entity.getService_email());
		requestBean.setService_address1(entity.getAddressEntity().getAddress_1());
		requestBean.setService_address2(entity.getAddressEntity().getAddress_2());
		requestBean.setService_city(entity.getAddressEntity().getCity());
		requestBean.setService_state(entity.getAddressEntity().getState());
		requestBean.setService_country(entity.getAddressEntity().getCountry());
		requestBean.setService_pin(entity.getAddressEntity().getPincode());
		requestBean.setService_created(entity.getService_created());
		requestBean.setService_updated(entity.getService_updated());
		if(entity.getAmenitiyEntity() != null){
			ServiceAmenitiyEntity amenityEntity = entity.getAmenitiyEntity();
			ServiceAmenityRequestBean amenityBean = new ServiceAmenityRequestBean();
			amenityBean.setCapacity(amenityEntity.getCapacity());
			amenityBean.setRooms(amenityEntity.getRooms());
			amenityBean.setPrice(amenityEntity.getPrice());
			amenityBean.setParking(amenityEntity.isParking());
			amenityBean.setLiquor(amenityEntity.isLiquor());
			amenityBean.setAir_condition(amenityEntity.isAir_condition());
			amenityBean.setWifi(amenityEntity.isWifi());
			amenityBean.setType(amenityEntity.getType());
			amenityBean.setCusine(amenityEntity.getCusine());
			amenityBean.setOccasion(amenityEntity.getOccasion());
			amenityBean.setGender(amenityEntity.getGender());
			amenityBean.setDance_style(amenityEntity.getDance_style());
			amenityBean.setFleet(amenityEntity.getFleet());
			requestBean.setAmenityBean(amenityBean);
		}
		if(entity.getImagesEntities() != null){
			Set<ServiceImagesEntity> imagesEntity = entity.getImagesEntities();
			Set<ServiceImagesRequestBean> imagesBean = new HashSet<ServiceImagesRequestBean>();
			for(ServiceImagesEntity image : imagesEntity) {
				ServiceImagesRequestBean imageBean = new ServiceImagesRequestBean();
				imageBean.setImage_id(image.getImage_id());
				imageBean.setUrl(image.getImage_url());
				imagesBean.add(imageBean);
			}
			requestBean.setImagesBean(new ArrayList<ServiceImagesRequestBean>(imagesBean));
		}
		if(entity.getVideosEntities() != null){
			Set<ServiceVideosEntity> videosEntity = entity.getVideosEntities();
			Set<ServiceVideosRequestBean> videosBean = new HashSet<ServiceVideosRequestBean>();
			for(ServiceVideosEntity video : videosEntity) {
				ServiceVideosRequestBean videoBean = new ServiceVideosRequestBean();
				videoBean.setVideo_id(video.getVideo_id());
				videoBean.setVideo_url(video.getVideo_url());
				videoBean.setVideo_thumbnail(video.getVideo_thumbnail());
				videosBean.add(videoBean);
			}
			requestBean.setVideosBeans(new ArrayList<ServiceVideosRequestBean>(videosBean));
		}
		return requestBean;
	}
	
	@RequestMapping(value = "/update_service", method = RequestMethod.POST)
	public String updateServiceDemoghraphicDetails(HttpServletRequest request,
			HttpServletResponse response, @ModelAttribute("service_creation_bean") ServiceCreationRequestBean requestBean, 
			BindingResult result, Model model, RedirectAttributes redirectAttributes, SessionStatus status, @RequestParam("_page") int currentPage) throws WISPServiceException {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		
		Map<Integer, String> pageForms = new HashMap<Integer, String>();
		pageForms.put(0, "vendor/edit_service");
		pageForms.put(1, "vendor/edit_service_media");
		pageForms.put(2, "vendor/edit_service_preview");
		if (userClickedCancel(request)) {
			status.setComplete();
			return "redirect:/vendor/home";
		} else if (userIsFinished(request)) {
			validator.validateServiceDemoghraphicDetails(requestBean, result);
			if (result.hasErrors()) {
				return pageForms.get(currentPage);
			} else {
				requestBean.setRegistrationComplete(true);
				if(requestBean.getService_id() != null && vendorAppServices.getVendorServiceDetailsByID(requestBean) != null){
					for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
						imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
					}
					for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
						videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
					}
					vendorAppServices.updateServiceDemoghraphicDetails(requestBean, 1);
				} else {
					for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
						imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
					}
					for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
						videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
					}
					vendorAppServices.createServiceDemoghraphicDetails(requestBean, userDetails.getUsername(), 1);
				}
				status.setComplete();
				return "redirect:/vendor/home";
			}
		} else {
			if(userClickedSave1(request)) {
				validator.validateServiceDemoghraphicDetails(requestBean, result);
				if (result.hasErrors()) {
					model.addAttribute("service_list", ServiceType.values());
					model.addAttribute("errors", "Your form contains errors");
					model.addAttribute("service_creation_bean", requestBean);
					return pageForms.get(currentPage);
				} else {
					int targetPage = WebUtils.getTargetPage(request, "_target",	currentPage);
					requestBean.setRegistrationComplete(false);
					if(requestBean.getService_id() != null && vendorAppServices.getVendorServiceDetailsByID(requestBean) != null){
						for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
							imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
						}
						for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
							videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
						}
						vendorAppServices.updateServiceDemoghraphicDetails(requestBean, 0);
						model.addAttribute("service_list", ServiceType.values());
						model.addAttribute("service_creation_bean", requestBean);
						return pageForms.get(targetPage);
					} else {
						for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
							imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
						}
						for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
							videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
						}
						Long service_id = vendorAppServices.createServiceDemoghraphicDetails(requestBean, userDetails.getUsername(), 0);
						requestBean.setService_id(service_id);
						model.addAttribute("service_list", ServiceType.values());
						model.addAttribute("service_creation_bean", requestBean);
						return pageForms.get(targetPage);
					}
				}
			} else if(userClickedSave2(request)){
				validator.validateServiceMediaDetails(requestBean, result);
				if (result.hasErrors()) {
					model.addAttribute("service_list", ServiceType.values());
					model.addAttribute("errors", "Your form contains errors");
					model.addAttribute("service_creation_bean", requestBean);
					return pageForms.get(currentPage);
				} else {
					int targetPage = WebUtils.getTargetPage(request, "_target",	currentPage);
					requestBean.setRegistrationComplete(false);
					if(requestBean.getService_id() != null && vendorAppServices.getVendorServiceDetailsByID(requestBean) != null){
						for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
							imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
						}
						for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
							videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
						}
						vendorAppServices.updateServiceDemoghraphicDetails(requestBean, 0);
						model.addAttribute("service_list", ServiceType.values());
						model.addAttribute("service_creation_bean", requestBean);
						return pageForms.get(targetPage);
					} else {
						for(ServiceImagesRequestBean imageBean : requestBean.getImagesBean()){
							imageBean.setUrl(fileUploadService.uploadImages(imageBean.getUrl()));
						}
						for(ServiceVideosRequestBean videoBean : requestBean.getVideosBeans()){
							videoBean.setVideo_url(fileUploadService.uploadVideos(videoBean.getVideo_url()));
						}
						Long service_id = vendorAppServices.createServiceDemoghraphicDetails(requestBean, userDetails.getUsername(), 0);
						requestBean.setService_id(service_id);
						model.addAttribute("service_list", ServiceType.values());
						model.addAttribute("service_creation_bean", requestBean);
						return pageForms.get(targetPage);
					}
				}
			} else {
				int targetPage = WebUtils.getTargetPage(request, "_target",	currentPage);
				if (userClickedPrevious(currentPage, targetPage)) {
					return pageForms.get(targetPage);
				} else {
					switch (currentPage) {
					case 0:
						validator.validateServiceDemoghraphicDetails(requestBean, result);
						break;
					case 1:
						model.addAttribute("service_creation_bean", requestBean);
						validator.validateServiceMediaDetails(requestBean, result);
						break;
					}
					if (result.hasErrors()) {
						List<ObjectError> errr = result.getAllErrors();
						for(ObjectError eer: errr){
							LOG_R.info("Errroror : "+eer.getDefaultMessage());
						}
						model.addAttribute("service_list", ServiceType.values());
						model.addAttribute("errors", "Your form contains errors");
						model.addAttribute("service_creation_bean", requestBean);
						return pageForms.get(currentPage);
					} else {
						return pageForms.get(targetPage);
					}
				}
			}
		}
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String showLoginForm(@RequestParam(value = "error", required = false) boolean error,
			Model model, HttpServletRequest request) {
		UserRegistrationBean userBean = new UserRegistrationBean();
		model.addAttribute("bean", userBean);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
		    return "redirect:/vendor/home";
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
		return "vendor/login";
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
						responseBean.setRedirectUrl("vendor/home");
					}else {
						redirectAttributes.addAttribute("errors", "Not register with any social sites.");
						responseBean.setRedirectUrl("vendor/login");
					}
				} else {
					applicationServices.updateUser(bean);
					autoLogin(user, request);
					responseBean.setRedirectUrl("vendor/home");
				}
			} else if (bean.getGoogle_id() != null 
					&& bean.getProvider() != null 
					&& bean.getProvider().equals(SocialLoginProviders.GOOGLE.name())) {
				if(user.getGoogle_id() != null && !user.getGoogle_id().isEmpty()) {
					if(bean.getGoogle_id().equals(user.getGoogle_id())) {
						autoLogin(user, request);
						responseBean.setRedirectUrl("vendor/home");
					} else {
						redirectAttributes.addAttribute("errors", "Not register with any social sites.");
						responseBean.setRedirectUrl("vendor/login");
					}
				} else {
					applicationServices.updateUser(bean);
					autoLogin(user, request);
					responseBean.setRedirectUrl("vendor/home");
				}
			}else {
				redirectAttributes.addAttribute("errors", "wrong provider");
				responseBean.setRedirectUrl("vendor/login");
			}
			
		} else {
			responseBean.setBean(bean);
			responseBean.setRedirectUrl(null);
		}
		return responseBean;
	}
	
	@RequestMapping(value = "/socialregistration", method = RequestMethod.POST)
	public String registerUserAccountWithSocialAccount(@ModelAttribute("user") @Valid UserRegistrationBean bean,
			BindingResult result, Errors errors, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request){
		if (result.hasErrors()) {
			model.addAttribute("error", "Your form contains errors");
			bean.setPassword("");
			bean.setConfirm_password("");
			model.addAttribute("bean", bean);
			return "vendor/register";
		}
		try {
			bean.setRole(2L);
			applicationServices.registerNewUserAccount(bean);
			UserEntity user = applicationServices.getUserByUserEmail(bean.getEmail());
			autoLogin(user, request);
			return "redirect:/vendor/home";
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
			return "vendor/register";
		}
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String showRegistrationForm(Model model) {
		UserRegistrationBean userBean = new UserRegistrationBean();
		model.addAttribute("bean", userBean);
		return "vendor/register";
	}
	
	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public String registerUserAccount(@ModelAttribute("user") @Valid UserRegistrationBean bean,
			BindingResult result, Errors errors, Model model, RedirectAttributes redirectAttributes){
		if (result.hasErrors()) {
			model.addAttribute("error", "Your form contains errors");
			bean.setPassword("");
			bean.setConfirm_password("");
			model.addAttribute("bean", bean);
			return "vendor/register";
		}
		try {
			bean.setRole(2L);
			applicationServices.registerNewUserAccount(bean);
			redirectAttributes.addFlashAttribute("success","Registration completed successfully.");
			return "redirect:/vendor/login";
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
			return "vendor/register";
		}
	}
	
	@RequestMapping(value = "/forgotpassword", method= RequestMethod.GET)
	public String forgotPassword(Model model) throws WISPServiceException{
		model.addAttribute("forgotPass", new ForgotPasswordBeans());
		return "vendor/forgotpassword";
	}
	
	@RequestMapping(value = "/forgotpassword", method= RequestMethod.POST)
	public String forgotPassword(@Valid ForgotPasswordBeans forgotPass,
            BindingResult result, Model model, RedirectAttributes redirectAttributes) throws WISPServiceException{
		model.addAttribute("forgotPass", forgotPass);
		if (result.hasErrors()) {
			model.addAttribute("error", "Your form contains errors");
            return "vendor/forgotpassword";
        } else {
        	UserEntity user= applicationServices.getUserByUserEmail(forgotPass.getEmail());
        	if(user == null){
        		model.addAttribute("error", "User do not exits.");
        		model.addAttribute("forgotPass", new ForgotPasswordBeans());
				return "vendor/forgotpassword";
        	}else {
        		applicationServices.generatePasswordResetLink(forgotPass.getEmail());
        		redirectAttributes.addFlashAttribute("success","Details Sent Successfully.");
				return "redirect:/vendor/login";
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
			return "vendor/resetpassword";
		} else {
			model.addAttribute("error", "It looks like you clicked on an invalid password reset link. Please try again.");
    		model.addAttribute("forgotPass", new ForgotPasswordBeans());
			return "vendor/forgotpassword";
		}
	}
	
	@RequestMapping(value = "/resetpassword", method= RequestMethod.POST)
	public String resetPassword(@Valid ResetPasswordBeans resetPasswordBeans,
            BindingResult result, Model model) throws WISPServiceException{
		if (result.hasErrors()) {
			model.addAttribute("error", result.getAllErrors().get(0).getDefaultMessage());
			model.addAttribute("resetPass", resetPasswordBeans);
            return "vendor/resetpassword";
        } else {
        	applicationServices.updateUserCredentials(resetPasswordBeans);
        	return "redirect:/vendor/login";
        }
	}
	
	@RequestMapping(value = "/changepass", method = RequestMethod.GET)
	public String changePassword(Model model) throws WISPServiceException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			ChangePasswordBean changePass = new ChangePasswordBean();
			model.addAttribute("changePass", changePass);
			return "vendor/changepass";
		}
		return "redirect:/vendor/login";
	}
	
	@RequestMapping(value = "/changepass", method = RequestMethod.POST)
	public String changePassword(@Valid ChangePasswordBean changePasswordBean,
			BindingResult result, Model model){
		if (result.hasErrors()) {
			model.addAttribute("error", result.getAllErrors().get(0).getDefaultMessage());
			model.addAttribute("changePass", changePasswordBean);
			return "vendor/changepass";
		} else {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (!(auth instanceof AnonymousAuthenticationToken)) {
				UserDetails userDetails = (UserDetails) auth.getPrincipal();
				changePasswordBean.setEmail(userDetails.getUsername());
				try {
					applicationServices.changeUserCredentials(changePasswordBean);
					model.addAttribute("changePass", new ChangePasswordBean());
					model.addAttribute("success", "Password has changed successfully.");
					return "vendor/changepass";
				} catch (WISPServiceException e) {
					model.addAttribute("error", e.getMessage());
					model.addAttribute("changePass", new ChangePasswordBean());
					return "vendor/changepass";
				}
			}
		}
		return "redirect:/vendor/login";
	}
	
	private boolean userClickedCancel(HttpServletRequest request) {
		return request.getParameter("_cancel") != null;
	}
	
	private boolean userClickedSave1(HttpServletRequest request) {
		return request.getParameter("_save1") != null;
	}
	
	private boolean userClickedSave2(HttpServletRequest request) {
		return request.getParameter("_save2") != null;
	}
	
	private boolean userIsFinished(HttpServletRequest request) {
		return request.getParameter("_finish") != null;
	}
	
	private boolean userClickedPrevious(int currentPage, int targetPage) {
		return targetPage < currentPage;
	}
	
	private void autoLogin(UserEntity user, HttpServletRequest request) {
		UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(user.getEmail(),user.getPassword());
	    // Authenticate the user
	    Authentication authentication = authenticationManager.authenticate(authRequest);
	    SecurityContext securityContext = SecurityContextHolder.getContext();
	    securityContext.setAuthentication(authentication);
	    // Create a new session and add the security context.
	    HttpSession session = request.getSession(true);
	    session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
	}
}
