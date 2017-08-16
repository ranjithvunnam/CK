package com.nunc.wisp.repository;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.repository.exception.WISPDataAccessException;

/**
 * @author Ranjith
 *
 */
@Repository("UserRepository")
public class UserRepositoryImpl implements UserRepository {
	
	protected static final Logger LOG_R = Logger.getLogger(UserRepositoryImpl.class);
	
	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;
	
	@Autowired
    private JdbcTemplate jdbcTemplate;
	
	@Override
	@Transactional
	public UserEntity getUserByEmail(String email) throws WISPDataAccessException {
		UserEntity entity = null;
		try {
			Criteria criteria = sessionFactory.getCurrentSession().createCriteria(UserEntity.class);
			criteria.add(Restrictions.eq("email", email));
			entity = (UserEntity) criteria.uniqueResult();
		} catch (HibernateException e) {
			LOG_R.error("Exception occured while updating the user into inventory db", e);
			throw new WISPDataAccessException(
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_MESSAGE,
					WISPDataAccessException.DATA_ACCESS_EXCEPTION_CODE);
		}
		return entity;
	}
	
}