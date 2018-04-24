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

-- Dumping structure for table yoovbundle.attributes
CREATE TABLE IF NOT EXISTS `attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(50) NOT NULL DEFAULT '',
  `attribute_type` enum('yesno','options') NOT NULL DEFAULT 'yesno',
  `remark` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoovbundle.attributes: ~0 rows (approximately)
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;

-- Dumping structure for table yoovbundle.attribute_categories
CREATE TABLE IF NOT EXISTS `attribute_categories` (
  `attribute_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `extra_charge` double unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`attribute_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoovbundle.attribute_categories: ~0 rows (approximately)
/*!40000 ALTER TABLE `attribute_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_categories` ENABLE KEYS */;

-- Dumping structure for table yoovbundle.attribute_options
CREATE TABLE IF NOT EXISTS `attribute_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT '',
  `alias` varchar(50) DEFAULT '',
  `price` double NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoovbundle.attribute_options: ~0 rows (approximately)
/*!40000 ALTER TABLE `attribute_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_options` ENABLE KEYS */;

-- Dumping structure for table yoovbundle.bundles
CREATE TABLE IF NOT EXISTS `bundles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(50) NOT NULL DEFAULT '',
  `pricing_type` enum('variable','fixed') DEFAULT NULL,
  `price` double DEFAULT NULL,
  `remark` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoovbundle.bundles: ~1 rows (approximately)
/*!40000 ALTER TABLE `bundles` DISABLE KEYS */;
INSERT INTO `bundles` (`id`, `name`, `alias`, `pricing_type`, `price`, `remark`, `created_at`, `updated_at`) VALUES
	(1, '開心組合123', '', 'fixed', 198, '大批1個(超級夏威夷/千島熱情/歡笑樂園/世外桃園)+小食拼盤/炸雞4件/雞翼...', NULL, NULL),
	(2, '五十五十(大)', '', 'fixed', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `bundles` ENABLE KEYS */;

-- Dumping structure for table yoovbundle.bundle_categories
CREATE TABLE IF NOT EXISTS `bundle_categories` (
  `bundle_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`bundle_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoovbundle.bundle_categories: ~0 rows (approximately)
/*!40000 ALTER TABLE `bundle_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `bundle_categories` ENABLE KEYS */;

-- Dumping structure for table yoovbundle.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(50) NOT NULL DEFAULT '',
  `default_price` double NOT NULL DEFAULT '0',
  `remark` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoovbundle.categories: ~6 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`, `alias`, `default_price`, `remark`, `created_at`, `updated_at`) VALUES
	(1, '番茄醬底(大批)', '', 108, '', NULL, NULL),
	(2, '特色醬底(大批)', '', 108, '', NULL, NULL),
	(3, '千島醬底(大批)', '', 108, '', NULL, NULL),
	(4, '番茄醬底(普通批)', '', 86, '', NULL, NULL),
	(5, '特色醬底(普通批)', '', 86, '', NULL, NULL),
	(6, '千島醬底(普通批)', '', 86, '', NULL, NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table yoovbundle.category_bundles
CREATE TABLE IF NOT EXISTS `category_bundles` (
  `category_id` int(10) unsigned NOT NULL,
  `bundle_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`category_id`,`bundle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoovbundle.category_bundles: ~0 rows (approximately)
/*!40000 ALTER TABLE `category_bundles` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_bundles` ENABLE KEYS */;

-- Dumping structure for table yoovbundle.category_products
CREATE TABLE IF NOT EXISTS `category_products` (
  `category_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `pricing_type` enum('use_default_in_category','special','dedicated') NOT NULL DEFAULT 'use_default_in_category',
  `price` double unsigned NOT NULL DEFAULT '0',
  `remark` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoovbundle.category_products: ~11 rows (approximately)
/*!40000 ALTER TABLE `category_products` DISABLE KEYS */;
INSERT INTO `category_products` (`category_id`, `product_id`, `pricing_type`, `price`, `remark`) VALUES
	(1, 1, 'use_default_in_category', 0, 0),
	(1, 2, 'use_default_in_category', 0, 0),
	(1, 3, 'use_default_in_category', 0, 0),
	(1, 4, 'use_default_in_category', 0, 0),
	(1, 5, 'use_default_in_category', 0, 0),
	(1, 6, 'use_default_in_category', 0, 0),
	(1, 7, 'use_default_in_category', 0, 0),
	(1, 8, 'use_default_in_category', 0, 0),
	(2, 9, 'use_default_in_category', 0, 0),
	(2, 10, 'use_default_in_category', 0, 0),
	(2, 11, 'use_default_in_category', 0, 0);
/*!40000 ALTER TABLE `category_products` ENABLE KEYS */;

-- Dumping structure for table yoovbundle.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(50) NOT NULL DEFAULT '',
  `remark` text NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table yoovbundle.products: ~11 rows (approximately)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `name`, `alias`, `remark`, `price`, `category_id`, `created_at`, `updated_at`) VALUES
	(1, '環遊世界 ( 大 )', '', '', 108, 0, NULL, NULL),
	(2, '啖 啖 肉 ( 大 )', '', '', 108, 0, NULL, NULL),
	(3, '情迷辣肉腸 ( 大 )', '', '', 108, 0, NULL, NULL),
	(4, '香草烤雞 ( 大 )', '', '', 108, 0, NULL, NULL),
	(5, '	夏 威 夷 ( 大 )', '', '', 108, 0, NULL, NULL),
	(6, '超級夏威夷 ( 大 )	', '', '', 108, 0, NULL, NULL),
	(7, '	墨西哥香辣 ( 大 )', '', '', 108, 0, NULL, NULL),
	(8, '歡笑樂園 ( 大 )', '', '', 108, 0, NULL, NULL),
	(9, '特色燒烤 ( 大 )', '', '', 108, 0, NULL, NULL),
	(10, '泰式辣香雞 ( 大 )', '', '', 108, 0, NULL, NULL),
	(11, '五十五十 ( 大 )', '', '', 123, 0, NULL, NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
