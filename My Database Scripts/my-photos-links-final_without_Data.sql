DROP SCHEMA IF EXISTS `photo-links-project`;

CREATE SCHEMA `photo-links-project`;
USE `photo-links-project` ;
  
  CREATE TABLE `photo-links-project`.`tags` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(200) NULL,
  `creation_time` DATETIME NULL,
  `created_by` VARCHAR(30) NULL,
  `updation_time` DATETIME NULL,
  `updated_by` VARCHAR(30) NULL,
  PRIMARY KEY (`tag_id`)
  )ENGINE=InnoDB AUTO_INCREMENT = 1;
  
  CREATE TABLE `photo-links-project`.`photo_links` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event` VARCHAR(200) NULL,
  `from_date` DATE NULL,
  `to_date` DATE NULL,
  `photos_link` VARCHAR(200) NULL,
  `creation_time` DATETIME NULL,
  `created_by` VARCHAR(30) NULL,
  `updation_time` DATETIME NULL,
  `updated_by` VARCHAR(30) NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

  CREATE TABLE `photo-links-project`.`roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

CREATE TABLE `photo-links-project`.`users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL UNIQUE,
  `password` char(80) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `security_ques` varchar(500) NULL,
  `security_ans` varchar(200) NULL,
  `block_flag` varchar(10) NOT NULL,
  `block_reason` varchar(500) NULL,
  `creation_time` DATETIME NULL,
  `updation_time` DATETIME NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

CREATE TABLE `photo-links-project`.`users_roles` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  CONSTRAINT `FK_USERSROLES_ROLEID` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  CONSTRAINT `FK_USERSROLES_USERID` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
);

  CREATE TABLE `photo-links-project`.`users_tags` (
  `user_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`tag_id`),
  CONSTRAINT `FK_USERSTAGS_TAGID` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`),
  CONSTRAINT `FK_USERSTAGS_USERID` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
);

  CREATE TABLE `photo-links-project`.`photolinks_tags` (
  `event_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`event_id`,`tag_id`),
  CONSTRAINT `FK_PHOTOLINKSTAGS_EVENTID` FOREIGN KEY (`event_id`) REFERENCES `photo_links` (`event_id`),
  CONSTRAINT `FK_PHOTOLINKSTAGS_TAGID` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`)
);

  CREATE TABLE `photo-links-project`.`feedbacks` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `feedback_type` varchar(10) NOT NULL,
  `feedback_msg` varchar(500) NULL,
  `submitted_date` DATETIME NULL,
  `submitted_by` varchar(50) NOT NULL,
  `read_date` DATETIME NULL,
  `read_by` varchar(50) NULL,
  `resolved_date`DATETIME NULL,
  `resolved_by` varchar(50) NULL,
  `resolution_msg` varchar(500) NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

INSERT INTO `photo-links-project`.`users`
(user_id,username,password,first_name,last_name,email,security_ques,security_ans,block_flag,block_reason,creation_time,updation_time)
VALUES (1,'superadmin','$2a$10$uxDOiWzVvifbgZRTFyUYqOyCBb1omGvi7.4fqjA1pKtqzxuuJ359O','Guna Teja','Yadavalli','gunateja100@gmail.com','What is your fav color ?','green','N',NULL,NOW(),NULL);


INSERT INTO `photo-links-project`.`roles`(`role_id`,`role_name`) VALUES (1,'ROLE_SUPERADMIN');
INSERT INTO `photo-links-project`.`roles`(`role_id`,`role_name`) VALUES (2,'ROLE_ADMIN');
INSERT INTO `photo-links-project`.`roles`(`role_id`,`role_name`) VALUES (3,'ROLE_USER');

INSERT INTO `photo-links-project`.`tags` (`tag_id`,`tag_name`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (1,'V R MAD KINGS','2020-07-31 21:16:32','superadmin','2020-07-31 21:16:32',NULL);
INSERT INTO `photo-links-project`.`tags` (`tag_id`,`tag_name`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (2,'FAMILY','2020-07-31 21:16:32','superadmin','2020-07-31 21:16:32',NULL);
INSERT INTO `photo-links-project`.`tags` (`tag_id`,`tag_name`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (3,'SURYA','2020-08-01 02:55:04','superadmin','2020-08-01 02:55:04',NULL);
INSERT INTO `photo-links-project`.`tags` (`tag_id`,`tag_name`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (4,'3 IDIOTS','2020-08-01 02:55:13','superadmin','2020-08-01 02:55:13',NULL);
INSERT INTO `photo-links-project`.`tags` (`tag_id`,`tag_name`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (5,'SIA CHILL GANG','2020-08-01 02:55:29','superadmin','2020-08-01 02:55:29',NULL);
INSERT INTO `photo-links-project`.`tags` (`tag_id`,`tag_name`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (6,'SRKR','2020-08-01 02:55:41','superadmin','2020-08-01 02:55:41',NULL);
INSERT INTO `photo-links-project`.`tags` (`tag_id`,`tag_name`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (7,'SRKR Roomies','2020-08-01 02:58:34','superadmin','2020-08-01 02:58:34',NULL);
INSERT INTO `photo-links-project`.`tags` (`tag_id`,`tag_name`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (8,'SIA TEAM','2020-08-01 10:42:02','superadmin','2020-08-01 10:42:02',NULL);


INSERT INTO `photo-links-project`.`users_roles` (`user_id`,`role_id`) VALUES (1,1);
INSERT INTO `photo-links-project`.`users_roles` (`user_id`,`role_id`) VALUES (1,2);
INSERT INTO `photo-links-project`.`users_roles` (`user_id`,`role_id`) VALUES (1,3);

INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (1,1);
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (1,2);
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (1,3);
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (1,4);
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (1,5);
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (1,6);
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (1,7);
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (1,8);