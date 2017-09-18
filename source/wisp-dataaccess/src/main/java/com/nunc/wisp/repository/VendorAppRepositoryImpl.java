package com.nunc.wisp.repository;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.ServiceHitsEntity;
import com.nunc.wisp.entities.ServiceImagesEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.entities.ServiceVideosEntity;
import com.nunc.wisp.entities.utils.CountriesEntity;
import com.nunc.wisp.entities.utils.StatesEntity;
import com.nunc.wisp.repository.exception.WISPDataAccessException;

@Repository("VendorAppRepository")
public class VendorAppRepositoryImpl implements VendorAppRepository {
	
protected static final Logger LOG_R = Logger.getLogger(VendorAppRepositoryImpl.class);
	
	private static final int MAX_ROWS_FOR_USER_SEARCH = 10;
	private static final int DEFAULT_OFFSET = 0;
	
	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;
	
	@Autowired
    JdbcTemplate jdbcTemplate;

	@Override
	@Transactional
	public Long createServiceDemoghraphicDetails(ServiceListEntity serviceListEntity) throws WISPDataAccessException {
		Long id = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			id = (Long) session.save(serviceListEntity);
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db", e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return id;
		
	}

	@Override
	@Transactional
	public void updateServiceDemoghraphicDetails(ServiceListEntity serviceListEntity) throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.saveOrUpdate(serviceListEntity);
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db", e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public ServiceListEntity getVendorServiceDetailsByID(Long service_id)
			throws WISPDataAccessException {
		ServiceListEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceListEntity.class);
			criteria.add(Restrictions.eq("service_id", service_id));
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
	public List<ServiceListEntity> getListOfServicesByVendorID(String email, Integer offset, Integer maxResults)
			throws WISPDataAccessException {
		List<ServiceListEntity> results = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceListEntity.class, "service")
			.createAlias("service.user_service_entity", "user")
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).add(Restrictions.eq("user.email", email))
			.setFirstResult(offset!=null?offset:DEFAULT_OFFSET).setMaxResults(maxResults!=null?maxResults:MAX_ROWS_FOR_USER_SEARCH)
			.addOrder(Order.desc("service_created"));;
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
	@Transactional
	public Long getCountOfServicesByVendorID(String email)
			throws WISPDataAccessException {
		return (Long)sessionFactory.getCurrentSession()
				.createCriteria(ServiceListEntity.class, "service")
				.createAlias("service.user_service_entity", "user")
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).add(Restrictions.eq("user.email", email))
				.setProjection(Projections.rowCount())
				.uniqueResult();
	}

	@Override
	@Transactional
	public ServiceListEntity getVendorServiceIndetailed(ServiceType service_type, Long service_id)
			throws WISPDataAccessException {
		ServiceListEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceListEntity.class);
			criteria.add(Restrictions.eq("service_id", service_id));
			criteria.add(Restrictions.eq("service_type", service_type));
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
	public List<Object[]> getAccessHistoryDetails(Long service_id,
			String min_date, String max_date) throws WISPDataAccessException {
		List<Object[]> results = null;
		String sql = "SELECT DATE_FORMAT(timestamp, '%Y-%m-%d') AS date, COUNT(*) AS count " +
				"FROM wisp_service_hits WHERE DATE(timestamp) BETWEEN DATE_FORMAT('"+min_date+"', '%Y-%m-%d') " +
				"AND DATE_FORMAT('"+max_date+"', '%Y-%m-%d') and wisp_services_details_service_id = "+service_id+" GROUP BY date";
		try {
			Session session = sessionFactory.getCurrentSession();
			SQLQuery query = session.createSQLQuery(sql);
			results = query.list();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}

		return results;
	}

	@Override
	@Transactional
	public void setAccessHistoryDetails(ServiceHitsEntity hitsEntity) throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			LOG_R.info("@setAccessHistoryDetails repository");
			session.save(hitsEntity);
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public void deleteImageFromDB(ServiceImagesEntity imagesEntity)	throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.delete(imagesEntity);
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public ServiceImagesEntity getImageByUrl(Long service_id, String url)
			throws WISPDataAccessException {
		ServiceImagesEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceImagesEntity.class, "images");
			criteria.add(Restrictions.eq("images.service_image_list_entity.service_id", service_id));
			criteria.add(Restrictions.eq("image_url", url));
			entity = (ServiceImagesEntity) criteria.uniqueResult();
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
	public List<ServiceHitsEntity> getAccessHistoryDetailsToDownload(Long service_id,
			Date from_date, Date to_date) throws WISPDataAccessException {
		List<ServiceHitsEntity> results = new ArrayList<ServiceHitsEntity>();
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceHitsEntity.class, "hitsEntity");
			criteria.add(Restrictions.eq("hitsEntity.service_list_hits_entity.service_id",service_id));
			criteria.add(Restrictions.ge("hitsEntity.timestamp", from_date)); 
			criteria.add(Restrictions.lt("hitsEntity.timestamp", getTomorrowDate(to_date)));
			results = criteria.list();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return results;
	}
	
	private Date getTomorrowDate(Date date) {
	    Calendar cal = Calendar.getInstance();
	    cal.setTime(date);
	    cal.add(Calendar.DATE, 1);
	    return cal.getTime();
	}

	@Override
	@Transactional
	public ServiceVideosEntity getVIdeoByUrl(Long service_id, String filePath)
			throws WISPDataAccessException {
		ServiceVideosEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceVideosEntity.class, "videos");
			criteria.add(Restrictions.eq("videos.service_video_list_entity.service_id", service_id));
			criteria.add(Restrictions.eq("video_url", filePath));
			entity = (ServiceVideosEntity) criteria.uniqueResult();
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
	public void deleteVideoFromDB(ServiceVideosEntity entity)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.delete(entity);
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public List<CountriesEntity> getAllCountries() throws WISPDataAccessException {
		List<CountriesEntity> results = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(CountriesEntity.class);
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
	@Transactional
	public CountriesEntity getCountryByName(String country_name)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(CountriesEntity.class);
			criteria.add(Restrictions.eq("country_name", country_name));
			return (CountriesEntity) criteria.uniqueResult();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public StatesEntity getStateByName(String state_name)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(StatesEntity.class);
			criteria.add(Restrictions.eq("state_name", state_name));
			return (StatesEntity) criteria.uniqueResult();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public Set<StatesEntity> getStatesByCountry(Long country_id)
			throws WISPDataAccessException {
		List<StatesEntity> results = new ArrayList<>();
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(StatesEntity.class);
			criteria.add(Restrictions.eq("country_entity.country_id", country_id));
			results = criteria.list();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return new HashSet<>(results);
	}
}
