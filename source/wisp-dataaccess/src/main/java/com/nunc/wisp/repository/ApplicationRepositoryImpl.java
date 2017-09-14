package com.nunc.wisp.repository;

import java.io.Reader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.LowerCaseFilter;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.WhitespaceTokenizer;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.util.Version;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.search.FullTextQuery;
import org.hibernate.search.FullTextSession;
import org.hibernate.search.Search;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.hibernate.transform.Transformers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.nunc.wisp.beans.ServiceFilterRequestBean;
import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.ContactUsEntity;
import com.nunc.wisp.entities.MainSliderEntity;
import com.nunc.wisp.entities.PasswordResetTokenEntity;
import com.nunc.wisp.entities.ServiceCommentsEntity;
import com.nunc.wisp.entities.ServiceEnquiryDetailsEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.entities.ServicesAddressEntity;
import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.entities.UserFavoritesEntity;
import com.nunc.wisp.entities.UserRoleEntity;
import com.nunc.wisp.repository.exception.WISPDataAccessException;
import com.nunc.wisp.repository.utils.PermutermTokenFilter;

@Repository("ApplicationRepository")
public class ApplicationRepositoryImpl implements ApplicationRepository {

	protected static final Logger LOG_R = Logger.getLogger(ApplicationRepositoryImpl.class);
	
	private static final int MAX_ROWS_FOR_USER_SEARCH = 10;
	private static final int DEFAULT_OFFSET = 0;
	
	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;
	
	@Autowired
    JdbcTemplate jdbcTemplate;

	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<MainSliderEntity> getMainSliderImages()
			throws WISPDataAccessException {
		List<MainSliderEntity> result = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(MainSliderEntity.class);
			criteria.add(Restrictions.eq("slider_status", 1));
			criteria.addOrder(Order.asc("slider_order"));
			result = criteria.list();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while updating the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return result;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void registerNewUserAccount(UserEntity user)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(user);
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public boolean isUserAlreadyRegistered(String email)
			throws WISPDataAccessException {
		boolean status = false;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(UserEntity.class);
			criteria.add(Restrictions.eq("email", email));
			UserEntity entity = (UserEntity) criteria.uniqueResult();
			if (entity != null) {
				status = true;
			}
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return status;
	}
	
	@Override
	@Transactional
	public boolean isUserRegisterOnlyAsClient(String email)
			throws WISPDataAccessException {
		boolean status = false;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(UserEntity.class, "user");
			criteria.add(Restrictions.eq("user.email", email));
			UserRoleEntity userEntity = new UserRoleEntity();
			userEntity.setRole_id(1L);
			criteria.add(Restrictions.eq("user.user_role_entity", userEntity));
			UserEntity entity = (UserEntity) criteria.uniqueResult();
			if (entity != null) {
				status = true;
			}
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return status;
	}
	
	@Override
	@Transactional
	public UserEntity getUserByUserEmail(String email)
			throws WISPDataAccessException {
		UserEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(UserEntity.class);
			criteria.add(Restrictions.eq("email", email));
			entity = (UserEntity) criteria.uniqueResult();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}

		return entity;
	}

	@Override
	@Transactional
	public PasswordResetTokenEntity getUserPasswordResetTokens(String email)
			throws WISPDataAccessException {
		PasswordResetTokenEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session
					.createCriteria(PasswordResetTokenEntity.class);
			criteria.add(Restrictions.eq("email", email));
			entity = (PasswordResetTokenEntity) criteria.uniqueResult();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return entity;
	}

	@Override
	@Transactional
	public void updatePasswordResetHash(
			PasswordResetTokenEntity resetTokenEntity)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.saveOrUpdate(resetTokenEntity);
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public PasswordResetTokenEntity isPasswordResetTokenExits(String token)
			throws WISPDataAccessException {
		PasswordResetTokenEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session
					.createCriteria(PasswordResetTokenEntity.class);
			criteria.add(Restrictions.eq("token", token));
			entity = (PasswordResetTokenEntity) criteria.uniqueResult();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return entity;
	}

