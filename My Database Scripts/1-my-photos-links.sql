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

  CREATE TABLE `photo-links-project`.`photoLinks_tags` (
  `event_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`event_id`,`tag_id`),
  CONSTRAINT `FK_PHOTOLINKSTAGS_EVENTID` FOREIGN KEY (`event_id`) REFERENCES `photo_links` (`event_id`),
  CONSTRAINT `FK_PHOTOLINKSTAGS_TAGID` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`)
);

insert into `photo-links-project`.`tags`(tag_name,creation_time,created_by,updation_time,updated_by) values ('V R MAD KINGS',NOW(),'Gunateja',NULL,NULL);
insert into `photo-links-project`.`tags`(tag_name,creation_time,created_by,updation_time,updated_by) values ('FAMILY',NOW(),'Gunateja',NULL,NULL);

insert into `photo-links-project`.`photo_links`(event,from_date,to_date,photos_link,creation_time,created_by,updation_time,updated_by) values 
('Chikmagalur Trip & Suma Marriage','2019-11-01','2019-11-03','https://photos.app.goo.gl/dPQKKHyrpsNVGgk28',NOW(),'Gunateja',NULL,NULL);
insert into `photo-links-project`.`photo_links`(event,from_date,to_date,photos_link,creation_time,created_by,updation_time,updated_by) values 
('Grandpa 100th Bday Celebrations','2014-03-23','2014-03-23','https://photos.app.goo.gl/H6tNmi4oKKyZWayTA',NOW(),'Gunateja',NULL,NULL);
insert into `photo-links-project`.`photo_links`(event,from_date,to_date,photos_link,creation_time,created_by,updation_time,updated_by) values 
('Guna Vadugu Pics','2019-06-23','2019-06-23','https://photos.app.goo.gl/qLGup5K2Cj2JpWhs8',NOW(),'Gunateja',NULL,NULL);

INSERT INTO `photo-links-project`.`roles`(`role_id`,`role_name`) VALUES (1,'ROLE_SUPERADMIN');
INSERT INTO `photo-links-project`.`roles`(`role_id`,`role_name`) VALUES (2,'ROLE_ADMIN');
INSERT INTO `photo-links-project`.`roles`(`role_id`,`role_name`) VALUES (3,'ROLE_USER');

INSERT INTO `photo-links-project`.`users`
(user_id,username,password,first_name,last_name,email,security_ques,security_ans,block_flag,block_reason,creation_time,updation_time)
VALUES (1,'superadmin','$2a$10$uxDOiWzVvifbgZRTFyUYqOyCBb1omGvi7.4fqjA1pKtqzxuuJ359O','Guna Teja','Yadavalli','superadmin_guna@gmail.com','What is your mothers maiden name?','ganapavarapu','N',NULL,NOW(),NULL);
INSERT INTO `photo-links-project`.`users`
(user_id,username,password,first_name,last_name,email,security_ques,security_ans,block_flag,block_reason,creation_time,updation_time)
VALUES (2,'admin','$2a$10$uxDOiWzVvifbgZRTFyUYqOyCBb1omGvi7.4fqjA1pKtqzxuuJ359O','Guna','Yadavalli','admin_guna@gmail.com','What is your bank account number?','9612080585','N',NULL,NOW(),NULL);
INSERT INTO `photo-links-project`.`users`
(user_id,username,password,first_name,last_name,email,security_ques,security_ans,block_flag,block_reason,creation_time,updation_time)
VALUES (3,'user','$2a$10$uxDOiWzVvifbgZRTFyUYqOyCBb1omGvi7.4fqjA1pKtqzxuuJ359O','Teja','Yadavalli','user_guna@gmail.com','What is your first company?','tcs','N',NULL,NOW(),NULL);

INSERT INTO `photo-links-project`.`users_roles` (`user_id`,`role_id`) VALUES (1,1);
INSERT INTO `photo-links-project`.`users_roles` (`user_id`,`role_id`) VALUES (1,2);
INSERT INTO `photo-links-project`.`users_roles` (`user_id`,`role_id`) VALUES (1,3);
INSERT INTO `photo-links-project`.`users_roles` (`user_id`,`role_id`) VALUES (2,2);
INSERT INTO `photo-links-project`.`users_roles` (`user_id`,`role_id`) VALUES (2,3);
INSERT INTO `photo-links-project`.`users_roles` (`user_id`,`role_id`) VALUES (3,3);
  
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (1,1);
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (1,2);
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (2,2);
INSERT INTO `photo-links-project`.`users_tags` (`user_id`,`tag_id`) VALUES (3,1);

INSERT INTO `photo-links-project`.`photoLinks_tags` (`event_id`,`tag_id`) VALUES (1,1);
INSERT INTO `photo-links-project`.`photoLinks_tags` (`event_id`,`tag_id`) VALUES (2,2);
INSERT INTO `photo-links-project`.`photoLinks_tags` (`event_id`,`tag_id`) VALUES (3,1);
INSERT INTO `photo-links-project`.`photoLinks_tags` (`event_id`,`tag_id`) VALUES (3,2);