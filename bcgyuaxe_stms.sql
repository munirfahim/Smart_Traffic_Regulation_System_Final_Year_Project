-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 07, 2020 at 03:52 PM
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
(264, 123, 'GA-12-3568', '2282187242', '00:20:15', '14:13:53', '2020-04-19', '2020-10-07', 1),
(265, 123, 'GA-12-3568', '2282187242', '00:30:38', '14:13:53', '2020-04-19', '2020-10-07', 1),
(266, 123, 'GA-12-3568', '2282187242', '00:30:44', '14:13:53', '2020-04-19', '2020-10-07', 1),
(267, 123, 'GA-12-3568', '2282187242', '00:30:46', '14:13:53', '2020-04-19', '2020-10-07', 1),
(268, 123, 'GA-12-3568', '2282187242', '00:40:09', '14:13:53', '2020-04-19', '2020-10-07', 1),
(269, 123, 'GA-12-3568', '2282187242', '00:40:19', '14:13:53', '2020-04-19', '2020-10-07', 1),
(270, 123, 'GA-12-3568', '2282187242', '00:40:27', '14:13:53', '2020-04-19', '2020-10-07', 1),
(271, 123, 'GA-12-3568', '2282187242', '00:40:43', '14:13:53', '2020-04-19', '2020-10-07', 1),
(272, 123, 'GA-12-3568', '2282187242', '00:45:08', '14:13:53', '2020-04-19', '2020-10-07', 1),
(273, 123, 'GA-12-3568', '2282187242', '00:47:22', '14:13:53', '2020-04-19', '2020-10-07', 1),
(274, 123, 'GA-12-3568', '2282187242', '00:47:24', '14:13:53', '2020-04-19', '2020-10-07', 1),
(275, 123, 'GA-12-3568', '2282187242', '00:47:25', '14:13:53', '2020-04-19', '2020-10-07', 1),
(276, 123, 'GA-12-3568', '2282187242', '00:57:16', '14:13:53', '2020-04-19', '2020-10-07', 1),
(277, 123, 'GA-12-3568', '2282187242', '00:59:48', '14:13:53', '2020-04-19', '2020-10-07', 1),
(278, 123, 'GA-12-3568', '2282187242', '01:00:49', '14:13:53', '2020-04-19', '2020-10-07', 1),
(279, 123, 'GA-12-3568', '14453526', '02:09:44', '13:36:17', '2020-04-21', '2020-10-07', 1),
(280, 123, 'GA-12-3568', '14453526', '02:14:25', '13:36:17', '2020-04-21', '2020-10-07', 1),
(281, 123, 'GA-12-3568', '14453526', '02:27:41', '13:36:17', '2020-04-21', '2020-10-07', 1),
(282, 123, 'GA-12-3568', '2282187242', '02:46:44', '14:13:53', '2020-04-21', '2020-10-07', 1),
(283, 123, 'GA-12-3568', '14453526', '02:53:02', '13:36:17', '2020-04-21', '2020-10-07', 1),
(284, 123, 'GA-12-3568', '14453526', '03:03:50', '13:36:17', '2020-04-21', '2020-10-07', 1),
(285, 123, 'GA-12-3568', '2282187242', '03:04:17', '14:13:53', '2020-04-21', '2020-10-07', 1),
(286, 123, 'GA-12-3568', '14453526', '03:07:50', '13:36:17', '2020-04-21', '2020-10-07', 1),
(287, 123, 'GA-12-3568', '2282187242', '03:09:36', '14:13:53', '2020-04-21', '2020-10-07', 1),
(288, 123, 'GA-12-3568', '14453526', '03:10:09', '13:36:17', '2020-04-21', '2020-10-07', 1),
(289, 123, 'GA-12-3568', '2282187242', '03:10:25', '14:13:53', '2020-04-21', '2020-10-07', 1),
(290, 123, 'GA-12-3568', '14453526', '03:11:08', '13:36:17', '2020-04-21', '2020-10-07', 1),
(291, 123, 'GA-12-3568', '2282187242', '03:13:29', '14:13:53', '2020-04-21', '2020-10-07', 1),
(292, 123, 'GA-12-3568', '2282187242', '03:15:10', '14:13:53', '2020-04-21', '2020-10-07', 1),
(293, 123, 'GA-12-3568', '2282187242', '03:15:21', '14:13:53', '2020-04-21', '2020-10-07', 1),
(294, 123, 'GA-12-3568', '2282187242', '03:17:37', '14:13:53', '2020-04-21', '2020-10-07', 1),
(295, 123, 'GA-12-3568', '14453526', '03:18:03', '13:36:17', '2020-04-21', '2020-10-07', 1),
(296, 123, 'GA-12-3568', '2282187242', '03:18:19', '14:13:53', '2020-04-21', '2020-10-07', 1),
(297, 123, 'GA-12-3568', '2282187242', '03:19:09', '14:13:53', '2020-04-21', '2020-10-07', 1),
(298, 123, 'GA-12-3568', '2282187242', '03:24:03', '14:13:53', '2020-04-21', '2020-10-07', 1),
(299, 123, 'GA-12-3568', '14453526', '03:24:49', '13:36:17', '2020-04-21', '2020-10-07', 1),
(300, 123, 'GA-12-3568', '2282187242', '03:25:02', '14:13:53', '2020-04-21', '2020-10-07', 1),
(301, 123, 'GA-12-3568', '2282187242', '03:25:24', '14:13:53', '2020-04-21', '2020-10-07', 1),
(302, 123, 'GA-12-3568', '2282187242', '03:29:51', '14:13:53', '2020-04-21', '2020-10-07', 1),
(303, 123, 'GA-12-3568', '14453526', '03:30:16', '13:36:17', '2020-04-21', '2020-10-07', 1),
(304, 123, 'GA-12-3568', '2282187242', '03:30:30', '14:13:53', '2020-04-21', '2020-10-07', 1),
(305, 123, 'GA-12-3568', '2282187242', '13:14:31', '14:13:53', '2020-10-04', '2020-10-07', 1),
(306, 123, 'GA-12-3568', '2282187242', '13:14:36', '14:13:53', '2020-10-04', '2020-10-07', 1),
(307, 123, 'GA-12-3568', '14453526', '09:14:03', '13:36:17', '2020-10-06', '2020-10-07', 1),
(308, 123, 'GA-12-3568', '2282187242', '09:14:36', '14:13:53', '2020-10-06', '2020-10-07', 1),
(309, 123, 'GA-12-3568', '14453526', '08:12:25', '13:36:17', '2020-10-07', '2020-10-07', 1),
(310, 123, 'GA-12-3568', '2282187242', '08:23:55', '14:13:53', '2020-10-07', '2020-10-07', 1),
(311, 123, 'GA-12-3568', '14453526', '08:32:22', '13:36:17', '2020-10-07', '2020-10-07', 1),
(312, 123, 'GA-12-3568', '2282187242', '08:44:40', '14:13:53', '2020-10-07', '2020-10-07', 1),
(313, 123, 'GA-12-3568', '2282187242', '08:56:54', '14:13:53', '2020-10-07', '2020-10-07', 1),
(314, 123, 'GA-12-3568', '2282187242', '09:00:18', '14:13:53', '2020-10-07', '2020-10-07', 1),
(315, 123, 'GA-12-3568', '2282187242', '09:13:38', '14:13:53', '2020-10-07', '2020-10-07', 1),
(316, 123, 'GA-12-3568', '2282187242', '09:39:59', '14:13:53', '2020-10-07', '2020-10-07', 1),
(317, 123, 'GA-12-3568', '2282187242', '09:45:01', '14:13:53', '2020-10-07', '2020-10-07', 1),
(318, 123, 'GA-12-3568', '2282187242', '09:52:21', '14:13:53', '2020-10-07', '2020-10-07', 1),
(319, 123, 'GA-12-3568', '14453526', '09:52:30', '13:36:17', '2020-10-07', '2020-10-07', 1),
(320, 123, 'GA-12-3568', '2282187242', '09:52:47', '14:13:53', '2020-10-07', '2020-10-07', 1),
(321, 123, 'GA-12-3568', '14453526', '09:52:52', '13:36:17', '2020-10-07', '2020-10-07', 1),
(322, 123, 'GA-12-3568', '14453526', '10:49:58', '13:36:17', '2020-10-07', '2020-10-07', 1),
(323, 123, 'GA-12-3568', '2282187242', '10:50:45', '14:13:53', '2020-10-07', '2020-10-07', 1),
(324, 123, 'GA-12-3568', '14453526', '10:50:52', '13:36:17', '2020-10-07', '2020-10-07', 1),
(325, 123, 'GA-12-3568', '2282187242', '10:50:56', '14:13:53', '2020-10-07', '2020-10-07', 1),
(326, 123, 'GA-12-3568', '2282187242', '10:51:03', '14:13:53', '2020-10-07', '2020-10-07', 1),
(327, 123, 'GA-12-3568', '14453526', '11:05:36', '13:36:17', '2020-10-07', '2020-10-07', 1),
(328, 123, 'GA-12-3568', '2282187242', '11:06:03', '14:13:53', '2020-10-07', '2020-10-07', 1),
(329, 123, 'GA-12-3568', '14453526', '11:06:30', '13:36:17', '2020-10-07', '2020-10-07', 1),
(330, 123, 'GA-12-3568', '2282187242', '11:08:55', '14:13:53', '2020-10-07', '2020-10-07', 1),
(331, 123, 'GA-12-3568', '2282187242', '11:11:27', '14:13:53', '2020-10-07', '2020-10-07', 1),
(332, 123, 'GA-12-3568', '2282187242', '11:15:25', '14:13:53', '2020-10-07', '2020-10-07', 1),
(333, 123, 'GA-12-3568', '14453526', '11:16:07', '13:36:17', '2020-10-07', '2020-10-07', 1),
(334, 123, 'GA-12-3568', '14453526', '11:16:39', '13:36:17', '2020-10-07', '2020-10-07', 1),
(335, 123, 'GA-12-3568', '2282187242', '11:16:44', '14:13:53', '2020-10-07', '2020-10-07', 1),
(336, 123, 'GA-12-3568', '14453526', '11:20:19', '13:36:17', '2020-10-07', '2020-10-07', 1),
(337, 123, 'GA-12-3568', '2282187242', '11:20:35', '14:13:53', '2020-10-07', '2020-10-07', 1),
(338, 123, 'GA-12-3568', '2282187242', '11:23:55', '14:13:53', '2020-10-07', '2020-10-07', 1),
(339, 123, 'GA-12-3568', '14453526', '11:25:10', '13:36:17', '2020-10-07', '2020-10-07', 1),
(340, 123, 'GA-12-3568', '2282187242', '11:25:18', '14:13:53', '2020-10-07', '2020-10-07', 1),
(341, 123, 'GA-12-3568', '2282187242', '11:27:23', '14:13:53', '2020-10-07', '2020-10-07', 1),
(342, 123, 'GA-12-3568', '14453526', '11:31:41', '13:36:17', '2020-10-07', '2020-10-07', 1),
(343, 123, 'GA-12-3568', '14453526', '11:32:08', '13:36:17', '2020-10-07', '2020-10-07', 1),
(344, 123, 'GA-12-3568', '2282187242', '11:32:40', '14:13:53', '2020-10-07', '2020-10-07', 1),
(345, 123, 'GA-12-3568', '14453526', '11:40:27', '13:36:17', '2020-10-07', '2020-10-07', 1),
(346, 123, 'GA-12-3568', '2282187242', '11:41:13', '14:13:53', '2020-10-07', '2020-10-07', 1),
(347, 123, 'GA-12-3568', '14453526', '11:41:24', '13:36:17', '2020-10-07', '2020-10-07', 1),
(348, 123, 'GA-12-3568', '2282187242', '11:41:32', '14:13:53', '2020-10-07', '2020-10-07', 1),
(349, 123, 'GA-12-3568', '14453526', '11:43:17', '13:36:17', '2020-10-07', '2020-10-07', 1),
(350, 123, 'GA-12-3568', '14453526', '11:43:37', '13:36:17', '2020-10-07', '2020-10-07', 1),
(351, 123, 'GA-12-3568', '14453526', '11:47:34', '13:36:17', '2020-10-07', '2020-10-07', 1),
(352, 123, 'GA-12-3568', '14453526', '11:57:13', '13:36:17', '2020-10-07', '2020-10-07', 1),
(353, 123, 'GA-12-3568', '14453526', '11:57:32', '13:36:17', '2020-10-07', '2020-10-07', 1),
(354, 123, 'GA-12-3568', '14453526', '11:57:51', '13:36:17', '2020-10-07', '2020-10-07', 1),
(355, 123, 'GA-12-3568', '2282187242', '11:58:00', '14:13:53', '2020-10-07', '2020-10-07', 1),
(356, 123, 'GA-12-3568', '14453526', '11:58:13', '13:36:17', '2020-10-07', '2020-10-07', 1),
(357, 123, 'GA-12-3568', '2282187242', '11:58:18', '14:13:53', '2020-10-07', '2020-10-07', 1),
(358, 123, 'GA-12-3568', '2282187242', '12:56:30', '14:13:53', '2020-10-07', '2020-10-07', 1),
(359, 123, 'GA-12-3568', '2282187242', '13:11:16', '14:13:53', '2020-10-07', '2020-10-07', 1),
(360, 123, 'GA-12-3568', '2282187242', '13:11:35', '14:13:53', '2020-10-07', '2020-10-07', 1),
(361, 123, 'GA-12-3568', '2282187242', '13:19:21', '14:13:53', '2020-10-07', '2020-10-07', 1),
(362, 123, 'GA-12-3568', '2282187242', '13:22:51', '14:13:53', '2020-10-07', '2020-10-07', 1),
(363, 123, 'GA-12-3568', '2282187242', '13:29:00', '14:13:53', '2020-10-07', '2020-10-07', 1),
(364, 123, 'GA-12-3568', '2282187242', '13:29:35', '14:13:53', '2020-10-07', '2020-10-07', 1),
(365, 123, 'GA-12-3568', '14453526', '13:30:01', '13:36:17', '2020-10-07', '2020-10-07', 1),
(366, 123, 'GA-12-3568', '14453526', '13:30:16', '13:36:17', '2020-10-07', '2020-10-07', 1),
(367, 123, 'GA-12-3568', '2282187242', '13:30:29', '14:13:53', '2020-10-07', '2020-10-07', 1),
(368, 123, 'GA-12-3568', '14453526', '13:35:45', '13:36:17', '2020-10-07', '2020-10-07', 1),
(369, 123, 'GA-12-3568', '14453526', '13:36:09', '13:36:17', '2020-10-07', '2020-10-07', 1),
(370, 123, 'GA-12-3568', '2282187242', '13:36:20', '14:13:53', '2020-10-07', '2020-10-07', 1),
(371, 123, 'GA-12-3568', '14453526', '13:37:03', '13:37:18', '2020-10-07', '2020-10-07', 1),
(372, 123, 'GA-12-3568', '2282187242', '13:37:18', '14:13:53', '2020-10-07', '2020-10-07', 1),
(373, 123, 'GA-12-3568', '2282187242', '14:09:14', '14:13:53', '2020-10-07', '2020-10-07', 1),
(374, 123, 'GA-12-3568', '2282187242', '14:10:11', '14:13:53', '2020-10-07', '2020-10-07', 1),
(375, 123, 'GA-12-3568', '14453526', '14:10:21', '14:10:48', '2020-10-07', '2020-10-07', 1),
(376, 123, 'GA-12-3568', '2282187242', '14:10:48', '14:13:53', '2020-10-07', '2020-10-07', 1),
(377, 123, 'GA-12-3568', '2282187242', '14:14:03', NULL, '2020-10-07', NULL, 0);

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
(38, 'person', '123', '2282187242', '0.69921875', 'Wed Oct 07 20:28:28 GMT+06:00 2020', 'House: 13, 13 Road-14/A, Dhaka 1230, Bangladesh', '5.0', '7.404497', '90.4001882', '23.864954', 0),
(39, 'person', '123', '2282187242', '0.7578125', 'Wed Oct 07 20:28:49 GMT+06:00 2020', 'House 91, à¦¸à§œà¦•-à§­, à¦¢à¦¾à¦•à¦¾ 1230, Bangladesh', '5.0', '7.424926', '90.4001014', '23.8635761', 0),
(40, 'person', '123', '2282187242', '0.7109375', 'Wed Oct 07 20:29:10 GMT+06:00 2020', '15, 1230 à¦¢à¦¾à¦•à¦¾ - à¦®à¦¯à¦¼à¦®à¦¨à¦¸à¦¿à¦‚à¦¹ à¦®à¦¹à¦¾à¦¸à¦¡à¦¼à¦•, à¦¢à¦¾à¦•à¦¾ 1230, Bangladesh', '5.0', '7.400672', '90.4000299', '23.8621161', 0),
(41, 'Speed_Violation', '123', '2282187242', '0', 'Wed Oct 07 20:29:35 GMT+06:00 2020', '4a Road-05, Dhaka 1230, Bangladesh', '5.0', '37.05996', '23.8595274', '23.8595274', 0),
(42, 'person', '123', '2282187242', '0.6875', 'Wed Oct 07 20:29:35 GMT+06:00 2020', '4a Road-05, Dhaka 1230, Bangladesh', '5.0', '37.05996', '90.4010957', '23.8595274', 0),
(43, 'Speed_Violation', '123', '2282187242', '0', 'Wed Oct 07 20:29:45 GMT+06:00 2020', '2 Road-04, Dhaka 1230, Bangladesh', '5.0', '37.289913', '23.856803', '23.856803', 0),
(44, 'person', '123', '2282187242', '0.64453125', 'Wed Oct 07 20:29:56 GMT+06:00 2020', 'Dhaka - Mymensingh Hwy, Dhaka 1230, Bangladesh', '5.0', '35.68173', '90.4055914', '23.8541709', 0),
(45, 'person', '123', '2282187242', '0.65625', 'Wed Oct 07 20:30:18 GMT+06:00 2020', 'Dhaka - Mymensingh Hwy, Dhaka 1230, Bangladesh', '5.0', '7.4215374', '90.408228', '23.850992', 0),
(46, 'person', '123', '2282187242', '0.73828125', 'Wed Oct 07 20:30:40 GMT+06:00 2020', '1230 Rd to International Terminal, Dhaka 1230, Bangladesh', '5.0', '11.770201', '90.4094426', '23.8494973', 0),
(47, 'person', '123', '2282187242', '0.7578125', 'Wed Oct 07 20:33:23 GMT+06:00 2020', 'Service Rd, Dhaka 1230, Bangladesh', '5.0', '2.9983203', '90.4005278', '23.8681722', 0),
(48, 'person', '123', '2282187242', '0.75', 'Wed Oct 07 20:33:48 GMT+06:00 2020', 'Amir Comlpex, Service Rd, Dhaka 1230, Bangladesh', '5.0', '7.426774', '90.4003196', '23.8675616', 0),
(49, 'person', '123', '2282187242', '0.73046875', 'Wed Oct 07 20:34:09 GMT+06:00 2020', 'House 9, 6th Floor,, Rd 7, à¦¢à¦¾à¦•à¦¾ 1230, Bangladesh', '5.0', '7.4234247', '90.40036', '23.8661481', 0),
(50, 'Speed_Violation', '123', '2282187242', '0', 'Wed Oct 07 20:34:11 GMT+06:00 2020', 'Rajlakshmi Bus Stop, Dhaka 1230, Bangladesh', '5.0', '37.18964', '90.4001505', '23.8645699', 0),
(51, 'Speed_Violation', '123', '2282187242', '0', 'Wed Oct 07 20:34:23 GMT+06:00 2020', 'Jasimuddin Bus Stop, Dhaka 1230, Bangladesh', '5.0', '37.03636', '90.4002349', '23.8609874', 0),
(52, 'Speed_Violation', '123', '2282187242', '0', 'Wed Oct 07 20:34:33 GMT+06:00 2020', '1 Rd No 8, Dhaka 1230, Bangladesh', '5.0', '36.7334', '90.4022595', '23.8581006', 0),
(53, 'Speed_Violation', '123', '2282187242', '0', 'Wed Oct 07 20:34:44 GMT+06:00 2020', 'Zashin Plaza, House# 1, Road# 1, Sector# 1, Dhaka, à¦¢à¦¾à¦•à¦¾ 1230, Bangladesh', '5.0', '37.129547', '90.4047349', '23.8552408', 0),
(54, 'person', '123', '2282187242', '0.71875', 'Wed Oct 07 20:34:52 GMT+06:00 2020', 'Dhaka - Mymensingh Hwy, Dhaka 1230, Bangladesh', '5.0', '36.355587', '90.4057994', '23.8539457', 0),
(55, 'Speed_Violation', '123', '2282187242', '0', 'Wed Oct 07 20:34:55 GMT+06:00 2020', '1230 Dhaka - Mymensingh Hwy, Dhaka 1230, Bangladesh', '5.0', '38.764423', '90.4068922', '23.8526157', 0),
(56, 'person', '123', '2282187242', '0.7578125', 'Wed Oct 07 20:35:18 GMT+06:00 2020', 'Dhaka - Mymensingh Hwy, Dhaka 1230, Bangladesh', '5.0', '7.422216', '90.4083139', '23.8508853', 0),
(57, 'person', '123', '2282187242', '0.7578125', 'Wed Oct 07 20:35:39 GMT+06:00 2020', '1230 Rd to International Terminal, Dhaka 1230, Bangladesh', '5.0', '11.809815', '90.4096068', '23.8492871', 0);

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
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=378;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `route_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `violation`
--
ALTER TABLE `violation`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