	@Override
	@Transactional
	public void updateUserCredentials(UserEntity userEntity)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.saveOrUpdate(userEntity);
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public void removePasswordResetToken(String token)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session
					.createCriteria(PasswordResetTokenEntity.class);
			PasswordResetTokenEntity entity = (PasswordResetTokenEntity) criteria
					.add(Restrictions.eq("token", token)).uniqueResult();
			session.delete(entity);
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public List<ServiceListEntity> getMainPageServiceList(ServiceType serviceTypes, String location)
			throws WISPDataAccessException {
		List<ServiceListEntity> result = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceListEntity.class, "service_list");
			criteria.createAlias("service_list.addressEntity", "address");
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			criteria.add(Restrictions.eq("service_type", serviceTypes));
			if(location != null && !location.isEmpty()) {
				criteria.add(Restrictions.eq("address.city", location));
			}
			criteria.add(Restrictions.eq("approval_status", 2));
			criteria.add(Restrictions.eq("service_display_status", true));
			criteria.setMaxResults(16);
			criteria.addOrder(Order.asc("service_display_order"));
			result = criteria.list();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while updating the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return result;
	}

	@Override
	@Transactional
	public List<ServiceListEntity> getListOfServices(ServiceFilterRequestBean bean, Integer offset, Integer maxResults) throws WISPDataAccessException {
		List<ServiceListEntity> result = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceListEntity.class, "service_list");
			criteria.createAlias("service_list.addressEntity", "address");
			criteria.createAlias("service_list.amenitiyEntity", "aminity");
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			criteria.add(Restrictions.eq("service_type", bean.getService_type()));
			if(isNotNull(bean.getLocation())){
				criteria.add(Restrictions.eq("address.city", bean.getLocation()));
			}
			if(bean.getAmenityBean() != null) {
				if(isNotNull(bean.getAmenityBean().getCapacity())){
					criteria.add(Restrictions.eq("aminity.capacity", bean.getAmenityBean().getCapacity()));
				}
				if(bean.getAmenityBean().getRooms() != null && bean.getAmenityBean().getRooms() > 0){
					criteria.add(Restrictions.eq("aminity.rooms", bean.getAmenityBean().getRooms()));
				}
				if(bean.getAmenityBean().isAir_condition()){
					criteria.add(Restrictions.eq("aminity.air_condition", bean.getAmenityBean().isAir_condition()));
				}
				if(bean.getAmenityBean().isParking()){
					criteria.add(Restrictions.eq("aminity.parking", bean.getAmenityBean().isParking()));
				}
				if(bean.getAmenityBean().isLiquor()){
					criteria.add(Restrictions.eq("aminity.liquor", bean.getAmenityBean().isLiquor()));
				}
				if(bean.getAmenityBean().isWifi()){
					criteria.add(Restrictions.eq("aminity.wifi", bean.getAmenityBean().isWifi()));
				}
			}
			if(isNotNull(bean.getSearchTerm())){
				Criterion name_condition = Restrictions.ilike("service_list.service_name", bean.getSearchTerm(), MatchMode.ANYWHERE);
				Criterion description_condition = Restrictions.ilike("service_list.service_description", bean.getSearchTerm(), MatchMode.ANYWHERE);
				Criterion completeCondition = Restrictions.disjunction().add(name_condition)
                        .add(description_condition);
				criteria.add(completeCondition);
			}
			criteria.add(Restrictions.eq("approval_status", 2));
			criteria.setFirstResult(offset!=null?offset:DEFAULT_OFFSET).setMaxResults(maxResults!=null?maxResults:MAX_ROWS_FOR_USER_SEARCH);
			criteria.addOrder(Order.desc("service_id"));
			result = criteria.list();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while updating the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return result;
	}

	private boolean isNotNull(String string) {
		return string != null && !string.isEmpty();
	}
	
	@Override
	@Transactional
	public Long getServiceListCount(ServiceFilterRequestBean bean) throws WISPDataAccessException {
		/*return (Long)sessionFactory.getCurrentSession()
				.createCriteria(ServiceListEntity.class, "service_list").createAlias("service_list.addressEntity", "address").setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.add(Restrictions.eq("service_type", serviceType))
				.add(Restrictions.eq("approval_status", 2))
				.setProjection(Projections.rowCount())
				.uniqueResult();*/
		Long result = 0L;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceListEntity.class, "service_list");
			criteria.createAlias("service_list.addressEntity", "address");
			criteria.createAlias("service_list.amenitiyEntity", "aminity");
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			criteria.add(Restrictions.eq("service_type", bean.getService_type()));
			if(isNotNull(bean.getLocation())){
				criteria.add(Restrictions.eq("address.city", bean.getLocation()));
			}
			if(bean.getAmenityBean() != null) {
				if(isNotNull(bean.getAmenityBean().getCapacity())){
					criteria.add(Restrictions.eq("aminity.capacity", bean.getAmenityBean().getCapacity()));
				}
				if(bean.getAmenityBean().getRooms() != null && bean.getAmenityBean().getRooms() > 0){
					criteria.add(Restrictions.eq("aminity.rooms", bean.getAmenityBean().getRooms()));
				}
				if(bean.getAmenityBean().isAir_condition()){
					criteria.add(Restrictions.eq("aminity.air_condition", bean.getAmenityBean().isAir_condition()));
				}
				if(bean.getAmenityBean().isParking()){
					criteria.add(Restrictions.eq("aminity.parking", bean.getAmenityBean().isParking()));
				}
				if(bean.getAmenityBean().isLiquor()){
					criteria.add(Restrictions.eq("aminity.liquor", bean.getAmenityBean().isLiquor()));
				}
				if(bean.getAmenityBean().isWifi()){
					criteria.add(Restrictions.eq("aminity.wifi", bean.getAmenityBean().isWifi()));
				}
			}
			if(isNotNull(bean.getSearchTerm())){
				Criterion name_condition = Restrictions.ilike("service_list.service_name", bean.getSearchTerm(), MatchMode.ANYWHERE);
				Criterion description_condition = Restrictions.ilike("service_list.service_description", bean.getSearchTerm(), MatchMode.ANYWHERE);
				Criterion completeCondition = Restrictions.disjunction().add(name_condition)
                        .add(description_condition);
				criteria.add(completeCondition);
			}
			criteria.add(Restrictions.eq("approval_status", 2));
			criteria.setProjection(Projections.rowCount());
			result = (Long)criteria.uniqueResult();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return result;
	}

	@Override
	@Transactional
	public ServiceListEntity getServiceIndetailed(ServiceType service_type,	Long service_id) throws WISPDataAccessException {
		ServiceListEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceListEntity.class);
			criteria.add(Restrictions.eq("service_id", service_id));
			criteria.add(Restrictions.eq("service_type", service_type));
			criteria.add(Restrictions.eq("approval_status", 2));
			entity = (ServiceListEntity) criteria.uniqueResult();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}

		return entity;
	}

	@Override
	@Transactional
	public List<UserFavoritesEntity> getUserFavoriteServices(Long id, Integer offset, Integer maxResults)
			throws WISPDataAccessException {
		List<UserFavoritesEntity> result = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(UserFavoritesEntity.class, "favorite");
			criteria.createAlias("favorite.user_fav_entity", "user");
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			criteria.add(Restrictions.eq("user.id", id));
			criteria.setFirstResult(offset!=null?offset:DEFAULT_OFFSET).setMaxResults(maxResults!=null?maxResults:MAX_ROWS_FOR_USER_SEARCH);
			result = criteria.list();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while updating the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return result;
	}

	@Override
	@Transactional
	public Long getUserFavServiceListCount(String email)
			throws WISPDataAccessException {
		return (Long)sessionFactory.getCurrentSession()
				.createCriteria(UserFavoritesEntity.class, "favorite")
				.createAlias("favorite.user_fav_entity", "user")
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).add(Restrictions.eq("user.email", email))
				.setProjection(Projections.rowCount())
				.uniqueResult();
	}

	@Override
	@Transactional
	public void addServiceFeedBack(ServiceCommentsEntity commentsEntity)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(commentsEntity);
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public ServiceListEntity getServiceIndetailedById(Long service_id)
			throws WISPDataAccessException {
		ServiceListEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceListEntity.class);
			criteria.add(Restrictions.eq("service_id", service_id));
			criteria.add(Restrictions.eq("approval_status", 2));
			entity = (ServiceListEntity) criteria.uniqueResult();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}

		return entity;
	}

	@Override
	@Transactional
	public void removeFromFavorite(Long service_id, Long user_id) throws WISPDataAccessException {
		String query = "DELETE FROM wisp_user_favorites WHERE service_id = ? and user_id = ?";
		Object[] params = {service_id, user_id};
		try {
			jdbcTemplate.update(query, params);
		} catch (DataAccessException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public void addToFavorite(Long service_id, Long user_id)
			throws WISPDataAccessException {
		String query = "INSERT INTO wisp_user_favorites (service_id, user_id, created_date) VALUES (?, ?, ?)";
		Object[] params = {service_id, user_id, new Date()};
		try {
			jdbcTemplate.update(query, params);
		} catch (DataAccessException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public boolean checkUserFavouriteStatus(Long service_id, Long user_id)
			throws WISPDataAccessException {
		String query = "SELECT count(*) FROM wisp_user_favorites WHERE service_id = ? AND user_id = ?";
		Object[] params = {service_id, user_id};
		try {
			Integer cnt = jdbcTemplate.queryForObject(query, Integer.class, params);
			return cnt != null && cnt > 0;
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db", e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}

	}

	@Override
	@Transactional
	public UserRoleEntity getRoleDetailsById(Long role_id) throws WISPDataAccessException {
		UserRoleEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(UserRoleEntity.class);
			criteria.add(Restrictions.eq("role_id", role_id));
			entity = (UserRoleEntity) criteria.uniqueResult();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}

		return entity;
	}

	@Override
	@Transactional
	public List<ServiceListEntity> simulateSearchResult(String searchQuery) throws WISPDataAccessException {
		List<ServiceListEntity> results = new ArrayList<>();
		try {	
			Session session = sessionFactory.getCurrentSession();
			/*LogicalExpression andExp = Restrictions.or(Restrictions.ilike("service_name", searchQuery, MatchMode.ANYWHERE),
					Restrictions.ilike("service_description", searchQuery, MatchMode.ANYWHERE));*/
			Criterion name_condition = Restrictions.ilike("service_name", searchQuery, MatchMode.ANYWHERE);
			Criterion description_condition = Restrictions.ilike("service_description", searchQuery, MatchMode.ANYWHERE);
			//Criterion type_condition = Restrictions.ilike("service_type", ServiceType.getNameByCode(searchQuery).name(), MatchMode.ANYWHERE);
			Criterion completeCondition = Restrictions.disjunction().add(name_condition)
				                              .add(description_condition)/*
				                              .add(type_condition)*/;
			Criteria criteria = session.createCriteria(ServiceListEntity.class)
					.add(completeCondition)
					.add(Restrictions.eq("approval_status", 2))
				    .setProjection(Projections.projectionList()
				    .add(Projections.property("service_id"), "service_id")
				    .add(Projections.property("service_type"), "service_type")
				    .add(Projections.property("service_name"), "service_name"))
				    .setResultTransformer(Transformers.aliasToBean(ServiceListEntity.class));
			results = criteria.list();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return results;
	}

	@Override
	public List<String> getListOfCities() throws WISPDataAccessException {
		List<String> result = new ArrayList<>();
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServicesAddressEntity.class);
			criteria.setProjection(Projections.distinct(Projections.property("city")));
			result = criteria.list();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while updating the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return result;
	}

	@Override
	@Transactional
	public void addContactUsDetails(ContactUsEntity createContactUsEntity)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(createContactUsEntity);
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public void addEnquiryDetails(
			ServiceEnquiryDetailsEntity createServiceEnquiryEntity)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(createServiceEnquiryEntity);
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while saving the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		
	}

	@Override
	@Transactional
	public List<ServiceCommentsEntity> getServiceComments(Long service_id)
			throws WISPDataAccessException {
		List<ServiceCommentsEntity> result = new ArrayList<>();
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceCommentsEntity.class,"comments");
			criteria.createAlias("comments.service_comments_list_entity", "service");
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			criteria.add(Restrictions.eq("service.service_id", service_id));
			result = criteria.list();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while updating the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return result;
	}

	@Override
	@Transactional
	public List<ServiceListEntity> getSearchResults(String search,
			Integer offset, Integer maxResults) throws WISPDataAccessException {
		List<ServiceListEntity> results = new ArrayList<>();
		try {
			Session session = sessionFactory.getCurrentSession();
			Criterion name_condition = Restrictions.ilike("service_name", search, MatchMode.ANYWHERE);
			Criterion description_condition = Restrictions.ilike("service_description", search, MatchMode.ANYWHERE);
			Criterion completeCondition = Restrictions.disjunction().add(name_condition).add(description_condition);
			Criteria criteria = session.createCriteria(ServiceListEntity.class)
					.add(completeCondition)
					.add(Restrictions.eq("approval_status", 2));
			criteria.setFirstResult(offset!=null?offset:DEFAULT_OFFSET).setMaxResults(maxResults!=null?maxResults:MAX_ROWS_FOR_USER_SEARCH);
			criteria.addOrder(Order.desc("service_id"));
			results = criteria.list();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while updating the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return results;
	}

	@Override
	@Transactional
	public Long getSearchResultsCount(String search, Integer offset,
			Integer maxResults) throws WISPDataAccessException {
		Criterion name_condition = Restrictions.ilike("service_name", search, MatchMode.ANYWHERE);
		Criterion description_condition = Restrictions.ilike("service_description", search, MatchMode.ANYWHERE);
		Criterion completeCondition = Restrictions.disjunction().add(name_condition).add(description_condition);
		return (Long) sessionFactory.getCurrentSession().createCriteria(ServiceListEntity.class)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.add(completeCondition)
				.add(Restrictions.eq("approval_status", 2)).setProjection(Projections.rowCount())
				.uniqueResult();
	}

	@Override
	@Transactional
	public List<ServiceListEntity> simulateSearchResultWithHibernateSearch(String searchQuery) throws WISPDataAccessException {
		
		List<ServiceListEntity> results = new ArrayList<>();
		FullTextSession fullTextSession = null;
		
		try {
			Session session = sessionFactory.getCurrentSession();
			
			fullTextSession = Search.getFullTextSession(session);
			QueryBuilder queryBuilder = fullTextSession.getSearchFactory().buildQueryBuilder().forEntity(ServiceListEntity.class).get();
			
			List<Query> queryList = new LinkedList<Query>();
	        
			Analyzer analyzer = new Analyzer() {
				
				@Override
				public TokenStream tokenStream(String fieldName, Reader reader) {
					// TODO Auto-generated method stub
					TokenStream tokens = new WhitespaceTokenizer(Version.LUCENE_31, reader);
					tokens = new LowerCaseFilter(Version.LUCENE_31, tokens);
					tokens = new PermutermTokenFilter(tokens);
			        return tokens;
				}
			};
			
			Query luceneFinalQuery = null;
			String[] arrKeywords = searchQuery.split(" ");
			for (String keyword : Arrays.asList(arrKeywords)) {
				luceneFinalQuery = queryBuilder.keyword().wildcard().onField("service_name").andField("service_description").matching(keyword+ "*").createQuery();
	            queryList.add(luceneFinalQuery);
	        }
			
			BooleanQuery finalQuery = new BooleanQuery();
	        for (Query q : queryList) {
	            finalQuery.add(q, Occur.MUST);
	        }

	        LOG_R.info("Hibernate Search Query "+finalQuery.toString());
		    FullTextQuery fullTextQuery = fullTextSession.createFullTextQuery(finalQuery, ServiceListEntity.class);
	        Criteria criteria = session.createCriteria(ServiceListEntity.class);
		    criteria.add(Restrictions.eq("approval_status", 2));
	        
	        
		    fullTextQuery.setCriteriaQuery(criteria);
	        results = fullTextQuery.list();
		} catch (HibernateException e) {
			LOG_R.error(
					"Exception occured while updating the user into inventory db",
					e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return results;
	}

}
