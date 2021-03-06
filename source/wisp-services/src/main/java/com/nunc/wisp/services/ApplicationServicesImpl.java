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
import com.nunc.wisp.beans.ContactUsBean;
import com.nunc.wisp.beans.ResetPasswordBeans;
import com.nunc.wisp.beans.SearchResultsResponseBean;
import com.nunc.wisp.beans.ServiceCommentsResponseBeans;
import com.nunc.wisp.beans.ServiceEnquiryBean;
import com.nunc.wisp.beans.ServiceFeedBackBean;
import com.nunc.wisp.beans.ServiceFilterRequestBean;
import com.nunc.wisp.beans.UserRegistrationBean;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.ContactUsEntity;
import com.nunc.wisp.entities.MainSliderEntity;
import com.nunc.wisp.entities.PasswordResetTokenEntity;
import com.nunc.wisp.entities.ServiceCommentsEntity;
import com.nunc.wisp.entities.ServiceEnquiryDetailsEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.entities.UserFavoritesEntity;
import com.nunc.wisp.repository.ApplicationRepository;
import com.nunc.wisp.repository.VendorAppRepository;
import com.nunc.wisp.repository.exception.WISPDataAccessException;
import com.nunc.wisp.services.exception.UserRoleExitsException;
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
	public void registerNewUserAccount(UserRegistrationBean bean) throws WISPServiceException, UserRoleExitsException {
		try {
			if(applicationRepository.isUserRegisterOnlyAsClient(bean.getEmail())) {
				UserEntity entity = applicationRepository.getUserByUserEmail(bean.getEmail());
				entity.setUser_role_entity(applicationRepository.getRoleDetailsById(2L));
				applicationRepository.updateUserCredentials(entity);
				throw new UserRoleExitsException("This email already registered, you can use same account for vendor.", 1000);
			} else if (applicationRepository.isUserAlreadyRegistered(bean.getEmail())) {
				throw new WISPServiceException("Email already in use.", 1000);
			}
			UserEntity user_entity = createUserEntity(bean);
			user_entity.setUser_role_entity(applicationRepository.getRoleDetailsById(bean.getRole()));
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
		entity.setFb_login_id(bean.getFb_login_id());
		entity.setGoogle_id(bean.getGoogle_id());
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
	public List<ServiceListEntity> getMainPageServiceList(ServiceType serviceType, String location) throws WISPServiceException {
		List<ServiceListEntity> results = null;
		try {
			results = applicationRepository.getMainPageServiceList(serviceType, location);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return results;
	}

	@Override
	@Transactional
	public List<ServiceListEntity> getListOfServices(ServiceFilterRequestBean bean, Integer offset, Integer maxResults) throws WISPServiceException {
		List<ServiceListEntity> results = null;
		try {
			results = applicationRepository.getListOfServices(bean, offset, maxResults);
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return results;
	}

	@Override
	@Transactional
	public Long getServiceListCount(ServiceFilterRequestBean bean) throws WISPServiceException {
		try {
			return applicationRepository.getServiceListCount(bean);
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
			LOG_R.info("Search Problem "+serviceType);
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
	public void toggleFavorite(Long service_id, String email)
			throws WISPServiceException {
		try {
			UserEntity user= applicationRepository.getUserByUserEmail(email);
			if(applicationRepository.checkUserFavouriteStatus(service_id, user.getId())) {
				applicationRepository.removeFromFavorite(service_id, user.getId());
			} else {
				applicationRepository.addToFavorite(service_id, user.getId());
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public List<SearchResultsResponseBean> simulateSearchResult(String tagName) throws WISPServiceException {
		List<SearchResultsResponseBean> results = new ArrayList<>();
		try {
			List<ServiceListEntity> entities = applicationRepository.simulateSearchResultWithHibernateSearch(tagName);
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

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public void addContactUsDetails(ContactUsBean bean)	throws WISPServiceException {
		try {
			applicationRepository.addContactUsDetails(createContactUsEntity(bean));
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		
	}

	private ContactUsEntity createContactUsEntity(ContactUsBean bean) {
		ContactUsEntity entity = new ContactUsEntity();
		entity.setName(bean.getName());
		entity.setEmail(bean.getEmail());
		entity.setPhone(bean.getPhone());
		entity.setDescription(bean.getMessage());
		entity.setCreated_date(new Date());
		return entity;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public void addEnquiryDetails(ServiceEnquiryBean bean)
			throws WISPServiceException {
		try {
			applicationRepository.addEnquiryDetails(createServiceEnquiryEntity(bean));
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		
	}

	private ServiceEnquiryDetailsEntity createServiceEnquiryEntity(ServiceEnquiryBean bean) {
		ServiceEnquiryDetailsEntity entity = new ServiceEnquiryDetailsEntity();
		entity.setName(bean.getName());
		entity.setEmail(bean.getEmail());
		entity.setPhone(bean.getPhone());
		entity.setDescription(bean.getDescription());
		entity.setService_id(bean.getService_id());
		entity.setEnquiry_date(bean.getEnquiry_date());
		entity.setCreated_date(new Date());
		return entity;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = WISPServiceException.class)
	public void updateUser(UserRegistrationBean bean)
			throws WISPServiceException {
		try {
			UserEntity user = applicationRepository.getUserByUserEmail(bean.getEmail());
			if(user != null) {
				if(bean.getFb_login_id() != null && !bean.getFb_login_id().isEmpty()) {
					user.setFb_login_id(bean.getFb_login_id());
				}else if(bean.getGoogle_id() != null && !bean.getGoogle_id().isEmpty()){
					user.setGoogle_id(bean.getGoogle_id());
				}
				applicationRepository.updateUserCredentials(user);
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		
	}

	@Override
	@Transactional
	public List<ServiceCommentsResponseBeans> getServiceComments(Long service_id)
			throws WISPServiceException {
		List<ServiceCommentsResponseBeans> comments = new ArrayList<>();
		try {
			List<ServiceCommentsEntity> commentsEntity = applicationRepository.getServiceComments(service_id);
			for(ServiceCommentsEntity commentEntity : commentsEntity) {
				ServiceCommentsResponseBeans comment = createServiceCommentsResponseBeans(commentEntity);
				comments.add(comment);
			}
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
		return comments;
	}

	private ServiceCommentsResponseBeans createServiceCommentsResponseBeans(
			ServiceCommentsEntity commentEntity) {
		ServiceCommentsResponseBeans bean = new ServiceCommentsResponseBeans();
		bean.setRating(commentEntity.getRating());
		bean.setComment_desc(commentEntity.getComment_desc());
		bean.setComment_created(commentEntity.getComment_created());
		bean.setFirst_name(commentEntity.getUser_comments_entity().getFirst_name());
		return bean;
	}

	@Override
	@Transactional
	public List<ServiceListEntity> getSearchResults(String search,
			Integer offset, Integer maxResults) throws WISPServiceException {
		try {
			return applicationRepository.getSearchResults(search, offset, maxResults);
			
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}

	@Override
	@Transactional
	public Long getSearchResultsCount(String search, Integer offset,
			Integer maxResults) throws WISPServiceException {
		try {
			return applicationRepository.getSearchResultsCount(search, offset, maxResults);
			
		} catch (WISPDataAccessException e) {
			LOG_R.error("Exception occured ::: ", e);
			throw new WISPServiceException(e.getMessage(), e.getErrorCode());
		}
	}
}
