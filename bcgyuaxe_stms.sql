-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 06, 2020 at 01:27 PM
-- Server version: 5.7.31-cll-lve
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bcgyuaxe_stms`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `id` int(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `Bus`
--

CREATE TABLE `Bus` (
  `bid` int(255) NOT NULL,
  `Dev_ID` int(255) NOT NULL,
  `L_No` varchar(30) NOT NULL,
  `Issuing_Auth` varchar(30) NOT NULL,
  `Fitness_Exp` date NOT NULL,
  `R_Perm_Exp` date NOT NULL,
  `C_Driver` varchar(30) DEFAULT '0',
  `VType` varchar(30) NOT NULL,
  `Bus_Image` varchar(255) NOT NULL,
  `route_name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Bus`
--

INSERT INTO `Bus` (`bid`, `Dev_ID`, `L_No`, `Issuing_Auth`, `Fitness_Exp`, `R_Perm_Exp`, `C_Driver`, `VType`, `Bus_Image`, `route_name`) VALUES
(1, 123, 'GA-12-3568', 'Dhaka Metro', '2021-01-21', '2021-01-01', '2282187242', 'Heavy', 'Bus1.jpg', 'route 1');

-- --------------------------------------------------------

--
-- Table structure for table `Driver`
--

CREATE TABLE `Driver` (
  `did` int(255) NOT NULL,
  `L_No` varchar(20) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `DOB` date NOT NULL,
  `BloodGroup` varchar(30) NOT NULL,
  `F_Name` varchar(30) NOT NULL,
  `L_Issue_D` date NOT NULL,
  `L_Val_D` date NOT NULL,
  `Issuing_Auth` varchar(30) NOT NULL,
  `Image` varchar(30) NOT NULL,
  `Signature` varchar(30) NOT NULL,
  `Address` varchar(30) NOT NULL,
  `V_Type` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Driver`
--

INSERT INTO `Driver` (`did`, `L_No`, `Name`, `DOB`, `BloodGroup`, `F_Name`, `L_Issue_D`, `L_Val_D`, `Issuing_Auth`, `Image`, `Signature`, `Address`, `V_Type`) VALUES
(1, '2282187242', 'Sirajum Munir Fahim', '1996-08-20', 'B+', 'Mohammad Faruk Hossain', '2019-07-08', '2021-01-15', 'Dhaka', 'Fahim.jpg', 'F_Sig.jpg', 'Uttara,Dhaka', 'Heavy'),
(2, '14453526', 'Fariha Tasnim', '1994-04-14', 'A+', 'Md. Haque', '2019-06-11', '2022-04-23', 'Dhaka', 'Fariha.jpg', 'Fariha_Sig.jpg', 'Dhaka', 'Heavy');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(6) UNSIGNED NOT NULL,
  `Dev_ID` int(255) DEFAULT NULL,
  `V_License` varchar(255) NOT NULL,
  `Driver_ID` varchar(30) DEFAULT NULL,
  `TimeIn` time DEFAULT NULL,
  `TimeOut` time DEFAULT NULL,
  `DateIn` date DEFAULT NULL,
  `DateOut` date DEFAULT NULL,
  `status` int(255) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `Dev_ID`, `V_License`, `Driver_ID`, `TimeIn`, `TimeOut`, `DateIn`, `DateOut`, `status`) VALUES
