-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 21, 2020 at 03:45 AM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id12991193_nodemculog`
--

-- --------------------------------------------------------

--
-- Table structure for table `Bus`
--

CREATE TABLE `Bus` (
  `bid` int(255) NOT NULL,
  `Dev_ID` int(255) NOT NULL,
  `L_No` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Issuing_Auth` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Fitness_Exp` date NOT NULL,
  `R_Perm_Exp` date NOT NULL,
  `C_Driver` varchar(30) COLLATE utf8_unicode_ci DEFAULT '0',
  `VType` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Bus_Image` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Bus`
--

INSERT INTO `Bus` (`bid`, `Dev_ID`, `L_No`, `Issuing_Auth`, `Fitness_Exp`, `R_Perm_Exp`, `C_Driver`, `VType`, `Bus_Image`) VALUES
(1, 123, 'GA-12-3568', 'Dhaka Metro', '2021-01-21', '2021-01-01', '0', 'Heavy', 'Bus1.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `Driver`
--

CREATE TABLE `Driver` (
  `did` int(255) NOT NULL,
  `L_No` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `DOB` date NOT NULL,
  `BloodGroup` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `F_Name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `L_Issue_D` date NOT NULL,
  `L_Val_D` date NOT NULL,
  `Issuing_Auth` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Image` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Signature` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Address` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `V_Type` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `status` int(255) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `Dev_ID`, `V_License`, `Driver_ID`, `TimeIn`, `TimeOut`, `DateIn`, `DateOut`, `status`) VALUES
(264, 123, 'GA-12-3568', '2282187242', '00:20:15', '03:30:45', '2020-04-19', '2020-04-21', 1),
(265, 123, 'GA-12-3568', '2282187242', '00:30:38', '03:30:45', '2020-04-19', '2020-04-21', 1),
(266, 123, 'GA-12-3568', '2282187242', '00:30:44', '03:30:45', '2020-04-19', '2020-04-21', 1),
(267, 123, 'GA-12-3568', '2282187242', '00:30:46', '03:30:45', '2020-04-19', '2020-04-21', 1),
(268, 123, 'GA-12-3568', '2282187242', '00:40:09', '03:30:45', '2020-04-19', '2020-04-21', 1),
(269, 123, 'GA-12-3568', '2282187242', '00:40:19', '03:30:45', '2020-04-19', '2020-04-21', 1),
(270, 123, 'GA-12-3568', '2282187242', '00:40:27', '03:30:45', '2020-04-19', '2020-04-21', 1),
(271, 123, 'GA-12-3568', '2282187242', '00:40:43', '03:30:45', '2020-04-19', '2020-04-21', 1),
(272, 123, 'GA-12-3568', '2282187242', '00:45:08', '03:30:45', '2020-04-19', '2020-04-21', 1),
(273, 123, 'GA-12-3568', '2282187242', '00:47:22', '03:30:45', '2020-04-19', '2020-04-21', 1),
(274, 123, 'GA-12-3568', '2282187242', '00:47:24', '03:30:45', '2020-04-19', '2020-04-21', 1),
(275, 123, 'GA-12-3568', '2282187242', '00:47:25', '03:30:45', '2020-04-19', '2020-04-21', 1),
(276, 123, 'GA-12-3568', '2282187242', '00:57:16', '03:30:45', '2020-04-19', '2020-04-21', 1),
(277, 123, 'GA-12-3568', '2282187242', '00:59:48', '03:30:45', '2020-04-19', '2020-04-21', 1),
(278, 123, 'GA-12-3568', '2282187242', '01:00:49', '03:30:45', '2020-04-19', '2020-04-21', 1),
(279, 123, 'GA-12-3568', '14453526', '02:09:44', '03:30:30', '2020-04-21', '2020-04-21', 1),
(280, 123, 'GA-12-3568', '14453526', '02:14:25', '03:30:30', '2020-04-21', '2020-04-21', 1),
(281, 123, 'GA-12-3568', '14453526', '02:27:41', '03:30:30', '2020-04-21', '2020-04-21', 1),
(282, 123, 'GA-12-3568', '2282187242', '02:46:44', '03:30:45', '2020-04-21', '2020-04-21', 1),
(283, 123, 'GA-12-3568', '14453526', '02:53:02', '03:30:30', '2020-04-21', '2020-04-21', 1),
(284, 123, 'GA-12-3568', '14453526', '03:03:50', '03:30:30', '2020-04-21', '2020-04-21', 1),
(285, 123, 'GA-12-3568', '2282187242', '03:04:17', '03:30:45', '2020-04-21', '2020-04-21', 1),
(286, 123, 'GA-12-3568', '14453526', '03:07:50', '03:30:30', '2020-04-21', '2020-04-21', 1),
(287, 123, 'GA-12-3568', '2282187242', '03:09:36', '03:30:45', '2020-04-21', '2020-04-21', 1),
(288, 123, 'GA-12-3568', '14453526', '03:10:09', '03:30:30', '2020-04-21', '2020-04-21', 1),
(289, 123, 'GA-12-3568', '2282187242', '03:10:25', '03:30:45', '2020-04-21', '2020-04-21', 1),
(290, 123, 'GA-12-3568', '14453526', '03:11:08', '03:30:30', '2020-04-21', '2020-04-21', 1),
(291, 123, 'GA-12-3568', '2282187242', '03:13:29', '03:30:45', '2020-04-21', '2020-04-21', 1),
(292, 123, 'GA-12-3568', '2282187242', '03:15:10', '03:30:45', '2020-04-21', '2020-04-21', 1),
(293, 123, 'GA-12-3568', '2282187242', '03:15:21', '03:30:45', '2020-04-21', '2020-04-21', 1),
(294, 123, 'GA-12-3568', '2282187242', '03:17:37', '03:30:45', '2020-04-21', '2020-04-21', 1),
(295, 123, 'GA-12-3568', '14453526', '03:18:03', '03:30:30', '2020-04-21', '2020-04-21', 1),
(296, 123, 'GA-12-3568', '2282187242', '03:18:19', '03:30:45', '2020-04-21', '2020-04-21', 1),
(297, 123, 'GA-12-3568', '2282187242', '03:19:09', '03:30:45', '2020-04-21', '2020-04-21', 1),
(298, 123, 'GA-12-3568', '2282187242', '03:24:03', '03:30:45', '2020-04-21', '2020-04-21', 1),
(299, 123, 'GA-12-3568', '14453526', '03:24:49', '03:30:30', '2020-04-21', '2020-04-21', 1),
(300, 123, 'GA-12-3568', '2282187242', '03:25:02', '03:30:45', '2020-04-21', '2020-04-21', 1),
(301, 123, 'GA-12-3568', '2282187242', '03:25:24', '03:30:45', '2020-04-21', '2020-04-21', 1),
(302, 123, 'GA-12-3568', '2282187242', '03:29:51', '03:30:45', '2020-04-21', '2020-04-21', 1),
(303, 123, 'GA-12-3568', '14453526', '03:30:16', '03:30:30', '2020-04-21', '2020-04-21', 1),
(304, 123, 'GA-12-3568', '2282187242', '03:30:30', '03:30:45', '2020-04-21', '2020-04-21', 1);

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for dumped tables
--

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
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=305;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
