package com.nunc.wisp.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.beans.request.ServiceCreationRequestBean;
import com.nunc.wisp.beans.request.ServiceImagesRequestBean;
import com.nunc.wisp.beans.request.ServiceVideosRequestBean;
import com.nunc.wisp.beans.vendor.ServiceAccessHitsResponseBean;
import com.nunc.wisp.entities.ServiceAmenitiyEntity;
import com.nunc.wisp.entities.ServiceHitsEntity;
import com.nunc.wisp.entities.ServiceImagesEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.entities.ServiceVideosEntity;
import com.nunc.wisp.entities.ServicesAddressEntity;
import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.repository.ApplicationRepository;
import com.nunc.wisp.repository.VendorAppRepository;
import com.nunc.wisp.repository.exception.WISPDataAccessException;
import com.nunc.wisp.services.exception.WISPServiceException;

@Service("VendorAppServices")
public class VendorAppServicesImpl implements VendorAppServices {
	
	protected static final Logger LOG_R = Logger.getLogger(VendorAppServicesImpl.class);
	
	@Autowired
	@Qualifier("VendorAppRepository")
	VendorAppRepository vendorAppRepository;
	
	@Autowired
	@Qualifier("ApplicationRepository")
	private ApplicationRepository applicationRepository;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public Long createServiceDemoghraphicDetails(ServiceCreationRequestBean requestBean, String email, Integer status) throws WISPServiceException {
		Long id= null;
		try {
			UserEntity user = applicationRepository.getUserByUserEmail(email);
			if(user != null){
				id = vendorAppRepository.createServiceDemoghraphicDetails(createServiceEntityWithDemoghraphicDetails(requestBean, user, status));
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return id;
	}

	private ServiceListEntity createServiceEntityWithDemoghraphicDetails(ServiceCreationRequestBean requestBean, UserEntity user, Integer status) {
		//Service
		ServiceListEntity service = new ServiceListEntity();
		service.setService_type(requestBean.getService_type());
		service.setService_name(requestBean.getService_name());
		service.setService_description(requestBean.getService_description());
		service.setService_website(requestBean.getService_website());
		service.setService_phone(requestBean.getService_phone());
		service.setService_email(requestBean.getService_email());
		service.setApproval_status(status);
		service.setService_created(new Date());
		service.setService_updated(new Date());
		
		//user
		service.setUser_service_entity(user);
		
		//Address
		ServicesAddressEntity address = new ServicesAddressEntity();
		address.setAddress_1(requestBean.getService_address1());
		address.setAddress_2(requestBean.getService_address2());
		address.setCity(requestBean.getService_city());
		address.setCountry(requestBean.getService_country());
		address.setPincode(requestBean.getService_pin());
		address.setState(requestBean.getService_state());
		
		service.setAddressEntity(address);
		address.setServiceListEntity(service);
		
		//Amenities
		if(requestBean.getAmenityBean() != null) {
			ServiceAmenitiyEntity amenity = new ServiceAmenitiyEntity();
			amenity.setCapacity(requestBean.getAmenityBean().getCapacity());
			amenity.setRooms(requestBean.getAmenityBean().getRooms());
			amenity.setPrice(requestBean.getAmenityBean().getPrice());
			amenity.setParking(requestBean.getAmenityBean().isParking());
			amenity.setLiquor(requestBean.getAmenityBean().isLiquor());
			amenity.setAir_condition(requestBean.getAmenityBean().isAir_condition());
			amenity.setWifi(requestBean.getAmenityBean().isWifi());
			amenity.setType(requestBean.getAmenityBean().getType());
			amenity.setCusine(requestBean.getAmenityBean().getCusine());
			amenity.setOccasion(requestBean.getAmenityBean().getOccasion());
			amenity.setGender(requestBean.getAmenityBean().getGender());
			amenity.setDance_style(requestBean.getAmenityBean().getDance_style());
			amenity.setFleet(requestBean.getAmenityBean().getFleet());
			service.setAmenitiyEntity(amenity);
			amenity.setService_list_amenities(service);
		}
		//Images
		if(requestBean.getImagesBean() != null) {
			Set<ServiceImagesEntity> imagesEntities = new HashSet<ServiceImagesEntity>();
			ServiceImagesEntity image = null;
			for(ServiceImagesRequestBean images : requestBean.getImagesBean()) {
				image = new ServiceImagesEntity();
				image.setImage_url(images.getUrl());
				image.setImage_description(images.getDescription());
				image.setService_image_list_entity(service);
				imagesEntities.add(image);
			}
			service.setImagesEntities(imagesEntities);
		}
		//Videos
		if(requestBean.getVideosBeans() != null) {
			Set<ServiceVideosEntity> videosEntities = new HashSet<ServiceVideosEntity>();
			ServiceVideosEntity video = null;
			for(ServiceVideosRequestBean videos : requestBean.getVideosBeans()) {
				video = new ServiceVideosEntity();
				video.setVideo_url(videos.getVideo_url());
				video.setVideo_thumbnail(videos.getVideo_thumbnail());
				video.setVideo_description(videos.getVideo_desc());
				video.setService_video_list_entity(service);
				videosEntities.add(video);
			}
			service.setVideosEntities(videosEntities);
		}
		return service;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public void updateServiceDemoghraphicDetails(ServiceCreationRequestBean requestBean,Integer status) throws WISPServiceException {
		try {
			ServiceListEntity entity = vendorAppRepository.getVendorServiceDetailsByID(requestBean.getService_id());
			if(entity != null) {
				vendorAppRepository.updateServiceDemoghraphicDetails(updateServiceEntityDetails(requestBean, entity, status));
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public ServiceListEntity getVendorServiceDetailsByID(
			ServiceCreationRequestBean requestBean) throws WISPServiceException {
		ServiceListEntity entity = null;
		try {
			entity = vendorAppRepository.getVendorServiceDetailsByID(requestBean.getService_id());
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return entity;
	}

	@Override
	@Transactional
	public List<ServiceListEntity> getListOfServicesByVendorID(String email,
			Integer offset, Integer maxResults) throws WISPServiceException {
		try {
				return vendorAppRepository.getListOfServicesByVendorID(email, offset, maxResults);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public Long getCountOfServicesByVendorID(String email) throws WISPServiceException {
		try {
			return vendorAppRepository.getCountOfServicesByVendorID(email);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public ServiceListEntity getVendorServiceIndetailed(ServiceType serviceType, Long service_id) throws WISPServiceException {
		ServiceListEntity result = null;
		try {
			result = vendorAppRepository.getVendorServiceIndetailed(serviceType, service_id);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return result;
	}

	@Override
	@Transactional
	public List<ServiceAccessHitsResponseBean> getAccessHistoryDetails(Long service_id, String from_date, String to_date)
			throws WISPServiceException {
		List<Object[]> result = new ArrayList<Object[]>();
		List<ServiceAccessHitsResponseBean> beans = new ArrayList<ServiceAccessHitsResponseBean>();
		try {
			result = vendorAppRepository.getAccessHistoryDetails(service_id, from_date, to_date);
			if(result != null && result.size() > 0){
				for(Object[] node : result){
					String [] dateParts = node[0].toString().split("-");
					ServiceAccessHitsResponseBean bean = new ServiceAccessHitsResponseBean();
					bean.setYear(Integer.parseInt(dateParts[0]));
					bean.setMonth(Integer.parseInt(dateParts[1]));
					bean.setDay(Integer.parseInt(dateParts[2]));
					bean.setHits_count(Integer.parseInt(node[1].toString()));
					beans.add(bean);
				}
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return beans;
	}

	@Override
	@Transactional
	public void setAccessHistoryDetails(Long service_id, String ip_address) throws WISPServiceException {
		try {
			ServiceListEntity slEntity = applicationRepository.getServiceIndetailedById(service_id);
			if(slEntity != null) {
				LOG_R.info(slEntity.getService_id());
				vendorAppRepository.setAccessHistoryDetails(createServiceHistoryEntity(slEntity, ip_address));
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	private ServiceHitsEntity createServiceHistoryEntity(ServiceListEntity slEntity, String ip_address) {
		ServiceHitsEntity hitsEntity = new ServiceHitsEntity();
		hitsEntity.setService_list_hits_entity(slEntity);
		hitsEntity.setIp_address(ip_address);
		hitsEntity.setTimestamp(new Date());
		return hitsEntity;
	}

	private ServiceListEntity updateServiceEntityDetails(ServiceCreationRequestBean requestBean, ServiceListEntity service, Integer status ) {
		//Service
		service.setService_type(requestBean.getService_type());
		service.setService_name(requestBean.getService_name());
		service.setService_description(requestBean.getService_description());
		service.setService_website(requestBean.getService_website());
		service.setService_phone(requestBean.getService_phone());
		service.setService_email(requestBean.getService_email());
		service.setApproval_status(status);
		service.setService_created(requestBean.getService_created());
		service.setService_updated(new Date());
		
		//Address
		ServicesAddressEntity address = service.getAddressEntity();
		address.setAddress_1(requestBean.getService_address1());
		address.setAddress_2(requestBean.getService_address2());
		address.setCity(requestBean.getService_city());
		address.setCountry(requestBean.getService_country());
		address.setPincode(requestBean.getService_pin());
		address.setState(requestBean.getService_state());
		
		service.setAddressEntity(address);
		address.setServiceListEntity(service);
		
		//Amenities
		if(requestBean.getAmenityBean() != null) {
			ServiceAmenitiyEntity amenity = service.getAmenitiyEntity();
			amenity.setCapacity(requestBean.getAmenityBean().getCapacity());
			amenity.setRooms(requestBean.getAmenityBean().getRooms());
			amenity.setPrice(requestBean.getAmenityBean().getPrice());
			amenity.setParking(requestBean.getAmenityBean().isParking());
			amenity.setLiquor(requestBean.getAmenityBean().isLiquor());
			amenity.setAir_condition(requestBean.getAmenityBean().isAir_condition());
			amenity.setWifi(requestBean.getAmenityBean().isWifi());
			amenity.setType(requestBean.getAmenityBean().getType());
			amenity.setCusine(requestBean.getAmenityBean().getCusine());
			amenity.setOccasion(requestBean.getAmenityBean().getOccasion());
			amenity.setGender(requestBean.getAmenityBean().getGender());
			amenity.setDance_style(requestBean.getAmenityBean().getDance_style());
			amenity.setFleet(requestBean.getAmenityBean().getFleet());
			service.setAmenitiyEntity(amenity);
			amenity.setService_list_amenities(service);
		}
		// Images
		if (requestBean.getImagesBean() != null) {
			Set<ServiceImagesEntity> imagesEntities = service.getImagesEntities();
			ServiceImagesEntity image = null;
			for (ServiceImagesRequestBean images : requestBean.getImagesBean()) {
				image = new ServiceImagesEntity();
				image.setImage_url(images.getUrl());
				image.setImage_description(images.getDescription());
				image.setService_image_list_entity(service);
				imagesEntities.add(image);
			}
			service.setImagesEntities(imagesEntities);
		}
		// Videos
		if (requestBean.getVideosBeans() != null) {
			Set<ServiceVideosEntity> videosEntities = service.getVideosEntities();
			ServiceVideosEntity video = null;
			for (ServiceVideosRequestBean videos : requestBean.getVideosBeans()) {
				video = new ServiceVideosEntity();
				video.setVideo_url(videos.getVideo_url());
				video.setVideo_thumbnail(videos.getVideo_thumbnail());
				video.setVideo_description(videos.getVideo_desc());
				video.setService_video_list_entity(service);
				videosEntities.add(video);
			}
			service.setVideosEntities(videosEntities);
		}
		return service;
	}
}
