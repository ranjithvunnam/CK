package com.nunc.wisp.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.MainSliderEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.repository.exception.WISPDataAccessException;

@Repository
public interface AdminApplicationRepository {

	public Long getCountOfServicesToVerify() throws WISPDataAccessException;

	public List<ServiceListEntity> getListOfServicesToVerify(Integer offset,
			Integer maxResults) throws WISPDataAccessException;

	public ServiceListEntity getServiceIndetailed(ServiceType serviceType,
			Long service_id) throws WISPDataAccessException;

	public void updateServiceStatus(ServiceListEntity service) throws WISPDataAccessException;

	public ServiceListEntity getServiceIndetailedByID(Long service_id) throws WISPDataAccessException;

	public List<MainSliderEntity> getHomePageSliderImages() throws WISPDataAccessException;

	public void createHomePageSliderImages(MainSliderEntity createMainSliderEntity) throws WISPDataAccessException;

	public Long getHighestOrder() throws WISPDataAccessException;

	public MainSliderEntity getHomePageSliderById(Long id) throws WISPDataAccessException;

	public void deleteHomePageSlider(MainSliderEntity entity) throws WISPDataAccessException;

	public void updateMainSliderEntity(MainSliderEntity entity) throws WISPDataAccessException;

	public void updateMainSliderData(List<MainSliderEntity> mainSlider) throws WISPDataAccessException;
	
}