(264, 123, 'GA-12-3568', '2282187242', '00:20:15', '09:13:57', '2020-04-19', '2020-10-06', 1),
(265, 123, 'GA-12-3568', '2282187242', '00:30:38', '09:13:57', '2020-04-19', '2020-10-06', 1),
(266, 123, 'GA-12-3568', '2282187242', '00:30:44', '09:13:57', '2020-04-19', '2020-10-06', 1),
(267, 123, 'GA-12-3568', '2282187242', '00:30:46', '09:13:57', '2020-04-19', '2020-10-06', 1),
(268, 123, 'GA-12-3568', '2282187242', '00:40:09', '09:13:57', '2020-04-19', '2020-10-06', 1),
(269, 123, 'GA-12-3568', '2282187242', '00:40:19', '09:13:57', '2020-04-19', '2020-10-06', 1),
(270, 123, 'GA-12-3568', '2282187242', '00:40:27', '09:13:57', '2020-04-19', '2020-10-06', 1),
(271, 123, 'GA-12-3568', '2282187242', '00:40:43', '09:13:57', '2020-04-19', '2020-10-06', 1),
(272, 123, 'GA-12-3568', '2282187242', '00:45:08', '09:13:57', '2020-04-19', '2020-10-06', 1),
(273, 123, 'GA-12-3568', '2282187242', '00:47:22', '09:13:57', '2020-04-19', '2020-10-06', 1),
(274, 123, 'GA-12-3568', '2282187242', '00:47:24', '09:13:57', '2020-04-19', '2020-10-06', 1),
(275, 123, 'GA-12-3568', '2282187242', '00:47:25', '09:13:57', '2020-04-19', '2020-10-06', 1),
(276, 123, 'GA-12-3568', '2282187242', '00:57:16', '09:13:57', '2020-04-19', '2020-10-06', 1),
(277, 123, 'GA-12-3568', '2282187242', '00:59:48', '09:13:57', '2020-04-19', '2020-10-06', 1),
(278, 123, 'GA-12-3568', '2282187242', '01:00:49', '09:13:57', '2020-04-19', '2020-10-06', 1),
(279, 123, 'GA-12-3568', '14453526', '02:09:44', '09:14:31', '2020-04-21', '2020-10-06', 1),
(280, 123, 'GA-12-3568', '14453526', '02:14:25', '09:14:31', '2020-04-21', '2020-10-06', 1),
(281, 123, 'GA-12-3568', '14453526', '02:27:41', '09:14:31', '2020-04-21', '2020-10-06', 1),
(282, 123, 'GA-12-3568', '2282187242', '02:46:44', '09:13:57', '2020-04-21', '2020-10-06', 1),
(283, 123, 'GA-12-3568', '14453526', '02:53:02', '09:14:31', '2020-04-21', '2020-10-06', 1),
(284, 123, 'GA-12-3568', '14453526', '03:03:50', '09:14:31', '2020-04-21', '2020-10-06', 1),
(285, 123, 'GA-12-3568', '2282187242', '03:04:17', '09:13:57', '2020-04-21', '2020-10-06', 1),
(286, 123, 'GA-12-3568', '14453526', '03:07:50', '09:14:31', '2020-04-21', '2020-10-06', 1),
(287, 123, 'GA-12-3568', '2282187242', '03:09:36', '09:13:57', '2020-04-21', '2020-10-06', 1),
(288, 123, 'GA-12-3568', '14453526', '03:10:09', '09:14:31', '2020-04-21', '2020-10-06', 1),
(289, 123, 'GA-12-3568', '2282187242', '03:10:25', '09:13:57', '2020-04-21', '2020-10-06', 1),
(290, 123, 'GA-12-3568', '14453526', '03:11:08', '09:14:31', '2020-04-21', '2020-10-06', 1),
(291, 123, 'GA-12-3568', '2282187242', '03:13:29', '09:13:57', '2020-04-21', '2020-10-06', 1),
(292, 123, 'GA-12-3568', '2282187242', '03:15:10', '09:13:57', '2020-04-21', '2020-10-06', 1),
(293, 123, 'GA-12-3568', '2282187242', '03:15:21', '09:13:57', '2020-04-21', '2020-10-06', 1),
(294, 123, 'GA-12-3568', '2282187242', '03:17:37', '09:13:57', '2020-04-21', '2020-10-06', 1),
(295, 123, 'GA-12-3568', '14453526', '03:18:03', '09:14:31', '2020-04-21', '2020-10-06', 1),
(296, 123, 'GA-12-3568', '2282187242', '03:18:19', '09:13:57', '2020-04-21', '2020-10-06', 1),
(297, 123, 'GA-12-3568', '2282187242', '03:19:09', '09:13:57', '2020-04-21', '2020-10-06', 1),
(298, 123, 'GA-12-3568', '2282187242', '03:24:03', '09:13:57', '2020-04-21', '2020-10-06', 1),
(299, 123, 'GA-12-3568', '14453526', '03:24:49', '09:14:31', '2020-04-21', '2020-10-06', 1),
(300, 123, 'GA-12-3568', '2282187242', '03:25:02', '09:13:57', '2020-04-21', '2020-10-06', 1),
(301, 123, 'GA-12-3568', '2282187242', '03:25:24', '09:13:57', '2020-04-21', '2020-10-06', 1),
(302, 123, 'GA-12-3568', '2282187242', '03:29:51', '09:13:57', '2020-04-21', '2020-10-06', 1),
(303, 123, 'GA-12-3568', '14453526', '03:30:16', '09:14:31', '2020-04-21', '2020-10-06', 1),
(304, 123, 'GA-12-3568', '2282187242', '03:30:30', '09:13:57', '2020-04-21', '2020-10-06', 1),
(305, 123, 'GA-12-3568', '2282187242', '13:14:31', '09:13:57', '2020-10-04', '2020-10-06', 1),
(306, 123, 'GA-12-3568', '2282187242', '13:14:36', '09:13:57', '2020-10-04', '2020-10-06', 1),
(307, 123, 'GA-12-3568', '14453526', '09:14:03', '09:14:31', '2020-10-06', '2020-10-06', 1),
(308, 123, 'GA-12-3568', '2282187242', '09:14:36', NULL, '2020-10-06', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `route_id` int(255) NOT NULL,
  `Route_Name` varchar(255) NOT NULL,
  `Stop 1` varchar(255) DEFAULT NULL,
  `Stop 2` varchar(255) DEFAULT NULL,
  `Stop 3` varchar(255) DEFAULT NULL,
  `Stop 4` varchar(255) DEFAULT NULL,
  `Stop 5` varchar(255) DEFAULT NULL,
  `Stop 6` varchar(255) DEFAULT NULL,
  `Stop 7` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`route_id`, `Route_Name`, `Stop 1`, `Stop 2`, `Stop 3`, `Stop 4`, `Stop 5`, `Stop 6`, `Stop 7`) VALUES
