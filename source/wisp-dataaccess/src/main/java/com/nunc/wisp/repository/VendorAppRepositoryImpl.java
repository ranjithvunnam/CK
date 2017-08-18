package com.nunc.wisp.repository;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.ServiceHitsEntity;
import com.nunc.wisp.entities.ServiceListEntity;
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
			.setFirstResult(offset!=null?offset:DEFAULT_OFFSET).setMaxResults(maxResults!=null?maxResults:MAX_ROWS_FOR_USER_SEARCH);
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
			session.save(hitsEntity);
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}
	
	
}
