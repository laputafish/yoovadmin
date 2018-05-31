-- --------------------------------------------------------
-- Host:                         192.168.1.222
-- Server version:               10.1.9-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table yoov_api.attributes
CREATE TABLE IF NOT EXISTS `attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `alias` varchar(50) NOT NULL DEFAULT '',
  `remark` text NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `label` varchar(50) NOT NULL DEFAULT '0',
  `type` enum('yesno','single','multiple') NOT NULL DEFAULT 'single',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.attributes: ~0 rows (approximately)
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;

-- Dumping structure for table yoov_api.attribute_options
CREATE TABLE IF NOT EXISTS `attribute_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_id` int(11) DEFAULT '0',
  `label` varchar(50) DEFAULT '',
  `price` double DEFAULT '0',
  `remark` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.attribute_options: ~0 rows (approximately)
/*!40000 ALTER TABLE `attribute_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_options` ENABLE KEYS */;

-- Dumping structure for table yoov_api.bundles
CREATE TABLE IF NOT EXISTS `bundles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `alias` varchar(50) NOT NULL DEFAULT '',
  `price` double unsigned NOT NULL DEFAULT '0',
  `remark` text NOT NULL,
  `price_type` enum('fixed','variable') NOT NULL DEFAULT 'variable',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.bundles: ~0 rows (approximately)
/*!40000 ALTER TABLE `bundles` DISABLE KEYS */;
/*!40000 ALTER TABLE `bundles` ENABLE KEYS */;

