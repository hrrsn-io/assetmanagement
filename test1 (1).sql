-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 02, 2013 at 06:37 PM
-- Server version: 5.5.24-log
-- PHP Version: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `test1`
--

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE IF NOT EXISTS `property` (
  `prop_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `prop_name` varchar(45) NOT NULL,
  `prop_count` tinyint(4) NOT NULL,
  `prop_category` varchar(45) NOT NULL,
  `prop_subcategory` varchar(45) DEFAULT NULL,
  `prop_location` tinyint(2) NOT NULL,
  `prop_image` varchar(100) DEFAULT NULL,
  `prop_purchased` date NOT NULL,
  `prop_purchase_docs` varchar(100) DEFAULT NULL,
  `prop_released` date DEFAULT NULL,
  `prop_release_docs` varchar(100) DEFAULT NULL,
  `prop_qr` varchar(255) NOT NULL,
  PRIMARY KEY (`prop_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=59 ;

--
-- Dumping data for table `property`
--

INSERT INTO `property` (`prop_id`, `prop_name`, `prop_count`, `prop_category`, `prop_subcategory`, `prop_location`, `prop_image`, `prop_purchased`, `prop_purchase_docs`, `prop_released`, `prop_release_docs`, `prop_qr`) VALUES
(48, 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?48484848484848484848'),
(49, 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?494949494949494949'),
(50, 'Toshiba Laptop', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5050505050505050'),
(51, 'tested', 2, 'Other', 'Portable', 4, 'http://flccoc.org/property/upload/pics/', '2013-10-16', 'http://flccoc.org/property/upload/pdocs/', '2013-10-25', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/51'),
(52, 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?52525252525252'),
(57, 'test3', 3, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5757'),
(58, 'pictested', 3, 'Technology', 'Desktop', 6, 'http://flccoc.org/property/upload/pics/1.jpg', '2013-10-09', 'http://flccoc.org/property/upload/pdocs/2.jpg', '2013-10-20', 'http://flccoc.org/property/upload/rdocs/3.jpg', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/');

--
-- Triggers `property`
--
DROP TRIGGER IF EXISTS `trg_hist_insert`;
DELIMITER //
CREATE TRIGGER `trg_hist_insert` AFTER INSERT ON `property`
 FOR EACH ROW BEGIN
	INSERT INTO prop_hist (prh_id, prop_id, prh_action, prh_modified, prh_name, prh_count, prh_category, prh_subcategory, prh_location, prh_image,
	prh_purchased, prh_purchase_docs, prh_released, prh_release_docs, prh_qr)
	VALUES (NULL, NEW.prop_id, 'insert', NOW(), NEW.prop_name, NEW.prop_count, NEW.prop_category, NEW.prop_subcategory, NEW.prop_location, NEW.prop_image, 	NEW.prop_purchased, NEW.prop_purchase_docs, NEW.prop_released, NEW.prop_release_docs, NEW.prop_qr);
	END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_hist_update`;
DELIMITER //
CREATE TRIGGER `trg_hist_update` AFTER UPDATE ON `property`
 FOR EACH ROW BEGIN
	INSERT INTO prop_hist (prh_id, prop_id, prh_action, prh_modified, prh_name, prh_count, prh_category, prh_subcategory, prh_location, prh_image,
	prh_purchased, prh_purchase_docs, prh_released, prh_release_docs, prh_qr)
	VALUES (NULL, NEW.prop_id, 'update', NOW(), NEW.prop_name, NEW.prop_count, NEW.prop_category, NEW.prop_subcategory, NEW.prop_location, NEW.prop_image, 	NEW.prop_purchased, NEW.prop_purchase_docs, NEW.prop_released, NEW.prop_release_docs, NEW.prop_qr);
	END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `prop_hist`
--

CREATE TABLE IF NOT EXISTS `prop_hist` (
  `prh_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `prop_id` tinyint(4) NOT NULL,
  `prh_action` varchar(15) NOT NULL,
  `prh_modified` datetime NOT NULL,
  `prh_name` varchar(45) NOT NULL,
  `prh_count` tinyint(4) NOT NULL,
  `prh_category` varchar(45) NOT NULL,
  `prh_subcategory` varchar(45) DEFAULT NULL,
  `prh_location` tinyint(2) NOT NULL,
  `prh_image` varchar(100) DEFAULT NULL,
  `prh_purchased` date NOT NULL,
  `prh_purchase_docs` varchar(100) DEFAULT NULL,
  `prh_released` date DEFAULT NULL,
  `prh_release_docs` varchar(100) DEFAULT NULL,
  `prh_qr` varchar(255) NOT NULL,
  PRIMARY KEY (`prh_id`),
  KEY `prop_id` (`prop_id`),
  KEY `prop_id_2` (`prop_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=776 ;

--
-- Dumping data for table `prop_hist`
--

INSERT INTO `prop_hist` (`prh_id`, `prop_id`, `prh_action`, `prh_modified`, `prh_name`, `prh_count`, `prh_category`, `prh_subcategory`, `prh_location`, `prh_image`, `prh_purchased`, `prh_purchase_docs`, `prh_released`, `prh_release_docs`, `prh_qr`) VALUES
(675, 44, 'insert', '2013-09-30 12:19:22', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, NULL, '0000-00-00', NULL, NULL, NULL, ''),
(676, 45, 'insert', '2013-09-30 12:25:50', 'Dell laptop Latitude E5520', 1, 'Technology', 'Laptop', 8, NULL, '0000-00-00', NULL, NULL, NULL, ''),
(677, 46, 'insert', '2013-09-30 12:25:58', 'Dell laptop Latitude E5520', 1, 'Technology', 'Laptop', 8, NULL, '0000-00-00', NULL, NULL, NULL, ''),
(678, 47, 'insert', '2013-09-30 12:28:33', 'e', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(679, 44, 'update', '2013-09-30 12:28:33', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, NULL, '0000-00-00', NULL, NULL, NULL, '44'),
(680, 45, 'update', '2013-09-30 12:28:33', 'Dell laptop Latitude E5520', 1, 'Technology', 'Laptop', 8, NULL, '0000-00-00', NULL, NULL, NULL, '45'),
(681, 47, 'update', '2013-09-30 12:28:33', 'e', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?47'),
(682, 47, 'update', '2013-09-30 12:29:30', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?47'),
(683, 48, 'insert', '2013-09-30 12:57:04', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(684, 48, 'update', '2013-09-30 12:57:04', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?48'),
(685, 49, 'insert', '2013-09-30 12:57:24', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(686, 48, 'update', '2013-09-30 12:57:24', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?4848'),
(687, 49, 'update', '2013-09-30 12:57:24', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?49'),
(688, 50, 'insert', '2013-09-30 12:57:51', 'Toshiba Laptop', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(689, 48, 'update', '2013-09-30 12:57:51', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?484848'),
(690, 49, 'update', '2013-09-30 12:57:51', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?4949'),
(691, 50, 'update', '2013-09-30 12:57:51', 'Toshiba Laptop', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?50'),
(692, 51, 'insert', '2013-10-02 10:27:45', 'test', 0, '', NULL, 0, NULL, '0000-00-00', NULL, NULL, NULL, ''),
(693, 48, 'update', '2013-10-02 11:31:40', 'Dell Latitude Lap E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?484848'),
(694, 48, 'update', '2013-10-02 11:31:55', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?484848'),
(695, 48, 'update', '2013-10-02 11:44:09', 'Dell Latitude Lap E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?484848'),
(696, 48, 'update', '2013-10-02 12:25:14', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?484848'),
(697, 48, 'update', '2013-10-02 12:25:30', 'Dell Latitude Lap E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?484848'),
(698, 48, 'update', '2013-10-02 12:26:52', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?484848'),
(699, 52, 'insert', '2013-10-02 12:29:49', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(700, 48, 'update', '2013-10-02 12:29:49', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?48484848'),
(701, 49, 'update', '2013-10-02 12:29:49', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?494949'),
(702, 50, 'update', '2013-10-02 12:29:49', 'Toshiba Laptop', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5050'),
(703, 51, 'update', '2013-10-02 12:29:49', 'test', 0, '', NULL, 0, NULL, '0000-00-00', NULL, NULL, NULL, '51'),
(704, 52, 'update', '2013-10-02 12:29:49', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?52'),
(705, 53, 'insert', '2013-10-02 12:30:21', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(706, 48, 'update', '2013-10-02 12:30:21', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?4848484848'),
(707, 49, 'update', '2013-10-02 12:30:21', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?49494949'),
(708, 50, 'update', '2013-10-02 12:30:21', 'Toshiba Laptop', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?505050'),
(709, 51, 'update', '2013-10-02 12:30:21', 'test', 0, '', NULL, 0, NULL, '0000-00-00', NULL, NULL, NULL, '5151'),
(710, 52, 'update', '2013-10-02 12:30:21', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5252'),
(711, 53, 'update', '2013-10-02 12:30:21', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?53'),
(712, 54, 'insert', '2013-10-02 12:32:32', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(713, 48, 'update', '2013-10-02 12:32:32', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?484848484848'),
(714, 49, 'update', '2013-10-02 12:32:32', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?4949494949'),
(715, 50, 'update', '2013-10-02 12:32:32', 'Toshiba Laptop', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?50505050'),
(716, 51, 'update', '2013-10-02 12:32:32', 'test', 0, '', NULL, 0, NULL, '0000-00-00', NULL, NULL, NULL, '515151'),
(717, 52, 'update', '2013-10-02 12:32:32', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?525252'),
(718, 53, 'update', '2013-10-02 12:32:32', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5353'),
(719, 54, 'update', '2013-10-02 12:32:32', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?54'),
(720, 55, 'insert', '2013-10-02 12:33:48', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(721, 48, 'update', '2013-10-02 12:33:48', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?48484848484848'),
(722, 49, 'update', '2013-10-02 12:33:48', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?494949494949'),
(723, 50, 'update', '2013-10-02 12:33:48', 'Toshiba Laptop', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5050505050'),
(724, 51, 'update', '2013-10-02 12:33:48', 'test', 0, '', NULL, 0, NULL, '0000-00-00', NULL, NULL, NULL, '51515151'),
(725, 52, 'update', '2013-10-02 12:33:48', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?52525252'),
(726, 53, 'update', '2013-10-02 12:33:48', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?535353'),
(727, 54, 'update', '2013-10-02 12:33:48', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5454'),
(728, 55, 'update', '2013-10-02 12:33:48', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?55'),
(729, 56, 'insert', '2013-10-02 12:34:09', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(730, 48, 'update', '2013-10-02 12:34:09', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?4848484848484848'),
(731, 49, 'update', '2013-10-02 12:34:09', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?49494949494949'),
(732, 50, 'update', '2013-10-02 12:34:09', 'Toshiba Laptop', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?505050505050'),
(733, 51, 'update', '2013-10-02 12:34:09', 'test', 0, '', NULL, 0, NULL, '0000-00-00', NULL, NULL, NULL, '5151515151'),
(734, 52, 'update', '2013-10-02 12:34:09', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5252525252'),
(735, 53, 'update', '2013-10-02 12:34:09', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?53535353'),
(736, 54, 'update', '2013-10-02 12:34:09', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?545454'),
(737, 55, 'update', '2013-10-02 12:34:09', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5555'),
(738, 56, 'update', '2013-10-02 12:34:09', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?56'),
(739, 57, 'insert', '2013-10-02 12:35:01', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(740, 48, 'update', '2013-10-02 12:35:02', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?484848484848484848'),
(741, 49, 'update', '2013-10-02 12:35:02', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?4949494949494949'),
(742, 50, 'update', '2013-10-02 12:35:02', 'Toshiba Laptop', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?50505050505050'),
(743, 51, 'update', '2013-10-02 12:35:02', 'test', 0, '', NULL, 0, NULL, '0000-00-00', NULL, NULL, NULL, '515151515151'),
(744, 52, 'update', '2013-10-02 12:35:02', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?525252525252'),
(745, 53, 'update', '2013-10-02 12:35:02', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5353535353'),
(746, 54, 'update', '2013-10-02 12:35:02', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?54545454'),
(747, 55, 'update', '2013-10-02 12:35:02', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?555555'),
(748, 56, 'update', '2013-10-02 12:35:02', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5656'),
(749, 57, 'update', '2013-10-02 12:35:02', 'test3', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?57'),
(750, 57, 'update', '2013-10-02 12:35:44', 'test3', 3, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?57'),
(751, 51, 'update', '2013-10-02 12:36:59', 'test', 2, '', '', 0, NULL, '0000-00-00', NULL, '0000-00-00', NULL, '515151515151'),
(752, 51, 'update', '2013-10-02 12:39:16', 'test', 2, 'Other', 'Portable', 4, NULL, '2013-10-16', NULL, '2013-10-25', NULL, '515151515151'),
(753, 51, 'update', '2013-10-02 12:39:52', 'test', 2, 'Other', 'Portable', 4, NULL, '2013-10-16', NULL, '2013-10-25', NULL, '515151515151'),
(754, 51, 'update', '2013-10-02 12:42:24', 'test', 2, 'Other', 'Portable', 4, 'http://flccoc.org/property/upload/pics/', '2013-10-16', NULL, '2013-10-25', NULL, 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(755, 51, 'update', '2013-10-02 12:42:24', 'test', 2, 'Other', 'Portable', 4, 'http://flccoc.org/property/upload/pics/', '2013-10-16', 'http://flccoc.org/property/upload/pdocs/', '2013-10-25', NULL, 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(756, 51, 'update', '2013-10-02 12:42:24', 'test', 2, 'Other', 'Portable', 4, 'http://flccoc.org/property/upload/pics/', '2013-10-16', 'http://flccoc.org/property/upload/pdocs/', '2013-10-25', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(757, 51, 'update', '2013-10-02 12:42:24', 'tested', 2, 'Other', 'Portable', 4, 'http://flccoc.org/property/upload/pics/', '2013-10-16', 'http://flccoc.org/property/upload/pdocs/', '2013-10-25', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(758, 58, 'insert', '2013-10-02 12:53:41', 'pictest', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/Tulips.jpg', '2013-10-09', 'http://flccoc.org/property/upload/pdocs/Jellyfish.jpg', '2013-10-20', 'http://flccoc.org/property/upload/rdocs/Desert.jpg', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?'),
(759, 48, 'update', '2013-10-02 12:53:41', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?48484848484848484848'),
(760, 49, 'update', '2013-10-02 12:53:41', 'Acer 22" monitor', 1, 'Technology', 'Other', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?494949494949494949'),
(761, 50, 'update', '2013-10-02 12:53:41', 'Toshiba Laptop', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5050505050505050'),
(762, 51, 'update', '2013-10-02 12:53:41', 'tested', 2, 'Other', 'Portable', 4, 'http://flccoc.org/property/upload/pics/', '2013-10-16', 'http://flccoc.org/property/upload/pdocs/', '2013-10-25', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/51'),
(763, 52, 'update', '2013-10-02 12:53:41', 'test2', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?52525252525252'),
(764, 57, 'update', '2013-10-02 12:53:41', 'test3', 3, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?5757'),
(765, 58, 'update', '2013-10-02 12:53:41', 'pictest', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/Tulips.jpg', '2013-10-09', 'http://flccoc.org/property/upload/pdocs/Jellyfish.jpg', '2013-10-20', 'http://flccoc.org/property/upload/rdocs/Desert.jpg', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?58'),
(766, 58, 'update', '2013-10-02 12:54:37', 'pictest', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '2013-10-09', 'http://flccoc.org/property/upload/pdocs/Jellyfish.jpg', '2013-10-20', 'http://flccoc.org/property/upload/rdocs/Desert.jpg', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(767, 58, 'update', '2013-10-02 12:54:37', 'pictest', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '2013-10-09', 'http://flccoc.org/property/upload/pdocs/', '2013-10-20', 'http://flccoc.org/property/upload/rdocs/Desert.jpg', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(768, 58, 'update', '2013-10-02 12:54:37', 'pictest', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '2013-10-09', 'http://flccoc.org/property/upload/pdocs/', '2013-10-20', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(769, 58, 'update', '2013-10-02 12:54:37', 'pictestss', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/', '2013-10-09', 'http://flccoc.org/property/upload/pdocs/', '2013-10-20', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(770, 58, 'update', '2013-10-02 13:43:08', 'pictestss', 1, 'Technology', 'Desktop', 1, 'http://flccoc.org/property/upload/pics/1.jpg', '2013-10-09', 'http://flccoc.org/property/upload/pdocs/2.jpg', '2013-10-20', 'http://flccoc.org/property/upload/rdocs/3.jpg', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(771, 58, 'update', '2013-10-02 13:43:40', 'pictested', 3, 'Technology', 'Desktop', 6, 'http://flccoc.org/property/upload/pics/1.jpg', '2013-10-09', 'http://flccoc.org/property/upload/pdocs/2.jpg', '2013-10-20', 'http://flccoc.org/property/upload/rdocs/3.jpg', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(772, 58, 'update', '2013-10-02 13:54:34', 'pictested', 3, 'Technology', 'Desktop', 6, 'http://flccoc.org/property/upload/pics/1.jpg', '2013-10-09', 'http://flccoc.org/property/upload/pdocs/2.jpg', '2013-10-20', 'http://flccoc.org/property/upload/rdocs/3.jpg', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=http://flccoc.org/property/upload/pics/'),
(773, 48, 'update', '2013-10-02 13:58:41', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?48484848484848484848'),
(774, 48, 'update', '2013-10-02 14:00:51', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?48484848484848484848'),
(775, 48, 'update', '2013-10-02 14:02:10', 'Dell Latitude Laptop E5220', 1, 'Technology', 'Laptop', 8, 'http://flccoc.org/property/upload/pics/', '0000-00-00', 'http://flccoc.org/property/upload/pdocs/', '0000-00-00', 'http://flccoc.org/property/upload/rdocs/', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?48484848484848484848');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `ID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(60) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `username`, `password`) VALUES
(1, 'admin', 'admin');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
