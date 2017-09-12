package com.nunc.wisp.repository;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.nunc.wisp.beans.enums.ServiceType;
import com.nunc.wisp.entities.MainSliderEntity;
import com.nunc.wisp.entities.ServiceListEntity;
import com.nunc.wisp.repository.exception.WISPDataAccessException;

@Repository("AdminApplicationRepository")
public class AdminApplicationRepositoryImpl implements AdminApplicationRepository{
	
	protected static final Logger LOG_R = Logger.getLogger(VendorAppRepositoryImpl.class);
	
	private static final int MAX_ROWS_FOR_USER_SEARCH = 10;
	private static final int DEFAULT_OFFSET = 0;
	
	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;
	
	@Override
	@Transactional
	public Long getCountOfServicesToVerify() throws WISPDataAccessException {
		return (Long)sessionFactory.getCurrentSession()
				.createCriteria(ServiceListEntity.class).setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.add(Restrictions.eq("approval_status", 1))
				.setProjection(Projections.rowCount())
				.uniqueResult();
	}

	@Override
	@Transactional
	public List<ServiceListEntity> getListOfServicesToVerify(Integer offset,
			Integer maxResults) throws WISPDataAccessException {
		List<ServiceListEntity> result = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(ServiceListEntity.class);
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			criteria.add(Restrictions.eq("approval_status", 1));
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

	@Override
	@Transactional
	public ServiceListEntity getServiceIndetailed(ServiceType service_type,
			Long service_id) throws WISPDataAccessException {
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
	public void updateServiceStatus(ServiceListEntity service)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.update(service);
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
	public ServiceListEntity getServiceIndetailedByID(Long service_id)
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
	public List<MainSliderEntity> getHomePageSliderImages() throws WISPDataAccessException {
		List<MainSliderEntity> results = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(MainSliderEntity.class);
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
	public void createHomePageSliderImages(MainSliderEntity entity)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(entity);
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public Long getHighestOrder() throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria c = session.createCriteria(MainSliderEntity.class);
			c.addOrder(Order.desc("slider_order"));
			c.setMaxResults(1);
			MainSliderEntity entity = (MainSliderEntity)c.uniqueResult();
			return entity.getSlider_order();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

	@Override
	@Transactional
	public MainSliderEntity getHomePageSliderById(Long id)
			throws WISPDataAccessException {
		MainSliderEntity entity = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Criteria criteria = session.createCriteria(MainSliderEntity.class);
			criteria.add(Restrictions.eq("id", id));
			entity = (MainSliderEntity) criteria.uniqueResult();
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
	public void deleteHomePageSlider(MainSliderEntity entity)
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
	public void updateMainSliderEntity(MainSliderEntity entity)
			throws WISPDataAccessException {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.saveOrUpdate(entity);
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while saving the user into inventory db",e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
	}

}