-- Dumping structure for table yoov_api.bundle_categories
CREATE TABLE IF NOT EXISTS `bundle_categories` (
  `bundle_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `qty` int(10) unsigned NOT NULL DEFAULT '1',
  `remark` text NOT NULL,
  PRIMARY KEY (`bundle_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.bundle_categories: ~0 rows (approximately)
/*!40000 ALTER TABLE `bundle_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `bundle_categories` ENABLE KEYS */;

-- Dumping structure for table yoov_api.bundle_exceptions
CREATE TABLE IF NOT EXISTS `bundle_exceptions` (
  `bundle_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `price_difference` double DEFAULT '0',
  `disabled` tinyint(1) unsigned DEFAULT '0',
  `remark` text,
  PRIMARY KEY (`bundle_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.bundle_exceptions: ~0 rows (approximately)
/*!40000 ALTER TABLE `bundle_exceptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `bundle_exceptions` ENABLE KEYS */;

-- Dumping structure for table yoov_api.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `alias` varchar(50) NOT NULL DEFAULT '',
  `remark` text NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `_lft` int(10) unsigned NOT NULL DEFAULT '0',
  `_rgt` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.categories: ~3 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`, `alias`, `remark`, `price`, `created_at`, `updated_at`, `_lft`, `_rgt`, `parent_id`) VALUES
	(1, '燒味飯類', '', '', 0, '2018-05-07 12:51:29', '0000-00-00 00:00:00', 0, 0, 0),
	(2, '港式粥品', '', '', 0, '2018-05-07 12:51:39', '0000-00-00 00:00:00', 0, 0, 0),
	(3, '炒燴飯類', '', '', 0, '2018-05-07 12:51:48', '0000-00-00 00:00:00', 0, 0, 0);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table yoov_api.category_attributes
CREATE TABLE IF NOT EXISTS `category_attributes` (
  `category_id` int(10) unsigned NOT NULL,
  `attribute_id` int(10) unsigned NOT NULL,
  `price` double unsigned NOT NULL DEFAULT '0',
  `remark` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`category_id`,`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.category_attributes: ~0 rows (approximately)
/*!40000 ALTER TABLE `category_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_attributes` ENABLE KEYS */;

-- Dumping structure for table yoov_api.category_products
CREATE TABLE IF NOT EXISTS `category_products` (
  `category_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `price` double unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`category_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.category_products: ~0 rows (approximately)
/*!40000 ALTER TABLE `category_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_products` ENABLE KEYS */;

-- Dumping structure for table yoov_api.commands
CREATE TABLE IF NOT EXISTS `commands` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `last_checked_at` timestamp NULL DEFAULT NULL,
  `enabled` tinyint(4) DEFAULT '1',
  `mode` enum('auto','manual') DEFAULT 'auto',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.commands: ~1 rows (approximately)
/*!40000 ALTER TABLE `commands` DISABLE KEYS */;
INSERT INTO `commands` (`id`, `name`, `last_checked_at`, `enabled`, `mode`, `created_at`, `updated_at`) VALUES
	(1, 'checkScanned', '2018-05-31 12:26:29', 1, 'auto', '2018-05-28 13:33:53', '2018-05-31 12:26:29');
/*!40000 ALTER TABLE `commands` ENABLE KEYS */;

-- Dumping structure for table yoov_api.documents
CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `media_id` int(10) unsigned DEFAULT '0',
  `filename` varchar(255) DEFAULT NULL,
  `folder_id` int(10) unsigned DEFAULT '0',
  `file_type` varchar(50) DEFAULT '0',
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.documents: ~0 rows (approximately)
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;

-- Dumping structure for table yoov_api.equipments
CREATE TABLE IF NOT EXISTS `equipments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `occupied_by` int(10) unsigned DEFAULT '0',
  `last_occupied_at` timestamp NULL DEFAULT NULL,
  `remark` text,
  `settings` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.equipments: ~0 rows (approximately)
/*!40000 ALTER TABLE `equipments` DISABLE KEYS */;
INSERT INTO `equipments` (`id`, `name`, `description`, `occupied_by`, `last_occupied_at`, `remark`, `settings`, `created_at`, `updated_at`) VALUES
	(1, 'scanner', 'Scanner', 0, '2018-05-28 09:49:54', NULL, '{"path":"/home/vagrant/Code/yoov/scan"}', NULL, '2018-05-29 09:21:38');
/*!40000 ALTER TABLE `equipments` ENABLE KEYS */;

-- Dumping structure for table yoov_api.folders
CREATE TABLE IF NOT EXISTS `folders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `_lft` int(10) unsigned NOT NULL DEFAULT '0',
  `_rgt` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `owned_by` int(10) unsigned NOT NULL DEFAULT '0',
  `is_system` tinyint(1) unsigned DEFAULT '0',
  `writable` tinyint(1) unsigned DEFAULT '0',
  `remark` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `folders__lft__rgt_parent_id_index` (`_lft`,`_rgt`,`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.folders: ~42 rows (approximately)
/*!40000 ALTER TABLE `folders` DISABLE KEYS */;
INSERT INTO `folders` (`id`, `_lft`, `_rgt`, `parent_id`, `name`, `description`, `owned_by`, `is_system`, `writable`, `remark`, `created_at`, `updated_at`) VALUES
	(1, 1, 92, NULL, 'root', '', 1, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(2, 2, 9, 1, 'public', 'Public Folder', 1, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(3, 3, 4, 2, 'scan', 'Scan', 1, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(4, 5, 6, 2, 'meetings', 'Meetings', 1, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(5, 7, 8, 2, 'shared', 'Shared', 1, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(6, 10, 91, 1, 'users', '', 0, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(7, 11, 18, 6, 'supervisor', 'supervisor', 1, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(8, 12, 13, 7, 'scan', 'Scan', 1, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(9, 14, 15, 7, 'meetings', 'Meetings', 1, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(10, 16, 17, 7, 'my_documents', 'My Documents', 1, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(11, 19, 26, 6, 'yoovtest1', '', 2, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(12, 20, 21, 11, 'scan', 'Scan', 2, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(13, 22, 23, 11, 'meetings', 'Meetings', 2, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(14, 24, 25, 11, 'my_documents', 'My Documents', 2, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(15, 27, 34, 6, 'yoovtest2', '', 3, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(16, 28, 29, 15, 'scan', 'Scan', 3, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:21'),
	(17, 30, 31, 15, 'meetings', 'Meetings', 3, 1, 0, NULL, '2018-05-28 04:20:21', '2018-05-28 04:20:22'),
	(18, 32, 33, 15, 'my_documents', 'My Documents', 3, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(19, 35, 42, 6, 'yoovtest3', '', 4, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(20, 36, 37, 19, 'scan', 'Scan', 4, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(21, 38, 39, 19, 'meetings', 'Meetings', 4, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(22, 40, 41, 19, 'my_documents', 'My Documents', 4, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(23, 43, 50, 6, 'yoovtest4', '', 5, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(24, 44, 45, 23, 'scan', 'Scan', 5, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(25, 46, 47, 23, 'meetings', 'Meetings', 5, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(26, 48, 49, 23, 'my_documents', 'My Documents', 5, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(27, 51, 58, 6, 'yoovtest5', '', 6, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(28, 52, 53, 27, 'scan', 'Scan', 6, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(29, 54, 55, 27, 'meetings', 'Meetings', 6, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(30, 56, 57, 27, 'my_documents', 'My Documents', 6, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(31, 59, 66, 6, 'yoovtest6', '', 7, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(32, 60, 61, 31, 'scan', 'Scan', 7, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(33, 62, 63, 31, 'meetings', 'Meetings', 7, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(34, 64, 65, 31, 'my_documents', 'My Documents', 7, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(35, 67, 74, 6, 'yoovtest7', '', 8, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(36, 68, 69, 35, 'scan', 'Scan', 8, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(37, 70, 71, 35, 'meetings', 'Meetings', 8, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(38, 72, 73, 35, 'my_documents', 'My Documents', 8, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(39, 75, 82, 6, 'YoovDominic', 'YoovDominic', 23, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(40, 76, 77, 39, 'scan', 'Scan', 23, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(41, 78, 79, 39, 'meetings', 'Meetings', 23, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(42, 80, 81, 39, 'my_documents', 'My Documents', 23, 1, 0, NULL, '2018-05-28 04:20:22', '2018-05-28 04:20:22'),
	(43, 83, 90, 6, 'dominic', '', 32, 0, 0, NULL, '2018-05-31 10:53:53', '2018-05-31 10:53:53'),
	(44, 84, 85, 43, 'scan', 'Scan', 32, 1, 0, NULL, '2018-05-31 10:53:53', '2018-05-31 10:53:53'),
	(45, 86, 87, 43, 'meetings', 'Meetings', 32, 1, 0, NULL, '2018-05-31 10:53:54', '2018-05-31 10:53:54'),
	(46, 88, 89, 43, 'my_documents', 'My Documents', 32, 1, 0, NULL, '2018-05-31 10:53:54', '2018-05-31 10:53:54');
/*!40000 ALTER TABLE `folders` ENABLE KEYS */;

-- Dumping structure for table yoov_api.folder_users
CREATE TABLE IF NOT EXISTS `folder_users` (
  `folder_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `writable` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`folder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.folder_users: ~0 rows (approximately)
/*!40000 ALTER TABLE `folder_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `folder_users` ENABLE KEYS */;

-- Dumping structure for table yoov_api.medias
CREATE TABLE IF NOT EXISTS `medias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `is_temp` tinyint(4) DEFAULT '1',
  `path` varchar(50) DEFAULT NULL,
  `filename` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.medias: ~3 rows (approximately)
/*!40000 ALTER TABLE `medias` DISABLE KEYS */;
INSERT INTO `medias` (`id`, `user_id`, `is_temp`, `path`, `filename`, `created_at`, `updated_at`) VALUES
	(111, 0, 0, '55/03', '46.jpg', '2018-05-28 17:53:48', '2018-05-28 17:53:48'),
	(112, 0, 0, 'cc/7d', 'truck.png', '2018-05-28 17:55:26', '2018-05-28 17:55:26'),
	(113, 0, 0, '8f/9d', 'building-business-garage-office-icon--icon-search-engine-3.png', '2018-05-28 17:56:35', '2018-05-28 17:56:35');
/*!40000 ALTER TABLE `medias` ENABLE KEYS */;

-- Dumping structure for table yoov_api.meetings
CREATE TABLE IF NOT EXISTS `meetings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `venue_type` enum('conference_room','else') NOT NULL DEFAULT 'conference_room',
  `venue` varchar(255) NOT NULL DEFAULT '',
  `meeting_room_booking_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `ended_at` timestamp NULL DEFAULT NULL,
  `remark` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.meetings: ~0 rows (approximately)
/*!40000 ALTER TABLE `meetings` DISABLE KEYS */;
INSERT INTO `meetings` (`id`, `subject`, `venue_type`, `venue`, `meeting_room_booking_id`, `user_id`, `started_at`, `ended_at`, `remark`, `created_at`, `updated_at`) VALUES
	(3, 'OA', 'conference_room', '', 6, 2, '2018-05-23 13:33:54', '2018-05-23 13:33:54', '', '2018-05-23 13:33:56', '2018-05-23 13:33:58');
/*!40000 ALTER TABLE `meetings` ENABLE KEYS */;

-- Dumping structure for table yoov_api.meeting_files
CREATE TABLE IF NOT EXISTS `meeting_files` (
  `meeting_id` int(10) unsigned NOT NULL,
  `media_id` int(10) unsigned NOT NULL,
  `remark` text NOT NULL,
  PRIMARY KEY (`meeting_id`,`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.meeting_files: ~0 rows (approximately)
/*!40000 ALTER TABLE `meeting_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting_files` ENABLE KEYS */;

-- Dumping structure for table yoov_api.meeting_participants
CREATE TABLE IF NOT EXISTS `meeting_participants` (
  `meeting_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`meeting_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.meeting_participants: ~0 rows (approximately)
/*!40000 ALTER TABLE `meeting_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting_participants` ENABLE KEYS */;

-- Dumping structure for table yoov_api.meeting_rooms
CREATE TABLE IF NOT EXISTS `meeting_rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `capacity` int(10) unsigned NOT NULL DEFAULT '0',
  `location` varchar(255) NOT NULL DEFAULT '',
  `remark` text NOT NULL,
  `equipments` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.meeting_rooms: ~2 rows (approximately)
/*!40000 ALTER TABLE `meeting_rooms` DISABLE KEYS */;
INSERT INTO `meeting_rooms` (`id`, `name`, `capacity`, `location`, `remark`, `equipments`, `created_at`, `updated_at`) VALUES
	(3, 'Room 2303', 6, 'Room 2303, 23/F', '', 'Smart TV', '2018-05-10 12:07:30', '0000-00-00 00:00:00'),
	(4, 'Donald Room', 4, 'Room 2303, 23/F', '', '', '2018-05-30 15:23:12', '0000-00-00 00:00:00'),
	(5, 'Phil Room', 4, 'Room 2303, 23/F', '', '', '2018-05-30 15:23:03', '0000-00-00 00:00:00');
/*!40000 ALTER TABLE `meeting_rooms` ENABLE KEYS */;

-- Dumping structure for table yoov_api.meeting_room_bookings
CREATE TABLE IF NOT EXISTS `meeting_room_bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_room_id` int(10) unsigned NOT NULL DEFAULT '0',
  `applicant_id` int(10) unsigned DEFAULT NULL,
  `applicant_name` varbinary(50) DEFAULT NULL,
  `purpose` varchar(100) DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `ended_at` timestamp NULL DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.meeting_room_bookings: ~10 rows (approximately)
/*!40000 ALTER TABLE `meeting_room_bookings` DISABLE KEYS */;
INSERT INTO `meeting_room_bookings` (`id`, `meeting_room_id`, `applicant_id`, `applicant_name`, `purpose`, `started_at`, `ended_at`, `status`, `remark`) VALUES
	(1, 1, 4, NULL, NULL, '2018-05-10 13:00:00', '2018-05-10 15:00:00', 'approved', NULL),
	(2, 2, 4, NULL, NULL, '2018-05-10 13:27:45', '2018-05-10 13:27:47', 'pending', NULL),
	(3, 3, 2, NULL, NULL, '2018-05-21 14:00:00', '2018-05-21 15:00:00', 'approved', NULL),
	(4, 3, 2, NULL, NULL, '2018-05-21 12:00:00', '2018-05-21 13:00:00', 'approved', NULL),
	(5, 3, 2, NULL, NULL, '2018-05-21 18:00:00', '2018-05-21 19:00:00', 'approved', NULL),
	(6, 3, 2, NULL, NULL, '2018-05-22 08:00:00', '2018-05-22 12:00:00', 'pending', NULL),
	(7, 3, 2, NULL, NULL, '2018-05-22 11:00:00', '2018-05-22 16:00:00', 'pending', NULL),
	(8, 3, 2, NULL, NULL, '2018-05-20 18:00:00', '2018-05-20 19:00:00', 'approved', NULL),
	(9, 3, 2, NULL, NULL, '2018-05-20 11:00:00', '2018-05-20 16:00:00', 'approved', NULL),
	(10, 3, 2, NULL, NULL, '2018-05-20 17:00:00', '2018-05-20 18:00:00', 'pending', NULL);
/*!40000 ALTER TABLE `meeting_room_bookings` ENABLE KEYS */;

-- Dumping structure for table yoov_api.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.migrations: ~9 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2018_05_07_050843_create_test_table', 2),
	(4, '2018_05_11_041459_create_user_info', 3),
	(5, '2016_06_01_000001_create_oauth_auth_codes_table', 4),
	(6, '2016_06_01_000002_create_oauth_access_tokens_table', 4),
	(7, '2016_06_01_000003_create_oauth_refresh_tokens_table', 4),
	(8, '2016_06_01_000004_create_oauth_clients_table', 4),
	(9, '2016_06_01_000005_create_oauth_personal_access_clients_table', 4),
	(10, '2018_05_28_022428_set_folders_nested_set', 5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table yoov_api.oauth_access_tokens
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.oauth_access_tokens: ~79 rows (approximately)
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('017ec8baab86a072fbadb03c4115b6c9468f825b269beded8c706054ebf3fe090c02126f449e6b17', 2, 2, NULL, '[]', 0, '2018-05-28 01:42:05', '2018-05-28 01:42:05', '2018-06-12 01:42:05'),
	('056c87981ecbcf958470266c0368594d1d52c44df1d3da26dd8295ea1af9b889d3a6e517863d056c', 2, 2, NULL, '[]', 0, '2018-05-31 10:42:14', '2018-05-31 10:42:14', '2018-06-15 10:42:14'),
	('05ee27ceeb066183716763982cceaad605af175c07cd67b486af3b70784966f0c0492854bfe58995', 2, 2, NULL, '[]', 0, '2018-05-25 07:28:04', '2018-05-25 07:28:04', '2018-06-09 07:28:04'),
	('084617e932834d3acd3849f66cb5a801a5a080dc5aa4075a3e4f63a3d776dcdc30b42bf49d6e521f', 2, 2, NULL, '[]', 0, '2018-05-25 07:25:12', '2018-05-25 07:25:12', '2018-06-09 07:25:12'),
	('0b59941dd0b69935c63660b82f7a25223033c7582a786ef31b9e5ea6e140f959093fb96e010c3a08', 2, 2, NULL, '[]', 0, '2018-05-14 07:50:12', '2018-05-14 07:50:12', '2018-05-29 07:50:12'),
	('0f73d39b2b111ad4c87b92bfbb2159d262483a61c807906bc45f3f6b8122f0bbcaeff287bc7fd0a7', 2, 2, NULL, '[]', 0, '2018-05-14 06:24:34', '2018-05-14 06:24:34', '2018-05-29 06:24:34'),
	('10dc8383f976676d0565bc6516f4932fc82c045f49b6d31a011572f2b2a99b44854363e07e13bd77', 2, 2, NULL, '[]', 0, '2018-05-30 13:48:39', '2018-05-30 13:48:39', '2018-06-14 13:48:39'),
	('12b8ef374fc5ce8ff1061364bdfce568835d65c4cefe772af544c53dfe51759f4d65bf58b1c6e624', 2, 2, NULL, '[]', 0, '2018-05-24 03:09:58', '2018-05-24 03:09:58', '2018-06-08 03:09:57'),
	('15e9747bbbf30c3715c3fa0c6a1802f615d8d831ec9ed9126e753b2d79e454fa12ae1c585e5405f4', 2, 2, NULL, '[]', 0, '2018-05-14 06:28:51', '2018-05-14 06:28:51', '2018-05-29 06:28:51'),
	('1d04f668f4506f0130fad2a98f9a9436be0793fa76d6eb892920e66891062a8f8d5d600b6baebef4', 2, 2, NULL, '[]', 0, '2018-05-14 08:58:35', '2018-05-14 08:58:35', '2018-05-29 08:58:35'),
	('255a807becc574b4cb2e52509dd83ebd955f810e32c148e9eb911a987002b443326355ef308e5a24', 2, 2, NULL, '[]', 0, '2018-05-14 06:58:23', '2018-05-14 06:58:23', '2018-05-29 06:58:23'),
	('26d6ef3b7d982a9a59112d0004599029f93b324ac8cbb0ba4f86315ce46d67e16396c6a45006217c', 2, 2, NULL, '[]', 0, '2018-05-14 06:22:53', '2018-05-14 06:22:53', '2018-05-29 06:22:53'),
	('2794893c9f82d8c303bc518a911f686b4ea46765d5b7fa8e5b1aae5d17fc240d9b1016629c5e62ef', 32, 2, NULL, '[]', 0, '2018-05-31 10:51:30', '2018-05-31 10:51:30', '2018-06-15 10:51:30'),
	('2a072f820fa085eeef9929d304b2d88d8677190ffc3f386bb6a317f7d75ca4417a1bd74ab55bec31', 2, 2, NULL, '[]', 0, '2018-05-14 08:45:48', '2018-05-14 08:45:48', '2018-05-29 08:45:48'),
	('2a1bcba1ab176a49ccb26bc7a1d30e846b93149622325ea305b25ca3d4b4c8f0bc92903e38733500', 2, 2, NULL, '[]', 0, '2018-05-14 06:27:53', '2018-05-14 06:27:53', '2018-05-29 06:27:53'),
	('2b6e0b6ca1c572f62355686373445791bef5377397c8b0781d2f8faa4f6b12918329c48ba0f1e400', 2, 2, NULL, '[]', 0, '2018-05-14 07:37:25', '2018-05-14 07:37:25', '2018-05-29 07:37:25'),
	('2d2ed9ff66e8e3963c0a8fd7d63375f9bc0be6107e754ae56e20886b838cbc3be392d85a40669c1f', 2, 2, NULL, '[]', 0, '2018-05-14 07:37:15', '2018-05-14 07:37:15', '2018-05-29 07:37:15'),
	('31571d58edf6d21938019646fb8fc15c692c7c8be882f4a50506832038c519a71b5945f3d53c6096', 2, 2, NULL, '[]', 0, '2018-05-25 08:09:30', '2018-05-25 08:09:30', '2018-06-09 08:09:30'),
	('3210e04028223076e536bd328e64b43fcd737e58404df3ea573daa82cb20d34a697153b186c7a22f', 2, 2, NULL, '[]', 0, '2018-05-15 01:28:04', '2018-05-15 01:28:04', '2018-05-30 01:28:03'),
	('3635250a3e8835e89d1fc1cdaf65e157b5d9d3143f61faf9fb2ef8f914cc47a7bb99e5646013aba0', 2, 2, NULL, '[]', 0, '2018-05-14 08:41:09', '2018-05-14 08:41:09', '2018-05-29 08:41:09'),
	('3743568f4315f9049507e98334888d9bf19a24703bce241612c78d987533eeeb574ce03a1a94cf1c', 2, 2, NULL, '[]', 0, '2018-05-28 01:40:02', '2018-05-28 01:40:02', '2018-06-12 01:40:02'),
	('39421feb5e1819abbb17508b2514c580193f2de17803f39021cf5765e229d9cce1b48507c011b785', 32, 2, NULL, '[]', 0, '2018-05-31 10:53:53', '2018-05-31 10:53:53', '2018-06-15 10:53:53'),
	('39ec5115b423dd501a25c2080d9fb43b7afde70eaf41cdd21aaa936dd01147af5c068e4cf2858686', 2, 2, NULL, '[]', 0, '2018-05-14 06:21:57', '2018-05-14 06:21:57', '2018-05-29 06:21:57'),
	('3a718635f488b6c2a9a875f40f00e171ecb17003338f79384fa973eb6a893f534bb5b8b61430da1e', 2, 2, NULL, '[]', 0, '2018-05-14 07:45:10', '2018-05-14 07:45:10', '2018-05-29 07:45:10'),
	('3b7b3955c87f6a5df4495ebf727f048440b3cf8e37ddbf6dc371364496fcc7ee9c14f4c91934fdf2', 2, 2, NULL, '[]', 0, '2018-05-14 07:53:01', '2018-05-14 07:53:01', '2018-05-29 07:53:01'),
	('3c39f36b7772f5c848fec2fe5e26f34b861036d08489e24a05dc11ca39bafdf9fb30710815860ae2', 2, 2, NULL, '[]', 0, '2018-05-14 09:04:28', '2018-05-14 09:04:28', '2018-05-29 09:04:27'),
	('3e4c3027180063fce710fe947db1df5b9dd3e93ebac6bbf3c6e7f520562bdacb560e400df8d0c906', 2, 2, NULL, '[]', 0, '2018-05-30 13:28:34', '2018-05-30 13:28:34', '2018-06-14 13:28:34'),
	('452626125525b1adc3e88ce096a8c4b5ce977cab3ce19cdefe867c30603d0aaa2ca4455b0b70219f', 2, 2, NULL, '[]', 0, '2018-05-25 07:31:51', '2018-05-25 07:31:51', '2018-06-09 07:31:51'),
	('4881a48034012f37743a36d19f003ec941cabbb7cfe13b31b9491164f80360e7fe4c06a765593ea7', 2, 2, NULL, '[]', 0, '2018-05-14 06:29:44', '2018-05-14 06:29:44', '2018-05-29 06:29:44'),
	('5046dfc9de37ca3f5d75d3f08482a170bb865c32092ef11eec156a07cc0063a1852251719243b0c2', 2, 2, NULL, '[]', 0, '2018-05-14 07:55:01', '2018-05-14 07:55:01', '2018-05-29 07:55:00'),
	('5563e0a3668f8075050c667f5029612600995372331445934b352841b5ac37d7efb1f83a2b3b5064', 2, 2, NULL, '[]', 0, '2018-05-30 09:55:36', '2018-05-30 09:55:36', '2018-06-14 09:55:36'),
	('586977887064f88f066a176a7f36cd82063503260929ae41cf14c2e35d3b6e6994a8565f9db35e6c', 2, 2, NULL, '[]', 0, '2018-05-14 07:38:17', '2018-05-14 07:38:17', '2018-05-29 07:38:17'),
	('587988cb766f49927e743fcfb1c7b4916da6363dc48e9292f11920160717668005c2286083f2e064', 2, 2, NULL, '[]', 0, '2018-05-14 06:57:17', '2018-05-14 06:57:17', '2018-05-29 06:57:17'),
	('5926b94da6da485556a6e500c01310ccdbea3c2ff288cae5032ccf95f38952f09d28f371565c80a0', 2, 2, NULL, '[]', 0, '2018-05-23 04:27:57', '2018-05-23 04:27:57', '2018-06-07 04:27:57'),
	('5ae5c135b8f8c11902143bace3fcbe9766eaf997466bb94c19799ce4c0ea8413afbe9c44006b5950', 2, 2, NULL, '[]', 0, '2018-05-24 03:13:22', '2018-05-24 03:13:22', '2018-06-08 03:13:22'),
	('5b82005704f01413d4c712aeccd44e37fd43757296d415a8d721d7d35e18bd6320f053e205afaefb', 2, 2, NULL, '[]', 0, '2018-05-30 13:50:00', '2018-05-30 13:50:00', '2018-06-14 13:50:00'),
	('5c61237b9f58eb17b4d015c5760f480f5b02d2d5b111d98ea0dd15f861143a0e27bffcf410d3cee7', 2, 2, NULL, '[]', 0, '2018-05-14 06:30:55', '2018-05-14 06:30:55', '2018-05-29 06:30:55'),
	('5def387fe20b8e791537da20266f7f2abcd7929333a29fcc79e75e5d28c960fe06595031f12741da', 2, 2, NULL, '[]', 0, '2018-05-14 07:39:06', '2018-05-14 07:39:06', '2018-05-29 07:39:06'),
	('68120e9299ac62413643b53456c10d7879083af601a988f62c9f90f13962dd52a8cceaa9d228c34f', 2, 2, NULL, '[]', 0, '2018-05-14 08:59:20', '2018-05-14 08:59:20', '2018-05-29 08:59:20'),
	('71774e762364bfb1f55d0bc4b8dd6a02f7f2584e3f57790a91fa46da65a8e36a1f08ad7b933fa12b', 2, 2, NULL, '[]', 0, '2018-05-23 02:22:26', '2018-05-23 02:22:26', '2018-06-07 02:22:26'),
	('73f4246f08d907c5dd6a36f59567a6acb1b89516700b5f010e1bd952e58480dba7b35fe9f802866d', 2, 2, NULL, '[]', 0, '2018-05-31 10:41:34', '2018-05-31 10:41:34', '2018-06-15 10:41:34'),
	('77311c034df4d1f269603cbf32f696bb9aa316509c4907677621b67b82608232bf3b0c50fdf4aebc', 2, 2, NULL, '[]', 0, '2018-05-15 03:48:15', '2018-05-15 03:48:15', '2018-05-30 03:48:15'),
	('7b4362e562a321dee6e0f71a4f2e075d02fe65429ba84761232314f9158903328582df0ba54aa01f', 2, 2, NULL, '[]', 0, '2018-05-25 07:33:36', '2018-05-25 07:33:36', '2018-06-09 07:33:36'),
	('7d46eb15ce37f1090f9089f77c8da2bdea4bb2cc8327114cf6df61c423bfe250042f462f1ead42c4', 2, 2, NULL, '[]', 0, '2018-05-28 03:25:09', '2018-05-28 03:25:09', '2018-06-12 03:25:09'),
	('8154438b3b2b66c00ecf8817841bd2b545b4f2fdf80f406cdc62c8e60677917ce398b07ea2c4d6e8', 2, 2, NULL, '[]', 0, '2018-05-28 18:06:20', '2018-05-28 18:06:20', '2018-06-12 18:06:20'),
	('8296b75dd8ec45e5b1c00c2735c7c647732469baf633d563fda2685776184e0fcaa06e5dc9456a78', 2, 2, NULL, '[]', 0, '2018-05-25 08:23:11', '2018-05-25 08:23:11', '2018-06-09 08:23:11'),
	('82d8eb4deee78b3f46292c0d02e6cde1f46c51ad23206ec61e5c31ac9040d26f16cb3b1e7eb12c1a', 2, 2, NULL, '[]', 0, '2018-05-14 08:21:52', '2018-05-14 08:21:52', '2018-05-29 08:21:52'),
	('859aecadc3c5a249ee5b7cb8cd09564019449337b64276cc45754ae614e70be0885485197d60562d', 2, 2, NULL, '[]', 0, '2018-05-16 03:15:16', '2018-05-16 03:15:16', '2018-05-31 03:15:16'),
	('875743a39fbed3394968fc66967129ab6f2909c5d0ec3e750ae9218188d8fd7fb4f9aed99dcdd7e7', 2, 2, NULL, '[]', 0, '2018-05-14 08:39:11', '2018-05-14 08:39:11', '2018-05-29 08:39:11'),
	('8e564836e11b678f848315f154deda7a6cd97a216957cf18765a3ceca5939cf05d9d0717d9a48883', 2, 2, NULL, '[]', 0, '2018-05-28 18:07:49', '2018-05-28 18:07:49', '2018-06-12 18:07:49'),
	('91e9703ddbbbf28e0374494216f8a947e04064f33c6d570142c98721cbc9e0d564c9df17190eaa3f', 2, 2, NULL, '[]', 0, '2018-05-14 08:37:30', '2018-05-14 08:37:30', '2018-05-29 08:37:30'),
	('9319c13e1eaffd1814b9919c74cdf9445243231231d1b3b4adab2acd9268c6c454ac324708d6644f', 2, 2, NULL, '[]', 0, '2018-05-25 07:49:33', '2018-05-25 07:49:33', '2018-06-09 07:49:33'),
	('9328cd3f7f3f525adfbe96276df2432e40476f6d637738c77207b547e3ae5cfcb03b47c7cc7dfc8e', 2, 2, NULL, '[]', 0, '2018-05-15 01:31:30', '2018-05-15 01:31:30', '2018-05-30 01:31:30'),
	('97123b275f4625e39108bfcf68a89a4dc5ee8f7aa6aabe351ad4553cd8180f691f54ba46bf3104e9', 2, 2, NULL, '[]', 0, '2018-05-24 03:12:46', '2018-05-24 03:12:46', '2018-06-08 03:12:46'),
	('9882db18b0ab488168f65526801e11fd477ec2aadafde345b1a4dddbf773b795f83c538330a53e25', 2, 2, NULL, '[]', 0, '2018-05-25 08:02:10', '2018-05-25 08:02:10', '2018-06-09 08:02:10'),
	('98a95bfb65421ab9a712e41c004c591fd2f5bfff62e268ba326aae9ee7774f7bc63afaf90455e693', 2, 2, NULL, '[]', 0, '2018-05-24 03:11:14', '2018-05-24 03:11:14', '2018-06-08 03:11:14'),
	('9ed5096a876eaae2b3d74159d98f7c35c811520daafbcb3d6c766f4f7d91211a6e527c5cb7880934', 2, 2, NULL, '[]', 0, '2018-05-25 08:30:45', '2018-05-25 08:30:45', '2018-06-09 08:30:45'),
	('a0aed0d272789cb93654bdcbf0337cea23c9bd506f7b2deaadb4d50a12e19959128b266b29ee28e2', 2, 2, NULL, '[]', 0, '2018-05-25 08:08:29', '2018-05-25 08:08:29', '2018-06-09 08:08:29'),
	('a0fde61678e9e5143833f30e92faace3e798bb9a74913a3aacd8108f15e641357d7691130723c251', 2, 2, NULL, '[]', 0, '2018-05-14 06:58:37', '2018-05-14 06:58:37', '2018-05-29 06:58:37'),
	('a1d9083c5293c4168eb8f6a36c2ac022204404bc2aaf261d3583ad3ac18dde595457c7424c5188dd', 2, 2, NULL, '[]', 0, '2018-05-14 08:42:16', '2018-05-14 08:42:16', '2018-05-29 08:42:16'),
	('a557e9050b1239332fce323302996e03fc849035e0d812d9f1ab563c2fe3cf2532a2872daa383774', 2, 2, NULL, '[]', 0, '2018-05-25 08:58:28', '2018-05-25 08:58:28', '2018-06-09 08:58:28'),
	('a6c3f45f1f0d65e56a3c63bdc3bdebefe0e895843c3d1a1feff11f7d8024a37766a5977ade24cf52', 2, 2, NULL, '[]', 0, '2018-05-14 08:47:33', '2018-05-14 08:47:33', '2018-05-29 08:47:32'),
	('a74bc337e7018202c1456023884e20867bda014aa4392d0d742c1c15f731f7106745482f5a8aa6f6', 2, 2, NULL, '[]', 0, '2018-05-14 07:53:13', '2018-05-14 07:53:13', '2018-05-29 07:53:13'),
	('a7afd3fbb0082482c3e35a787d21cba49703935c24180bc7e4f063173dfeec4a0e24ece04a8dce8a', 2, 2, NULL, '[]', 0, '2018-05-16 03:06:21', '2018-05-16 03:06:21', '2018-05-31 03:06:21'),
	('a9d60c17eab752712d590c5ddd1d33c834340e0f7ee64e78140ac533bc2a16e627c69820bab131b9', 2, 2, NULL, '[]', 0, '2018-05-16 03:01:27', '2018-05-16 03:01:27', '2018-05-31 03:01:27'),
	('b1ab13e5a892b539ef8ab6e9d5bf59d17bb5064035738ab78fdcfba45cd42667f84c284c57a7e96e', 2, 2, NULL, '[]', 0, '2018-05-23 01:47:13', '2018-05-23 01:47:13', '2018-06-07 01:47:12'),
	('c028d711e733c8c13c081eea5278925226b8a0f6c1d2379c3e6af1787b796b8b1012294822608823', 2, 2, NULL, '[]', 0, '2018-05-14 07:43:53', '2018-05-14 07:43:53', '2018-05-29 07:43:53'),
	('c4f3321c33c572ad4f9179d58c01436f42dac47e921354ea7396c6fa4e82360fea38c4e0885dd55c', 2, 2, NULL, '[]', 0, '2018-05-14 07:40:03', '2018-05-14 07:40:03', '2018-05-29 07:40:03'),
	('ca0f4557e1342e699429253339bf131e74af74b775065db80338250e71819cc7bb49d91e62cc259c', 2, 2, NULL, '[]', 0, '2018-05-17 07:19:59', '2018-05-17 07:19:59', '2018-06-01 07:19:59'),
	('cd4e4605b49ee3b8c3aa2352eebb680f5b4933592b13b809f878b72f90db9d0c12c113a0575abc7f', 2, 2, NULL, '[]', 0, '2018-05-14 06:31:31', '2018-05-14 06:31:31', '2018-05-29 06:31:31'),
	('d84c8084425bd03621997cce58fd159c170ec1a031d59906c703a0afcc8a5c2ed5cdba1ae8f7b037', 2, 2, NULL, '[]', 0, '2018-05-14 06:21:11', '2018-05-14 06:21:11', '2018-05-29 06:21:11'),
	('dfb01ea8c381b97f43e5734fda66c3f5fbd185be5bab58d88b8b26557292e310b9efb398b1f9c5d1', 2, 2, NULL, '[]', 0, '2018-05-15 02:26:19', '2018-05-15 02:26:19', '2018-05-30 02:26:19'),
	('e47535998ae244e642e6f9877d38b214cc15b2c93302f4509fe69230c73f51711c10d39c3a9542bc', 2, 2, NULL, '[]', 0, '2018-05-25 08:13:56', '2018-05-25 08:13:56', '2018-06-09 08:13:56'),
	('e5f116d55acd9ff0c73c0137d9b865368c039f525737afba164ddab34bb3f2685d5ca0edec4f9c9b', 2, 2, NULL, '[]', 0, '2018-05-14 03:56:05', '2018-05-14 03:56:05', '2018-05-29 03:56:05'),
	('ed549399a97a86f82dbedea48302996bd10a33287f1278d8c730e893a1f89f99ffb27cb921a17d91', 2, 2, NULL, '[]', 0, '2018-05-14 08:39:50', '2018-05-14 08:39:50', '2018-05-29 08:39:50'),
	('edd3f8a3a7128b2bfbb07c6a70708b83811bd9428947005001895cd09e8f4c1000052f1c67e53230', 2, 2, NULL, '[]', 0, '2018-05-25 07:33:24', '2018-05-25 07:33:24', '2018-06-09 07:33:24'),
	('eea19ce4835661fdeb5aa877cd51743daa31014c6fac8d5b21f8a2ff5861cb6e17729d2c0df4d982', 2, 2, NULL, '[]', 0, '2018-05-25 08:57:59', '2018-05-25 08:57:59', '2018-06-09 08:57:58'),
	('ef53344b39f1bf6d5047b17871f3b3574e3ceae87954563d385d774bf158258b3499969089ce8052', 2, 2, NULL, '[]', 0, '2018-05-24 03:13:16', '2018-05-24 03:13:16', '2018-06-08 03:13:16'),
	('f17e59664ba5c97d2562aae385e48d782670e3593f8488b7bb6966c4d0a302d34de4011dd7e547f8', 2, 2, NULL, '[]', 0, '2018-05-14 06:25:34', '2018-05-14 06:25:34', '2018-05-29 06:25:33'),
	('f253b67c7ce8bae00ca40548080e65420b44deae91b2efb58427497a2e167fdd7a4d0d390bea0d6f', 2, 2, NULL, '[]', 0, '2018-05-31 10:41:28', '2018-05-31 10:41:28', '2018-06-15 10:41:27'),
	('f2695bdc2d4fd578be5c21bd9a297aac1ff0f86411476e1b489a70c520a77431ea2bed4489099141', 2, 2, NULL, '[]', 0, '2018-05-25 08:27:59', '2018-05-25 08:27:59', '2018-06-09 08:27:59'),
	('f4b5d06a2802b87f8a14ac4b3e3f7fa580abfbd0a9d20bb3a9e5bcac0dfb6a5ee67ea9d916da9abf', 2, 2, NULL, '[]', 0, '2018-05-14 08:53:28', '2018-05-14 08:53:28', '2018-05-29 08:53:28'),
	('f9106aef1d3789839366b845ea3656626ab143ed880880001c832510c3945cb06e753063bff10f3c', 2, 2, NULL, '[]', 0, '2018-05-14 09:04:39', '2018-05-14 09:04:39', '2018-05-29 09:04:38'),
	('fbbb75634e9b120983107855c0d55e297ecd9deafdbcb02ab3138323f6fcd662874a39c4793d5a5a', 2, 2, NULL, '[]', 0, '2018-05-14 07:53:58', '2018-05-14 07:53:58', '2018-05-29 07:53:58'),
	('fd1448fd964ff4203eaac99aabef9ba7ab312eea2105081ca046dfe4628bf43583290a64b04dfe39', 2, 2, NULL, '[]', 0, '2018-05-14 06:18:09', '2018-05-14 06:18:09', '2018-05-29 06:18:08'),
	('fd68843a602bdea649bc8c18c3d1571ae812af922738a720442703a32c0397849336438ed940f086', 2, 2, NULL, '[]', 0, '2018-05-14 08:48:53', '2018-05-14 08:48:53', '2018-05-29 08:48:53'),
	('fe86bae4f1268dc59bdbe96665167b9ec78f0b884467bccf0b28785e11288029ac82a28a1f12de6f', 2, 2, NULL, '[]', 0, '2018-05-14 07:47:51', '2018-05-14 07:47:51', '2018-05-29 07:47:51'),
	('ff0d9fc70c0e9af09c00917e46311ef5ad7c8acee8c8253258207cca6b16bacd7d7f2cacbfc0b08e', 2, 2, NULL, '[]', 0, '2018-05-14 08:04:26', '2018-05-14 08:04:26', '2018-05-29 08:04:26'),
	('ff4ab5861f3e2aa4b3f13eb59a0bc560b1027bc9f824349e02226cdbbff8273a974d86fc595c4886', 2, 2, NULL, '[]', 0, '2018-05-23 04:31:07', '2018-05-23 04:31:07', '2018-06-07 04:31:07'),
	('ff5d474e69b3d3614ce83e49d42831dd4ab7ff7513a716cd4d25063c81144cff5d1e218248d01cb2', 2, 2, NULL, '[]', 0, '2018-05-23 04:29:36', '2018-05-23 04:29:36', '2018-06-07 04:29:36');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Dumping structure for table yoov_api.oauth_auth_codes
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.oauth_auth_codes: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Dumping structure for table yoov_api.oauth_clients
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.oauth_clients: ~2 rows (approximately)
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'YoovAPI56 Personal Access Client', 'SboWdeZQFxOFHUzlU95c1VLEuAf6XsRdHrhMNL2N', 'http://localhost', 1, 0, 0, '2018-05-14 02:33:30', '2018-05-14 02:33:30'),
	(2, NULL, 'YoovAPI56 Password Grant Client', 'XC9wlfaujJt7qC5sqtTzmYo52WjK5AEpa1D7RKLo', 'http://localhost', 0, 1, 0, '2018-05-14 02:33:30', '2018-05-14 02:33:30');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Dumping structure for table yoov_api.oauth_personal_access_clients
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.oauth_personal_access_clients: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2018-05-14 02:33:30', '2018-05-14 02:33:30');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Dumping structure for table yoov_api.oauth_refresh_tokens
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.oauth_refresh_tokens: ~79 rows (approximately)
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
	('026e5902d1804f4ca16a4e2e508f9c48dc33831ab9bb1a89c88932c61096277c9b0754024dc8d8be', 'ff4ab5861f3e2aa4b3f13eb59a0bc560b1027bc9f824349e02226cdbbff8273a974d86fc595c4886', 0, '2018-06-22 04:31:07'),
	('052ff1cb3107663739e0b19efe77bfa0cd8dfb77cb32e10fbc9ad6437209e1f4efafc6e76a100b5e', 'a6c3f45f1f0d65e56a3c63bdc3bdebefe0e895843c3d1a1feff11f7d8024a37766a5977ade24cf52', 0, '2018-06-13 08:47:32'),
	('08306f56d695a6317bf787cb435cf66664986b4192e0a749a25cc0e0fd64bd10114eba8e534cd51a', 'edd3f8a3a7128b2bfbb07c6a70708b83811bd9428947005001895cd09e8f4c1000052f1c67e53230', 0, '2018-06-24 07:33:24'),
	('0a32337ffd102641ad3cdd230b7931721aa26febe4357f293be8efc83c3d7786658f82e911cc881b', 'a0aed0d272789cb93654bdcbf0337cea23c9bd506f7b2deaadb4d50a12e19959128b266b29ee28e2', 0, '2018-06-24 08:08:29'),
	('0f6f835b6c291fc180178cf7f3fa2d0bc2641cda365dbd1ce511ba62df696a60b045a0b31a3328f2', '3b7b3955c87f6a5df4495ebf727f048440b3cf8e37ddbf6dc371364496fcc7ee9c14f4c91934fdf2', 0, '2018-06-13 07:53:01'),
	('12aae887843abf6d1ddcbe4b20612c762ebc2ef497a3af2fb9af79558bbec3ac23763816d5a83657', '9328cd3f7f3f525adfbe96276df2432e40476f6d637738c77207b547e3ae5cfcb03b47c7cc7dfc8e', 0, '2018-06-14 01:31:30'),
	('153a7c01c9d8e4f115b85d7d97363f90d4ec623dde46f7a8c965532be1712db05a0eb98356dca666', '77311c034df4d1f269603cbf32f696bb9aa316509c4907677621b67b82608232bf3b0c50fdf4aebc', 0, '2018-06-14 03:48:15'),
	('1cee10fe5605ed22a6dadc874f82e59f5fa9423bbfc48b0b3305a64391d31d7ebf4e3247e04382e5', '3635250a3e8835e89d1fc1cdaf65e157b5d9d3143f61faf9fb2ef8f914cc47a7bb99e5646013aba0', 0, '2018-06-13 08:41:09'),
	('1d8a22c83cd939cda08acbb1b810e69d6b6615f680bbac55e93524695c80c5349d9782a215f5e2eb', 'c4f3321c33c572ad4f9179d58c01436f42dac47e921354ea7396c6fa4e82360fea38c4e0885dd55c', 0, '2018-06-13 07:40:03'),
	('1db99931d01d8c1785dd8a9c9c2d27823ab4d343e3e471bcd5c2624f016a150a4bdb223e8b74e774', '9ed5096a876eaae2b3d74159d98f7c35c811520daafbcb3d6c766f4f7d91211a6e527c5cb7880934', 0, '2018-06-24 08:30:45'),
	('22f8ed3d16e0a159bc1fefef3ffd301e57b27fa1ca4aa6c400c28f02c4fe1f70233543df15eb85e5', 'b1ab13e5a892b539ef8ab6e9d5bf59d17bb5064035738ab78fdcfba45cd42667f84c284c57a7e96e', 0, '2018-06-22 01:47:12'),
	('26b428a43baedcc02a31b413b5967d9716f07b3154c511aaad9de2c3e02ce9960fb47240950a4afa', 'a1d9083c5293c4168eb8f6a36c2ac022204404bc2aaf261d3583ad3ac18dde595457c7424c5188dd', 0, '2018-06-13 08:42:16'),
	('2a017c4fc9ce8a3072c4c9af38f82346f24e3da235eee7be06b241cfe48522fe814b89127b923119', '0f73d39b2b111ad4c87b92bfbb2159d262483a61c807906bc45f3f6b8122f0bbcaeff287bc7fd0a7', 0, '2018-06-13 06:24:34'),
	('2a2e797d878f7fe51f047acb678c554aacaed791a6dcc44598385574cce2c66ea7a110cc683ec2c1', '9882db18b0ab488168f65526801e11fd477ec2aadafde345b1a4dddbf773b795f83c538330a53e25', 0, '2018-06-24 08:02:10'),
	('2c23647224340a974545059ea39b2ab18d99319ff68c05814c1677b3b40ef6164a222e6aa1b66c26', 'cd4e4605b49ee3b8c3aa2352eebb680f5b4933592b13b809f878b72f90db9d0c12c113a0575abc7f', 0, '2018-06-13 06:31:31'),
	('2eaf13d6ee83ff470e2d3897bd2226c2d956fb60538b69cd9ca88d6f2f0b9a55f321820ca6792ccd', 'ca0f4557e1342e699429253339bf131e74af74b775065db80338250e71819cc7bb49d91e62cc259c', 0, '2018-06-16 07:19:59'),
	('325b3700f3e11bb4101303563f1ca058287c393f2b2f572d7da406b82e46bfe6b94d264562e79a8e', '26d6ef3b7d982a9a59112d0004599029f93b324ac8cbb0ba4f86315ce46d67e16396c6a45006217c', 0, '2018-06-13 06:22:53'),
	('3403e5038fed6ab4879cf0e1ecfdcfc863f733194e170cef6732b221036dfd45645e6769ca427009', 'ff0d9fc70c0e9af09c00917e46311ef5ad7c8acee8c8253258207cca6b16bacd7d7f2cacbfc0b08e', 0, '2018-06-13 08:04:26'),
	('38d762408e700b80087045037dc3801bd3904da34e82261d0bd8fb0b4a7824e95cb939eac3653a31', '1d04f668f4506f0130fad2a98f9a9436be0793fa76d6eb892920e66891062a8f8d5d600b6baebef4', 0, '2018-06-13 08:58:35'),
	('3a35664093d2a36fc31a845688441c89d9c64cfe095ff36d0efd03f9605264ecef8db658dba71f2c', '73f4246f08d907c5dd6a36f59567a6acb1b89516700b5f010e1bd952e58480dba7b35fe9f802866d', 0, '2018-06-30 10:41:34'),
	('3c4d93993e6dda216b2b49c917cf60d9311ae417eceb769ebe1fdbd7a9df97899609eda74ef5eb65', '5926b94da6da485556a6e500c01310ccdbea3c2ff288cae5032ccf95f38952f09d28f371565c80a0', 0, '2018-06-22 04:27:57'),
	('3d1104d340cd12991bbe728c0abea1f07cc282f8ee96194a60aefcd174544e93b8962fe4279fb092', 'a74bc337e7018202c1456023884e20867bda014aa4392d0d742c1c15f731f7106745482f5a8aa6f6', 0, '2018-06-13 07:53:13'),
	('3d83389e5eb656bd5ee117792a4bcb914f8a2b34e8f145fad2ea5aca00d11697580bbfce1977fce9', '3743568f4315f9049507e98334888d9bf19a24703bce241612c78d987533eeeb574ce03a1a94cf1c', 0, '2018-06-27 01:40:02'),
	('3f042cd66c072c0caec034ce1ff74ce6d420aa132400a16d81d20da768bfc713a9b7867a33345d94', '8296b75dd8ec45e5b1c00c2735c7c647732469baf633d563fda2685776184e0fcaa06e5dc9456a78', 0, '2018-06-24 08:23:11'),
	('406e3e0580399eb4d66b06ff9e3172b8764fdbe415803a9b78284bbd8a250284ff6dccb3146169ff', 'dfb01ea8c381b97f43e5734fda66c3f5fbd185be5bab58d88b8b26557292e310b9efb398b1f9c5d1', 0, '2018-06-14 02:26:19'),
	('44b1ed66dc3c75167d9028f6812d622efb1154dcea28cf8863fdc23b3f16352204ae884b5e3b861a', '39ec5115b423dd501a25c2080d9fb43b7afde70eaf41cdd21aaa936dd01147af5c068e4cf2858686', 0, '2018-06-13 06:21:57'),
	('46710dca6372a844fd65532e1ad9d27224b5e9511a93277b8d7bd42ecd1f8521b6b85407b3375bd4', '017ec8baab86a072fbadb03c4115b6c9468f825b269beded8c706054ebf3fe090c02126f449e6b17', 0, '2018-06-27 01:42:05'),
	('473158e01b9f327408290dd81f92638453a6808fb36289305be8c99bbe028a8a9901f23606e93dd6', '056c87981ecbcf958470266c0368594d1d52c44df1d3da26dd8295ea1af9b889d3a6e517863d056c', 0, '2018-06-30 10:42:14'),
	('4806e23e803f01c8753144db35bea1aae9e9a184f36d8a544c4bfd538b165cd03870a75293241e0b', '71774e762364bfb1f55d0bc4b8dd6a02f7f2584e3f57790a91fa46da65a8e36a1f08ad7b933fa12b', 0, '2018-06-22 02:22:26'),
	('486f3c169097c3fef67ebe1c0d6f89608e8f4a39f16e3e62c9bf8d767833319008fc4450d56730e2', 'e5f116d55acd9ff0c73c0137d9b865368c039f525737afba164ddab34bb3f2685d5ca0edec4f9c9b', 0, '2018-06-13 03:56:05'),
	('4e072945154c4ac458b092db4a7954c86b5f55cbff0f933713575b16d039eab58602e50cc703d8a2', 'd84c8084425bd03621997cce58fd159c170ec1a031d59906c703a0afcc8a5c2ed5cdba1ae8f7b037', 0, '2018-06-13 06:21:11'),
	('501c2fb1527055ce5e285acb2297d22513aa8da4e7996adf2d26182d1e25d519a622a9141c623cef', 'ed549399a97a86f82dbedea48302996bd10a33287f1278d8c730e893a1f89f99ffb27cb921a17d91', 0, '2018-06-13 08:39:50'),
	('5194ab2319b5359e640cd9a5155873a0a8d66d0cb33c9c6b6a8acbfee368eacf4aa4e5dd19ff183a', 'f9106aef1d3789839366b845ea3656626ab143ed880880001c832510c3945cb06e753063bff10f3c', 0, '2018-06-13 09:04:38'),
	('5303bf0bb005803966c64a1de5b38bd877c7dc41568a97af75e46b92d24d97fc80898b36ed4838ad', '5def387fe20b8e791537da20266f7f2abcd7929333a29fcc79e75e5d28c960fe06595031f12741da', 0, '2018-06-13 07:39:06'),
	('58120067e63cd868acc6f81335f3c65cd85ed367efecb2dfd3d59be05bb8e9f82b55db9c8173c9f8', 'f17e59664ba5c97d2562aae385e48d782670e3593f8488b7bb6966c4d0a302d34de4011dd7e547f8', 0, '2018-06-13 06:25:33'),
	('5a2cd7fe8c69af4c0d98bae16fb563674f7a4fda8da92d3c94a6b9fc9d31c0d72a079caba468376d', '5563e0a3668f8075050c667f5029612600995372331445934b352841b5ac37d7efb1f83a2b3b5064', 0, '2018-06-29 09:55:36'),
	('5d3e3374539bbf17e288d11658486e1335e49f1a440079226fdca36a3067355efe3f93631c4f1d0d', '98a95bfb65421ab9a712e41c004c591fd2f5bfff62e268ba326aae9ee7774f7bc63afaf90455e693', 0, '2018-06-23 03:11:14'),
	('60aef7e08d9a77a6479b534a54e7c15774f83fe9a2bb7f90d3d2fa624914dfc427fa1f4ea7d3eaed', 'a0fde61678e9e5143833f30e92faace3e798bb9a74913a3aacd8108f15e641357d7691130723c251', 0, '2018-06-13 06:58:37'),
	('62673211c95d27bcb429cc209022cd1d8a63db17dc8acf654c0bb760c9c120365762057ce4732d8a', '3c39f36b7772f5c848fec2fe5e26f34b861036d08489e24a05dc11ca39bafdf9fb30710815860ae2', 0, '2018-06-13 09:04:27'),
	('64be844e0024e3ce946b4c2783d6b933af388c0a72144d9f1202a670ee233aa9379429e0e235dc94', '05ee27ceeb066183716763982cceaad605af175c07cd67b486af3b70784966f0c0492854bfe58995', 0, '2018-06-24 07:28:04'),
	('64eac96f8f3c5d69713e393806950000526021124eee56ce66774472bd66cce4bc79f321749f4e00', '15e9747bbbf30c3715c3fa0c6a1802f615d8d831ec9ed9126e753b2d79e454fa12ae1c585e5405f4', 0, '2018-06-13 06:28:51'),
	('65f6692eb21aaea3a06901faea55543bc968b079c7bee1c3c48553bd18e632dee57bc5c407dbde28', 'fd1448fd964ff4203eaac99aabef9ba7ab312eea2105081ca046dfe4628bf43583290a64b04dfe39', 0, '2018-06-13 06:18:08'),
	('6d5af792490e423147fb02504b0e0b7fc1382dd054487142a1c1aa66fa091736161d0e993993d70d', '0b59941dd0b69935c63660b82f7a25223033c7582a786ef31b9e5ea6e140f959093fb96e010c3a08', 0, '2018-06-13 07:50:12'),
	('6f1d9827af3f0a379a68c637599574064befe1fb1f4a38c38172632e608e73b08350ece193d104e3', '5ae5c135b8f8c11902143bace3fcbe9766eaf997466bb94c19799ce4c0ea8413afbe9c44006b5950', 0, '2018-06-23 03:13:22'),
	('70a268f49a4ed4877e39f6cba8fce3e07340579bbdac38a64795c0a029ebb0583d875463586afb35', '4881a48034012f37743a36d19f003ec941cabbb7cfe13b31b9491164f80360e7fe4c06a765593ea7', 0, '2018-06-13 06:29:44'),
	('72425912188188d9b10ba5b839223bcec2afc10169d7e212dc39571977c76ec6e4c10dbb82da38ab', '875743a39fbed3394968fc66967129ab6f2909c5d0ec3e750ae9218188d8fd7fb4f9aed99dcdd7e7', 0, '2018-06-13 08:39:11'),
	('76418f77f6d440e59b1342e29bc9484b26309ec4240d73cbb6b37204790d09084c9a31995d9e34fa', '587988cb766f49927e743fcfb1c7b4916da6363dc48e9292f11920160717668005c2286083f2e064', 0, '2018-06-13 06:57:17'),
	('78e12e8d04c3c319d759c49cd90a6bdac3f2fa3d4a80509c3dd92611b071982ff3897575a3f824f7', '586977887064f88f066a176a7f36cd82063503260929ae41cf14c2e35d3b6e6994a8565f9db35e6c', 0, '2018-06-13 07:38:17'),
	('7b33186c450bc3e7bca662af0f2c679e1ec220af07490102547e100934c6a301661efa98e33d5b0b', '3210e04028223076e536bd328e64b43fcd737e58404df3ea573daa82cb20d34a697153b186c7a22f', 0, '2018-06-14 01:28:03'),
	('7c2321dfc060116f8d663397704c11afb2361b64669b3f99f948d1f5303ba5faba26d8486df02154', '8e564836e11b678f848315f154deda7a6cd97a216957cf18765a3ceca5939cf05d9d0717d9a48883', 0, '2018-06-27 18:07:49'),
	('7e93c5848d6d194e6c73b15241995f755bff3d15aba7384718c3fef3b86d2516fca1a4659570ee22', '2b6e0b6ca1c572f62355686373445791bef5377397c8b0781d2f8faa4f6b12918329c48ba0f1e400', 0, '2018-06-13 07:37:25'),
	('7f263a93cb5738bfae86a3d465bdd2a4dd7e3e7f56149a9a410cccbea2d812b8023ff0f023188137', '859aecadc3c5a249ee5b7cb8cd09564019449337b64276cc45754ae614e70be0885485197d60562d', 0, '2018-06-15 03:15:16'),
	('80a765de68929b9ff3bb1a5b9226b779c1d2487119a68518c8085e6b38f0e47c2c7082a5ed18f35b', '5b82005704f01413d4c712aeccd44e37fd43757296d415a8d721d7d35e18bd6320f053e205afaefb', 0, '2018-06-29 13:50:00'),
	('81b672a013850b226dc34a281e38f467d601fbbeeca9c1879292130622c447c57b41b0785ac14113', '82d8eb4deee78b3f46292c0d02e6cde1f46c51ad23206ec61e5c31ac9040d26f16cb3b1e7eb12c1a', 0, '2018-06-13 08:21:52'),
	('85e99f10a469af85b9f9349538df85a2c1680ba46746f764b051716b65e4b1b9153f4faad82de28e', '5c61237b9f58eb17b4d015c5760f480f5b02d2d5b111d98ea0dd15f861143a0e27bffcf410d3cee7', 0, '2018-06-13 06:30:55'),
	('9310960554c059dfabde335473799025db2a05822aebce7c7c7a65e8e50222ec46d22c2d4f382406', 'a557e9050b1239332fce323302996e03fc849035e0d812d9f1ab563c2fe3cf2532a2872daa383774', 0, '2018-06-24 08:58:28'),
	('9395dc5bb94aa17f62826cc2d8dd5f2e27c36adbadd4ad1b71c8bb2842f9761fc626202ab0603702', '2d2ed9ff66e8e3963c0a8fd7d63375f9bc0be6107e754ae56e20886b838cbc3be392d85a40669c1f', 0, '2018-06-13 07:37:15'),
	('94370c8a726259f2d8ca2b6731a8442128f68044a58a28e6b342951c490299fe9f79bf0de9b96b41', 'ef53344b39f1bf6d5047b17871f3b3574e3ceae87954563d385d774bf158258b3499969089ce8052', 0, '2018-06-23 03:13:16'),
	('96cc75f0917e50279098be2952c5f43b6a68f7e0b413c2b37d8569dfb1357dd02501c139a3be1c48', '255a807becc574b4cb2e52509dd83ebd955f810e32c148e9eb911a987002b443326355ef308e5a24', 0, '2018-06-13 06:58:23'),
	('9e8af51c765be84db6a3d39b46019b380b0dab3fe1bbf77dfb8eed7a15f8c8d2cb9168ad449eff6d', '2a1bcba1ab176a49ccb26bc7a1d30e846b93149622325ea305b25ca3d4b4c8f0bc92903e38733500', 0, '2018-06-13 06:27:53'),
	('a43a626024676ec55e70c4af46133e653a0475499bd22091da9e14f5d1f418386bfaf9c7d869d2ad', '2794893c9f82d8c303bc518a911f686b4ea46765d5b7fa8e5b1aae5d17fc240d9b1016629c5e62ef', 0, '2018-06-30 10:51:30'),
	('a904c6827b79d5a862cb2298557c927b6fd8fb8b3b8d87786fdae84409117dfae30c47533178a91f', '452626125525b1adc3e88ce096a8c4b5ce977cab3ce19cdefe867c30603d0aaa2ca4455b0b70219f', 0, '2018-06-24 07:31:51'),
	('ab8bc61d256d83d3ab89cec357b50234b51cb727ec6f275c7ddf5c1c79482c748509721299eb4e76', '68120e9299ac62413643b53456c10d7879083af601a988f62c9f90f13962dd52a8cceaa9d228c34f', 0, '2018-06-13 08:59:20'),
	('afcc23acd9c9ad06101156f76b196c05a2772ea81480a127cae888c2951e4ad658d2264e537ff2b8', '7b4362e562a321dee6e0f71a4f2e075d02fe65429ba84761232314f9158903328582df0ba54aa01f', 0, '2018-06-24 07:33:36'),
	('b09b124ccfa8ca2d28916e82c9ac7eac47cd4cfefe8334171391a9c454a9878340535c386fa8e69e', 'f2695bdc2d4fd578be5c21bd9a297aac1ff0f86411476e1b489a70c520a77431ea2bed4489099141', 0, '2018-06-24 08:27:59'),
	('b17ea9dde60c821bd4aa580ae30d33975c2ad70192c1899c273c7de95d0d3cb112b0301ad004f33c', '084617e932834d3acd3849f66cb5a801a5a080dc5aa4075a3e4f63a3d776dcdc30b42bf49d6e521f', 0, '2018-06-24 07:25:12'),
	('b4760139a78e5ad0ef90c8d8736e00363aa617a6da7956751624af1427fab09366d78038b2cfab49', '12b8ef374fc5ce8ff1061364bdfce568835d65c4cefe772af544c53dfe51759f4d65bf58b1c6e624', 0, '2018-06-23 03:09:58'),
	('b9822777fab06dc393971f7c1d586b999c1996356ef3a668962477a9faace09cd1517ca00efffe54', '31571d58edf6d21938019646fb8fc15c692c7c8be882f4a50506832038c519a71b5945f3d53c6096', 0, '2018-06-24 08:09:30'),
	('bd050e22a2a078862148d93f0178fa2b9d4d2b408691bb76af7ca906cb83f8c237c367f792fc24d6', 'fd68843a602bdea649bc8c18c3d1571ae812af922738a720442703a32c0397849336438ed940f086', 0, '2018-06-13 08:48:53'),
	('be4cb8f77bdae3e8f7b8ba87abd9bd3dad3e588a640e98428a11fd487af7cac4563b92fc30533d26', '91e9703ddbbbf28e0374494216f8a947e04064f33c6d570142c98721cbc9e0d564c9df17190eaa3f', 0, '2018-06-13 08:37:30'),
	('c5f7028261802a94459a94d86f5c68f2d52b8b7f74fd6ad77e7a54a920131cb841c8df1d8c06496c', 'a9d60c17eab752712d590c5ddd1d33c834340e0f7ee64e78140ac533bc2a16e627c69820bab131b9', 0, '2018-06-15 03:01:27'),
	('c8d6cb56ea94ef55d87948b593f376718383e854644177a5e63c767a6b206026b4a2557e6d748d0a', 'eea19ce4835661fdeb5aa877cd51743daa31014c6fac8d5b21f8a2ff5861cb6e17729d2c0df4d982', 0, '2018-06-24 08:57:58'),
	('cacf2e96cec0f841272da7c0feb729ae792d338b26f4db1432c96b89ec11c13ffe0314953556d04a', '9319c13e1eaffd1814b9919c74cdf9445243231231d1b3b4adab2acd9268c6c454ac324708d6644f', 0, '2018-06-24 07:49:33'),
	('d3615ff10f92092190d0d71497abdb272ac6f736a7a2bb863bf5693d8f8992365e7036a2c395e46f', '5046dfc9de37ca3f5d75d3f08482a170bb865c32092ef11eec156a07cc0063a1852251719243b0c2', 0, '2018-06-13 07:55:00'),
	('d9496c9a698fc5a6e8c8b436f5a04c2e909a38cfaa3f1bf9c62fb245be96017f8722df50fe2c1782', '7d46eb15ce37f1090f9089f77c8da2bdea4bb2cc8327114cf6df61c423bfe250042f462f1ead42c4', 0, '2018-06-27 03:25:09'),
	('d9b5145dbb20fe7f9add50feff3346f40bcc32f54115a6e30ac54f3171cb75a7d0971962b6413de6', '3e4c3027180063fce710fe947db1df5b9dd3e93ebac6bbf3c6e7f520562bdacb560e400df8d0c906', 0, '2018-06-29 13:28:34'),
	('dd5b12287c42475a2c7b707d4f0ce5495319d58c71518774a5b357565000b10fb52dccc04ad65396', 'f4b5d06a2802b87f8a14ac4b3e3f7fa580abfbd0a9d20bb3a9e5bcac0dfb6a5ee67ea9d916da9abf', 0, '2018-06-13 08:53:28'),
	('e3f1061894dc177df007be2c5b180b5b1de951e83591e23df70e467c52375009c51d7d742fc8b8e2', 'f253b67c7ce8bae00ca40548080e65420b44deae91b2efb58427497a2e167fdd7a4d0d390bea0d6f', 0, '2018-06-30 10:41:28'),
	('e8c39cb52c171336237e6c9f4a252b39e5d38b7a466b907d3620d7a19e64c7fcc1c8d9d3b5869536', 'ff5d474e69b3d3614ce83e49d42831dd4ab7ff7513a716cd4d25063c81144cff5d1e218248d01cb2', 0, '2018-06-22 04:29:36'),
	('e99ec6c6c9de42e78a45442776e021017f29387a3e22d05087d5c65f5113d985736b3c818b4961d3', '2a072f820fa085eeef9929d304b2d88d8677190ffc3f386bb6a317f7d75ca4417a1bd74ab55bec31', 0, '2018-06-13 08:45:48'),
	('ea1c14619b3d7fcd6f0509c94c3f4cb568fa9bea7a0fe5dcb6eab1cb8f26110677a2c58227e3d1d8', 'e47535998ae244e642e6f9877d38b214cc15b2c93302f4509fe69230c73f51711c10d39c3a9542bc', 0, '2018-06-24 08:13:56'),
	('ed47a95751c2e07466958e835ccd6bbe10cf93f0c5afe2823709d80c4169cb5dec9b18fdf5f73cbc', '8154438b3b2b66c00ecf8817841bd2b545b4f2fdf80f406cdc62c8e60677917ce398b07ea2c4d6e8', 0, '2018-06-27 18:06:20'),
	('ef4444167fc6b6c0f81e530b744ff79d5c10773c9c15bcf966e7aa8379073fb0a15de91ffd5fc013', '3a718635f488b6c2a9a875f40f00e171ecb17003338f79384fa973eb6a893f534bb5b8b61430da1e', 0, '2018-06-13 07:45:10'),
	('ef9ed25d0d89a4f20d15d8f203b529cb3ef4382443355ae78a6b377456cf23ac40d54f497b2777b7', '97123b275f4625e39108bfcf68a89a4dc5ee8f7aa6aabe351ad4553cd8180f691f54ba46bf3104e9', 0, '2018-06-23 03:12:46'),
	('f26bda260bd478bae0d57da98887ca04556c72744a460816b5de1c23144297e842fdc31d22ed1130', 'c028d711e733c8c13c081eea5278925226b8a0f6c1d2379c3e6af1787b796b8b1012294822608823', 0, '2018-06-13 07:43:53'),
	('f2a94f144e26b5732f993c35d10ff01dd94c95825f0879e66ea461afcb4c2eb2db51e4d1180477d0', '10dc8383f976676d0565bc6516f4932fc82c045f49b6d31a011572f2b2a99b44854363e07e13bd77', 0, '2018-06-29 13:48:39'),
	('f31df1ce7b0c8175cff6974dead74816d24fef41b0babcd41d5fefb2413ad5acc3835a2e5fa7ac30', 'fe86bae4f1268dc59bdbe96665167b9ec78f0b884467bccf0b28785e11288029ac82a28a1f12de6f', 0, '2018-06-13 07:47:51'),
	('f44c84f0d98ca293fb0e536b204d2ef9ce5e4da03ccdd6a272797fc1826bb188691a6b43257497ca', 'a7afd3fbb0082482c3e35a787d21cba49703935c24180bc7e4f063173dfeec4a0e24ece04a8dce8a', 0, '2018-06-15 03:06:21'),
	('f7c889494320c2e46befe5f52025f441b16076aee59517361ce453ea5a79cd18c162a72ffbfca7f7', '39421feb5e1819abbb17508b2514c580193f2de17803f39021cf5765e229d9cce1b48507c011b785', 0, '2018-06-30 10:53:53'),
	('fdf5cc1845e2cba18f101332a977cc3109e60372139198c8dfa30946d7ed6a9058d694751d7b6aed', 'fbbb75634e9b120983107855c0d55e297ecd9deafdbcb02ab3138323f6fcd662874a39c4793d5a5a', 0, '2018-06-13 07:53:58');
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Dumping structure for table yoov_api.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table yoov_api.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `alias` varchar(50) NOT NULL DEFAULT '',
  `price` double NOT NULL DEFAULT '0',
  `remark` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.products: ~0 rows (approximately)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Dumping structure for table yoov_api.product_attributes
CREATE TABLE IF NOT EXISTS `product_attributes` (
  `product_id` int(10) unsigned NOT NULL,
  `attribute_id` int(10) unsigned NOT NULL,
  `price` double unsigned NOT NULL DEFAULT '0',
  `remark` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`product_id`,`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.product_attributes: ~0 rows (approximately)
/*!40000 ALTER TABLE `product_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_attributes` ENABLE KEYS */;

-- Dumping structure for table yoov_api.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(128) DEFAULT '',
  `name` varchar(128) DEFAULT '',
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.settings: ~4 rows (approximately)
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`, `type`, `name`, `value`) VALUES
	(1, '', 'image_xs_size_w', '48'),
	(2, '', 'image_xs_size_h', '48'),
	(3, '', 'image_sm_size_w', '128'),
	(4, '', 'image_sm_size_h', '128');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;

-- Dumping structure for table yoov_api.table
CREATE TABLE IF NOT EXISTS `table` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `airline` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `_lft` int(10) unsigned NOT NULL DEFAULT '0',
  `_rgt` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `table__lft__rgt_parent_id_index` (`_lft`,`_rgt`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.table: ~0 rows (approximately)
/*!40000 ALTER TABLE `table` DISABLE KEYS */;
/*!40000 ALTER TABLE `table` ENABLE KEYS */;

-- Dumping structure for table yoov_api.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `confirmed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `conrfirmation_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.users: ~9 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `alias`, `first_name`, `last_name`, `mobile`, `email`, `password`, `confirmed`, `conrfirmation_code`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'supervisor', '', '', '', '', 'yoov2017@gmail.com', '$2y$10$5sRbMXhBGfkStQPeU2JofuWfFiBdU84bdafobn04DmM6WtsAD1IX.', 0, NULL, NULL, '2017-12-21 03:39:27', '2017-12-21 03:39:27'),
	(2, 'yoovtest1', '', '', '', '', 'yoovtest1@gmail.com', '$2y$10$qxibRPeYTnOR6c8PY1DBsOLjb4RifLZamhrBk3J4scNK2AgOHabri', 0, NULL, NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(3, 'yoovtest2', '', '', '', '', 'yoovtest2@gmail.com', '$2y$10$lUzKi3tv0gjLU.NTozvCwuP8Zd0oAcgoYpcZVlCn0m8Juv3b7TwNK', 0, NULL, NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(4, 'yoovtest3', '', '', '', '', 'yoovtest3@gmail.com', '$2y$10$bPQKoquyBv1zfQB7jBEgbe7obbdqklkzZFSRcDiUk7HAdPzPPdAA.', 0, NULL, NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(5, 'yoovtest4', '', '', '', '', 'yoovtest4@gmail.com', '$2y$10$QCDCRlJnv.cPkFnDjJl8T.4hcqDhZDJ71LjAT.CNixoTufe6ZqvxW', 0, NULL, NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(6, 'yoovtest5', '', '', '', '', 'yoovtest5@gmail.com', '$2y$10$gjyGbmCu2b34/mJ0TnpxDeRcRiaKXwoZzzmIVqvDqKrpNXvaeJxQe', 0, NULL, NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(7, 'yoovtest6', '', '', '', '', 'yoovtest6@gmail.com', '$2y$10$Mc9wb36138MHuvJ5CH/3PuMAd81X8rE4/GyEw3n8JH4g6IeGol53u', 0, NULL, NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(8, 'yoovtest7', '', '', '', '', 'yoovtest7@gmail.com', '$2y$10$HKrHYCfodbgyP1Pe/yBUP.b9w741WSM/HFxFpdGWncTc1NeSDHlKW', 0, NULL, NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(30, 'phil', 'Phil', '', '', '61136557', 'philipwong@yoov.com', '$2y$10$aSRBnBXCeMJ7rp8dBwq5RuH9gt6oIAGhYiyYEMcBvYSi0S2kkbT0a', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(31, 'mark', 'Mark', '', '', '64883360', 'hc.devmark@gmail.com', '$2y$10$vDupUjoc8LwbCI2pxkcBgOrQIY9A0LRscM0mFbAEAmXAEr/AUFfCi', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(32, 'dominic', 'Dominic', '', '', '90279335', 'dominic@yoov.com', '$2y$10$TTFjz50GZLDFidvru30sKuG1TqlSJZYt.YM0QlUxP6YnbEkEt60Pm', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(33, 'peter', 'Peter', '', '', '51260545', 'peterleung@yoov.com', '$2y$10$SpLDzBF2azA6yOOGLsR0aOo/KiRRnZz/D5QqgmevYwz8/MxhBk2Ba', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(34, 'raymond', 'Raymond', '', '', '51168205', 'raymondcheung@yoov.com', '$2y$10$rNY999UBcEkGGtNW2iNLVOqUdEKlzIBxQR7ulokY9ysLtSE.zKeSa', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(35, 'sugar', 'Sugar', '', '', '67067103', 'sugartsang@yoov.com', '$2y$10$bnrdtnhwPhZgrrbt3Kk6u.JZupk0OEhBkln5cAGzY4c24hcfFHPGq', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(36, 'teresa', 'Teresa', '', '', '', 'teresa@utimeapps.com', '$2y$10$X96PEfkluhlCu/Qv8AhzEOMzVH9xhr8PBpXs9Phy251rO3PFtU5A2', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(37, 'yvonne', 'Yvonne', '', '', '64359588', 'yvonnefan@yoov.com', '$2y$10$O1VQhA1SjfqeH0XXJYaA1OGc.9xsO2UsWjrhwtBb2ZiSbf.4/8heK', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(38, 'tommy', 'Tommy', '', '', '61549843', 'tommychan@yoov.com', '$2y$10$7T4ZPUUax18Mx1r8TE494uLG8qsBXgkWUTXDU6XiEdzmyVVpJg/Y.', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(39, 'winnie', 'Winnie', 'Nga-lai', '', '', 'winnietse@yoov.com', '$2y$10$s/9DSqI2YNlDhw33m9CEguWveRmgGPMMOwOeQkeJ8.YVbtHLmRAVG', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(40, 'york', 'York', '', '', '60413927', 'yorkliang@yoov.com', '$2y$10$YV3FskzlBLlBeCgj/vTZj.hi7xgf.L8rHdY4Qrjed1MHs9zyrMkg.', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(41, 'donald', 'Donald', '', '', '93378630', 'donald@utimeapps.com', '$2y$10$6L8EwWXeCL/VzhXpxlZz6ubBOjq07k/20Jh03iLlR9nazMIxTZg6y', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(42, 'eric', 'Eric', '', '', '65016603', 'ericshek@yoov.com', '$2y$10$zNRZ7Ms.TvP9CXif4lk4TeV3spsf8lTZA4XR12Pve7nNZ7VIE9QSa', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(43, 'jack', 'jack', '', '', '51098796', 'jackwong@yoov.com', '$2y$10$b8.5YVm/3ROGYeOVfNp9hOiDs3Zkg2sIZH5HXeRUE8BPscpSnxkFa', 0, NULL, NULL, '2018-05-31 10:51:13', '2018-05-31 10:51:13'),
	(44, 'jacob', 'Jacob', '', '', '66922577', 'jacob@utimeapps.com', '$2y$10$K31fYVgZREcyX3v1qb06WeYW/dfxBqI3nrhBUypR4jh6KSJE7/UM2', 0, NULL, NULL, '2018-05-31 10:51:14', '2018-05-31 10:51:14'),
	(45, 'jennifer', 'Jennifer', '', '', '60482678', 'jennifer@utimeapps.com', '$2y$10$UKmOvqDDGkZ5k.aSKnqgregQ2hb/wcQ4H0.Vzo60U5R4YLYXt1ul2', 0, NULL, NULL, '2018-05-31 10:51:14', '2018-05-31 10:51:14'),
	(46, 'jessica', 'Jessica', 'Ka-yee', '', '91376708', 'jessicatam@yoov.com', '$2y$10$MbWFVDsJcuc.YerkVC5iF.JZiino2sPP6JbPwiD.oue3TwGAvY0m.', 0, NULL, NULL, '2018-05-31 10:51:14', '2018-05-31 10:51:14'),
	(47, 'kelly', 'Kelly', '', '', '98611397', 'kellytsui@yoov.com', '$2y$10$9cfTclM0A7ThqrsQWjnSVOLe6AIVvkigLxdtt2MzudlIJBM/SLwji', 0, NULL, NULL, '2018-05-31 10:51:14', '2018-05-31 10:51:14'),
	(48, 'luke', 'Luke', '', '', '62210324', 'lukeng@yoov.com', '$2y$10$w1MkKBCl0YLvUS51HEmn4ucfB0hBvDef5L.OQevM56fKTikbXQLsO', 0, NULL, NULL, '2018-05-31 10:51:14', '2018-05-31 10:51:14'),
	(49, 'andriy', 'Andriy', 'Kwok-wah', '', '63372725', 'andriychiu@yoov.com', '$2y$10$OSGJU3F7KUcX5hUWza8Nz.jrl/svxzwrG27aQxcZpGpHzzb/k2S4a', 0, NULL, NULL, '2018-05-31 10:51:14', '2018-05-31 10:51:14'),
	(50, 'cyrus', 'Cyrus', '', '', '91743087', 'cyrus@utimeapps.com', '$2y$10$MdHp7C0zWYdNLVciyjR2WO8XFewI0dLr30z/LXbk2x8ysp9GQX.vq', 0, NULL, NULL, '2018-05-31 10:51:14', '2018-05-31 10:51:14'),
	(51, 'daniel', 'Daniel', '', '', '92305065', 'danielleung@yoov.com', '$2y$10$Ss/sTYDHUQ/gk0kGiJeDXedPw01Vpq8.e6wtEs0apCLVnNopOm3Na', 0, NULL, NULL, '2018-05-31 10:51:14', '2018-05-31 10:51:14');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table yoov_api.user_infos
CREATE TABLE IF NOT EXISTS `user_infos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `folder_id` int(10) unsigned NOT NULL DEFAULT '0',
  `remark` text COLLATE utf8mb4_unicode_ci,
  `_lft` int(10) unsigned NOT NULL DEFAULT '0',
  `_rgt` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_infos__lft__rgt_parent_id_index` (`_lft`,`_rgt`,`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.user_infos: ~7 rows (approximately)
/*!40000 ALTER TABLE `user_infos` DISABLE KEYS */;
INSERT INTO `user_infos` (`id`, `user_id`, `first_name`, `last_name`, `folder_id`, `remark`, `_lft`, `_rgt`, `parent_id`) VALUES
	(26, 2, '', '', 11, NULL, 1, 14, NULL),
	(27, 3, '', '', 0, NULL, 2, 7, 26),
	(28, 4, '', '', 19, NULL, 8, 13, 26),
	(29, 5, '', '', 0, NULL, 3, 4, 27),
	(30, 6, '', '', 0, NULL, 5, 6, 27),
	(31, 7, '', '', 0, NULL, 9, 10, 28),
	(32, 8, '', '', 0, NULL, 11, 12, 28),
	(33, 0, '', '', 0, NULL, 15, 16, NULL),
	(34, 0, '', '', 0, NULL, 17, 18, NULL),
	(35, 32, '', '', 43, NULL, 19, 20, NULL);
/*!40000 ALTER TABLE `user_infos` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
