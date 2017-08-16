package com.nunc.wisp.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.nunc.wisp.beans.ServiceStatusUpdateRequestBean;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.services.exception.WISPServiceException;

@Service
public interface AdminApplicationServices {

	public Long getCountOfServicesToVerify() throws WISPServiceException;

	public List<ServiceListEntity> getListOfServicesToVerify(Integer offset,
			Integer maxResults) throws WISPServiceException;

	public ServiceListEntity getServiceIndetailed(ServiceType nameByCode,
			Long service_id) throws WISPServiceException;

	public void updateServiceStatus(ServiceStatusUpdateRequestBean bean) throws WISPServiceException;
	
	
}
