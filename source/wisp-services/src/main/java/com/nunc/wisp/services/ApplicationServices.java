package com.nunc.wisp.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.nunc.wisp.beans.ChangePasswordBean;
import com.nunc.wisp.beans.CustomErrorMessageBan;
import com.nunc.wisp.beans.ResetPasswordBeans;
import com.nunc.wisp.beans.SearchResultsResponseBean;
import com.nunc.wisp.beans.ServiceFeedBackBean;
import com.nunc.wisp.beans.UserRegistrationBean;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.MainSliderEntity;
import com.nunc.wisp.entities.ServiceCommentsEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.entities.UserFavoritesEntity;
import com.nunc.wisp.services.exception.WISPServiceException;

@Service
public interface ApplicationServices {
	
	public List<MainSliderEntity> getMainSliderImages() throws WISPServiceException;
	
	public void registerNewUserAccount(UserRegistrationBean bean) throws WISPServiceException;

	public UserEntity getUserByUserEmail(String email) throws WISPServiceException;

	public void generatePasswordResetLink(String email) throws WISPServiceException;

	public boolean isPasswordResetTokenValid(String token) throws WISPServiceException;

	public void updateUserCredentials(ResetPasswordBeans resetPasswordBeans) throws WISPServiceException;

	public List<ServiceListEntity> getMainPageServiceList(ServiceType serviceType) throws WISPServiceException;

	public List<ServiceListEntity> getListOfServices(ServiceType serviceType, Integer offset, Integer maxResults) throws WISPServiceException;

	public Long getServiceListCount(ServiceType serviceType) throws WISPServiceException;

	public ChangePasswordBean changeUserCredentials(ChangePasswordBean changePasswordBean) throws WISPServiceException;

	public ServiceListEntity getServiceIndetailed(ServiceType nameByCode, Long service_id) throws WISPServiceException;
	
	public List<UserFavoritesEntity> getUserFavoriteServices(String email, Integer offset, Integer maxResults) throws WISPServiceException;

	public Long getUserFavServiceListCount(String username) throws WISPServiceException;
	
	public ServiceCommentsEntity addServiceFeedBack(ServiceFeedBackBean feedbackBean) throws WISPServiceException;

	public void removeFromFavorite(Long service_id, String username) throws WISPServiceException;

	public CustomErrorMessageBan addToFavorite(Long service_id, String username) throws WISPServiceException;

	public List<SearchResultsResponseBean> simulateSearchResult(String tagName) throws WISPServiceException;

	public List<String> getListOfCities() throws WISPServiceException;
}