(1, 'route 1', 'Azampur Local Bus Stop', 'Rajlakshmi Bus Stop', 'Jasimuddin Bus Stop', 'Kawla Railgate Bus Station', 'Khilkhet South Bus Stop', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `violation`
--

CREATE TABLE `violation` (
  `id` int(255) NOT NULL,
  `violation_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `bus_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `driver_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `confidence` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `violation_time` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `loc_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `loc_accuracy` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `speed` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `longitude` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `latitude` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dispute` int(255) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `violation`
--

INSERT INTO `violation` (`id`, `violation_name`, `bus_id`, `driver_id`, `confidence`, `violation_time`, `loc_name`, `loc_accuracy`, `speed`, `longitude`, `latitude`, `dispute`) VALUES
(2, 'person', '123', '2282187242', '0.55078125', 'Mon Oct 05 21:09:52 GMT+06:00 2020', '11 Road-6, Dhaka 1230, Bangladesh', '68.646', '0', '23.86027', '23.86027', 0),
(4, 'person', '123', '2282187242', '0.609375', 'Mon Oct 05 21:23:30 GMT+06:00 2020', 'Service Rd, Dhaka 1230, Bangladesh', '5.0', '16.554901', '23.8678569', '23.8678569', 0),
(5, 'person', '123', '2282187242', '0.51171875', 'Tue Oct 06 12:54:05 GMT+06:00 2020', 'Shahajalal Ave, Dhaka 1230, Bangladesh', '5.0', '8.8813984E-8', '23.8677867', '23.8677867', 0),
(6, 'person', '123', '2282187242', '0.5390625', 'Tue Oct 06 12:54:26 GMT+06:00 2020', '1230 Dhaka - Mymensingh Hwy, Dhaka 1230, Bangladesh', '5.0', '2.9992437', '23.8682997', '23.8682997', 0),
(7, 'Speed_Violation', '123', '2282187242', '0', 'Tue Oct 06 12:54:36 GMT+06:00 2020', '11 Road-14/D, Dhaka 1230, Bangladesh', '5.0', '37.169834', '23.8666973', '23.8666973', 0),
(8, 'Speed_Violation', '123', '2282187242', '0', 'Tue Oct 06 12:54:47 GMT+06:00 2020', 'Rajlakshmi Bus Stop, Dhaka 1230, Bangladesh', '5.0', '36.779724', '23.8645339', '23.8645339', 0),
(9, 'Speed_Violation', '123', '2282187242', '0', 'Tue Oct 06 12:54:57 GMT+06:00 2020', 'Rajlakshmi Bus Stop, Dhaka 1230, Bangladesh', '5.0', '36.77506', '23.8645274', '23.8645274', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Bus`
--
ALTER TABLE `Bus`
  ADD PRIMARY KEY (`bid`),
  ADD UNIQUE KEY `L_No` (`L_No`);

--
-- Indexes for table `Driver`
--
ALTER TABLE `Driver`
  ADD PRIMARY KEY (`did`),
  ADD UNIQUE KEY `L_No` (`L_No`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`route_id`),
  ADD UNIQUE KEY `Route_Name` (`Route_Name`);

--
-- Indexes for table `violation`
--
ALTER TABLE `violation`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admin`
--
ALTER TABLE `Admin`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Bus`
--
ALTER TABLE `Bus`
  MODIFY `bid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Driver`
--
ALTER TABLE `Driver`
  MODIFY `did` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=309;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `route_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `violation`
--
ALTER TABLE `violation`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
