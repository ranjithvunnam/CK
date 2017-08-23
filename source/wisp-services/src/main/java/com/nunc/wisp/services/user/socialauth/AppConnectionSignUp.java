package com.nunc.wisp.services.user.socialauth;

import org.apache.log4j.Logger;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionSignUp;


/**
 * If no local user associated with the given connection then
 * connection signup will create a new local user from the given connection.
 *
 */
public class AppConnectionSignUp implements ConnectionSignUp {
	
	protected static final Logger LOG_R = Logger.getLogger(AppConnectionSignUp.class);
  /*  @Autowired
    private UserService userService;*/

    @Override
    public String execute(final Connection<?> connection) {
       /* UserRegistrationForm userDetails = toUserRegistrationObject(connection.getKey().getProviderUserId(), SecurityUtil.toSocialProvider(connection.getKey().getProviderId()), connection.fetchUserProfile());
        LocalUser user = (LocalUser) userService.registerNewUser(userDetails);*/
    	LOG_R.info("Application Prompted for registration");
        return "1";
    }

   /* private UserRegistrationForm toUserRegistrationObject(final String userId, final SocialProvider socialProvider, final UserProfile userProfile) {
        return UserRegistrationForm.getBuilder()
                .addUserId(userId)
                .addFirstName(userProfile.getName())
                .addEmail(userProfile.getEmail())
                .addPassword(userProfile.getName())
                .addSocialProvider(socialProvider).build();
    }*/

}
