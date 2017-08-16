package com.nunc.wisp.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.ServiceHitsEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.repository.exception.WISPDataAccessException;

@Repository
public interface VendorAppRepository {

	public Long createServiceDemoghraphicDetails(ServiceListEntity serviceListEntity) throws WISPDataAccessException;

	public void updateServiceDemoghraphicDetails(
			ServiceListEntity createServiceEntityWithDemoghraphicDetails) throws WISPDataAccessException;

	public ServiceListEntity getVendorServiceDetailsByID(Long service_id) throws WISPDataAccessException;

	public List<ServiceListEntity> getListOfServicesByVendorID(String email, Integer offset, Integer maxResults) throws WISPDataAccessException;

	public Long getCountOfServicesByVendorID(String email) throws WISPDataAccessException;

	public ServiceListEntity getVendorServiceIndetailed(
			ServiceType serviceType, Long service_id) throws WISPDataAccessException;

	public List<Object[]> getAccessHistoryDetails(Long service_id, String from_date, String to_date) throws WISPDataAccessException;

	public void setAccessHistoryDetails(ServiceHitsEntity hitsEntity) throws WISPDataAccessException;

}
