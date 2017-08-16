package com.nunc.wisp.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.nunc.wisp.beans.ChangePasswordBean;
import com.nunc.wisp.beans.CustomErrorMessageBan;
import com.nunc.wisp.beans.ResetPasswordBeans;
import com.nunc.wisp.beans.SearchResultsResponseBean;
import com.nunc.wisp.beans.ServiceFeedBackBean;
import com.nunc.wisp.beans.UserRegistrationBean;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.MainSliderEntity;
import com.nunc.wisp.entities.PasswordResetTokenEntity;
import com.nunc.wisp.entities.ServiceCommentsEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.entities.UserFavoritesEntity;
import com.nunc.wisp.repository.ApplicationRepository;
import com.nunc.wisp.repository.VendorAppRepository;
import com.nunc.wisp.repository.exception.WISPDataAccessException;
import com.nunc.wisp.services.exception.WISPServiceException;
import com.nunc.wisp.services.mailutils.Emailer;

@Service("ApplicationServices")
public class ApplicationServicesImpl implements ApplicationServices {

	protected static final Logger LOG_R = Logger.getLogger(ApplicationServicesImpl.class);
	
	private int PASSWORD_RESET_TOKEN_EXPIRE_TIME = 1440;
	
	@Autowired
	@Qualifier("ApplicationRepository")
	private ApplicationRepository applicationRepository;
	
	@Autowired
	@Qualifier("VendorAppRepository")
	VendorAppRepository vendorAppRepository;
	
	@Autowired
	Emailer emailer;
	
	@Autowired
	@Qualifier("encoder")
	private PasswordEncoder encoder;

