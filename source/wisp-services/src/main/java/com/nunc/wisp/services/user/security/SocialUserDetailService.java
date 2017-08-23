package com.nunc.wisp.services.user.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.social.security.SocialAuthenticationException;
import org.springframework.social.security.SocialUserDetails;
import org.springframework.social.security.SocialUserDetailsService;
import org.springframework.stereotype.Service;

import com.nunc.wisp.entities.UserEntity;
import com.nunc.wisp.services.user.socialauth.SocialUser;

@Service("socialUserDetailService")
public class SocialUserDetailService implements SocialUserDetailsService {

	@Autowired
    @Qualifier(value = "UserAuthService")
    private UserDetailsService userDetailService;

    @Override
    public SocialUserDetails loadUserByUserId(final String userId) throws UsernameNotFoundException, DataAccessException {
        UserEntity user = (UserEntity) userDetailService.loadUserByUsername(userId);
        if (user == null) {
            throw new SocialAuthenticationException("No local user mapped with social user " + userId);
        }
        GrantedAuthority grant = new GrantedAuthorityImpl(user.getUser_role_entity().getRole_name());
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(grant);
        return new SocialUser(String.valueOf(user.getId()),user.getEmail(), user.getPassword(), true, true, true, true, authorities);
    }
}
