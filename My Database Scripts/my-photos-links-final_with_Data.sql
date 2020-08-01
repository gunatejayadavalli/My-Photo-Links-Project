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

INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (1,'Grandpa\'s 100th Bday Celebrations','2014-03-23','2014-03-23','https://photos.app.goo.gl/JNrZyi81L8BVwxHt9','2020-08-01 02:52:45','superadmin','2020-08-01 02:52:45',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (2,'Surya 9th Class batch Get Together','2014-05-14','2014-05-14','https://photos.app.goo.gl/nPAjDorhWbwYp8iNA','2020-08-01 02:57:40','superadmin','2020-08-01 02:57:40',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (3,'Rahul brother Panchakatlu Function','2014-08-03','2014-08-03','https://photos.app.goo.gl/tBVnuLCznV1e8DFE6','2020-08-01 02:59:43','superadmin','2020-08-01 02:59:43',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (4,'Diwali with B.Tech Roomies','2014-10-24','2014-10-24','https://photos.app.goo.gl/ucn4ygHoFYuyi8F97','2020-08-01 03:02:08','superadmin','2020-08-01 03:50:13','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (5,'First day in TCS','2016-11-21','2016-11-21','https://photos.app.goo.gl/c7pufdPS7w3H77bL9','2020-08-01 03:04:57','superadmin','2020-08-01 03:04:57',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (6,'Fantastic Beasts Movie','2016-11-26','2016-11-26','https://photos.app.goo.gl/bjSdi8T6TrPxFXcw9','2020-08-01 03:06:57','superadmin','2020-08-01 03:06:57',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (7,'First weekend in TCS - ECR Beach','2016-11-26','2016-11-26','https://photos.app.goo.gl/vj4iLWPjUBB5fxr26','2020-08-01 03:09:25','superadmin','2020-08-01 03:09:25',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (8,'Suma Bday Celebrations - 2016','2016-11-30','2016-11-30','https://photos.app.goo.gl/yq3MChuHCZULCUK49','2020-08-01 03:10:30','superadmin','2020-08-01 03:10:30',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (9,'Phoenix Mall - First Time','2016-12-04','2016-12-04','https://photos.app.goo.gl/PEZJqJdeJD7xWU3T7','2020-08-01 03:12:23','superadmin','2020-08-01 03:12:23',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (10,'Guna & Harsha @ CCD ','2016-12-04','2016-12-04','https://photos.app.goo.gl/ereMjQkYZWHGPNzk7','2020-08-01 03:13:46','superadmin','2020-08-01 17:08:21','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (11,'Vandaloor Zoo','2016-12-10','2016-12-10','https://photos.app.goo.gl/Bte79n4soJVEejkd8','2020-08-01 03:17:32','superadmin','2020-08-01 03:17:32',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (12,'Mayajaal First time ','2016-12-10','2016-12-10','https://photos.app.goo.gl/1wmKuWKE2vAZKhXT7','2020-08-01 03:19:13','superadmin','2020-08-01 14:33:54','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (13,'ECR Avenue Beach - Chennai Floods','2016-12-13','2016-12-13','https://photos.app.goo.gl/JP2xYuFBRcJfwcSn6','2020-08-01 03:21:15','superadmin','2020-08-01 03:21:15',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (14,'VGP Universal & Snow Kingdom','2016-12-18','2016-12-18','https://photos.app.goo.gl/CwXRNxeXZ5hvoM8H8','2020-08-01 03:23:22','superadmin','2020-08-01 03:23:22',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (15,'Lift Pics','2016-12-24','2016-12-30','https://photos.app.goo.gl/k1hecYjU2dLARs349','2020-08-01 03:30:53','superadmin','2020-08-01 03:46:07','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (16,'Karapakkam Temple','2016-12-24','2016-12-24','https://photos.app.goo.gl/9eof2koSoSAG9unY8','2020-08-01 03:31:39','superadmin','2020-08-01 03:31:39',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (17,'T Nagar - First Time','2016-12-25','2016-12-25','https://photos.app.goo.gl/gTvcjAj8qhRdVzrB6','2020-08-01 03:32:22','superadmin','2020-08-01 03:46:32','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (18,'Karri Bday Celebrations - 2016','2016-12-30','2016-12-30','https://photos.app.goo.gl/wwMMy2GrY8h3nyjf7','2020-08-01 03:36:02','superadmin','2020-08-01 03:36:02',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (19,'Vamsi - Anusha 🤭❤️','2017-01-01','2017-01-01','https://photos.app.goo.gl/98nXntZqByKhBJTw6','2020-08-01 03:37:27','superadmin','2020-08-01 03:37:27',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (20,'Jan 1 - Supriya, Marina, ECR, Iskon','2017-01-01','2017-01-01','https://photos.app.goo.gl/FtPmiTHRmtWngYSN7','2020-08-01 03:40:46','superadmin','2020-08-01 03:42:34','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (21,'Rasika Bday Celebrations - 2017','2017-01-01','2017-01-01','https://photos.app.goo.gl/fBfV24s13MA13MLz5','2020-08-01 03:41:37','superadmin','2020-08-01 03:41:37',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (22,'CCD & T Nagar','2017-01-07','2017-01-07','https://photos.app.goo.gl/doEv3Hmmvg6HV84b6','2020-08-01 03:45:32','superadmin','2020-08-01 03:45:32',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (23,'Deepu Bday - 2017','2017-01-08','2017-01-08','https://photos.app.goo.gl/CpDtkNEa9P1FgPhF8','2020-08-01 03:49:27','superadmin','2020-08-01 03:49:27',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (24,'CCD Free 😂😂','2017-01-09','2017-01-09','https://photos.app.goo.gl/feNamXmt5zxN8CpD6','2020-08-01 03:52:07','superadmin','2020-08-01 03:52:07',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (25,'In train pics gng to Sankranti','2017-01-12','2017-01-12','https://photos.app.goo.gl/gsFnqQZg9gdjWtT88','2020-08-01 03:53:51','superadmin','2020-08-01 03:53:51',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (26,'KFC pics','2017-01-27','2017-01-27','https://photos.app.goo.gl/RzmnmY4Xf2hvyV8y7','2020-08-01 03:56:30','superadmin','2020-08-01 03:56:30',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (27,'Mahabalipuram Pics - Missing 🤔','2017-01-22','2017-01-22','https://photos.app.goo.gl/1WtpRcANkJdbE8FY6','2020-08-01 03:57:36','superadmin','2020-08-01 03:57:36',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (28,'ECR Beach','2017-01-29','2017-01-29','https://photos.app.goo.gl/J5wR2ui7bSkqzNVf9','2020-08-01 03:58:28','superadmin','2020-08-01 03:58:28',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (29,'First time to sirusei','2017-02-02','2017-02-02','https://photos.app.goo.gl/njVkBeaMX9U8Je6x8','2020-08-01 03:59:28','superadmin','2020-08-01 03:59:28',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (30,'V R MAD KINGS - Random Occasions','1970-01-01','2020-08-01','https://photos.app.goo.gl/Vzy7YAB8mcUNvMSX7','2020-08-01 04:01:42','superadmin','2020-08-01 12:20:43','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (31,'Sunshine Evenue Beach','2017-02-05','2017-02-05','https://photos.app.goo.gl/sCGmoYHpGbYvnfjs7','2020-08-01 04:02:32','superadmin','2020-08-01 04:02:32',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (32,'Pondicherry Pics','2017-02-12','2017-02-12','https://photos.app.goo.gl/zp12UiVSuwAQ45jB8','2020-08-01 04:04:28','superadmin','2020-08-01 04:04:28',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (33,'Alex Rare Pics 😂','2017-02-17','2017-12-27','https://photos.app.goo.gl/2537n8nsVNDG1M7P7','2020-08-01 04:05:18','superadmin','2020-08-01 04:58:42','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (34,'Appu Bday - 2017','2017-02-18','2017-02-18','https://photos.app.goo.gl/sKCmeQfhrhg9qSHr9','2020-08-01 04:06:20','superadmin','2020-08-01 04:06:20',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (35,'Chennai One','2017-02-26','2017-02-26','https://photos.app.goo.gl/n3vzJQAq6w6oV6kj6','2020-08-01 04:07:25','superadmin','2020-08-01 04:07:25',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (36,'Holi Pics - 2017','2017-03-12','2017-03-12','https://photos.app.goo.gl/9AhDdSDGjeCtzeb37','2020-08-01 04:08:51','superadmin','2020-08-01 04:08:51',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (37,'Phoenix mall','2017-03-19','2017-03-19','https://photos.app.goo.gl/hcAdSgAe4qpaXNct5','2020-08-01 04:10:23','superadmin','2020-08-01 04:10:23',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (38,'Siruseri Pics','2017-03-24','2018-10-17','https://photos.app.goo.gl/xw5bLQLz4CtrMaWx6','2020-08-01 04:11:34','superadmin','2020-08-01 11:10:30','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (39,'Santu Bday Celebrations - 2017','2017-03-30','2017-03-30','https://photos.app.goo.gl/oh5eLWQW2gZCF5hA8','2020-08-01 04:12:32','superadmin','2020-08-01 04:12:32',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (40,'ABs - Bday Treats - 2017','2017-04-05','2017-04-05','https://photos.app.goo.gl/GxHKZJfY7Svk5uWA8','2020-08-01 04:15:44','superadmin','2020-08-01 17:01:29','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (41,'KFC Pics','2017-04-09','2017-04-09','https://photos.app.goo.gl/atueSWWjRuwV6MMr6','2020-08-01 04:17:09','superadmin','2020-08-01 04:17:09',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (43,'Movie ','2017-04-22','2017-04-22','https://photos.app.goo.gl/y9A7se68Nb7MCsxBA','2020-08-01 04:19:12','superadmin','2020-08-01 04:19:12',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (44,'Tirupati & Thalakona Pics','2017-04-29','2017-04-30','https://photos.app.goo.gl/9U1JAQvrV1cXUsbZ8','2020-08-01 04:20:37','superadmin','2020-08-01 04:21:56','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (45,'Mouni Bday Celebrations - 2017','2017-05-09','2017-05-09','https://photos.app.goo.gl/LrfQBzAdEdUrEPGj7','2020-08-01 04:23:50','superadmin','2020-08-01 04:23:50',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (46,'Akki Bday Celebrations - 2017','2017-05-20','2017-05-20','https://photos.app.goo.gl/r8E4NewrWcM5AJ429','2020-08-01 04:29:27','superadmin','2020-08-01 04:29:27',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (47,'Harsha Brother Marraige','2017-05-20','2017-05-21','https://photos.app.goo.gl/RJD9S44zjYNVAMRV9','2020-08-01 04:31:08','superadmin','2020-08-01 04:31:08',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (48,'Irfan Bday - 2017','2017-05-30','2017-05-30','https://photos.app.goo.gl/kBpdQmCiKXbnm9y97','2020-08-01 04:34:42','superadmin','2020-08-01 04:34:42',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (49,'Guna Bday Celebrations - 2017','2017-05-31','2017-05-31','https://photos.app.goo.gl/dK6pzaZr2sJRnTb89','2020-08-01 04:35:41','superadmin','2020-08-01 05:17:13','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (50,'Satti Bday - 2017','2017-06-13','2017-06-13','https://photos.app.goo.gl/BGXcJ49oD4sFATdM8','2020-08-01 04:36:31','superadmin','2020-08-01 04:36:31',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (52,'Alex Bday Celebrations - 2017','2017-06-25','2017-06-25','https://photos.app.goo.gl/rNLunADUHDCacBgYA','2020-08-01 04:38:28','superadmin','2020-08-01 04:38:28',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (53,'Event in Project','2017-07-14','2017-07-14','https://photos.app.goo.gl/auzz284YDJqoBRbr5','2020-08-01 04:39:50','superadmin','2020-08-01 04:39:50',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (54,'Phoenix Mall Pics','2017-08-06','2017-08-06','https://photos.app.goo.gl/S1RcJB12qJQw32HZ9','2020-08-01 04:41:21','superadmin','2020-08-01 04:41:21',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (55,'Mouni Pics','2017-08-11','2017-08-11','https://photos.app.goo.gl/Gieyw321VvEtB38Q7','2020-08-01 04:42:16','superadmin','2020-08-01 04:42:16',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (56,'Harshini Bday - 2017','2017-10-10','2017-10-10','https://photos.app.goo.gl/WtLut3igg6pUnKdk7','2020-08-01 04:43:40','superadmin','2020-08-01 04:43:40',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (57,'Mouni KFC Bet 😂😂','2017-10-12','2017-10-12','https://photos.app.goo.gl/rLZCrB5qD26T9jZT9','2020-08-01 04:44:27','superadmin','2020-08-01 04:44:27',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (58,'Sandy Bday Celebrations - 2017','2017-10-19','2017-10-19','https://photos.app.goo.gl/tNxMgssQ4cft4QqB6','2020-08-01 04:53:21','superadmin','2020-08-01 04:53:21',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (59,'Makkinavarigudem House Warming','2017-11-26','2017-11-26','https://photos.app.goo.gl/9Pa6Cqizsbx4ieop9','2020-08-01 04:54:36','superadmin','2020-08-01 04:54:36',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (60,'Event in Project','2017-12-21','2017-12-21','https://photos.app.goo.gl/fQZBPR5YLGtH45Lc6','2020-08-01 04:55:40','superadmin','2020-08-01 04:55:40',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (61,'Tada Waterfalls','2017-12-24','2017-12-24','https://photos.app.goo.gl/9CjDutTdM55rNPzFA','2020-08-01 04:57:10','superadmin','2020-08-01 04:57:10',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (62,'Event in project','2017-12-28','2017-12-28','https://photos.app.goo.gl/GZ4Mdu6Nq4hwqnyaA','2020-08-01 04:59:54','superadmin','2020-08-01 09:57:57','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (63,'Badminton Match In Stadium','2018-01-07','2018-01-07','https://photos.app.goo.gl/xBPMBT59PrQCTYs67','2020-08-01 05:01:17','superadmin','2020-08-01 05:01:17',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (64,'Deepu Bday Celebrations - 2018','2017-01-08','2017-01-08','https://photos.app.goo.gl/5AzRbU2mgZ3amcYk6','2020-08-01 05:02:06','superadmin','2020-08-01 05:02:06',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (65,'Coorg Trip','2018-01-26','2018-01-28','https://photos.app.goo.gl/7kGD9pWXgASy5bHx5','2020-08-01 09:57:30','superadmin','2020-08-01 09:57:30',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (66,'Pics at PVR Velachery','2018-02-11','2018-02-11','https://photos.app.goo.gl/kNLFR7NDoVEWMMZQ9','2020-08-01 10:27:42','superadmin','2020-08-01 10:27:42',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (67,'Appu Bday Celebrations - 2018','2018-02-18','2018-02-18','https://photos.app.goo.gl/zHHcVHMxFQvrL8nS7','2020-08-01 10:28:37','superadmin','2020-08-01 10:28:37',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (68,'Vizag Trip - Santu Sister Marriage','2018-03-03','2018-03-04','https://photos.app.goo.gl/CXgp7wUtfTf3fnde6','2020-08-01 10:30:07','superadmin','2020-08-01 10:30:54','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (69,'Tada Trip','2018-03-24','2018-03-24','https://photos.app.goo.gl/EpC2pPoFTH1Ut1rM6','2020-08-01 10:32:18','superadmin','2020-08-01 10:32:18',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (70,'Pics with Sowjanya Akka & Babai','2018-04-07','2018-04-07','https://photos.app.goo.gl/gKo7e5MW4HP697jN9','2020-08-01 10:34:07','superadmin','2020-08-01 10:34:07',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (71,'In Flat Pics - Gang meets','2018-04-14','2020-08-01','https://photos.app.goo.gl/7TjcsRJM4GcgiCY69','2020-08-01 10:35:19','superadmin','2020-08-01 12:46:28','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (72,'Neeha  Bday Celebrations(Adv)- 2018','2018-04-16','2018-04-16','https://photos.app.goo.gl/4cUWvmzLp5aVW7L8A','2020-08-01 10:37:01','superadmin','2020-08-01 10:37:01',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (73,'Mouni Bday Celebrations - 2018','2018-05-09','2018-05-09','https://photos.app.goo.gl/ZQtkK1KWJJwT1xFg9','2020-08-01 10:38:07','superadmin','2020-08-01 10:38:07',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (74,'Guna Bday Celebrations - 2018','2018-05-31','2018-05-31','https://photos.app.goo.gl/igihLcvFqEnKGb867','2020-08-01 10:39:27','superadmin','2020-08-01 10:42:34','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (75,'Nagalapuram Water Falls Trip','2018-06-02','2018-06-02','https://photos.app.goo.gl/wEbSNCUBU1UVgNVn9','2020-08-01 10:47:31','superadmin','2020-08-01 10:47:31',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (76,'SIA Outing','2018-07-13','2018-07-13','https://photos.app.goo.gl/WuUKsEVf6RBV4j6V9','2020-08-01 10:53:18','superadmin','2020-08-01 10:53:18',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (77,'Vamsi Bday Celebrations - 2018','2018-07-28','2018-07-28','https://photos.app.goo.gl/hR3VRhSZQRsT8mdo9','2020-08-01 10:54:21','superadmin','2020-08-01 10:54:21',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (78,'Mangroves & Pondy Trip','2018-08-11','2018-08-12','https://photos.app.goo.gl/wCSWA5yhVQyUJCj86','2020-08-01 10:56:53','superadmin','2020-08-01 10:59:36','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (79,'Deepu & Guna Flight Jrny Pics','2018-08-19','2018-08-19','https://photos.app.goo.gl/omh8NoUXrF5c8i3Y6','2020-08-01 11:02:25','superadmin','2020-08-01 11:02:44','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (80,'Sahiti send off pics','2018-08-20','2018-08-20','https://photos.app.goo.gl/1F7NfSsQ2tS3cNHL6','2020-08-01 11:05:11','superadmin','2020-08-01 11:05:11',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (81,'Google Meetup @ ZOHO','2018-08-25','2018-08-25','https://photos.app.goo.gl/Lv73k6NMBMkMSDRK7','2020-08-01 11:06:06','superadmin','2020-08-01 11:06:06',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (82,'Rakshabandhan Pics','2018-08-27','2018-08-27','https://photos.app.goo.gl/hikcraXwjdnnuazY9','2020-08-01 11:07:10','superadmin','2020-08-01 11:52:19','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (83,'Daddy\'s Old 10th Class batches Pics','1970-01-01','2020-08-01','https://photos.app.goo.gl/bo2ayyVdoFGThLP78','2020-08-01 11:09:24','superadmin','2020-08-01 11:09:24',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (84,'Rithwik Pics','1970-01-01','2020-08-01','https://photos.app.goo.gl/QmSVcgRX5S8ayPsRA','2020-08-01 11:57:04','superadmin','2020-08-01 11:57:04',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (85,'3 IDIOTS - Random Occasions','1970-01-01','2020-08-01','https://photos.app.goo.gl/SDQWYKVw7bFhzzsB9','2020-08-01 11:58:25','superadmin','2020-08-01 12:20:35','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (86,'Trijju Bday Celebrations - 2018','2018-10-26','2018-10-26','https://photos.app.goo.gl/hgbXASRSVSGhn6pY8','2020-08-01 11:59:41','superadmin','2020-08-01 11:59:41',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (87,'Alex came to Chennai - PUB, VGP','2018-10-27','2018-10-28','https://photos.app.goo.gl/f9AWzBdnZ47egwPK9','2020-08-01 12:13:10','superadmin','2020-08-01 12:13:10',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (88,'Diwali @ Makkinavarigudem - 2018','2018-11-07','2018-11-07','https://photos.app.goo.gl/y2snYGSs1RbrNtbcA','2020-08-01 12:28:16','superadmin','2020-08-01 12:28:16',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (89,'Nagulachavithi at Home - 2018','2018-11-11','2018-11-11','https://photos.app.goo.gl/fsWaupU3DQevJucp8','2020-08-01 12:30:35','superadmin','2020-08-01 12:30:35',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (90,'Dinesh Prabhath Bday - 2018','2018-11-21','2018-11-21','https://photos.app.goo.gl/Eg4po56LeJkdPZ2h8','2020-08-01 12:34:47','superadmin','2020-08-01 12:34:47',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (91,'Jyotsna Bday Celebrations - 2018','2018-10-30','2018-10-30','https://photos.app.goo.gl/GUzP9YdM5JX4J3ya6','2020-08-01 12:38:11','superadmin','2020-08-01 12:38:11',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (92,'Jyotsna Send Off','2018-12-03','2018-12-03','https://photos.app.goo.gl/Mpth1Eb18vXvtVh56','2020-08-01 12:39:39','superadmin','2020-08-01 12:39:39',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (93,'Manyavar Shopping for Sruthi Mrg','2018-12-08','2018-12-08','https://photos.app.goo.gl/yn8V5qhn8Kt3gfzs9','2020-08-01 12:44:36','superadmin','2020-08-01 12:44:36',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (94,'Badminton Pics','1970-01-01','2020-08-01','https://photos.app.goo.gl/G4WLtWxLcSRCsa7F7','2020-08-01 12:45:40','superadmin','2020-08-01 13:35:53','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (95,'Thiruvanmiyur Beach - B4 Sruthi Mrg','2018-12-09','2018-12-09','https://photos.app.goo.gl/ex44t62NvGF8Tgmw8','2020-08-01 12:50:42','superadmin','2020-08-01 12:50:42',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (96,'Sruthi Bday Celebrations(Adv)- 2018','2018-12-13','2018-12-13','https://photos.app.goo.gl/6K1oW1ncPSyup7kM6','2020-08-01 12:55:16','superadmin','2020-08-01 12:55:16',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (97,'Sruthi Send Off - Gng for Mrg','2018-12-14','2018-12-14','https://photos.app.goo.gl/kb5ezNyNFikDQhdDA','2020-08-01 12:56:46','superadmin','2020-08-01 12:56:46',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (98,'Irfan Send Off','2018-12-17','2018-12-17','https://photos.app.goo.gl/AhYEEcbk9TUA6bQQ8','2020-08-01 13:01:41','superadmin','2020-08-01 13:01:41',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (99,'Sruthi Marriage Trip','2018-12-20','2018-12-22','https://photos.app.goo.gl/fTv91iGXmzw6zaNA7','2020-08-01 13:03:11','superadmin','2020-08-01 13:03:11',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (100,'Shravani Bday Celebrations - 2018','2018-12-27','2018-12-27','https://photos.app.goo.gl/tQWZ2B6dm219KoV96','2020-08-01 13:14:21','superadmin','2020-08-01 13:14:21',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (101,'Mahitha Marriage Trip','2018-12-29','2018-12-30','https://photos.app.goo.gl/r4g6esaedefpWg8j6','2020-08-01 13:20:02','superadmin','2020-08-01 13:20:02',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (102,'Potluck - Dec 31st 2018','2018-12-31','2018-12-31','https://photos.app.goo.gl/PwNBSq5er71Q42QW7','2020-08-01 13:23:31','superadmin','2020-08-01 13:23:31',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (103,'Jan 1st Celebrations at OMR Food St','2019-01-01','2019-01-01','https://photos.app.goo.gl/XEe74pQhz8La9W3g7','2020-08-01 13:25:25','superadmin','2020-08-01 13:25:25',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (104,'New Year Celebrations','2019-01-01','2019-01-01','https://photos.app.goo.gl/3paykuUKFEeSBHTp9','2020-08-01 13:27:55','superadmin','2020-08-01 13:27:55',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (105,'New Year Celebrations - Dinner','2019-01-01','2019-01-01','https://photos.app.goo.gl/jhniCdQ1BTi6n3XYA','2020-08-01 13:29:11','superadmin','2020-08-01 13:29:11',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (106,'Sruthi Back to Chennai after Mrg','2019-01-02','2019-01-02','https://photos.app.goo.gl/13qzyGohSXhPp9Ut9','2020-08-01 13:32:22','superadmin','2020-08-01 13:32:22',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (107,'Mukund Bday Celebrations - 2019','2019-01-02','2019-01-02','https://photos.app.goo.gl/RVgSVFTWZFkieU2a7','2020-08-01 13:34:02','superadmin','2020-08-01 13:34:02',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (108,'Mahabalipuram Trip','2019-01-05','2019-01-05','https://photos.app.goo.gl/cMWgP5w3TARbJN4P7','2020-08-01 13:37:29','superadmin','2020-08-01 13:37:29',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (109,'Deepu Bday Celebrations - 2019','2019-01-08','2019-01-08','https://photos.app.goo.gl/ruNBQds4BgGEnQHL7','2020-08-01 13:40:33','superadmin','2020-08-01 13:40:33',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (110,'Vinod Send Off to Singapore','2019-01-12','2019-01-12','https://photos.app.goo.gl/nvNkFbwMNDXYjdLS6','2020-08-01 13:42:28','superadmin','2020-08-01 13:42:28',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (111,'Random Pics VR MAD KINGS & 3 IDIOTS','1970-01-01','2020-08-01','https://photos.app.goo.gl/vayv2DYNN13n4gLY6','2020-08-01 13:47:54','superadmin','2020-08-01 13:47:54',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (112,'Irfan came to Chennai-Vellore Trip','2019-01-26','2019-01-26','https://photos.app.goo.gl/MBeXCYieJeBLyQBJ8','2020-08-01 14:15:45','superadmin','2020-08-01 14:20:40','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (113,'Harsha Bday Celebrations - 2019','2019-01-26','2019-01-26','https://photos.app.goo.gl/9v5LPZEiBxkC3TE56','2020-08-01 14:16:38','superadmin','2020-08-01 14:16:38',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (114,'Irfan back to Hyd - Zeeshan Lunch','2019-01-28','2019-01-28','https://photos.app.goo.gl/yQxYewieHvMypu1e7','2020-08-01 14:25:09','superadmin','2020-08-01 14:25:09',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (115,'Bindu Send Off','2019-01-31','2019-02-01','https://photos.app.goo.gl/fbR3qGg5PUynvTfTA','2020-08-01 14:27:02','superadmin','2020-08-01 14:27:02',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (116,'Rahul Marriage','2019-02-07','2019-02-08','https://photos.app.goo.gl/Tpzz5F2BHy51bVtg8','2020-08-01 14:29:04','superadmin','2020-08-01 14:29:04',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (117,'Random Grp Video Call Pics - Common','1970-01-01','2020-08-01','https://photos.app.goo.gl/WcgiHjMQTdccUfY67','2020-08-01 14:31:06','superadmin','2020-08-01 16:18:03','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (118,'Appu Bday Celebrations - 2020','2019-02-18','2019-02-18','https://photos.app.goo.gl/9eDsXZFeoyNK1vsH8','2020-08-01 14:44:46','superadmin','2020-08-01 14:44:46',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (119,'Singapore treat','2019-03-08','2019-03-08','https://photos.app.goo.gl/4nZfSe3ReWBTwEta9','2020-08-01 14:59:13','superadmin','2020-08-01 14:59:13',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (120,'KFC pics - Sandy, Guna & Deepu','2019-03-14','2019-03-14','https://photos.app.goo.gl/L3aXyrAQrzZ3ZRYm6','2020-08-01 15:01:48','superadmin','2020-08-01 17:07:58','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (121,'Pulikat Lake Trip','2019-03-23','2019-03-23','https://photos.app.goo.gl/qukJScGnTgTyktd68','2020-08-01 15:04:45','superadmin','2020-08-01 15:04:45',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (122,'Santu Bday Celebrations - 2019','2019-03-28','2019-03-28','https://photos.app.goo.gl/T89DvSQz2uYhUiie6','2020-08-01 15:12:05','superadmin','2020-08-01 15:12:05',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (123,'Guru Send Off to Singapore','2019-04-04','2019-04-04','https://photos.app.goo.gl/fYr85UQLMXUjM4FT9','2020-08-01 15:17:34','superadmin','2020-08-01 15:17:34',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (124,'Sruthi Send Off to Banglore','2019-05-05','2019-05-05','https://photos.app.goo.gl/jJCGXr8r9g8xEebE6','2020-08-01 15:25:04','superadmin','2020-08-01 15:25:04',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (125,'Mouni Bday Celebrations - 2019','2019-05-09','2019-05-09','https://photos.app.goo.gl/knbjV86dE5ECuuYw7','2020-08-01 15:26:02','superadmin','2020-08-01 15:26:02',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (126,'Harsha Marriage Shopping - Manyavar','2019-05-12','2019-05-12','https://photos.app.goo.gl/ftHeAHbCzzzyj1ru6','2020-08-01 15:27:12','superadmin','2020-08-01 15:27:12',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (127,'Harsha Marriage Trip','2019-05-17','2019-05-18','https://photos.app.goo.gl/TcUHaE9uPSAqQ6SA7','2020-08-01 15:32:20','superadmin','2020-08-01 15:32:20',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (128,'Invited friends to home','2019-05-18','2019-05-18','https://photos.app.goo.gl/MSA6TpQg1iFQBf6v9','2020-08-01 15:34:19','superadmin','2020-08-01 15:34:19',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (129,'Mouni brother Ritwik Bday','2019-05-19','2019-05-19','https://photos.app.goo.gl/kR4PsRz9x6nhHQwZ9','2020-08-01 15:35:39','superadmin','2020-08-01 15:35:39',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (130,'Harsha Chennai house Warming','2019-05-29','2019-05-29','https://photos.app.goo.gl/HsUxvhsK9TxD7YDz9','2020-08-01 15:41:07','superadmin','2020-08-01 15:41:26','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (131,'Guna Bday Celebrations - 2019','2019-05-31','2019-05-31','https://photos.app.goo.gl/XnhS93SgKo11L8Ej8','2020-08-01 15:43:08','superadmin','2020-08-01 15:43:08',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (132,'Guna Bday Celebrations - 2019','2019-05-31','2019-05-31','https://photos.app.goo.gl/P42Gmn6igNikkXWZ8','2020-08-01 15:44:16','superadmin','2020-08-01 15:44:16',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (133,'Guna Bday (Belated) - 2019','2019-06-03','2019-06-03','https://photos.app.goo.gl/fHKgAvwGbH9A5Uky7','2020-08-01 15:47:54','superadmin','2020-08-01 15:47:54',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (134,'Gowrisankar Treat - Coal BBQ','2019-06-20','2019-06-20','https://photos.app.goo.gl/44ATzxh8jrBXAsf16','2020-08-01 15:49:57','superadmin','2020-08-01 15:49:57',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (135,'Guna Vadugu Pics','2019-06-23','2019-06-23','https://photos.app.goo.gl/qLGup5K2Cj2JpWhs8','2020-08-01 15:52:58','superadmin','2020-08-01 15:52:58',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (136,'Mukund Send Off to Singapore','2019-06-26','2019-06-26','https://photos.app.goo.gl/C5m6WGog1zQ4UnHAA','2020-08-01 15:54:24','superadmin','2020-08-01 15:54:24',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (137,'Sharmila Bday Celebrations - 2019','2019-06-26','2019-06-26','https://photos.app.goo.gl/hiDrmb4GSfTY16AD6','2020-08-01 15:55:36','superadmin','2020-08-01 15:55:36',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (138,'Mahitha invited to her home','2019-06-30','2019-06-30','https://photos.app.goo.gl/P5cszDutk6BaiTsA7','2020-08-01 16:00:37','superadmin','2020-08-01 16:00:37',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (139,'Karri Send Off to Hyd 2019','2019-06-30','2019-06-30','https://photos.app.goo.gl/BUdHZAWJsCzHh6gP8','2020-08-01 16:04:00','superadmin','2020-08-01 16:04:00',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (140,'Warangal Trip to Srikanth Home','2019-07-21','2019-07-21','https://photos.app.goo.gl/i5FNV29mCpx2fDwq9','2020-08-01 16:10:20','superadmin','2020-08-01 16:10:20',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (141,'Bday Celebrations - 2019','2019-07-23','2019-07-23','https://photos.app.goo.gl/KsE2taEmrgUe2cHV8','2020-08-01 16:11:43','superadmin','2020-08-01 16:11:43',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (142,'Gowrisankar Send Off to Singapore','2019-07-26','2019-07-26','https://photos.app.goo.gl/zbxjoPJWFjYrEKbg6','2020-08-01 16:15:54','superadmin','2020-08-01 16:19:10','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (143,'Vamsi Bday Celebrations - 2019','2019-07-28','2019-07-28','https://photos.app.goo.gl/tojLRmaTK9AUwizF6','2020-08-01 16:20:30','superadmin','2020-08-01 16:20:30',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (144,'Mouni Send Off to Hyd','2019-07-29','2019-07-29','https://photos.app.goo.gl/ZTZDYSozuK5BfNUt6','2020-08-01 16:25:16','superadmin','2020-08-01 16:25:16',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (145,'Not sure 🤔','2019-07-31','2019-07-31','https://photos.app.goo.gl/tMa9tEMt4yLhDKy17','2020-08-01 16:27:57','superadmin','2020-08-01 16:27:57',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (146,'Banglore Trip - Hogenekkal','2019-08-03','2019-08-04','https://photos.app.goo.gl/zHcAES9y6uTf281Y7','2020-08-01 16:30:30','superadmin','2020-08-01 16:30:30',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (147,'Sowmya send off to Singapore','2019-08-09','2019-08-09','https://photos.app.goo.gl/A5Jn2hsW2wNdwDeBA','2020-08-01 16:32:03','superadmin','2020-08-01 16:32:03',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (148,'Dinesh Treat & Send Off','2019-08-11','2019-08-11','https://photos.app.goo.gl/SkUfS9aJs9fnDWHX9','2020-08-01 16:33:25','superadmin','2020-08-01 16:33:25',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (149,'Vamsi & Akki Bday Treat - 2019','2019-08-12','2019-08-12','https://photos.app.goo.gl/jZwZtKcwS8777npa6','2020-08-01 16:34:32','superadmin','2020-08-01 17:00:58','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (150,'Dinesh Send Off to Hyd','2019-08-13','2019-08-13','https://photos.app.goo.gl/KrauuSgzu8whWGDL7','2020-08-01 16:35:50','superadmin','2020-08-01 16:35:50',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (151,'Kovalam beach DJ','2019-08-25','2019-08-25','https://photos.app.goo.gl/VAK2UBXTJs9kE1Pe7','2020-08-01 16:39:13','superadmin','2020-08-01 16:39:13',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (152,'Onesta Name Of the Week - Akki Guna','2019-08-27','2019-08-27','https://photos.app.goo.gl/Fco98TSb7fo9T3gZA','2020-08-01 16:41:38','superadmin','2020-08-01 16:41:38',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (153,'Srikanth Bday Celebrations - 2019','2019-09-10','2019-09-10','https://photos.app.goo.gl/MBymFW4f7eGGhFwBA','2020-08-01 16:49:46','superadmin','2020-08-01 17:00:50','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (154,'Guru Singapore Return treat','2019-09-11','2019-09-11','https://photos.app.goo.gl/mbKgjVr1ofdjRKUs8','2020-08-01 16:50:47','superadmin','2020-08-01 16:50:47',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (155,'Srikanth Bday Celebrations - 2019','2019-09-17','2019-09-17','https://photos.app.goo.gl/i23cedHWCRc221HL6','2020-08-01 16:52:03','superadmin','2020-08-01 17:00:40','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (156,'Geetha last day in project','2019-09-20','2019-09-20','https://photos.app.goo.gl/cUZi6k3LWFL3op958','2020-08-01 16:54:18','superadmin','2020-08-01 16:54:18',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (157,'Sriram Send Off & Treat','2019-09-20','2019-09-20','https://photos.app.goo.gl/qY393JrtRoeEcxuQ9','2020-08-01 16:55:22','superadmin','2020-08-01 16:55:22',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (158,'Deepu Last day n Chennai & Send Off','2019-09-21','2019-09-22','https://photos.app.goo.gl/5upvuRyC4GH3L9KF9','2020-08-01 16:59:11','superadmin','2020-08-01 16:59:11',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (159,'Subharna Bday Celebrations - 2019','2019-09-23','2019-09-23','https://photos.app.goo.gl/rUYM1jsQMfMBJf7YA','2020-08-01 17:00:10','superadmin','2020-08-01 17:00:10',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (160,'Coastal Aroma - Sea Food Restaurant','2019-09-29','2019-09-29','https://photos.app.goo.gl/sQcrXQAaz45NJDsd9','2020-08-01 17:02:58','superadmin','2020-08-01 17:03:29','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (161,'Silka Bday Celebrations','2019-09-30','2019-09-30','https://photos.app.goo.gl/pZcvacdEYCP4rh2F9','2020-08-01 17:05:31','superadmin','2020-08-01 17:05:31',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (162,'Marina Beach - Vamsi & Guna','2019-10-02','2019-10-02','https://photos.app.goo.gl/3Ug3FecDF93hq7wRA','2020-08-01 17:06:48','superadmin','2020-08-01 17:07:06','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (163,'Hyd trp - Satti Rcpn & Sndy Sis Mrg','2019-10-05','2019-10-07','https://photos.app.goo.gl/AhRfiNXW6Qm2xm3YA','2020-08-01 17:13:56','superadmin','2020-08-01 17:13:56',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (164,'Vizag Trip - Akki Sister Reception','2019-10-12','2019-10-13','https://photos.app.goo.gl/r9iD4BycP3ENHdWU9','2020-08-01 17:17:21','superadmin','2020-08-01 17:17:21',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (165,'Neeha Marriage Trip','2019-10-18','2019-10-20','https://photos.app.goo.gl/hXyUrhpWdYyBDg6j9','2020-08-01 17:23:48','superadmin','2020-08-01 17:23:48',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (166,'Sandy Bday Celebrations - 2019','2019-10-19','2019-10-19','https://photos.app.goo.gl/U9EWGpqrmFc5Wtkm9','2020-08-01 17:26:19','superadmin','2020-08-01 17:26:41','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (167,'Trijju Bday Celebrations - 2019','2019-10-26','2019-10-26','https://photos.app.goo.gl/LVUkDGz3McDXkKKk9','2020-08-01 17:31:49','superadmin','2020-08-01 17:31:49',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (168,'Chikmagalur Trip & Suma Marriage','2019-11-01','2019-11-03','https://photos.app.goo.gl/dPQKKHyrpsNVGgk28','2020-08-01 17:33:11','superadmin','2020-08-01 17:33:11',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (169,'Dinesh Bday Celebrations - 2019','2019-11-20','2019-11-20','https://photos.app.goo.gl/XyN65HjTh758nunJ7','2020-08-01 17:42:15','superadmin','2020-08-01 17:42:15',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (170,'Irfan Came - Nagalapuram Trp','2020-01-05','2020-01-05','https://photos.app.goo.gl/HUsecPHYmJt3yRJMA','2020-08-01 17:45:46','superadmin','2020-08-01 18:20:46','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (171,'Mahitha Last working Day in TCS','2020-01-07','2020-01-07','https://photos.app.goo.gl/PyQ979qmvAJmF3YN8','2020-08-01 17:48:54','superadmin','2020-08-01 17:48:54',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (172,'Sankranti Kodi pandhalu - Mkvgm','2020-01-15','2020-01-15','https://photos.app.goo.gl/xq6cH3gFzZWMAbuTA','2020-08-01 18:02:08','superadmin','2020-08-01 18:02:08',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (173,'Hyd Trip - Irfan Bro Engagement','2020-01-18','2020-01-21','https://photos.app.goo.gl/WuWGV36w4iYw6uCa7','2020-08-01 18:03:47','superadmin','2020-08-01 18:03:47',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (174,'Preeti Promotion & Onsite Treat','2020-01-24','2020-01-24','https://photos.app.goo.gl/gcXsU5jdQPtTjEyC7','2020-08-01 18:06:42','superadmin','2020-08-01 18:06:42',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (175,'Mandeez - Chennai','2020-01-26','2020-01-26','https://photos.app.goo.gl/4WW3jrxsS6pxyFrS6','2020-08-01 18:14:24','superadmin','2020-08-01 18:14:24',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (176,'Event in SIA','2020-01-27','2020-01-27','https://photos.app.goo.gl/uWzUVu1ZcSEgv7HL8','2020-08-01 18:15:40','superadmin','2020-08-01 18:15:40',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (177,'Mouni Came to Chennai','2020-02-02','2020-02-02','https://photos.app.goo.gl/VNX8dTgQDToy11o57','2020-08-01 18:17:06','superadmin','2020-08-01 18:17:06',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (178,'Dineout - Big Hit Restaurant','2020-02-02','2020-02-02','https://photos.app.goo.gl/uTHCQdcU6c9jpaWm9','2020-08-01 18:18:18','superadmin','2020-08-01 19:06:20','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (179,'Akki Send Off to Banglore','2020-02-03','2020-02-03','https://photos.app.goo.gl/jt144jy29Y9wT9p27','2020-08-01 18:19:09','superadmin','2020-08-01 18:19:09',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (180,'Last week in Flat - Irfan,Akki Came','2020-02-22','2020-02-23','https://photos.app.goo.gl/d6gB3o7sUCixJtNB8','2020-08-01 18:24:08','superadmin','2020-08-01 18:24:35','superadmin');
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (181,'Vamsi New Bike','2020-03-14','2020-03-14','https://photos.app.goo.gl/6YpuL45YD6TWAKdZ7','2020-08-01 18:28:26','superadmin','2020-08-01 18:28:26',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (182,'Guru came to India','2020-03-14','2020-03-14','https://photos.app.goo.gl/BMF3nQcyEuQGJEUd8','2020-08-01 18:29:27','superadmin','2020-08-01 18:29:27',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (183,'Deepthi Engagement Pics','2020-03-15','2020-03-15','https://photos.app.goo.gl/CyKkJb2swX89BToa9','2020-08-01 18:30:13','superadmin','2020-08-01 18:30:13',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (184,'Uday Anna Bday Celebrations - 2020','2020-05-20','2020-05-20','https://photos.app.goo.gl/iRVSLRN28QCgSNJTA','2020-08-01 18:40:32','superadmin','2020-08-01 18:40:32',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (185,'Guna Bday Celebrations - 2020','2020-05-31','2020-05-31','https://photos.app.goo.gl/n3XDCV7gZjVb2Kyy7','2020-08-01 18:43:30','superadmin','2020-08-01 18:43:30',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (186,'Lucky Bday Celebrations - 2020','2020-06-01','2020-06-01','https://photos.app.goo.gl/Dj2Ktx2VmyvSqDTYA','2020-08-01 18:44:18','superadmin','2020-08-01 18:44:18',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (187,'Revanth Bday Celebrations - 2020','2020-06-06','2020-06-06','https://photos.app.goo.gl/UN5iP3YzmVtNmjT46','2020-08-01 18:47:55','superadmin','2020-08-01 18:47:55',NULL);
INSERT INTO `photo-links-project`.`photo_links` (`event_id`,`event`,`from_date`,`to_date`,`photos_link`,`creation_time`,`created_by`,`updation_time`,`updated_by`) VALUES (188,'Deepu Marriage Pics','2020-06-10','2020-06-10','https://photos.app.goo.gl/Jkf8Ct5498Sx67HLA','2020-08-01 18:49:05','superadmin','2020-08-01 18:49:05',NULL);

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

INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (5,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (6,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (7,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (8,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (9,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (10,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (11,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (12,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (13,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (14,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (15,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (16,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (17,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (18,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (19,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (20,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (21,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (22,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (23,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (24,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (25,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (26,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (27,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (28,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (29,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (30,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (31,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (32,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (33,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (34,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (35,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (36,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (37,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (38,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (39,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (40,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (41,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (43,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (44,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (45,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (46,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (47,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (48,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (50,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (52,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (54,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (55,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (57,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (58,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (61,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (63,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (64,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (65,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (66,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (67,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (68,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (69,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (71,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (72,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (73,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (74,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (77,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (78,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (79,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (81,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (82,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (87,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (93,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (94,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (95,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (96,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (97,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (98,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (99,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (103,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (105,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (106,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (109,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (111,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (112,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (113,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (114,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (117,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (118,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (120,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (121,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (122,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (124,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (125,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (126,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (127,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (128,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (129,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (130,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (131,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (139,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (143,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (144,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (146,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (149,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (151,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (152,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (158,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (162,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (163,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (164,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (165,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (166,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (167,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (168,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (170,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (173,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (175,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (177,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (178,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (179,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (180,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (181,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (183,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (188,1);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (1,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (59,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (70,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (83,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (84,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (88,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (89,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (128,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (135,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (172,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (184,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (185,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (186,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (187,2);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (2,3);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (53,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (56,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (60,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (62,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (74,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (75,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (76,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (80,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (85,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (86,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (100,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (101,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (104,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (105,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (108,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (110,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (111,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (115,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (117,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (123,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (127,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (128,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (129,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (132,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (137,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (138,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (140,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (145,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (147,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (151,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (154,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (155,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (160,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (167,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (171,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (174,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (176,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (182,4);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (49,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (53,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (56,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (60,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (62,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (74,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (75,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (76,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (80,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (86,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (100,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (101,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (108,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (110,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (115,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (123,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (132,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (137,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (138,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (140,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (145,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (147,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (148,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (150,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (154,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (155,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (171,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (174,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (176,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (182,5);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (3,7);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (4,7);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (116,7);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (74,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (90,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (91,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (92,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (102,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (107,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (119,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (133,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (134,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (136,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (141,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (142,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (153,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (156,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (157,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (159,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (161,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (169,8);
INSERT INTO `photo-links-project`.`photolinks_tags` (`event_id`,`tag_id`) VALUES (176,8);

