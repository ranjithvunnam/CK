package com.nunc.wisp.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.nunc.wisp.beans.ServiceFilterRequestBean;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.MainSliderEntity;
import com.nunc.wisp.entities.PasswordResetTokenEntity;
import com.nunc.wisp.entities.ServiceCommentsEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.entities.UserFavoritesEntity;
import com.nunc.wisp.entities.UserRoleEntity;
import com.nunc.wisp.repository.exception.WISPDataAccessException;

@Repository
public interface ApplicationRepository {
	
	public List<MainSliderEntity> getMainSliderImages() throws WISPDataAccessException;

	public void registerNewUserAccount(UserEntity user) throws WISPDataAccessException;

	public boolean isUserAlreadyRegistered(String email) throws WISPDataAccessException;

	public UserEntity getUserByUserEmail(String email) throws WISPDataAccessException;

	public PasswordResetTokenEntity getUserPasswordResetTokens(String email) throws WISPDataAccessException;

	public void updatePasswordResetHash(PasswordResetTokenEntity resetTokenEntity) throws WISPDataAccessException;

	public PasswordResetTokenEntity isPasswordResetTokenExits(String token) throws WISPDataAccessException;

	public void updateUserCredentials(UserEntity userEntity) throws WISPDataAccessException;

	public void removePasswordResetToken(String token) throws WISPDataAccessException;

	public List<ServiceListEntity> getMainPageServiceList(ServiceType serviceType, String location) throws WISPDataAccessException;

	public List<ServiceListEntity> getListOfServices(ServiceFilterRequestBean bean, Integer offset, Integer maxResults) throws WISPDataAccessException;

	public Long getServiceListCount(ServiceFilterRequestBean bean) throws WISPDataAccessException;

	public ServiceListEntity getServiceIndetailed(ServiceType serviceType,	Long service_id) throws WISPDataAccessException;

	public List<UserFavoritesEntity> getUserFavoriteServices(Long id, Integer offset, Integer maxResults) throws WISPDataAccessException;

	public Long getUserFavServiceListCount(String email) throws WISPDataAccessException;

	public void addServiceFeedBack(ServiceCommentsEntity commentsEntity) throws WISPDataAccessException;

	public ServiceListEntity getServiceIndetailedById(Long service_id) throws WISPDataAccessException;

	public void removeFromFavorite(Long service_id, Long email) throws WISPDataAccessException;

	public void addToFavorite(Long service_id, Long id) throws WISPDataAccessException;

	public boolean checkUserFavouriteStatus(Long service_id, Long id) throws WISPDataAccessException;

	public UserRoleEntity getRoleDetailsById(Long role) throws WISPDataAccessException;

	public List<ServiceListEntity> simulateSearchResult(String searchQuery) throws WISPDataAccessException;

	public List<String> getListOfCities() throws WISPDataAccessException;
}
