package com.nunc.wisp.services;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nunc.wisp.beans.ServiceStatusUpdateRequestBean;
import com.nunc.wisp.beans.enums.ServiceType;
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
}
