CREATE TABLE `wisp_main_slider` (
  `slider_id` int(11) NOT NULL,
  `slider_url` varchar(100) NOT NULL,
  `slider_description` varchar(256) NOT NULL,
  `slider_order` int(11) NOT NULL,
  `slider_status` tinyint(1) NOT NULL,
  PRIMARY KEY (`slider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_service_hits` (
  `hit_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wisp_services_details_service_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hit_id`),
  KEY `wisp_service_hits_FKIndex1` (`wisp_services_details_service_id`),
  CONSTRAINT `wisp_service_hits_ibfk_1` FOREIGN KEY (`wisp_services_details_service_id`) REFERENCES `wisp_services_details` (`service_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_services_address` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address_1` varchar(255) DEFAULT NULL,
  `address_2` varchar(255) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `pincode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_services_amenities` (
  `amenity_id` int(10) unsigned NOT NULL,
  `capacity` varchar(512) DEFAULT NULL,
  `rooms` varchar(45) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `parking` tinyint(3) unsigned DEFAULT NULL,
  `liquor` tinyint(3) unsigned DEFAULT NULL,
  `air_conditioning` tinyint(3) unsigned DEFAULT NULL,
  `wifi` tinyint(3) unsigned DEFAULT NULL,
  `type` varchar(1024) DEFAULT NULL,
  `cusine` varchar(1024) DEFAULT NULL,
  `occasion` varchar(1024) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `dance_style` varchar(1024) DEFAULT NULL,
  `fleet` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`amenity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_services_comments` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `service_id` int(10) unsigned NOT NULL,
  `rating` float NOT NULL,
  `comment_desc` varchar(255) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `comment_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `wisp_services_comments_FKIndex1` (`service_id`),
  KEY `wisp_services_comments_FKIndex2` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_services_details` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_type` varchar(45) NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `service_description` mediumtext NOT NULL,
  `service_website` varchar(100) DEFAULT NULL,
  `service_phone` varchar(45) NOT NULL,
  `service_email` varchar(255) NOT NULL,
  `service_banner_url` varchar(255) DEFAULT NULL,
  `service_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `service_updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `service_avg_rating` float DEFAULT '0',
  `approval_status` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_services_images` (
  `image_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` int(10) unsigned NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `image_description` varchar(255) NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `wisp_services_images_FKIndex1` (`service_id`),
  CONSTRAINT `wisp_services_images_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `wisp_services_details` (`service_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_services_videos` (
  `video_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` int(10) unsigned NOT NULL,
  `video_url` varchar(255) NOT NULL,
  `video_thumbnail` varchar(512) DEFAULT NULL,
  `video_description` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`video_id`),
  KEY `wisp_services_videos_FKIndex1` (`service_id`),
  CONSTRAINT `wisp_services_videos_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `wisp_services_details` (`service_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_user_favorites` (
  `favorite_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`favorite_id`),
  KEY `wisp_user_favorites_FKIndex1` (`user_id`),
  KEY `wisp_user_favorites_FKIndex2` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_user_roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_user_tokens` (
  `token_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `token` varchar(256) NOT NULL,
  `expiry_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `wisp_users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone_primary` varchar(45) NOT NULL,
  `phone_secondary` varchar(45) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `wisp_users_FKIndex1` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wisp_traffic_view` AS select `wisp_service_hits`.`wisp_services_details_service_id` AS `wisp_services_details_service_id` from `wisp_service_hits`;
