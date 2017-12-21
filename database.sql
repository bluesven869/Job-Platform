# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.53-0+deb8u1)
# Database: job_platform
# Generation Time: 2016-11-17 10:02:35 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table job_platform_applications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_applications`;

CREATE TABLE `job_platform_applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `cover` longtext COLLATE utf8_unicode_ci,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CE14E4F7A76ED395` (`user_id`),
  KEY `IDX_CE14E4F7BE04EA9` (`job_id`),
  CONSTRAINT `FK_CE14E4F7BE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job_platform_jobs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_CE14E4F7A76ED395` FOREIGN KEY (`user_id`) REFERENCES `job_platform_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_applications` WRITE;
/*!40000 ALTER TABLE `job_platform_applications` DISABLE KEYS */;

INSERT INTO `job_platform_applications` (`id`, `user_id`, `job_id`, `cover`, `created`, `modified`)
VALUES
	(3,2,8,'I like your job. Please check my profile.','2016-11-16 16:00:16',NULL);

/*!40000 ALTER TABLE `job_platform_applications` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_categories`;

CREATE TABLE `job_platform_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B0A86085989D9B62` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_categories` WRITE;
/*!40000 ALTER TABLE `job_platform_categories` DISABLE KEYS */;

INSERT INTO `job_platform_categories` (`id`, `name`, `slug`, `created`, `modified`)
VALUES
	(1,'WordPress','wordpress','0000-00-00 00:00:00',NULL),
	(2,'Java','java','0000-00-00 00:00:00',NULL),
	(3,'SEO/SEM','seo-sem','2016-10-22 12:37:52',NULL),
	(4,'Python','python','2016-10-22 12:38:11',NULL),
	(5,'SQL','sql','0000-00-00 00:00:00',NULL),
	(6,'Webdesign','webdesign','0000-00-00 00:00:00',NULL),
	(7,'Symfony','symfony','0000-00-00 00:00:00',NULL),
	(8,'PHP','php','0000-00-00 00:00:00',NULL),
	(9,'JavaScript','javascript','0000-00-00 00:00:00',NULL),
	(10,'React.js','reactjs','0000-00-00 00:00:00',NULL),
	(11,'Angular 2','angular2','0000-00-00 00:00:00',NULL),
	(12,'PostgreSQL','postgresql','0000-00-00 00:00:00',NULL),
	(13,'Linux','linux','0000-00-00 00:00:00',NULL),
	(14,'Photoshop','photoshop','0000-00-00 00:00:00',NULL),
	(15,'Illustrator','illustrator','0000-00-00 00:00:00',NULL),
	(16,'Data Mining','data-mining','0000-00-00 00:00:00',NULL),
	(17,'Copywriting','copywriting','0000-00-00 00:00:00',NULL),
	(18,'Marketing','marketing','0000-00-00 00:00:00',NULL),
	(19,'Link building ','link-building','0000-00-00 00:00:00',NULL),
	(20,'Magento','magento','0000-00-00 00:00:00',NULL),
	(21,'Drupal','drupal','0000-00-00 00:00:00',NULL);

/*!40000 ALTER TABLE `job_platform_categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_companies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_companies`;

CREATE TABLE `job_platform_companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logo_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkedin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_companies` WRITE;
/*!40000 ALTER TABLE `job_platform_companies` DISABLE KEYS */;

