package com.nunc.wisp.services.user.security;

import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.repository.UserRepository;
import com.nunc.wisp.repository.exception.WISPDataAccessException;

@Service("UserAuthService")
public class UserAuthServiceImpl implements UserDetailsService {

	protected static final Logger LOG_R = Logger.getLogger(UserAuthServiceImpl.class);

	@Autowired
	@Qualifier("UserRepository")
	private UserRepository repo;
	

	/* (non-Javadoc)
	 * @see org.springframework.security.core.userdetails.UserDetailsService#loadUserByUsername(java.lang.String)
	 */
	@Override
	@Transactional
	public UserDetails loadUserByUsername(String email)throws UsernameNotFoundException {
		UserDetails user = null;
		try {
			UserEntity loadUserByUserName = repo.getUserByEmail(email);
			if (loadUserByUserName != null) {
				Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
				LOG_R.info("ROLE "+loadUserByUserName.getUser_role_entity().getRole_name());
				GrantedAuthority grant = new GrantedAuthorityImpl(loadUserByUserName.getUser_role_entity().getRole_name());
				authorities.add(grant);
				user = new UserDetailsImpl(loadUserByUserName.getEmail(),loadUserByUserName.getPassword(), authorities);
			} else {
				throw new UsernameNotFoundException("User name not found.");
			}
		} catch (WISPDataAccessException e) {
			throw new UsernameNotFoundException("Exception occurred wile reading user info."); 
		}
		return user;
	}
}