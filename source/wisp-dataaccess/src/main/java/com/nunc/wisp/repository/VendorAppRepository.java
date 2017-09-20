package com.nunc.wisp.repository;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.ServiceHitsEntity;
import com.nunc.wisp.entities.ServiceImagesEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.entities.ServiceVideosEntity;
import com.nunc.wisp.entities.utils.CitiesEntity;
import com.nunc.wisp.entities.utils.CountriesEntity;
import com.nunc.wisp.entities.utils.StatesEntity;
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

	public void deleteImageFromDB(ServiceImagesEntity imagesEntity) throws WISPDataAccessException;

	public ServiceImagesEntity getImageByUrl(Long service_id, String url) throws WISPDataAccessException;

	public List<ServiceHitsEntity> getAccessHistoryDetailsToDownload(Long service_id, Date from_date, Date to_date) throws WISPDataAccessException;

	public ServiceVideosEntity getVIdeoByUrl(Long service_id, String filePath) throws WISPDataAccessException;

	public void deleteVideoFromDB(ServiceVideosEntity entity) throws WISPDataAccessException;

	public List<CountriesEntity> getAllCountries() throws WISPDataAccessException;

	public CountriesEntity getCountryByName(String country_name) throws WISPDataAccessException;

	public StatesEntity getStateByName(String state_name) throws WISPDataAccessException;

	public Set<StatesEntity> getStatesByCountry(Long country_id) throws WISPDataAccessException;
	
	public Set<CitiesEntity> getCitiesByState(Long state_id) throws WISPDataAccessException;
}