INSERT INTO `job_platform_companies` (`id`, `logo_name`, `name`, `description`, `email`, `country`, `address`, `website`, `phone`, `latitude`, `longitude`, `facebook`, `twitter`, `linkedin`, `is_verified`, `created`, `modified`)
VALUES
	(1,'5823378ab667d.png','Franklin Simon','<p>Suspendisse pretium justo nec metus finibus, id laoreet erat imperdiet. Donec quam dui, ornare sed dapibus at, rhoncus nec mi. Donec vestibulum sapien vitae leo consequat dictum. Duis interdum pharetra neque sit amet cursus. Fusce vulputate erat non felis bibendum, ut sodales nisl blandit.</p><p>Donec eros justo, ultrices sit amet justo sed, rhoncus facilisis risus. Praesent hendrerit, felis vel condimentum varius, nisi sapien faucibus quam, et gravida nunc arcu eu nunc. Aliquam luctus sem ut diam malesuada, sed facilisis enim imperdiet.&nbsp;</p>','info@wearecodevision.com','SK','2343 West Drive\r\nChicago, IL 60606','http://example.com','+0-123-456-789','40.722740','-74.002042','https://facebook.com','https://twitter.com','https://linkedin.com',NULL,'2016-11-09 15:40:58','2016-11-09 15:49:46'),
	(2,'582c70472a472.png','Magik Lamp','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.</p><p>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.</p>','sample@example.com','GB','2090 Rubaiyat Road\r\nWhite Cloud, MI 49349','http://example.com','+0-123-456-789','40.736535','-73.916235','https://facebook.com','https://twitter.com','https://linkedin.com',NULL,'2016-11-13 13:29:08','2016-11-16 15:42:15'),
	(3,'582c704d7f9c8.png','Young @ Heart','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','sample@example.com','US','348 Valley Lane\r\nAustin, TX 78746','http://example.com','+0-123-456-789','40.695941','-73.914871','http://facebook.com','http://twitter.com','http://linkedin.com',NULL,'2016-11-14 21:55:14','2016-11-16 15:42:21'),
	(4,'582c70544c859.png','Incredible Universe','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','sample@example.com','US','3981 Burke Street\r\nWellesley, MA 02181','http://example.com','+0-123-456-789','40.768292','-73.955419','http://facebook.com','http://twitter.com','http://linkedin.com',NULL,'2016-11-14 22:02:47','2016-11-16 15:42:28'),
	(5,'582c705a75ec2.png','Universal Design Partners','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','sample@example.com','US','3880 McDonald Avenue\r\nApopka, FL 32703','http://example.com','+0-123-456-789','40.721062','-74.066394','http://facebook.com','http://twitter.com','http://linkedin.com',NULL,'2016-11-14 22:08:38','2016-11-16 15:42:34'),
	(6,'582c7060d28e3.png','Showbiz Pizza Place','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','sample@example.com','US','3740 Memory Lane\r\nRockford, IL 61101','http://example.com','+0-123-456-789','40.702585','-73.947261','http://facebook.com','http://twitter.com','http://linkedin.com',NULL,'2016-11-15 16:03:51','2016-11-16 15:42:40'),
	(7,'582c7065b28e7.png','Omni Realty','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','sample@example.com','US','1539 Sand Fork Road\r\nLogansport, IN 46947','http://example.com','+0-123-456-789','40.732260','-73.808647','http://facebook.com','http://twitter.com','http://linkedin.com',NULL,'2016-11-15 17:42:44','2016-11-16 15:42:45'),
	(8,'582c706b50d27.png','Magna Gases','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','sample@example.com','US','1273 Marion Drive\r\nPlant City, FL 33566','http://example.com','+0-123-456-789','40.756649','-74.074906','http://facebook.com','http://twitter.com','http://linkedin.com',NULL,'2016-11-15 17:50:18','2016-11-16 15:42:51');

/*!40000 ALTER TABLE `job_platform_companies` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_contracts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_contracts`;

CREATE TABLE `job_platform_contracts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_contracts` WRITE;
/*!40000 ALTER TABLE `job_platform_contracts` DISABLE KEYS */;

INSERT INTO `job_platform_contracts` (`id`, `name`)
VALUES
	(1,'Full-time'),
	(2,'Part-time'),
	(3,'Brigade');

/*!40000 ALTER TABLE `job_platform_contracts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_educations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_educations`;

CREATE TABLE `job_platform_educations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `degree` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `field` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `year_from` int(11) NOT NULL,
  `year_to` int(11) NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F9535040A76ED395` (`user_id`),
  CONSTRAINT `FK_F9535040A76ED395` FOREIGN KEY (`user_id`) REFERENCES `job_platform_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_educations` WRITE;
/*!40000 ALTER TABLE `job_platform_educations` DISABLE KEYS */;

