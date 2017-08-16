package com.nunc.wisp.repository;

import org.springframework.stereotype.Repository;

import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.repository.exception.WISPDataAccessException;


/**
 * @author Ranjith
 *
 */
@Repository
public interface UserRepository {
	
	public UserEntity getUserByEmail(String email) throws WISPDataAccessException;
	
}