-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2023 at 12:00 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `itws1100termproject`
--
CREATE DATABASE IF NOT EXISTS `itws1100termproject` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `itws1100termproject`;

-- --------------------------------------------------------

--
-- Table structure for table `discovered_items`
--

CREATE TABLE `discovered_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email_address` tinytext NOT NULL,
  `phone` varchar(24) NOT NULL,
  `location` tinytext NOT NULL,
  `item_type` varchar(32) NOT NULL,
  `color_name` varchar(24) NOT NULL,
  `image_url` varchar(64) NOT NULL,
  `found_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `upload_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `comments` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `discovered_items`
--

INSERT INTO `discovered_items` (`id`, `first_name`, `last_name`, `email_address`, `phone`, `location`, `item_type`, `color_name`, `image_url`, `found_timestamp`, `upload_timestamp`, `comments`) VALUES
(1, 'Candice', 'Korn', 'candice.korn@fakedomain.com', '', 'Outside Union', 'Sweater/Jacket', 'maroon', 'no-image-either.jpg', '2023-11-29 17:08:22', '2023-11-29 19:47:56', 'Maroon zip-up sweatshirt on ground outside the Union building.'),
(2, 'Travis', 'Heavener', 'heavet@rpi.edu', '', 'My driveway', 'Homo sapiens', 'white', '', '2023-11-29 20:33:00', '2023-11-29 19:55:06', 'If found, return to my parents (I got lost)'),
(7, 'Matthew', 'Voynovich', 'voynom@rpi.edu', '', 'Barton Hall', 'Other (specify in comments)', 'White', '20231202_221402.png', '2023-12-03 03:11:00', '2023-12-03 03:14:02', 'Matt\'s Roommate'),
(9, 'James', 'Bond', 'JamesBond@007.eu', '', 'Mexico', 'Wearable tech', 'White', '20231204_123309.jpg', '2023-12-04 17:32:00', '2023-12-04 17:33:09', '');

-- --------------------------------------------------------

--
-- Table structure for table `lost_items`
--

CREATE TABLE `lost_items` (
  `id` int(11) UNSIGNED NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email_address` tinytext NOT NULL,
  `phone` varchar(24) NOT NULL,
  `location_last_known` tinytext NOT NULL,
  `item_type` varchar(32) NOT NULL,
  `color_name` varchar(24) NOT NULL,
  `image_url` varchar(64) NOT NULL,
  `lost_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `upload_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `comments` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lost_items`
--

INSERT INTO `lost_items` (`id`, `first_name`, `last_name`, `email_address`, `phone`, `location_last_known`, `item_type`, `color_name`, `image_url`, `lost_timestamp`, `upload_timestamp`, `comments`) VALUES
(1, 'Reese', 'Peace', 'reese.peace@fakedomain.com', '', 'Near DCC', 'AirPods', 'lime', 'no-image-here.jpg', '2023-11-29 05:00:00', '2023-11-29 19:39:22', 'Electric green carrying case'),
(2, 'Also', 'Travis', 'heavet@rpi.edu', '', 'Earth', 'Homo sapiens', 'white', '', '2004-09-22 19:33:00', '2023-11-29 19:58:35', 'Missing, no reward'),
(3, 'Me', 'OR', 'Something', '', 'somewhere', 'Wearable tech', 'Purple', '', '2023-11-29 23:16:00', '2023-11-29 23:16:57', ''),
(4, 'Matthew', 'Voynovich', 'voynom@rpi.edu', '', 'Davison Hall', 'Other (specify in comments)', 'White', '', '2023-12-03 03:10:00', '2023-12-03 03:10:19', 'My Roommate'),
(5, 'Travis', 'Heavener', 'heavet@rpi.edu', '', 'DCC', 'Jewelry & bracelets', 'Black', '', '2023-11-30 22:30:00', '2023-12-03 19:33:10', 'I genuinely lost a black ring this isn\'t part of the testing data'),
(6, 'Travis', 'Heavener', 'heavet@rpi.edu', '', 'My dorm', 'Headwear', 'Black', '', '2023-12-03 20:19:00', '2023-12-03 20:19:10', 'My trusty Phillies hat, I just found it btw'),
(7, 'L', 'D', 'fakemail', 'Jk', 'A', 'Headwear', 'Red', '', '2023-12-04 17:32:00', '2023-12-04 17:33:00', ''),
(8, 'Matt', 'Voyn', 'voynom@rpi.edu', '', 'Lally Hall', 'Headwear', 'Blue', '', '2023-12-04 17:32:00', '2023-12-04 17:33:01', 'I dont know where it went');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `discovered_items`
--
ALTER TABLE `discovered_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lost_items`
--
ALTER TABLE `lost_items`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `discovered_items`
--
ALTER TABLE `discovered_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `lost_items`
--
ALTER TABLE `lost_items`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