	@Override
	@Transactional
	public List<MainSliderEntity> getMainSliderImages() throws WISPServiceException {
		List<MainSliderEntity> results = null;
		try {
			results = applicationRepository.getMainSliderImages();
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return results;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public void registerNewUserAccount(UserRegistrationBean bean) throws WISPServiceException {
		try {
			if (applicationRepository.isUserAlreadyRegistered(bean.getEmail())) {
				// TODO
				throw new WISPServiceException("Email already in use.", 1000);
			}
			UserEntity user_entity = createUserEntity(bean);
			user_entity.setUser_role_entity(applicationRepository.getRoleDetailsById(bean.getRole()));
			LOG_R.info("Role details "+user_entity.getUser_role_entity().getRole_name());
			applicationRepository.registerNewUserAccount(user_entity);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	/**
	 * @param bean
	 * @return
	 */
	private UserEntity createUserEntity(UserRegistrationBean bean) {
		UserEntity entity = new UserEntity();
		entity.setCreatedDate(new Date());
		entity.setEmail(bean.getEmail());
		entity.setFirst_name(bean.getFirst_name());
		entity.setLast_name(bean.getLast_name());
		entity.setPassword(encoder.encode(bean.getPassword()));
		entity.setPhone_primary(bean.getPhone_primary());
		entity.setPhone_secondary(bean.getPhone_secondary());
		entity.setUpdatedDate(new Date());
		return entity;
	}

	@Override
	@Transactional
	public UserEntity getUserByUserEmail(String email) throws WISPServiceException {
		UserEntity user = null;
		try {
			user = applicationRepository.getUserByUserEmail(email);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return user;
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public void generatePasswordResetLink(String email) throws WISPServiceException {
		// TODO Auto-generated method stub
		try{
			PasswordResetTokenEntity resetTokenEntity = applicationRepository.getUserPasswordResetTokens(email);
			String hasedToken = UUID.randomUUID().toString();
			Date expiryDate = addMinutesToDate(PASSWORD_RESET_TOKEN_EXPIRE_TIME, new Date());
			if(resetTokenEntity != null){
				resetTokenEntity.setToken(hasedToken);
				resetTokenEntity.setExpiryDate(expiryDate);
				applicationRepository.updatePasswordResetHash(resetTokenEntity);
			}else {
				applicationRepository.updatePasswordResetHash(creatPasswordResetTokenEntity(hasedToken, expiryDate, email));
			}
			emailer.send("Password Reset link", hasedToken, email, email);
		}catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		} catch (MessagingException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), 3000);
		}
	}
	
	private PasswordResetTokenEntity creatPasswordResetTokenEntity(String hasedToken, Date expiryDate, String email) {
		PasswordResetTokenEntity entity= new PasswordResetTokenEntity();
		entity.setToken(hasedToken);
		entity.setExpiryDate(expiryDate);
		entity.setEmail(email);
		return entity;
	}
	
	private Date addMinutesToDate(int minutes, Date beforeTime){
	    final long ONE_MINUTE_IN_MILLIS = 60000;
	    long curTimeInMs = beforeTime.getTime();
	    Date afterAddingMins = new Date(curTimeInMs + (minutes * ONE_MINUTE_IN_MILLIS));
	    return afterAddingMins;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public boolean isPasswordResetTokenValid(String token)
			throws WISPServiceException {
		boolean isValid = false;
		try {
			PasswordResetTokenEntity entity= applicationRepository.isPasswordResetTokenExits(token);
			if(entity != null && new Date().before(entity.getExpiryDate())){
				isValid = true;
			}
			
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return isValid;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public void updateUserCredentials(ResetPasswordBeans resetPasswordBeans)
			throws WISPServiceException {
		try {
			PasswordResetTokenEntity entity = applicationRepository.isPasswordResetTokenExits(resetPasswordBeans.getToken());
			if(entity != null) {
				UserEntity userEntity= applicationRepository.getUserByUserEmail(entity.getEmail());
				userEntity.setPassword(encoder.encode(resetPasswordBeans.getPassword()));
				userEntity.setUpdatedDate(new Date());
				applicationRepository.updateUserCredentials(userEntity);
				applicationRepository.removePasswordResetToken(resetPasswordBeans.getToken());
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}
	
	@Override
	@Transactional
	public ChangePasswordBean changeUserCredentials(
			ChangePasswordBean changePasswordBean) throws WISPServiceException {
		try {
			UserEntity entity = applicationRepository.getUserByUserEmail(changePasswordBean.getEmail());
			if(entity != null && ! encoder.matches(changePasswordBean.getOldPassword(), entity.getPassword())) {
				throw new WISPServiceException("Please enter correct old password", 1004);
			}
			entity.setPassword(encoder.encode(changePasswordBean.getPassword()));
			applicationRepository.updateUserCredentials(entity);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return changePasswordBean;
	}
	
	@Override
	@Transactional
	public List<ServiceListEntity> getMainPageServiceList(ServiceType serviceType) throws WISPServiceException {
		List<ServiceListEntity> results = null;
		try {
			results = applicationRepository.getMainPageServiceList(serviceType);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return results;
	}

	@Override
	@Transactional
	public List<ServiceListEntity> getListOfServices(ServiceType serviceType, Integer offset, Integer maxResults) throws WISPServiceException {
		List<ServiceListEntity> results = null;
		try {
			results = applicationRepository.getListOfServices(serviceType, offset, maxResults);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return results;
	}

	@Override
	@Transactional
	public Long getServiceListCount(ServiceType serviceType) throws WISPServiceException {
		try {
			return applicationRepository.getServiceListCount(serviceType);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public ServiceListEntity getServiceIndetailed(ServiceType serviceType,Long service_id)
			throws WISPServiceException {
		ServiceListEntity result = null;
		try {
			result = applicationRepository.getServiceIndetailed(serviceType, service_id);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return result;
	}

	@Override
	@Transactional
	public List<UserFavoritesEntity> getUserFavoriteServices(String email, Integer offset, Integer maxResults)
			throws WISPServiceException {
		List<UserFavoritesEntity> results = null;
		try {
			UserEntity entity = applicationRepository.getUserByUserEmail(email);
			if(entity != null){
				results = applicationRepository.getUserFavoriteServices(entity.getId(), offset, maxResults);
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return results;
	}

	@Override
	@Transactional
	public Long getUserFavServiceListCount(String email)
			throws WISPServiceException {
		try {
			return applicationRepository.getUserFavServiceListCount(email);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public ServiceCommentsEntity addServiceFeedBack(ServiceFeedBackBean feedBackBean)
			throws WISPServiceException {
		ServiceCommentsEntity commentsEntity = null;
		try {
			UserEntity entity = applicationRepository.getUserByUserEmail(feedBackBean.getEmail());
			if(entity != null){
				ServiceListEntity serviceListEntity = applicationRepository.getServiceIndetailedById(feedBackBean.getService_id());
				commentsEntity = createServiceFeedBackEntity(feedBackBean);
				commentsEntity.setService_comments_list_entity(serviceListEntity);
				commentsEntity.setUser_comments_entity(entity);
				applicationRepository.addServiceFeedBack(commentsEntity);
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return commentsEntity;
	}

	private ServiceCommentsEntity createServiceFeedBackEntity(ServiceFeedBackBean feedBackBean) {
		ServiceCommentsEntity entity = new ServiceCommentsEntity();
		entity.setRating(feedBackBean.getRating());
		entity.setComment_desc(feedBackBean.getComment_desc());
		entity.setIp_address(feedBackBean.getIp_address());
		entity.setComment_created(new Date());
		return entity;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public void removeFromFavorite(Long service_id, String email)
			throws WISPServiceException {
		try {
			UserEntity user= applicationRepository.getUserByUserEmail(email);
			if(user == null){
				throw new WISPServiceException("User don't exists.", 4000);
			}
			applicationRepository.removeFromFavorite(service_id, user.getId());
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public CustomErrorMessageBan addToFavorite(Long service_id, String email)
			throws WISPServiceException {
		try {
			UserEntity user= applicationRepository.getUserByUserEmail(email);
			if(user == null){
				return new CustomErrorMessageBan("User don't exists.", 4000);
			}
			if(applicationRepository.checkUserFavouriteStatus(service_id, user.getId())) {
				return new CustomErrorMessageBan("This is your favourite.", 4001);
			}
			applicationRepository.addToFavorite(service_id, user.getId());
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return new CustomErrorMessageBan("Success", 200);
	}

	@Override
	@Transactional
	public List<SearchResultsResponseBean> simulateSearchResult(String tagName) throws WISPServiceException {
		List<SearchResultsResponseBean> results = new ArrayList<>();
		try {
			List<ServiceListEntity> entities = applicationRepository.simulateSearchResult(tagName);
			for(ServiceListEntity entity : entities) {
				SearchResultsResponseBean bean = new SearchResultsResponseBean();
				bean.setService_id(entity.getService_id());
				bean.setService_name(entity.getService_name());
				bean.setService_type(entity.getService_type().getDescription());
				results.add(bean);
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return results;
	}

	@Override
	@Transactional
	public List<String> getListOfCities() throws WISPServiceException {
		List<String> results = new ArrayList<String>();
		try {
			results = applicationRepository.getListOfCities();
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return results;
	}
}