INSERT INTO `job_platform_educations` (`id`, `user_id`, `name`, `degree`, `field`, `year_from`, `year_to`, `description`, `created`, `modified`)
VALUES
	(1,3,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-09 20:48:07',NULL),
	(2,3,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-09 20:48:07',NULL),
	(3,3,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-09 20:48:07',NULL),
	(4,2,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-09 21:09:52',NULL),
	(5,2,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-09 21:09:52',NULL),
	(6,2,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-09 21:09:52',NULL),
	(7,4,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-09 21:15:36',NULL),
	(8,4,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-09 21:15:36',NULL),
	(9,4,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-09 21:15:36',NULL),
	(10,8,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 13:49:58',NULL),
	(11,8,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 13:51:53',NULL),
	(12,8,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a','2016-11-13 13:52:38',NULL),
	(13,5,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 13:57:49',NULL),
	(14,5,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 13:58:33',NULL),
	(15,5,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 13:59:20',NULL),
	(16,6,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:02:39',NULL),
	(17,6,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:03:18',NULL),
	(18,6,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:04:08',NULL),
	(19,9,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:12:49',NULL),
	(20,9,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:12:49',NULL),
	(21,9,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:12:49',NULL),
	(22,10,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:20:15',NULL),
	(23,10,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:20:15',NULL),
	(24,10,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:20:15',NULL),
	(25,11,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:27:15',NULL),
	(26,11,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:27:15',NULL),
	(27,11,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:27:15',NULL),
	(28,7,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:35:45',NULL),
	(29,7,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:35:45',NULL),
	(30,7,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 14:35:45',NULL),
	(31,13,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 21:33:59',NULL),
	(32,13,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 21:33:59',NULL),
	(33,13,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 21:33:59',NULL),
	(34,14,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 21:50:38',NULL),
	(35,14,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 21:50:38',NULL),
	(36,14,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-13 21:50:38',NULL),
	(37,15,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-14 21:04:24',NULL),
	(38,15,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-14 21:04:24',NULL),
	(39,15,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-14 21:04:24',NULL),
	(40,16,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-14 21:18:16',NULL),
	(41,16,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-14 21:18:16',NULL),
	(42,16,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-14 21:18:16',NULL),
	(43,17,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-14 21:38:43',NULL),
	(44,17,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-14 21:38:43',NULL),
	(45,17,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-14 21:38:43',NULL),
	(46,18,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-15 16:11:11',NULL),
	(47,18,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-15 16:11:11',NULL),
	(48,18,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-15 16:11:11',NULL),
	(49,19,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-15 17:35:18',NULL),
	(50,19,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-15 17:35:18',NULL),
	(51,19,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-15 17:35:18',NULL),
	(52,20,'Evencrest Secondary of Engineering','Master\'s','Information Technologies',2012,2016,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-16 17:10:01',NULL),
	(53,20,'Oxdell School of Performance Arts','Master\'s','UI/UX',2008,2012,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-16 17:10:01',NULL),
	(54,20,'Dewdell School of Music','Master\'s','Management',2004,2008,'Quisque quam erat, finibus eget augue sit amet, vulputate dapibus magna. Sed viverra purus sed nulla efficitur, et finibus sem suscipit. Sed ultrices elementum enim, sed maximus nibh facilisis a.','2016-11-16 17:10:01',NULL);

/*!40000 ALTER TABLE `job_platform_educations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_experiences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_experiences`;

CREATE TABLE `job_platform_experiences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `month_from` int(11) NOT NULL,
  `year_from` int(11) NOT NULL,
  `month_to` int(11) NOT NULL,
  `year_to` int(11) NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5C33CB93A76ED395` (`user_id`),
  CONSTRAINT `FK_5C33CB93A76ED395` FOREIGN KEY (`user_id`) REFERENCES `job_platform_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_experiences` WRITE;
/*!40000 ALTER TABLE `job_platform_experiences` DISABLE KEYS */;

INSERT INTO `job_platform_experiences` (`id`, `user_id`, `company_name`, `name`, `month_from`, `year_from`, `month_to`, `year_to`, `description`, `created`, `modified`)
VALUES
	(1,3,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-09 20:49:08',NULL),
	(2,3,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-09 20:49:08',NULL),
	(3,2,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-09 21:11:18',NULL),
	(4,2,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-09 21:11:18',NULL),
	(5,4,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-09 21:16:40',NULL),
	(6,4,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-09 21:16:40',NULL),
	(7,8,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 13:53:51',NULL),
	(8,8,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 13:55:20',NULL),
	(9,5,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:00:25',NULL),
	(10,5,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:01:11',NULL),
	(11,6,'Schucks Auto Supply','Real estate appraiser',2,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:05:58',NULL),
	(12,6,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:05:58',NULL),
	(13,9,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:15:07',NULL),
	(14,9,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:15:07',NULL),
	(15,10,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:21:41',NULL),
	(16,10,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:21:41',NULL),
	(17,11,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:28:51',NULL),
	(18,11,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:28:51',NULL),
	(19,7,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:37:21',NULL),
	(20,7,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 14:37:21',NULL),
	(21,13,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 21:35:39',NULL),
	(22,13,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 21:35:39',NULL),
	(23,14,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 21:56:37',NULL),
	(24,14,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-13 21:56:37',NULL),
	(25,15,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-14 21:06:22',NULL),
	(26,15,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-14 21:06:22',NULL),
	(27,16,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-14 21:21:43',NULL),
	(28,16,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-14 21:21:43',NULL),
	(29,17,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-14 21:42:02',NULL),
	(30,17,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-14 21:42:02',NULL),
	(31,18,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-15 16:13:05',NULL),
	(32,18,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-15 16:13:05',NULL),
	(33,19,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-15 17:37:17',NULL),
	(34,19,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-15 17:37:17',NULL),
	(35,20,'Schucks Auto Supply','Real estate appraiser',8,2012,10,2012,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-16 17:11:38',NULL),
	(36,20,'Mikrotechnic','Clerical supervisor',2,2013,5,2014,'Liquam facilisis ex purus, eu pulvinar eros commodo sed. Aliquam id nunc eget ante tempor tristique. Quisque quam erat, finibus eget augue sit amet','2016-11-16 17:11:38',NULL);

/*!40000 ALTER TABLE `job_platform_experiences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_favorites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_favorites`;

CREATE TABLE `job_platform_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DA8661EEA76ED395` (`user_id`),
  KEY `IDX_DA8661EEBE04EA9` (`job_id`),
  CONSTRAINT `FK_DA8661EEBE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job_platform_jobs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_DA8661EEA76ED395` FOREIGN KEY (`user_id`) REFERENCES `job_platform_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_favorites` WRITE;
/*!40000 ALTER TABLE `job_platform_favorites` DISABLE KEYS */;

INSERT INTO `job_platform_favorites` (`id`, `user_id`, `job_id`, `created`, `modified`)
VALUES
	(1,2,12,'2016-11-16 15:48:34',NULL),
	(2,2,3,'2016-11-16 15:48:38',NULL),
	(3,2,7,'2016-11-16 15:48:44',NULL),
	(4,2,8,'2016-11-16 15:48:49',NULL);

/*!40000 ALTER TABLE `job_platform_favorites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_job_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_job_category`;

CREATE TABLE `job_platform_job_category` (
  `job_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`job_id`,`category_id`),
  KEY `IDX_58D63EBDBE04EA9` (`job_id`),
  KEY `IDX_58D63EBD12469DE2` (`category_id`),
  CONSTRAINT `FK_58D63EBD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `job_platform_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_58D63EBDBE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job_platform_jobs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_job_category` WRITE;
/*!40000 ALTER TABLE `job_platform_job_category` DISABLE KEYS */;

INSERT INTO `job_platform_job_category` (`job_id`, `category_id`)
VALUES
	(1,1),
	(1,3),
	(1,6),
	(2,3),
	(2,6),
	(2,17),
	(2,19),
	(3,1),
	(3,3),
	(3,17),
	(4,5),
	(4,6),
	(4,7),
	(5,3),
	(5,18),
	(5,19),
	(6,14),
	(6,15),
	(6,20),
	(7,3),
	(7,16),
	(7,17),
	(7,18),
	(7,19),
	(8,9),
	(8,10),
	(8,11),
	(9,17),
	(9,18),
	(9,19),
	(10,4),
	(10,5),
	(10,6),
	(10,9),
	(10,10),
	(10,11),
	(11,1),
	(11,20),
	(11,21),
	(12,7),
	(12,18),
	(12,19);

/*!40000 ALTER TABLE `job_platform_job_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_jobs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_jobs`;

CREATE TABLE `job_platform_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `contract_id` int(11) DEFAULT NULL,
  `project_type_id` int(11) DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(7,2) DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `featured_until` datetime DEFAULT NULL,
  `is_published` tinyint(1) DEFAULT NULL,
  `published_until` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_87455425A76ED395` (`user_id`),
  KEY `IDX_87455425979B1AD6` (`company_id`),
  KEY `IDX_874554252576E0FD` (`contract_id`),
  KEY `IDX_87455425535280F6` (`project_type_id`),
  CONSTRAINT `FK_87455425979B1AD6` FOREIGN KEY (`company_id`) REFERENCES `job_platform_companies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_874554252576E0FD` FOREIGN KEY (`contract_id`) REFERENCES `job_platform_contracts` (`id`),
  CONSTRAINT `FK_87455425535280F6` FOREIGN KEY (`project_type_id`) REFERENCES `job_platform_project_types` (`id`),
  CONSTRAINT `FK_87455425A76ED395` FOREIGN KEY (`user_id`) REFERENCES `job_platform_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_jobs` WRITE;
/*!40000 ALTER TABLE `job_platform_jobs` DISABLE KEYS */;

INSERT INTO `job_platform_jobs` (`id`, `user_id`, `company_id`, `contract_id`, `project_type_id`, `name`, `description`, `country`, `price`, `is_featured`, `created`, `modified`, `featured_until`, `is_published`, `published_until`)
VALUES
	(1,2,2,1,2,'WordPress Website Development','<p>Proin gravida massa condimentum bibendum bibendum. Fusce tempor fermentum massa varius suscipit. Etiam molestie a nunc a cursus. Vestibulum nec tellus malesuada, vehicula orci ornare, posuere nibh.</p><p>Cras luctus eleifend odio eu consequat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum convallis a enim sed mattis. Curabitur non nulla porta, condimentum odio in, malesuada nisi.</p>','AU',2000.00,1,'2016-11-14 15:03:51','2016-11-17 11:01:22',NULL,1,NULL),
	(2,2,3,2,1,'Sales Manager','<p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify;\"><font face=\"Open Sans, Arial, sans-serif\"><span style=\"font-size: 14px;\">Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</span></font></p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify;\"><font face=\"Open Sans, Arial, sans-serif\"><span style=\"font-size: 14px;\"><br></span></font><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\">Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</span></p>','US',NULL,0,'2016-11-14 15:13:32','2016-11-17 11:01:45',NULL,1,NULL),
	(3,2,4,1,2,'Website Copywriter','<p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\">Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\">Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</p>','GB',NULL,1,'2016-11-14 15:14:12','2016-11-17 11:01:48',NULL,1,NULL),
	(4,2,5,3,1,'Symfony / MySQL Work','<p>Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p><p>Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</p>','CA',NULL,0,'2016-11-14 15:15:01','2016-11-17 11:01:51',NULL,1,NULL),
	(5,2,6,1,2,'Ads Coaching','<p>Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p><p>Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</p>','US',800.00,0,'2016-11-14 15:17:17','2016-11-17 11:01:55',NULL,1,NULL),
	(6,2,7,1,1,'UX/UI Designer','<p>Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p><p>Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</p>','AT',NULL,1,'2016-11-14 15:18:03','2016-11-17 11:02:00',NULL,1,NULL),
	(7,2,8,2,2,'Mailchimp Marketing','<p>Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p><p>Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</p>','CH',NULL,0,'2016-11-14 15:18:47','2016-11-17 11:02:07',NULL,1,NULL),
	(8,2,1,3,1,'Front End JavaScript Developer','<p>Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p><p>Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</p>','DE',NULL,NULL,'2016-11-14 15:19:33','2016-11-14 15:34:38',NULL,1,NULL),
	(9,2,2,2,2,'Social Media Coaching','<p>Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p><p>Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</p>','FR',340.00,1,'2016-11-14 15:20:27','2016-11-17 11:02:12',NULL,1,NULL),
	(10,2,3,1,1,'Fullstack Django/Python Developer','<p>Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. </p><p>Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</p>','GB',NULL,0,'2016-11-14 15:21:23','2016-11-17 11:02:17',NULL,1,NULL),
	(11,2,4,1,2,'Open Source CMS Guru','<p>Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p><p>Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</p>','CA',NULL,0,'2016-11-14 15:21:50','2016-11-17 11:02:22',NULL,1,NULL),
	(12,2,1,1,2,'Data Analytics System','<p>Ut nec turpis erat. Aliquam fermentum, dolor eu tincidunt ornare, mauris mauris lacinia justo, in iaculis enim neque vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p><p>Maecenas tristique dictum dui ut malesuada. Suspendisse a auctor lectus, non commodo nunc. Phasellus rhoncus a urna eget ultrices. Ut vulputate eros eu augue tincidunt semper. Cras a sapien magna. Pellentesque eu pretium massa, id elementum mi.</p>','DK',NULL,1,'2016-11-14 15:22:46','2016-11-16 14:01:25',NULL,1,NULL);

/*!40000 ALTER TABLE `job_platform_jobs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_order_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_order_items`;

CREATE TABLE `job_platform_order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `type` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `price` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BCB158538D9F6D38` (`order_id`),
  KEY `IDX_BCB15853BE04EA9` (`job_id`),
  CONSTRAINT `FK_BCB15853BE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job_platform_jobs` (`id`),
  CONSTRAINT `FK_BCB158538D9F6D38` FOREIGN KEY (`order_id`) REFERENCES `job_platform_orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table job_platform_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_orders`;

CREATE TABLE `job_platform_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gateway` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `currency` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `price` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `company_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `reg_no` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `vat_no` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `county` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `street` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `postal_code` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E454A9DCA76ED395` (`user_id`),
  KEY `IDX_E454A9DC979B1AD6` (`company_id`),
  CONSTRAINT `FK_E454A9DC979B1AD6` FOREIGN KEY (`company_id`) REFERENCES `job_platform_companies` (`id`),
  CONSTRAINT `FK_E454A9DCA76ED395` FOREIGN KEY (`user_id`) REFERENCES `job_platform_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table job_platform_payment_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_payment_tokens`;

CREATE TABLE `job_platform_payment_tokens` (
  `hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `details` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:object)',
  `after_url` longtext COLLATE utf8_unicode_ci,
  `target_url` longtext COLLATE utf8_unicode_ci NOT NULL,
  `gateway_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table job_platform_payments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_payments`;

CREATE TABLE `job_platform_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_amount` int(11) DEFAULT NULL,
  `currency_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `details` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_E4A45BD58D9F6D38` (`order_id`),
  CONSTRAINT `FK_E4A45BD58D9F6D38` FOREIGN KEY (`order_id`) REFERENCES `job_platform_orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table job_platform_profiles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_profiles`;

CREATE TABLE `job_platform_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `avatar_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `phone` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkedin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A4645D7A76ED395` (`user_id`),
  CONSTRAINT `FK_A4645D7A76ED395` FOREIGN KEY (`user_id`) REFERENCES `job_platform_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_profiles` WRITE;
/*!40000 ALTER TABLE `job_platform_profiles` DISABLE KEYS */;

INSERT INTO `job_platform_profiles` (`id`, `user_id`, `type`, `avatar_name`, `first_name`, `last_name`, `title`, `country`, `address`, `description`, `phone`, `website`, `facebook`, `twitter`, `linkedin`, `created`, `modified`)
VALUES
	(1,2,'public','58298c486bda1.jpg','Mario','Matthews','Full Stack Developer','US','3232 Browning Lane\r\nMadison, WI 53703','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.</p><p>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.</p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-09 15:37:42','2016-11-14 11:04:56'),
	(8,3,'public','58298c5969697.jpg','Donald','Thomas','Java Expert','US','3232 Browning Lane\r\nMadison, WI 53703','<p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 1rem; line-height: 2; color: rgb(0, 0, 0); font-family: Poppins, Arial, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 1rem; line-height: 2; color: rgb(0, 0, 0); font-family: Poppins, Arial, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.</p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-09 20:42:38','2016-11-14 11:05:13'),
	(9,4,'public','58298c219cafa.jpg','Gregory','Bohannon','SEO Guru','GB','3232 Browning Lane\r\nMadison, WI 53703','<p>Integer\r\n augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque\r\n vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum \r\nluctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla \r\nfinibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, \r\nsagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.</p><p>Phasellus\r\n bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque\r\n nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas \r\nlibero, eget vestibulum tortor. Donec nibh tellus, elementum nec \r\ndignissim nec, mattis in lectus. Vivamus mollis metus eget libero \r\nmaximus, non euismod elit euismod. Vestibulum ut diam vitae turpis \r\npellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet \r\nfinibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue\r\n ante.</p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-09 21:13:55','2016-11-14 11:04:17'),
	(10,5,'public','58298c19ee5cc.jpg','Franklin','Parker','Department head','US','1987 Roosevelt Street\r\nSan Francisco, CA 94110','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-13 13:36:07','2016-11-14 11:04:09'),
	(11,6,'public','58298c12f23ca.jpg','Virginie','Beausoleil','Personal trainer','FR','25, place de Miremont\r\n47300 VILLENEUVE-SUR-LOT','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-13 13:42:31','2016-11-14 11:04:02'),
	(12,8,'public','58298c0c50615.jpg','Claudia','Egger','Business support assistant','DE','Buelowstrasse 35\r\n57648 Bölsberg','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-13 13:47:58','2016-11-14 11:03:56'),
	(13,9,'public','58298c049b957.jpg','Lewis','Brennan','Production cost estimator','GB','90 Iffley Road\r\nBROADBRIDGE HEATH\r\nRH12 5YA','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-13 14:10:47','2016-11-14 11:03:48'),
	(14,10,'public','58298bfb34777.jpg','Kenan','Engström','Nursery worker','SE','Sandlyckan 30\r\n840 32  KLÖVSJÖ','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-13 14:18:13','2016-11-14 11:03:39'),
	(15,11,'public','58298bf31ad88.jpg','Kevin','Miller','Directory assistance operator','US','3836 Glenwood Avenue\r\nSouth Euclid, OH 44121','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-13 14:25:22','2016-11-14 11:03:31'),
	(16,7,'public','58298bd9cadcb.jpg','Alexandra','Hassall','Office support team leader','AU','30 Porana Place\r\nBALLIDU WA 6606','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-13 14:34:01','2016-11-14 11:03:05'),
	(17,13,'public','58298bc8145c2.jpg','Mildred','Bentley','Real estate agent','US','1900 Junkins Avenue\r\nAlbany, GA 31701','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-13 21:31:08','2016-11-14 11:02:48'),
	(18,14,'public','58298b87c6c58.jpg','Kari','Heiskanen','Environmental engineering technician','FI','Sahantie 12\r\n33230 TAMPERE','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-13 21:48:15','2016-11-14 11:01:43'),
	(19,15,'PUBLIC','582c6da60a2e2.jpg','Nanna','Eriksen','Documentation specialist','DK','Fynshovedvej 13\r\n5892 Gudbjerg Sydfyn','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-14 21:00:48','2016-11-16 15:31:02'),
	(20,16,'PUBLIC','582c6dad26999.jpg','Dieter','Herz','Automotive repairer','DE','Koepenicker Str. 43\r\n55743 Idar-Oberstein','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-14 21:16:02','2016-11-16 15:31:09'),
	(21,17,'PUBLIC','582c6db3563fc.jpg','Elizabeth','Clemmons','Administrative office specialist','US','567 Nelm Street\r\nVienna, VA 22182','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-14 21:28:14','2016-11-16 15:31:15'),
	(22,18,'PUBLIC','582c6dba0ac44.jpg','Jordan','Crespo','Natural sciences manager','ES','Padre Caro, 68\r\n13680 Fuente el Fresno','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-15 16:08:56','2016-11-16 15:31:22'),
	(23,19,'PUBLIC','582c6dc2c3a81.jpg','Zak','Ferguson','Administrative manager','GB','Administrative manager','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://linkedin.com','2016-11-15 17:33:27','2016-11-16 15:31:30'),
	(24,20,'PUBLIC','582c6dcd49d67.jpg','Leslie','Nava','Nuclear engineer','US','4185 Austin Avenue\r\nSavannah, GA 31401','<p>Integer augue mauris, dictum ut tellus eget, auctor finibus augue. Pellentesque vel elit vel ante rutrum aliquet sit amet vel sem. Integer dictum luctus nisi. Etiam tincidunt dolor et ultrices porta. Integer fringilla finibus posuere. Mauris et tellus finibus, scelerisque sem sit amet, sagittis augue. Cras et nibh ac tellus gravida vestibulum ut eu lorem.<br><br>Phasellus bibendum leo id est ultrices, a interdum sapien tincidunt. Pellentesque nibh mi, sollicitudin ac vehicula id, auctor in augue. Fusce a egestas libero, eget vestibulum tortor. Donec nibh tellus, elementum nec dignissim nec, mattis in lectus. Vivamus mollis metus eget libero maximus, non euismod elit euismod. Vestibulum ut diam vitae turpis pellentesque imperdiet. Nunc tellus ex, luctus id orci vel, laoreet finibus augue. Maecenas leo magna, pharetra et erat eu, ultricies congue ante.<br></p>','+0-123-456-789','http://example.com','http://facebook.com','http://twitter.com','http://twitter.com','2016-11-15 17:48:39','2016-11-16 15:31:41');

/*!40000 ALTER TABLE `job_platform_profiles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_project_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_project_types`;

CREATE TABLE `job_platform_project_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_project_types` WRITE;
/*!40000 ALTER TABLE `job_platform_project_types` DISABLE KEYS */;

INSERT INTO `job_platform_project_types` (`id`, `name`)
VALUES
	(1,'Ongoing'),
	(2,'One-time');

/*!40000 ALTER TABLE `job_platform_project_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_searches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_searches`;

CREATE TABLE `job_platform_searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `query` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E16EF8FEA76ED395` (`user_id`),
  CONSTRAINT `FK_E16EF8FEA76ED395` FOREIGN KEY (`user_id`) REFERENCES `job_platform_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table job_platform_user_company
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_user_company`;

CREATE TABLE `job_platform_user_company` (
  `user_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`company_id`),
  KEY `IDX_2E6F9542A76ED395` (`user_id`),
  KEY `IDX_2E6F9542979B1AD6` (`company_id`),
  CONSTRAINT `FK_2E6F9542979B1AD6` FOREIGN KEY (`company_id`) REFERENCES `job_platform_companies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2E6F9542A76ED395` FOREIGN KEY (`user_id`) REFERENCES `job_platform_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_user_company` WRITE;
/*!40000 ALTER TABLE `job_platform_user_company` DISABLE KEYS */;

INSERT INTO `job_platform_user_company` (`user_id`, `company_id`)
VALUES
	(2,1),
	(3,2),
	(3,3),
	(3,4),
	(3,5),
	(3,6),
	(3,7),
	(20,8);

/*!40000 ALTER TABLE `job_platform_user_company` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job_platform_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_platform_users`;

CREATE TABLE `job_platform_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `locked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `credentials_expired` tinyint(1) NOT NULL,
  `credentials_expire_at` datetime DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B4A691A892FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_B4A691A8A0D96FBF` (`email_canonical`),
  UNIQUE KEY `UNIQ_B4A691A8C05FB297` (`confirmation_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `job_platform_users` WRITE;
/*!40000 ALTER TABLE `job_platform_users` DISABLE KEYS */;

INSERT INTO `job_platform_users` (`id`, `username`, `username_canonical`, `email`, `email_canonical`, `enabled`, `salt`, `password`, `last_login`, `locked`, `expired`, `expires_at`, `confirmation_token`, `password_requested_at`, `roles`, `credentials_expired`, `credentials_expire_at`, `is_verified`, `created`, `modified`)
VALUES
	(2,'admin','admin','info@wearecodevision.com','info@wearecodevision.com',1,'sja3evxyjhcg8gs0go40ggwwsgssc04','$2y$13$ArlUVwiTR6Z1q4J4k7rdYOugetVr0mFrPAJIgFyN1lMqsGPX5i01y','2016-11-17 10:57:49',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,NULL,'2016-11-09 14:57:18','2016-11-17 10:57:49'),
	(3,'sample1','sample1','sample1@example.com','sample1@example.com',1,'nbjodt4a17kgcg888w8oc8w0os0sg4c','$2y$13$OZScYe0RfszrrzePHl0Ub.m7npQdE/5uI0pc56NBTgGGgRdoUr/KW','2016-11-15 17:37:50',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,1,'2016-11-09 20:23:58','2016-11-15 17:42:44'),
	(4,'sample2','sample2','sample2@example.com','sample2@example.com',1,'gjqwhkuje28sw4wgo4ok88848c4oo44','$2y$13$aP1JUWkFfDvfVeOkBJE1XehrlAZvnwJ/fQtqNkhKHQYFUu6IyeTNi','2016-11-09 21:12:04',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:24:06','2016-11-09 21:12:04'),
	(5,'sample3','sample3','sample3@example.com','sample3@example.com',1,'dkc42hbqqmg44804ockc00kswssw88g','$2y$13$i9MrLq.82oLHd/vLPvZXLuZXj4TfDixmnE3JEk8ZJp3E9cfU6wS6W','2016-11-13 13:56:51',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,1,'2016-11-09 20:24:15','2016-11-14 11:28:04'),
	(6,'sample4','sample4','sample4@example.com','sample4@example.com',1,'4x05jwv71r8kg4wocswo4sc0ogcg4s0','$2y$13$z/tVeno5tnaVSRYxc9qQR.q2RE2Pqm6tSLOWUCGE3QB3A4DeCFtta','2016-11-13 14:01:47',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:24:23','2016-11-13 14:01:47'),
	(7,'sample5','sample5','sample5@example.com','sample5@example.com',1,'sl0wntaa1k0kwcwo4gwcc8scws4808w','$2y$13$qSnss7OqLawxiOCmEQFGv.IaOOAycBLNF/2vTQm6KRCC7/OPN0cPS','2016-11-13 14:31:38',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,1,'2016-11-09 20:24:32','2016-11-14 11:28:06'),
	(8,'sample6','sample6','sample6@example.com','sample6@example.com',1,'bxdhy79pdqg48kc80cgsow04ksgkogo','$2y$13$Ii/nYIOo2pk9gF3IO7HoGOwlaAhBFHb/N2CZW6pu4bb75jBHRC62S','2016-11-13 14:31:22',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:24:40','2016-11-13 14:31:22'),
	(9,'sample7','sample7','sample7@example.com','sample7@example.com',1,'75ztxqwhh98gwo8wk4k04kscws0ogco','$2y$13$MxF2KyZsgdFmUBRHoE4vhe57HbdMRcl.r47x2v151v8OI5W3J3d0q','2016-11-13 14:31:02',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:24:48','2016-11-13 14:31:02'),
	(10,'sample8','sample8','sample8@example.com','sample8@example.com',1,'3xdk3cc5phc0k0w88kgg8wss0ccoso8','$2y$13$s4vTBWCrEkuw4aR5fm8bKe0nKgZIFqJLWRKsRCBNTJv2pQhPhogWW','2016-11-13 14:30:40',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,1,'2016-11-09 20:24:58','2016-11-14 11:28:09'),
	(11,'sample9','sample9','sample9@example.com','sample9@example.com',1,'al78gjod1sg8ocoosgckw8cg4o008go','$2y$13$LFuWv4.Z.lLRZkIMNPspw.6kah.2Rx6VXIZdzz0dYlUrSPbpufgoC','2016-11-13 14:30:09',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,1,'2016-11-09 20:25:08','2016-11-14 11:28:10'),
	(12,'sample10','sample10','sample10@example.com','sample10@example.com',1,'a2089enbvew4ss88okog04wgcsc480g','$2y$13$W771ucXfRfzw2MJrHIPYgOOTkKoPUApV6uhu6OkHMFRU/lGk2Ww3q',NULL,0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:25:17',NULL),
	(13,'sample11','sample11','sample11@example.com','sample11@example.com',1,'eliourd6o8gsowg4sko0ko48c44cwco','$2y$13$BJU.OcgLpRL12OtWm16jEOg0LfjOXDZnthNlbJvdaBUtuZwCE2ewG','2016-11-13 21:21:07',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:25:26','2016-11-13 21:21:07'),
	(14,'sample12','sample12','sample12@example.com','sample12@example.com',1,'72plp26pwe0w00ko0sw484gco444k84','$2y$13$g0n0NShiTSiyhavAjC4FJeWPn7gmOF0EbF5FFPeobQhNYMpAzuSOy','2016-11-13 21:43:56',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,1,'2016-11-09 20:25:34','2016-11-14 11:28:12'),
	(15,'sample13','sample13','sample13@example.com','sample13@example.com',1,'h86esapi5eok0c088ggocss4kkw8skk','$2y$13$/cvmi4YWwviUG/96VmBrbeIgKX/Nl7K1BPVrbw8PUmf6QJF0lTuxu','2016-11-14 20:49:39',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:25:42','2016-11-14 21:06:22'),
	(16,'sample14','sample14','sample14@example.com','sample14@example.com',1,'lpb4wywpry8wwos8w0w0gkswg4woosc','$2y$13$3P7VU3DoGjOncyac/3Syt.gIueakRsLdTXV7gVCC88MMyLiwz.JiC','2016-11-14 21:12:07',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:25:51','2016-11-14 21:21:43'),
	(17,'sample15','sample15','sample15@example.com','sample15@example.com',1,'in4l66kl9pckw8gcowwos0w80wkks0w','$2y$13$Yu94srmWGb2QsilYuTW/KuiwlCNUWhMB6s3aBVGjtr6eBaEbfMFSa','2016-11-14 21:25:22',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,1,'2016-11-09 20:25:59','2016-11-14 21:42:02'),
	(18,'sample16','sample16','sample16@example.com','sample16@example.com',1,'j0vr7jc1o68gc408wcos0kkk0s48c00','$2y$13$d4XPUyDPygCEU.QsHcXTGOLw76K4Idlbcihp9xEfRr58kKgNlxxSu','2016-11-15 16:04:35',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:26:09','2016-11-15 16:13:05'),
	(19,'sample17','sample17','sample17@example.com','sample17@example.com',1,'ozkc3t0anvkkookoogossskg4ccww0c','$2y$13$J3LzWFJdsO1XyohORGAH7emlaWrOOl6JOz7ZBWqWowQg/EV4n2Z6K','2016-11-15 17:31:00',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,1,'2016-11-09 20:26:19','2016-11-15 17:37:17'),
	(20,'sample18','sample18','sample18@example.com','sample18@example.com',1,'ri7qx31ojqosok8ogwckwwk8kcsk84','$2y$13$SpwecQC644lQeG7bc9BnaupzDWaCgmkevpMw3AkVr5m7zSoRKEwFe','2016-11-15 17:44:41',0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:26:30','2016-11-16 17:11:38'),
	(21,'sample19','sample19','sample19@example.com','sample19@example.com',1,'fja979bo4qo08g448gs448csw8osc44','$2y$13$SSqDR/z8VxALg18IzYmD5eE9skQLsKGH6fyyQF4NFIjiOtZs2UyYm',NULL,0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,1,'2016-11-09 20:26:41','2016-11-14 11:28:19'),
	(22,'sample20','sample20','sample20@example.com','sample20@example.com',1,'n32aandjvn4swow04cwws0os4g8sosk','$2y$13$G2C9t73cumd5PrO5SlWMAugr07b74jaKER4hfs4.1hMVjEyWN5NKO',NULL,0,0,NULL,NULL,NULL,'a:0:{}',0,NULL,NULL,'2016-11-09 20:26:51',NULL);

/*!40000 ALTER TABLE `job_platform_users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
