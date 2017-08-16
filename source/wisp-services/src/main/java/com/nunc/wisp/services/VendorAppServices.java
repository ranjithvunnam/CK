package com.nunc.wisp.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.beans.request.ServiceCreationRequestBean;
import com.nunc.wisp.beans.vendor.ServiceAccessHitsResponseBean;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.services.exception.WISPServiceException;

@Service
public interface VendorAppServices {
	
	public List<ServiceListEntity> getListOfServicesByVendorID(String email, Integer offset, Integer maxResults) throws WISPServiceException;

	public Long createServiceDemoghraphicDetails(ServiceCreationRequestBean requestBean, String email,Integer status) throws WISPServiceException;

	public void updateServiceDemoghraphicDetails(ServiceCreationRequestBean requestBean,Integer status) throws WISPServiceException;

	public ServiceListEntity getVendorServiceDetailsByID(ServiceCreationRequestBean requestBean) throws WISPServiceException;
	
	public Long getCountOfServicesByVendorID(String email) throws WISPServiceException;

	public ServiceListEntity getVendorServiceIndetailed(ServiceType nameByCode,	Long service_id) throws WISPServiceException;

	public List<ServiceAccessHitsResponseBean> getAccessHistoryDetails(Long service_id, String from_date, String to_date) throws WISPServiceException;

	public void setAccessHistoryDetails(Long service_id, String remoteAddr) throws WISPServiceException;
}
