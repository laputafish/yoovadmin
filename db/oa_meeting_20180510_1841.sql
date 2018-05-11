-- --------------------------------------------------------
-- Host:                         127.0.0.1
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.meetings: ~0 rows (approximately)
/*!40000 ALTER TABLE `meetings` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.meeting_rooms: ~4 rows (approximately)
/*!40000 ALTER TABLE `meeting_rooms` DISABLE KEYS */;
INSERT INTO `meeting_rooms` (`id`, `name`, `capacity`, `location`, `remark`, `equipments`, `created_at`, `updated_at`) VALUES
	(1, 'Room 101', 5, 'Room 101, 1/F', '', 'TV', '2018-05-10 18:40:37', '2018-05-10 10:40:53'),
	(2, 'Room 201', 5, 'Room 201, 2/F', '', 'Projector', '2018-05-10 12:05:58', '0000-00-00 00:00:00'),
	(3, 'Room 2303', 6, 'Room 2303, 23/F', '', 'Smart TV', '2018-05-10 12:07:30', '0000-00-00 00:00:00'),
	(4, 'Room 2601', 20, 'Room 2601, 26/F', '', 'TV, Projector, White Board, Video Conference', '2018-05-10 12:07:04', '0000-00-00 00:00:00');
/*!40000 ALTER TABLE `meeting_rooms` ENABLE KEYS */;

-- Dumping structure for table yoov_api.meeting_room_bookings
CREATE TABLE IF NOT EXISTS `meeting_room_bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_room_id` int(10) unsigned NOT NULL DEFAULT '0',
  `applicant_id` int(10) unsigned DEFAULT NULL,
  `from_datetime` timestamp NULL DEFAULT NULL,
  `to_datetime` timestamp NULL DEFAULT NULL,
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoov_api.meeting_room_bookings: ~2 rows (approximately)
/*!40000 ALTER TABLE `meeting_room_bookings` DISABLE KEYS */;
INSERT INTO `meeting_room_bookings` (`id`, `meeting_room_id`, `applicant_id`, `from_datetime`, `to_datetime`, `remark`) VALUES
	(1, 1, 4, '2018-05-10 13:00:00', '2018-05-10 15:00:00', NULL),
	(2, 2, 4, '2018-05-10 13:27:45', '2018-05-10 13:27:47', NULL);
/*!40000 ALTER TABLE `meeting_room_bookings` ENABLE KEYS */;

-- Dumping structure for table yoov_api.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.migrations: ~3 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2018_05_07_050843_create_test_table', 2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

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
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yoov_api.users: ~8 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Dominic', 'yoov2017@gmail.com', '$2y$10$5sRbMXhBGfkStQPeU2JofuWfFiBdU84bdafobn04DmM6WtsAD1IX.', NULL, '2017-12-21 03:39:27', '2017-12-21 03:39:27'),
	(2, 'yoovtest1', 'yoovtest1@gmail.com', '$2y$10$qxibRPeYTnOR6c8PY1DBsOLjb4RifLZamhrBk3J4scNK2AgOHabri', NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(3, 'yoovtest2', 'yoovtest2@gmail.com', '$2y$10$lUzKi3tv0gjLU.NTozvCwuP8Zd0oAcgoYpcZVlCn0m8Juv3b7TwNK', NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(4, 'yoovtest3', 'yoovtest3@gmail.com', '$2y$10$bPQKoquyBv1zfQB7jBEgbe7obbdqklkzZFSRcDiUk7HAdPzPPdAA.', NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(5, 'yoovtest4', 'yoovtest4@gmail.com', '$2y$10$QCDCRlJnv.cPkFnDjJl8T.4hcqDhZDJ71LjAT.CNixoTufe6ZqvxW', NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(6, 'yoovtest5', 'yoovtest5@gmail.com', '$2y$10$gjyGbmCu2b34/mJ0TnpxDeRcRiaKXwoZzzmIVqvDqKrpNXvaeJxQe', NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(7, 'yoovtest6', 'yoovtest6@gmail.com', '$2y$10$Mc9wb36138MHuvJ5CH/3PuMAd81X8rE4/GyEw3n8JH4g6IeGol53u', NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18'),
	(8, 'yoovtest7', 'yoovtest7@gmail.com', '$2y$10$HKrHYCfodbgyP1Pe/yBUP.b9w741WSM/HFxFpdGWncTc1NeSDHlKW', NULL, '2018-05-10 05:26:18', '2018-05-10 05:26:18');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
