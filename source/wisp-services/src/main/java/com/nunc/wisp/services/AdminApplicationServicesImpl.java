package com.nunc.wisp.services;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nunc.wisp.beans.ServiceStatusUpdateRequestBean;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.MainSliderEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.repository.AdminApplicationRepository;
import com.nunc.wisp.repository.ApplicationRepository;
import com.nunc.wisp.repository.exception.WISPDataAccessException;
import com.nunc.wisp.services.exception.WISPServiceException;

@Service("AdminApplicationServices")
public class AdminApplicationServicesImpl implements AdminApplicationServices {
	
	protected static final Logger LOG_R = Logger.getLogger(AdminApplicationServicesImpl.class);
	
	@Autowired
	@Qualifier("AdminApplicationRepository")
	AdminApplicationRepository adminApplicationRepository;
	
	@Autowired
	@Qualifier("ApplicationRepository")
	private ApplicationRepository applicationRepository;
	
	@Override
	@Transactional
	public Long getCountOfServicesToVerify() throws WISPServiceException {
		try {
			return adminApplicationRepository.getCountOfServicesToVerify();
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public List<ServiceListEntity> getListOfServicesToVerify(Integer offset,
			Integer maxResults) throws WISPServiceException {
		List<ServiceListEntity> results = null;
		try {
			results = adminApplicationRepository.getListOfServicesToVerify(offset, maxResults);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return results;
	}

	@Override
	@Transactional
	public ServiceListEntity getServiceIndetailed(ServiceType serviceType,
			Long service_id) throws WISPServiceException {
		ServiceListEntity result = null;
		try {
			result = adminApplicationRepository.getServiceIndetailed(serviceType, service_id);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return result;
	}

	@Override
	@Transactional
	public void updateServiceStatus(ServiceStatusUpdateRequestBean bean)
			throws WISPServiceException {
		try {
			
			ServiceListEntity service = adminApplicationRepository.getServiceIndetailedByID(bean.getService_id());
			if(service != null) {
				if(bean !=null && bean.getStatus()!= null){
					service.setApproval_status(bean.getStatus());
					adminApplicationRepository.updateServiceStatus(service);
				}
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public List<MainSliderEntity> getHomePageSliderImages()
			throws WISPServiceException {
		try {
			return adminApplicationRepository.getHomePageSliderImages();
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public MainSliderEntity createHomePageSliderImages(String name, String url,
			String description) throws WISPServiceException {
		MainSliderEntity entity = new MainSliderEntity();
		try {
			createMainSliderEntity(name, url, description, entity);
			adminApplicationRepository.createHomePageSliderImages(entity);
			return entity;
			
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	private MainSliderEntity createMainSliderEntity(String name, String url,
			String description, MainSliderEntity entity) throws WISPDataAccessException {
		entity.setSlider_url(url);
		entity.setSlider_name(name);
		entity.setSlider_description(description);
		entity.setSlider_status(0);
		entity.setSlider_order(adminApplicationRepository.getHighestOrder()+1);
		return entity;
	}

	@Override
	@Transactional
	public void deleteHomePageSlider(Long id) throws WISPServiceException {
		try {
			MainSliderEntity entity = adminApplicationRepository.getHomePageSliderById(id);
			if(entity != null){
				adminApplicationRepository.deleteHomePageSlider(entity);
			}
			
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public void updateBannerImageStatus(Long id) throws WISPServiceException {
		try {
			MainSliderEntity entity = adminApplicationRepository.getHomePageSliderById(id);
			if(entity != null){
				if(entity.getSlider_status() == 0){
					entity.setSlider_status(1);
				} else {
					entity.setSlider_status(0);
				}
				adminApplicationRepository.updateMainSliderEntity(entity);
			}
			
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public void updateMainSliderData(List<MainSliderEntity> mainSlider)
			throws WISPServiceException {
		try {
			if(mainSlider != null && mainSlider.size()>0) {
				adminApplicationRepository.updateMainSliderData(mainSlider);
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}
}
