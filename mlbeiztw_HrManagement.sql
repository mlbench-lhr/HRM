-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 10, 2025 at 02:05 AM
-- Server version: 11.4.8-MariaDB-cll-lve-log
-- PHP Version: 8.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mlbeiztw_HrManagement`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `log_name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) DEFAULT NULL,
  `causer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`properties`)),
  `batch_uuid` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1, 'default', 'created', 'App\\Models\\Globals', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(2, 'default', 'created', 'App\\Models\\Branch', 'created', 1, NULL, NULL, '{\"attributes\":{\"name\":\"Cairo Branch\",\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(3, 'default', 'created', 'App\\Models\\Branch', 'created', 2, NULL, NULL, '{\"attributes\":{\"name\":\"NY Branch\",\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(4, 'default', 'created', 'App\\Models\\Department', 'created', 1, NULL, NULL, '{\"attributes\":{\"name\":\"IT\",\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(5, 'default', 'created', 'App\\Models\\Department', 'created', 2, NULL, NULL, '{\"attributes\":{\"name\":\"HR\",\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(6, 'default', 'created', 'App\\Models\\Department', 'created', 3, NULL, NULL, '{\"attributes\":{\"name\":\"Sales\",\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(7, 'default', 'created', 'App\\Models\\Department', 'created', 4, NULL, NULL, '{\"attributes\":{\"name\":\"Customer Service\",\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(8, 'default', 'created', 'App\\Models\\Position', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(9, 'default', 'created', 'App\\Models\\Position', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(10, 'default', 'created', 'App\\Models\\Position', 'created', 3, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(11, 'default', 'created', 'App\\Models\\Position', 'created', 4, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(12, 'default', 'created', 'App\\Models\\Shift', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(13, 'default', 'created', 'App\\Models\\Shift', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(14, 'default', 'created', 'App\\Models\\Employee', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(15, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(16, 'default', 'created', 'App\\Models\\Employee', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(17, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(18, 'default', 'created', 'App\\Models\\Employee', 'created', 3, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(19, 'default', 'updated', 'App\\Models\\Employee', 'updated', 3, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(20, 'default', 'created', 'App\\Models\\Employee', 'created', 4, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(21, 'default', 'updated', 'App\\Models\\Employee', 'updated', 4, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(22, 'default', 'created', 'App\\Models\\Employee', 'created', 5, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(23, 'default', 'updated', 'App\\Models\\Employee', 'updated', 5, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(24, 'default', 'created', 'App\\Models\\Employee', 'created', 6, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(25, 'default', 'updated', 'App\\Models\\Employee', 'updated', 6, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(26, 'default', 'created', 'App\\Models\\Employee', 'created', 7, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(27, 'default', 'updated', 'App\\Models\\Employee', 'updated', 7, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(28, 'default', 'created', 'App\\Models\\Employee', 'created', 8, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(29, 'default', 'updated', 'App\\Models\\Employee', 'updated', 8, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(30, 'default', 'created', 'App\\Models\\Employee', 'created', 9, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(31, 'default', 'updated', 'App\\Models\\Employee', 'updated', 9, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(32, 'default', 'created', 'App\\Models\\Employee', 'created', 10, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(33, 'default', 'updated', 'App\\Models\\Employee', 'updated', 10, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(34, 'default', 'created', 'App\\Models\\Employee', 'created', 11, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(35, 'default', 'updated', 'App\\Models\\Employee', 'updated', 11, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(36, 'default', 'created', 'App\\Models\\Employee', 'created', 12, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(37, 'default', 'updated', 'App\\Models\\Employee', 'updated', 12, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(38, 'default', 'created', 'App\\Models\\Employee', 'created', 13, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(39, 'default', 'updated', 'App\\Models\\Employee', 'updated', 13, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(40, 'default', 'created', 'App\\Models\\Employee', 'created', 14, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(41, 'default', 'updated', 'App\\Models\\Employee', 'updated', 14, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(42, 'default', 'created', 'App\\Models\\Employee', 'created', 15, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(43, 'default', 'updated', 'App\\Models\\Employee', 'updated', 15, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(44, 'default', 'created', 'App\\Models\\Employee', 'created', 16, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(45, 'default', 'updated', 'App\\Models\\Employee', 'updated', 16, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(46, 'default', 'created', 'App\\Models\\Metric', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(47, 'default', 'created', 'App\\Models\\Metric', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(48, 'default', 'created', 'App\\Models\\Metric', 'created', 3, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(49, 'default', 'created', 'App\\Models\\Metric', 'created', 4, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(50, 'default', 'created', 'App\\Models\\Metric', 'created', 5, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(51, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(52, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(53, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(54, 'default', 'created', 'App\\Models\\Attendance', 'created', 1, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(55, 'default', 'created', 'App\\Models\\Attendance', 'created', 2, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(56, 'default', 'created', 'App\\Models\\Attendance', 'created', 3, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(57, 'default', 'created', 'App\\Models\\Attendance', 'created', 4, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(58, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(59, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(60, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(61, 'default', 'created', 'App\\Models\\Attendance', 'created', 5, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(62, 'default', 'created', 'App\\Models\\Attendance', 'created', 6, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(63, 'default', 'created', 'App\\Models\\Attendance', 'created', 7, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(64, 'default', 'created', 'App\\Models\\Attendance', 'created', 8, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(65, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 3, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(66, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 3, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(67, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 3, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(68, 'default', 'created', 'App\\Models\\Attendance', 'created', 9, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(69, 'default', 'created', 'App\\Models\\Attendance', 'created', 10, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(70, 'default', 'created', 'App\\Models\\Attendance', 'created', 11, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(71, 'default', 'created', 'App\\Models\\Attendance', 'created', 12, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(72, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 4, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(73, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 4, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(74, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 4, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(75, 'default', 'created', 'App\\Models\\Attendance', 'created', 13, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(76, 'default', 'created', 'App\\Models\\Attendance', 'created', 14, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(77, 'default', 'created', 'App\\Models\\Attendance', 'created', 15, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(78, 'default', 'created', 'App\\Models\\Attendance', 'created', 16, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(79, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 5, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(80, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 5, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(81, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 5, NULL, NULL, '[]', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(82, 'default', 'created', 'App\\Models\\Attendance', 'created', 17, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(83, 'default', 'created', 'App\\Models\\Attendance', 'created', 18, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(84, 'default', 'created', 'App\\Models\\Attendance', 'created', 19, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(85, 'default', 'created', 'App\\Models\\Attendance', 'created', 20, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(86, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 6, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(87, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 6, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(88, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 6, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(89, 'default', 'created', 'App\\Models\\Attendance', 'created', 21, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(90, 'default', 'created', 'App\\Models\\Attendance', 'created', 22, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(91, 'default', 'created', 'App\\Models\\Attendance', 'created', 23, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(92, 'default', 'created', 'App\\Models\\Attendance', 'created', 24, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(93, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 7, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(94, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 7, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(95, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 7, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(96, 'default', 'created', 'App\\Models\\Attendance', 'created', 25, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(97, 'default', 'created', 'App\\Models\\Attendance', 'created', 26, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(98, 'default', 'created', 'App\\Models\\Attendance', 'created', 27, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(99, 'default', 'created', 'App\\Models\\Attendance', 'created', 28, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(100, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 8, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(101, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 8, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(102, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 8, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(103, 'default', 'created', 'App\\Models\\Attendance', 'created', 29, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(104, 'default', 'created', 'App\\Models\\Attendance', 'created', 30, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(105, 'default', 'created', 'App\\Models\\Attendance', 'created', 31, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(106, 'default', 'created', 'App\\Models\\Attendance', 'created', 32, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(107, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 9, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(108, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 9, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(109, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 9, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(110, 'default', 'created', 'App\\Models\\Attendance', 'created', 33, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(111, 'default', 'created', 'App\\Models\\Attendance', 'created', 34, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(112, 'default', 'created', 'App\\Models\\Attendance', 'created', 35, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(113, 'default', 'created', 'App\\Models\\Attendance', 'created', 36, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(114, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 10, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(115, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 10, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(116, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 10, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(117, 'default', 'created', 'App\\Models\\Attendance', 'created', 37, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(118, 'default', 'created', 'App\\Models\\Attendance', 'created', 38, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(119, 'default', 'created', 'App\\Models\\Attendance', 'created', 39, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(120, 'default', 'created', 'App\\Models\\Attendance', 'created', 40, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(121, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 11, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(122, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 11, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(123, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 11, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(124, 'default', 'created', 'App\\Models\\Attendance', 'created', 41, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(125, 'default', 'created', 'App\\Models\\Attendance', 'created', 42, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(126, 'default', 'created', 'App\\Models\\Attendance', 'created', 43, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(127, 'default', 'created', 'App\\Models\\Attendance', 'created', 44, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(128, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 12, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(129, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 12, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(130, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 12, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(131, 'default', 'created', 'App\\Models\\Attendance', 'created', 45, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(132, 'default', 'created', 'App\\Models\\Attendance', 'created', 46, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(133, 'default', 'created', 'App\\Models\\Attendance', 'created', 47, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(134, 'default', 'created', 'App\\Models\\Attendance', 'created', 48, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(135, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 13, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(136, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 13, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(137, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 13, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(138, 'default', 'created', 'App\\Models\\Attendance', 'created', 49, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(139, 'default', 'created', 'App\\Models\\Attendance', 'created', 50, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(140, 'default', 'created', 'App\\Models\\Attendance', 'created', 51, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(141, 'default', 'created', 'App\\Models\\Attendance', 'created', 52, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(142, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 14, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(143, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 14, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(144, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 14, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(145, 'default', 'created', 'App\\Models\\Attendance', 'created', 53, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(146, 'default', 'created', 'App\\Models\\Attendance', 'created', 54, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(147, 'default', 'created', 'App\\Models\\Attendance', 'created', 55, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(148, 'default', 'created', 'App\\Models\\Attendance', 'created', 56, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(149, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 15, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(150, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 15, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(151, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 15, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(152, 'default', 'created', 'App\\Models\\Attendance', 'created', 57, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(153, 'default', 'created', 'App\\Models\\Attendance', 'created', 58, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(154, 'default', 'created', 'App\\Models\\Attendance', 'created', 59, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(155, 'default', 'created', 'App\\Models\\Attendance', 'created', 60, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(156, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 16, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(157, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 16, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(158, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 16, NULL, NULL, '[]', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(159, 'default', 'created', 'App\\Models\\Attendance', 'created', 61, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(160, 'default', 'created', 'App\\Models\\Attendance', 'created', 62, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(161, 'default', 'created', 'App\\Models\\Attendance', 'created', 63, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(162, 'default', 'created', 'App\\Models\\Attendance', 'created', 64, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(163, 'default', 'created', 'App\\Models\\Manager', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(164, 'default', 'created', 'App\\Models\\Manager', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(165, 'default', 'created', 'App\\Models\\Payroll', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(166, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(167, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(168, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 3, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(169, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 4, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(170, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 5, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(171, 'default', 'created', 'App\\Models\\Addition', 'created', 1, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(172, 'default', 'created', 'App\\Models\\Deduction', 'created', 1, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(173, 'default', 'created', 'App\\Models\\Payroll', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(174, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 6, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(175, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 7, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(176, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 8, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(177, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 9, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(178, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 10, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(179, 'default', 'created', 'App\\Models\\Addition', 'created', 2, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(180, 'default', 'created', 'App\\Models\\Deduction', 'created', 2, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(181, 'default', 'created', 'App\\Models\\Payroll', 'created', 3, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(182, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 11, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(183, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 12, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(184, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 13, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(185, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 14, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(186, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 15, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(187, 'default', 'created', 'App\\Models\\Addition', 'created', 3, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(188, 'default', 'created', 'App\\Models\\Deduction', 'created', 3, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(189, 'default', 'created', 'App\\Models\\Payroll', 'created', 4, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(190, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 16, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(191, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 17, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(192, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 18, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(193, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 19, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(194, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 20, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(195, 'default', 'created', 'App\\Models\\Addition', 'created', 4, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(196, 'default', 'created', 'App\\Models\\Deduction', 'created', 4, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(197, 'default', 'created', 'App\\Models\\Payroll', 'created', 5, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(198, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 21, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(199, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 22, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(200, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 23, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(201, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 24, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(202, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 25, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(203, 'default', 'created', 'App\\Models\\Addition', 'created', 5, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(204, 'default', 'created', 'App\\Models\\Deduction', 'created', 5, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(205, 'default', 'created', 'App\\Models\\Payroll', 'created', 6, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(206, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 26, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(207, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 27, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(208, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 28, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(209, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 29, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(210, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 30, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(211, 'default', 'created', 'App\\Models\\Addition', 'created', 6, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(212, 'default', 'created', 'App\\Models\\Deduction', 'created', 6, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(213, 'default', 'created', 'App\\Models\\Payroll', 'created', 7, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(214, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 31, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(215, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 32, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(216, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 33, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(217, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 34, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(218, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 35, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(219, 'default', 'created', 'App\\Models\\Addition', 'created', 7, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(220, 'default', 'created', 'App\\Models\\Deduction', 'created', 7, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(221, 'default', 'created', 'App\\Models\\Payroll', 'created', 8, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(222, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 36, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(223, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 37, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(224, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 38, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(225, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 39, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(226, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 40, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(227, 'default', 'created', 'App\\Models\\Addition', 'created', 8, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(228, 'default', 'created', 'App\\Models\\Deduction', 'created', 8, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(229, 'default', 'created', 'App\\Models\\Payroll', 'created', 9, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(230, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 41, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(231, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 42, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(232, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 43, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(233, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 44, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(234, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 45, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(235, 'default', 'created', 'App\\Models\\Addition', 'created', 9, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(236, 'default', 'created', 'App\\Models\\Deduction', 'created', 9, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(237, 'default', 'created', 'App\\Models\\Payroll', 'created', 10, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(238, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 46, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(239, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 47, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(240, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 48, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(241, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 49, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(242, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 50, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(243, 'default', 'created', 'App\\Models\\Addition', 'created', 10, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(244, 'default', 'created', 'App\\Models\\Deduction', 'created', 10, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(245, 'default', 'created', 'App\\Models\\Payroll', 'created', 11, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(246, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 51, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(247, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 52, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(248, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 53, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(249, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 54, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(250, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 55, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(251, 'default', 'created', 'App\\Models\\Addition', 'created', 11, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(252, 'default', 'created', 'App\\Models\\Deduction', 'created', 11, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(253, 'default', 'created', 'App\\Models\\Payroll', 'created', 12, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(254, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 56, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(255, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 57, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(256, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 58, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(257, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 59, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(258, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 60, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(259, 'default', 'created', 'App\\Models\\Addition', 'created', 12, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(260, 'default', 'created', 'App\\Models\\Deduction', 'created', 12, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(261, 'default', 'created', 'App\\Models\\Payroll', 'created', 13, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(262, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 61, NULL, NULL, '[]', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(263, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 62, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(264, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 63, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(265, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 64, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(266, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 65, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(267, 'default', 'created', 'App\\Models\\Addition', 'created', 13, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(268, 'default', 'created', 'App\\Models\\Deduction', 'created', 13, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(269, 'default', 'created', 'App\\Models\\Payroll', 'created', 14, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(270, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 66, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(271, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 67, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(272, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 68, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(273, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 69, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(274, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 70, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(275, 'default', 'created', 'App\\Models\\Addition', 'created', 14, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(276, 'default', 'created', 'App\\Models\\Deduction', 'created', 14, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(277, 'default', 'created', 'App\\Models\\Payroll', 'created', 15, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(278, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 71, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(279, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 72, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(280, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 73, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(281, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 74, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(282, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 75, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(283, 'default', 'created', 'App\\Models\\Addition', 'created', 15, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(284, 'default', 'created', 'App\\Models\\Deduction', 'created', 15, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(285, 'default', 'created', 'App\\Models\\Payroll', 'created', 16, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(286, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 76, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(287, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 77, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(288, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 78, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(289, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 79, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(290, 'default', 'created', 'App\\Models\\EmployeeEvaluation', 'created', 80, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(291, 'default', 'created', 'App\\Models\\Addition', 'created', 16, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(292, 'default', 'created', 'App\\Models\\Deduction', 'created', 16, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(293, 'default', 'created', 'App\\Models\\Request', 'created', 1, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(294, 'default', 'created', 'App\\Models\\Request', 'created', 2, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(295, 'default', 'created', 'App\\Models\\Request', 'created', 3, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(296, 'default', 'created', 'App\\Models\\Request', 'created', 4, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(297, 'default', 'created', 'App\\Models\\Request', 'created', 5, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(298, 'default', 'created', 'App\\Models\\Request', 'created', 6, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(299, 'default', 'created', 'App\\Models\\Request', 'created', 7, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(300, 'default', 'created', 'App\\Models\\Request', 'created', 8, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(301, 'default', 'created', 'App\\Models\\Request', 'created', 9, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(302, 'default', 'created', 'App\\Models\\Request', 'created', 10, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(303, 'default', 'created', 'App\\Models\\Request', 'created', 11, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(304, 'default', 'created', 'App\\Models\\Request', 'created', 12, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(305, 'default', 'created', 'App\\Models\\Request', 'created', 13, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(306, 'default', 'created', 'App\\Models\\Request', 'created', 14, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(307, 'default', 'created', 'App\\Models\\Request', 'created', 15, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(308, 'default', 'created', 'App\\Models\\Request', 'created', 16, NULL, NULL, '[]', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(309, 'default', 'created', 'App\\Models\\Calendar', 'created', 1, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(310, 'default', 'created', 'App\\Models\\Calendar', 'created', 2, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(311, 'default', 'created', 'App\\Models\\Calendar', 'created', 3, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(312, 'default', 'created', 'App\\Models\\Calendar', 'created', 4, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(313, 'default', 'created', 'App\\Models\\Calendar', 'created', 5, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(314, 'default', 'created', 'App\\Models\\Calendar', 'created', 6, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(315, 'default', 'created', 'App\\Models\\Calendar', 'created', 7, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(316, 'default', 'created', 'App\\Models\\Calendar', 'created', 8, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(317, 'default', 'created', 'App\\Models\\Calendar', 'created', 9, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(318, 'default', 'created', 'App\\Models\\Calendar', 'created', 10, NULL, NULL, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(319, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 12:24:12', '2025-05-07 12:24:12'),
(320, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 12:24:34', '2025-05-07 12:24:34');
INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(321, 'default', 'created', 'App\\Models\\Employee', 'created', 17, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:07:38', '2025-05-07 13:07:38'),
(322, 'default', 'updated', 'App\\Models\\Employee', 'updated', 17, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:07:38', '2025-05-07 13:07:38'),
(323, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 17, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:07:38', '2025-05-07 13:07:38'),
(324, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 17, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:07:38', '2025-05-07 13:07:38'),
(325, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 17, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:07:38', '2025-05-07 13:07:38'),
(326, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 8, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:22:55', '2025-05-07 13:22:55'),
(327, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:24:31', '2025-05-07 13:24:31'),
(328, 'default', 'created', 'App\\Models\\Attendance', 'created', 65, 'App\\Models\\Employee', 2, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:25:06', '2025-05-07 13:25:06'),
(329, 'default', 'created', 'App\\Models\\Request', 'created', 17, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 13:26:44', '2025-05-07 13:26:44'),
(330, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 13:27:40', '2025-05-07 13:27:40'),
(331, 'default', 'updated', 'App\\Models\\Request', 'updated', 17, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:28:22', '2025-05-07 13:28:22'),
(332, 'default', 'updated', 'App\\Models\\Request', 'updated', 11, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:32:17', '2025-05-07 13:32:17'),
(333, 'default', 'deleted', 'App\\Models\\Request', 'deleted', 9, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:32:34', '2025-05-07 13:32:34'),
(334, 'default', 'created', 'App\\Models\\Branch', 'created', 3, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":\"ml bench\",\"text\":null}}', NULL, '2025-05-07 13:44:14', '2025-05-07 13:44:14'),
(335, 'default', 'created', 'App\\Models\\Manager', 'created', 3, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:44:14', '2025-05-07 13:44:14'),
(336, 'default', 'created', 'App\\Models\\Attendance', 'created', 66, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(337, 'default', 'updated', 'App\\Models\\Attendance', 'updated', 65, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null},\"old\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(338, 'default', 'created', 'App\\Models\\Attendance', 'created', 67, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(339, 'default', 'created', 'App\\Models\\Attendance', 'created', 68, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(340, 'default', 'created', 'App\\Models\\Attendance', 'created', 69, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(341, 'default', 'created', 'App\\Models\\Attendance', 'created', 70, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(342, 'default', 'created', 'App\\Models\\Attendance', 'created', 71, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(343, 'default', 'created', 'App\\Models\\Attendance', 'created', 72, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(344, 'default', 'created', 'App\\Models\\Attendance', 'created', 73, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(345, 'default', 'created', 'App\\Models\\Attendance', 'created', 74, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(346, 'default', 'created', 'App\\Models\\Attendance', 'created', 75, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(347, 'default', 'created', 'App\\Models\\Attendance', 'created', 76, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(348, 'default', 'created', 'App\\Models\\Attendance', 'created', 77, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(349, 'default', 'created', 'App\\Models\\Attendance', 'created', 78, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(350, 'default', 'created', 'App\\Models\\Attendance', 'created', 79, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(351, 'default', 'created', 'App\\Models\\Attendance', 'created', 80, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(352, 'default', 'updated', 'App\\Models\\Addition', 'updated', 2, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null},\"old\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:52:31', '2025-05-07 13:52:31'),
(353, 'default', 'updated', 'App\\Models\\Deduction', 'updated', 2, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null},\"old\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 13:52:31', '2025-05-07 13:52:31'),
(354, 'default', 'updated', 'App\\Models\\Payroll', 'updated', 2, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:52:31', '2025-05-07 13:52:31'),
(355, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 13:52:51', '2025-05-07 13:52:51'),
(356, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 13:53:22', '2025-05-07 13:53:22'),
(357, 'default', 'updated', 'App\\Models\\Employee', 'updated', 17, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 14:02:59', '2025-05-07 14:02:59'),
(358, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 14:09:27', '2025-05-07 14:09:27'),
(359, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 14:16:13', '2025-05-07 14:16:13'),
(360, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 14:28:20', '2025-05-07 14:28:20'),
(361, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 14:37:58', '2025-05-07 14:37:58'),
(362, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 14:38:10', '2025-05-07 14:38:10'),
(363, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 14:39:07', '2025-05-07 14:39:07'),
(364, 'default', 'updated', 'App\\Models\\Addition', 'updated', 2, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null},\"old\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 14:39:38', '2025-05-07 14:39:38'),
(365, 'default', 'updated', 'App\\Models\\Deduction', 'updated', 2, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":null,\"text\":null},\"old\":{\"name\":null,\"text\":null}}', NULL, '2025-05-07 14:39:38', '2025-05-07 14:39:38'),
(366, 'default', 'updated', 'App\\Models\\Payroll', 'updated', 2, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 14:39:38', '2025-05-07 14:39:38'),
(367, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 14:42:42', '2025-05-07 14:42:42'),
(368, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 14:43:36', '2025-05-07 14:43:36'),
(369, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 14:43:44', '2025-05-07 14:43:44'),
(370, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 14:44:06', '2025-05-07 14:44:06'),
(371, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 14:55:18', '2025-05-07 14:55:18'),
(372, 'default', 'created', 'App\\Models\\Employee', 'created', 18, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 16:16:04', '2025-05-07 16:16:04'),
(373, 'default', 'updated', 'App\\Models\\Employee', 'updated', 18, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 16:16:04', '2025-05-07 16:16:04'),
(374, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 18, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 16:16:04', '2025-05-07 16:16:04'),
(375, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 18, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 16:16:04', '2025-05-07 16:16:04'),
(376, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 18, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 16:16:04', '2025-05-07 16:16:04'),
(377, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 16:16:52', '2025-05-07 16:16:52'),
(378, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 16:23:58', '2025-05-07 16:23:58'),
(379, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 16:24:27', '2025-05-07 16:24:27'),
(380, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 5, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 18:43:39', '2025-05-07 18:43:39'),
(381, 'default', 'updated', 'App\\Models\\Employee', 'updated', 3, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 18:44:37', '2025-05-07 18:44:37'),
(382, 'default', 'created', 'App\\Models\\Branch', 'created', 4, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":\"Branch 1\",\"text\":null}}', NULL, '2025-05-07 19:11:30', '2025-05-07 19:11:30'),
(383, 'default', 'created', 'App\\Models\\Employee', 'created', 19, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:12:30', '2025-05-07 19:12:30'),
(384, 'default', 'updated', 'App\\Models\\Employee', 'updated', 19, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:12:30', '2025-05-07 19:12:30'),
(385, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 19, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:12:30', '2025-05-07 19:12:30'),
(386, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 19, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:12:30', '2025-05-07 19:12:30'),
(387, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 19, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:12:30', '2025-05-07 19:12:30'),
(388, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 18, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:14:54', '2025-05-07 19:14:54'),
(389, 'default', 'created', 'App\\Models\\Manager', 'created', 4, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:17:41', '2025-05-07 19:17:41'),
(390, 'default', 'created', 'App\\Models\\Department', 'created', 5, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":\"CV\",\"text\":null}}', NULL, '2025-05-07 19:18:37', '2025-05-07 19:18:37'),
(391, 'default', 'created', 'App\\Models\\Manager', 'created', 5, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:18:37', '2025-05-07 19:18:37'),
(392, 'default', 'created', 'App\\Models\\Department', 'created', 6, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":\"CVV\",\"text\":null}}', NULL, '2025-05-07 19:19:22', '2025-05-07 19:19:22'),
(393, 'default', 'created', 'App\\Models\\Manager', 'created', 6, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:19:22', '2025-05-07 19:19:22'),
(394, 'default', 'created', 'App\\Models\\Position', 'created', 5, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:22:58', '2025-05-07 19:22:58'),
(395, 'default', 'created', 'App\\Models\\Shift', 'created', 3, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:44:43', '2025-05-07 19:44:43'),
(396, 'default', 'updated', 'App\\Models\\Shift', 'updated', 3, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:45:35', '2025-05-07 19:45:35'),
(397, 'default', 'created', 'App\\Models\\Employee', 'created', 20, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:49:23', '2025-05-07 19:49:23'),
(398, 'default', 'updated', 'App\\Models\\Employee', 'updated', 20, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:49:23', '2025-05-07 19:49:23'),
(399, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 20, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:49:23', '2025-05-07 19:49:23'),
(400, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 20, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:49:23', '2025-05-07 19:49:23'),
(401, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 20, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 19:49:23', '2025-05-07 19:49:23'),
(402, 'default', 'created', 'App\\Models\\Request', 'created', 18, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 20:03:48', '2025-05-07 20:03:48'),
(403, 'default', 'created', 'App\\Models\\Request', 'created', 19, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 20:07:39', '2025-05-07 20:07:39'),
(404, 'default', 'updated', 'App\\Models\\Request', 'updated', 19, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 20:17:49', '2025-05-07 20:17:49'),
(405, 'default', 'updated', 'App\\Models\\Request', 'updated', 2, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-07 20:18:28', '2025-05-07 20:18:28'),
(406, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-07 20:36:28', '2025-05-07 20:36:28'),
(407, 'default', 'created', 'App\\Models\\Employee', 'created', 21, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 11:59:57', '2025-05-08 11:59:57'),
(408, 'default', 'updated', 'App\\Models\\Employee', 'updated', 21, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 11:59:57', '2025-05-08 11:59:57'),
(409, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 21, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 11:59:57', '2025-05-08 11:59:57'),
(410, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 21, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 11:59:57', '2025-05-08 11:59:57'),
(411, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 21, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 11:59:57', '2025-05-08 11:59:57'),
(412, 'default', 'created', 'App\\Models\\Department', 'created', 7, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":\"Executives\",\"text\":null}}', NULL, '2025-05-08 14:17:25', '2025-05-08 14:17:25'),
(413, 'default', 'created', 'App\\Models\\Position', 'created', 6, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:17:47', '2025-05-08 14:17:47'),
(414, 'default', 'created', 'App\\Models\\Employee', 'created', 22, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:19:10', '2025-05-08 14:19:10'),
(415, 'default', 'updated', 'App\\Models\\Employee', 'updated', 22, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:19:10', '2025-05-08 14:19:10'),
(416, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 22, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:19:10', '2025-05-08 14:19:10'),
(417, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 22, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:19:10', '2025-05-08 14:19:10'),
(418, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 22, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:19:10', '2025-05-08 14:19:10'),
(419, 'default', 'updated', 'App\\Models\\EmployeeShift', 'updated', 2, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:20:15', '2025-05-08 14:20:15'),
(420, 'default', 'updated', 'App\\Models\\EmployeeShift', 'updated', 4, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:20:15', '2025-05-08 14:20:15'),
(421, 'default', 'updated', 'App\\Models\\EmployeeShift', 'updated', 6, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:20:15', '2025-05-08 14:20:15'),
(422, 'default', 'updated', 'App\\Models\\EmployeeShift', 'updated', 10, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:20:15', '2025-05-08 14:20:15'),
(423, 'default', 'updated', 'App\\Models\\EmployeeShift', 'updated', 12, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:20:15', '2025-05-08 14:20:15'),
(424, 'default', 'updated', 'App\\Models\\EmployeeShift', 'updated', 14, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:20:15', '2025-05-08 14:20:15'),
(425, 'default', 'updated', 'App\\Models\\EmployeeShift', 'updated', 16, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:20:15', '2025-05-08 14:20:15'),
(426, 'default', 'deleted', 'App\\Models\\Shift', 'deleted', 2, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:20:15', '2025-05-08 14:20:15'),
(427, 'default', 'updated', 'App\\Models\\Shift', 'updated', 3, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:20:22', '2025-05-08 14:20:22'),
(428, 'default', 'updated', 'App\\Models\\Shift', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:20:34', '2025-05-08 14:20:34'),
(429, 'default', 'created', 'App\\Models\\Request', 'created', 20, 'App\\Models\\Employee', 21, '[]', NULL, '2025-05-08 14:28:34', '2025-05-08 14:28:34'),
(430, 'default', 'updated', 'App\\Models\\Request', 'updated', 20, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:29:45', '2025-05-08 14:29:45'),
(431, 'default', 'updated', 'App\\Models\\Request', 'updated', 20, 'App\\Models\\Employee', 21, '[]', NULL, '2025-05-08 14:29:58', '2025-05-08 14:29:58'),
(432, 'default', 'updated', 'App\\Models\\Request', 'updated', 20, 'App\\Models\\Employee', 21, '[]', NULL, '2025-05-08 14:30:23', '2025-05-08 14:30:23'),
(433, 'default', 'created', 'App\\Models\\Employee', 'created', 23, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:57:15', '2025-05-08 14:57:15'),
(434, 'default', 'updated', 'App\\Models\\Employee', 'updated', 23, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:57:15', '2025-05-08 14:57:15'),
(435, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 23, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:57:15', '2025-05-08 14:57:15'),
(436, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 23, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:57:15', '2025-05-08 14:57:15'),
(437, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 23, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 14:57:15', '2025-05-08 14:57:15'),
(438, 'default', 'created', 'App\\Models\\Request', 'created', 21, 'App\\Models\\Employee', 21, '[]', NULL, '2025-05-08 17:20:05', '2025-05-08 17:20:05'),
(439, 'default', 'updated', 'App\\Models\\Request', 'updated', 21, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 17:21:43', '2025-05-08 17:21:43'),
(440, 'default', 'created', 'App\\Models\\Request', 'created', 22, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 18:25:23', '2025-05-08 18:25:23'),
(441, 'default', 'created', 'App\\Models\\Employee', 'created', 24, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 18:35:03', '2025-05-08 18:35:03'),
(442, 'default', 'updated', 'App\\Models\\Employee', 'updated', 24, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 18:35:03', '2025-05-08 18:35:03'),
(443, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 24, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 18:35:03', '2025-05-08 18:35:03'),
(444, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 24, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 18:35:03', '2025-05-08 18:35:03'),
(445, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 24, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 18:35:03', '2025-05-08 18:35:03'),
(446, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 18:39:48', '2025-05-08 18:39:48'),
(447, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-08 18:58:11', '2025-05-08 18:58:11'),
(448, 'default', 'updated', 'App\\Models\\Request', 'updated', 19, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-08 18:59:53', '2025-05-08 18:59:53'),
(449, 'default', 'updated', 'App\\Models\\Employee', 'updated', 2, 'App\\Models\\Employee', 2, '[]', NULL, '2025-05-08 19:05:10', '2025-05-08 19:05:10'),
(450, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:09:18', '2025-05-08 19:09:18'),
(451, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 2, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:10:40', '2025-05-08 19:10:40'),
(452, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 3, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:10:50', '2025-05-08 19:10:50'),
(453, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 4, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:10:59', '2025-05-08 19:10:59'),
(454, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 6, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:11:12', '2025-05-08 19:11:12'),
(455, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 7, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:11:21', '2025-05-08 19:11:21'),
(456, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 9, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:11:31', '2025-05-08 19:11:31'),
(457, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 10, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:12:03', '2025-05-08 19:12:03'),
(458, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 11, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:12:13', '2025-05-08 19:12:13'),
(459, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 13, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:12:20', '2025-05-08 19:12:20'),
(460, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 12, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:12:27', '2025-05-08 19:12:27'),
(461, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 14, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:12:42', '2025-05-08 19:12:42'),
(462, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 15, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:12:52', '2025-05-08 19:12:52'),
(463, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 16, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:13:02', '2025-05-08 19:13:02'),
(464, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 19, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:13:11', '2025-05-08 19:13:11'),
(465, 'default', 'deleted', 'App\\Models\\Employee', 'deleted', 20, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:13:26', '2025-05-08 19:13:26'),
(466, 'default', 'created', 'App\\Models\\Position', 'created', 7, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:35:46', '2025-05-08 19:35:46'),
(467, 'default', 'created', 'App\\Models\\Department', 'created', 8, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":\"Designing\",\"text\":null}}', NULL, '2025-05-08 19:36:08', '2025-05-08 19:36:08'),
(468, 'default', 'created', 'App\\Models\\Employee', 'created', 25, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:42:46', '2025-05-08 19:42:46'),
(469, 'default', 'updated', 'App\\Models\\Employee', 'updated', 25, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:42:46', '2025-05-08 19:42:46'),
(470, 'default', 'created', 'App\\Models\\EmployeeSalary', 'created', 25, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:42:46', '2025-05-08 19:42:46'),
(471, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 25, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:42:46', '2025-05-08 19:42:46'),
(472, 'default', 'created', 'App\\Models\\EmployeeShift', 'created', 25, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:42:46', '2025-05-08 19:42:46'),
(473, 'default', 'deleted', 'App\\Models\\Branch', 'deleted', 1, 'App\\Models\\Employee', 1, '{\"old\":{\"name\":\"Cairo Branch\",\"text\":null}}', NULL, '2025-05-08 19:44:07', '2025-05-08 19:44:07'),
(474, 'default', 'deleted', 'App\\Models\\Branch', 'deleted', 2, 'App\\Models\\Employee', 1, '{\"old\":{\"name\":\"NY Branch\",\"text\":null}}', NULL, '2025-05-08 19:44:15', '2025-05-08 19:44:15'),
(475, 'default', 'deleted', 'App\\Models\\Branch', 'deleted', 4, 'App\\Models\\Employee', 1, '{\"old\":{\"name\":\"Branch 1\",\"text\":null}}', NULL, '2025-05-08 19:44:25', '2025-05-08 19:44:25'),
(476, 'default', 'updated', 'App\\Models\\Branch', 'updated', 3, 'App\\Models\\Employee', 1, '{\"attributes\":{\"name\":\"ML Bench\",\"text\":null},\"old\":{\"name\":\"ml bench\",\"text\":null}}', NULL, '2025-05-08 19:45:51', '2025-05-08 19:45:51'),
(477, 'default', 'updated', 'App\\Models\\Manager', 'updated', 3, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:45:51', '2025-05-08 19:45:51'),
(478, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:46:16', '2025-05-08 19:46:16'),
(479, 'default', 'created', 'App\\Models\\Position', 'created', 8, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:47:18', '2025-05-08 19:47:18'),
(480, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:47:25', '2025-05-08 19:47:25'),
(481, 'default', 'updated', 'App\\Models\\EmployeePosition', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:47:25', '2025-05-08 19:47:25'),
(482, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 26, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:47:25', '2025-05-08 19:47:25'),
(483, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:47:57', '2025-05-08 19:47:57'),
(484, 'default', 'created', 'App\\Models\\Position', 'created', 9, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:50:08', '2025-05-08 19:50:08'),
(485, 'default', 'updated', 'App\\Models\\Employee', 'updated', 17, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:50:24', '2025-05-08 19:50:24'),
(486, 'default', 'updated', 'App\\Models\\EmployeePosition', 'updated', 17, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:50:24', '2025-05-08 19:50:24'),
(487, 'default', 'created', 'App\\Models\\EmployeePosition', 'created', 27, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 19:50:24', '2025-05-08 19:50:24'),
(488, 'default', 'created', 'App\\Models\\Position', 'created', 10, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-08 20:08:37', '2025-05-08 20:08:37'),
(489, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-09 12:53:11', '2025-05-09 12:53:11'),
(490, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-13 13:42:47', '2025-05-13 13:42:47'),
(491, 'default', 'updated', 'App\\Models\\Employee', 'updated', 1, 'App\\Models\\Employee', 1, '[]', NULL, '2025-05-14 14:33:23', '2025-05-14 14:33:23');

-- --------------------------------------------------------

--
-- Table structure for table `additions`
--

CREATE TABLE `additions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payroll_id` bigint(20) UNSIGNED NOT NULL,
  `rewards` decimal(10,2) NOT NULL DEFAULT 0.00,
  `incentives` decimal(10,2) NOT NULL DEFAULT 0.00,
  `reimbursements` decimal(10,2) NOT NULL DEFAULT 0.00,
  `shift_differentials` decimal(10,2) NOT NULL DEFAULT 0.00,
  `commissions` decimal(10,2) NOT NULL DEFAULT 0.00,
  `overtime` decimal(10,2) NOT NULL DEFAULT 0.00,
  `extra_hour_rate` decimal(10,2) NOT NULL DEFAULT 0.00,
  `due_date` date NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `additions`
--

INSERT INTO `additions` (`id`, `payroll_id`, `rewards`, `incentives`, `reimbursements`, `shift_differentials`, `commissions`, `overtime`, `extra_hour_rate`, `due_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 488.37, 240.66, 605.84, 652.65, 694.47, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(2, 2, 343.86, 462.96, 402.72, 0.00, 105.72, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 14:39:38'),
(3, 3, 115.41, 130.60, 179.23, 534.82, 701.19, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(4, 4, 561.96, 143.59, 154.67, 606.58, 175.64, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(5, 5, 340.08, 632.71, 722.28, 355.38, 182.75, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(6, 6, 307.36, 639.87, 545.37, 521.78, 949.75, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(7, 7, 440.68, 198.82, 357.71, 681.19, 832.67, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(8, 8, 779.84, 33.03, 501.03, 203.39, 100.30, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(9, 9, 517.95, 651.75, 84.47, 543.08, 115.52, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(10, 10, 367.64, 583.84, 727.46, 638.49, 155.50, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(11, 11, 342.38, 627.87, 282.32, 37.38, 996.28, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(12, 12, 784.48, 293.53, 428.58, 241.32, 402.87, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(13, 13, 964.81, 933.24, 70.50, 504.36, 436.90, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(14, 14, 94.34, 452.66, 759.99, 392.60, 691.34, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(15, 15, 343.96, 980.18, 344.13, 282.68, 782.16, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(16, 16, 527.95, 22.04, 712.88, 898.88, 233.85, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47');

-- --------------------------------------------------------

--
-- Table structure for table `archived_employees`
--

CREATE TABLE `archived_employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `national_id` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `bank_acc_no` varchar(255) DEFAULT NULL,
  `hired_on` date NOT NULL,
  `released_on` date NOT NULL,
  `was_remote` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `archived_employees`
--

INSERT INTO `archived_employees` (`id`, `name`, `phone`, `email`, `national_id`, `address`, `bank_acc_no`, `hired_on`, `released_on`, `was_remote`, `created_at`, `updated_at`) VALUES
(1, 'Alessandro Rau', '203-703-2161', 'kelli.cassin@example.com', '23062842339835', '648 Meredith Orchard\nEast Casandraside, VA 15472-7138', 'CR87389335836939582235', '2024-07-24', '2025-05-07', 0, '2025-05-07 13:22:55', '2025-05-07 13:22:55'),
(2, 'Aidan Bernier', '(781) 305-9604', 'hudson.diana@example.net', '20246408165456', '74904 Arvid Island\nJanisville, AR 16032', 'DK3998898777250701', '2023-10-19', '2025-05-07', 0, '2025-05-07 18:43:39', '2025-05-07 18:43:39'),
(3, 'testing', '03237654091', 'ultrainstinctn05@gmail.com', '2324343434344', 'johar town lahore', NULL, '2025-05-07', '2025-05-07', 0, '2025-05-07 19:14:54', '2025-05-07 19:14:54'),
(4, 'Spicy Leaf', '01001005001', 'spicy@pillow.com', '29904268801155', '443 Merlin Circle\nEast Lacey, AR 50465', 'KZ59172G2R427083G62Z', '2023-01-25', '2025-05-08', 0, '2025-05-08 19:10:40', '2025-05-08 19:10:40'),
(5, 'Zoila Mosciski', '03454646709', 'balistreri.bailee@example.org', '24206987402177', '7078 Anderson Lake Apt. 821\nWildermanmouth, AK 16426', 'GT03DICKXB25LS7W565DX54923RN', '2025-04-27', '2025-05-08', 0, '2025-05-08 19:10:50', '2025-05-08 19:10:50'),
(6, 'Dahlia Champlin', '(863) 819-4424', 'dhuel@example.com', '29726164347619', '436 Sipes Villages\nEbertborough, AZ 45003-0544', 'IT12L0932723339B0430CBZFVV7', '2023-09-08', '2025-05-08', 0, '2025-05-08 19:10:59', '2025-05-08 19:10:59'),
(7, 'Aglae Medhurst', '954-552-3932', 'geovanny.jerde@example.org', '23226428816183', '441 Harvey Common Suite 923\nSavionmouth, MD 66542-0257', 'MR5882644752404125908419911', '2024-07-15', '2025-05-08', 0, '2025-05-08 19:11:12', '2025-05-08 19:11:12'),
(8, 'Layla Kirlin DVM', '1-737-999-5952', 'loy.schoen@example.com', '25538851001134', '2733 Ebert Stream\nNew Howard, MO 08860-5845', 'SI78138845015781765', '2024-06-26', '2025-05-08', 0, '2025-05-08 19:11:21', '2025-05-08 19:11:21'),
(9, 'Nicholas Durgan', '1-425-857-7421', 'ebeer@example.org', '23853519330812', '28070 Roel Ridges\nSouth Jasonside, WY 17869', 'KZ82885379918EH3180T', '2023-08-07', '2025-05-08', 0, '2025-05-08 19:11:31', '2025-05-08 19:11:31'),
(10, 'Nash Balistreri', '1-985-740-8868', 'irice@example.net', '21194557351073', '86252 Hoeger Track Suite 169\nNorth Sylvester, MO 28034', 'ES6710500096573363555061', '2023-10-07', '2025-05-08', 0, '2025-05-08 19:12:03', '2025-05-08 19:12:03'),
(11, 'Omari Towne', '+1.414.235.9162', 'lberge@example.net', '24013366020396', '6724 Spencer Pike Suite 857\nLake Talonside, OH 84129-9770', 'BH59YCVD8AYEOA936L7K11', '2022-08-17', '2025-05-08', 0, '2025-05-08 19:12:13', '2025-05-08 19:12:13'),
(12, 'Rebecca Kautzer II', '+1.680.320.0870', 'rosenbaum.stephania@example.net', '28732694510995', '968 Considine Spurs Apt. 549\nHickleburgh, OH 63639', 'AE187445947028009989305', '2024-04-18', '2025-05-08', 0, '2025-05-08 19:12:20', '2025-05-08 19:12:20'),
(13, 'Hermina Kunze', '838-619-5004', 'adams.kadin@example.net', '22061157087342', '3003 Helena Lane\nNorth Adalberto, LA 17641-6334', 'KW18XQLO5899076471168434570558', '2024-08-25', '2025-05-08', 0, '2025-05-08 19:12:27', '2025-05-08 19:12:27'),
(14, 'Vincenzo Ankunding II', '+1-320-356-7413', 'rau.wiley@example.com', '27649568684634', '2401 Leuschke Roads Apt. 544\nMannmouth, PA 63813', 'IL240890170310764522941', '2023-07-05', '2025-05-08', 0, '2025-05-08 19:12:42', '2025-05-08 19:12:42'),
(15, 'Carmel Upton', '+12293803989', 'alysha45@example.net', '29117650050521', '552 Rowe Mews Apt. 655\nWaelchiburgh, ME 82861', 'SM28Z2055738529W6496TNBJH0I', '2024-07-06', '2025-05-08', 0, '2025-05-08 19:12:52', '2025-05-08 19:12:52'),
(16, 'Mrs. Roma Gleason', '1-704-776-1863', 'mcclure.reid@example.org', '28516297324480', '6115 Welch Estate\nFritzshire, OH 99720-8324', 'GE50PJ3715274712937227', '2024-06-14', '2025-05-08', 0, '2025-05-08 19:13:02', '2025-05-08 19:13:02'),
(17, 'Noor', '03004299654', 'noor@gmail.com', '29423567896', 'J3 Johar Town, Lahore', NULL, '2025-05-05', '2025-05-08', 0, '2025-05-08 19:13:11', '2025-05-08 19:13:11'),
(18, 'Asma', '03456789210', 'asma@gmail.com', '299876655443221', 'Iqbal Town, Lahore', NULL, '2025-05-02', '2025-05-08', 0, '2025-05-08 19:13:26', '2025-05-08 19:13:26');

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `status` enum('on_time','late','missed') NOT NULL DEFAULT 'missed',
  `sign_in_time` time DEFAULT NULL,
  `sign_off_time` time DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `is_manually_filled` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `attendances`
--

INSERT INTO `attendances` (`id`, `employee_id`, `date`, `status`, `sign_in_time`, `sign_off_time`, `notes`, `is_manually_filled`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-05-01', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(2, 1, '2025-05-04', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(3, 1, '2025-05-05', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(4, 1, '2025-05-06', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(5, 2, '2025-05-01', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(6, 2, '2025-05-04', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(7, 2, '2025-05-05', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(8, 2, '2025-05-06', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(9, 3, '2025-05-01', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(10, 3, '2025-05-04', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(11, 3, '2025-05-05', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(12, 3, '2025-05-06', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(13, 4, '2025-05-01', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(14, 4, '2025-05-04', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(15, 4, '2025-05-05', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(16, 4, '2025-05-06', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(17, 5, '2025-05-01', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(18, 5, '2025-05-04', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(19, 5, '2025-05-05', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(20, 5, '2025-05-06', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(21, 6, '2025-05-01', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(22, 6, '2025-05-04', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(23, 6, '2025-05-05', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(24, 6, '2025-05-06', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(25, 7, '2025-05-01', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(26, 7, '2025-05-04', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(27, 7, '2025-05-05', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(28, 7, '2025-05-06', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(29, 8, '2025-05-01', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(30, 8, '2025-05-04', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(31, 8, '2025-05-05', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(32, 8, '2025-05-06', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(33, 9, '2025-05-01', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(34, 9, '2025-05-04', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(35, 9, '2025-05-05', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(36, 9, '2025-05-06', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(37, 10, '2025-05-01', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(38, 10, '2025-05-04', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(39, 10, '2025-05-05', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(40, 10, '2025-05-06', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(41, 11, '2025-05-01', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(42, 11, '2025-05-04', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(43, 11, '2025-05-05', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(44, 11, '2025-05-06', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(45, 12, '2025-05-01', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(46, 12, '2025-05-04', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(47, 12, '2025-05-05', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(48, 12, '2025-05-06', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(49, 13, '2025-05-01', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(50, 13, '2025-05-04', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(51, 13, '2025-05-05', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(52, 13, '2025-05-06', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(53, 14, '2025-05-01', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(54, 14, '2025-05-04', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(55, 14, '2025-05-05', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(56, 14, '2025-05-06', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(57, 15, '2025-05-01', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(58, 15, '2025-05-04', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(59, 15, '2025-05-05', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(60, 15, '2025-05-06', 'on_time', '08:00:00', '16:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(61, 16, '2025-05-01', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(62, 16, '2025-05-04', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(63, 16, '2025-05-05', 'on_time', '16:00:00', '00:00:00', NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(64, 16, '2025-05-06', 'missed', NULL, NULL, NULL, 0, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(65, 2, '2025-05-07', 'late', '09:25:06', '18:50:00', 'Sign-in Manually filled by employee', 1, '2025-05-07 13:25:06', '2025-05-07 13:51:44'),
(66, 1, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(67, 3, '2025-05-07', 'late', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(68, 4, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(69, 5, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(70, 6, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(71, 7, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(72, 9, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(73, 10, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(74, 11, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(75, 12, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(76, 13, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(77, 14, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(78, 15, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(79, 16, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44'),
(80, 17, '2025-05-07', 'on_time', '09:00:00', '17:00:00', NULL, 0, '2025-05-07 13:51:44', '2025-05-07 13:51:44');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `address`, `phone`, `email`, `created_at`, `updated_at`) VALUES
(3, 'ML Bench', 'Building no 424, J3 Johar Town Lahore', '03007520852', 'hr@ml-bench.com', '2025-05-07 13:44:14', '2025-05-08 19:45:51');

-- --------------------------------------------------------

--
-- Table structure for table `calendars`
--

CREATE TABLE `calendars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `type` enum('holiday','meeting','event','other') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `calendars`
--

INSERT INTO `calendars` (`id`, `start_date`, `end_date`, `title`, `type`, `created_at`, `updated_at`) VALUES
(1, '2025-05-27', '2025-05-27', 'Voluptate non qui.', 'event', '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(2, '2025-05-28', '2025-05-28', 'Id aut.', 'event', '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(3, '2025-05-24', '2025-05-25', 'In consequatur.', 'holiday', '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(4, '2025-05-25', '2025-05-25', 'Quibusdam fugiat aut.', 'event', '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(5, '2025-06-01', '2025-06-02', 'Quo itaque expedita.', 'holiday', '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(6, '2025-05-19', '2025-05-19', 'Totam accusantium veritatis.', 'meeting', '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(7, '2025-05-28', '2025-05-29', 'Sit et autem.', 'holiday', '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(8, '2025-05-10', '2025-05-10', 'Nihil quam.', 'holiday', '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(9, '2025-05-21', '2025-05-21', 'Hic fugiat et.', 'meeting', '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(10, '2025-06-01', '2025-06-03', 'Occaecati dolorem quisquam.', 'other', '2025-05-07 12:23:47', '2025-05-07 12:23:47');

-- --------------------------------------------------------

--
-- Table structure for table `deductions`
--

CREATE TABLE `deductions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payroll_id` bigint(20) UNSIGNED NOT NULL,
  `income_tax` decimal(10,2) NOT NULL DEFAULT 0.00,
  `social_security_contributions` decimal(10,2) NOT NULL DEFAULT 0.00,
  `health_insurance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `retirement_plan` decimal(10,2) NOT NULL DEFAULT 0.00,
  `benefits` decimal(10,2) NOT NULL DEFAULT 0.00,
  `union_fees` decimal(10,2) NOT NULL DEFAULT 0.00,
  `undertime` decimal(10,2) NOT NULL DEFAULT 0.00,
  `negative_hour_rate` decimal(10,2) NOT NULL DEFAULT 0.00,
  `due_date` date NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `deductions`
--

INSERT INTO `deductions` (`id`, `payroll_id`, `income_tax`, `social_security_contributions`, `health_insurance`, `retirement_plan`, `benefits`, `union_fees`, `undertime`, `negative_hour_rate`, `due_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 433.52, 909.01, 946.50, 167.03, 946.41, 174.95, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(2, 2, 174.01, 967.12, 114.28, 197.46, 370.65, 481.54, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 14:39:38'),
(3, 3, 706.83, 165.21, 720.71, 993.15, 900.01, 26.71, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(4, 4, 969.27, 34.99, 855.83, 447.30, 230.00, 476.09, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(5, 5, 888.64, 635.36, 507.52, 238.94, 813.68, 943.34, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(6, 6, 93.45, 397.36, 79.63, 585.58, 492.95, 593.84, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(7, 7, 681.76, 803.59, 509.13, 681.73, 866.80, 429.71, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(8, 8, 121.06, 869.32, 187.68, 495.28, 59.44, 395.09, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(9, 9, 248.15, 401.42, 598.31, 51.27, 622.46, 598.89, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(10, 10, 120.56, 900.03, 742.30, 462.45, 864.57, 819.53, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(11, 11, 83.99, 916.32, 475.43, 899.78, 843.67, 324.39, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(12, 12, 735.74, 495.58, 12.98, 311.08, 516.21, 34.07, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(13, 13, 647.97, 621.80, 909.35, 209.06, 0.72, 819.76, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(14, 14, 678.86, 193.89, 799.35, 307.03, 894.15, 265.32, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(15, 15, 458.21, 101.36, 889.74, 140.11, 487.13, 852.34, 0.00, 0.00, '2025-05-07', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(16, 16, 296.66, 339.50, 789.50, 133.66, 227.75, 574.07, 0.00, 0.00, '2025-05-07', 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'IT', '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(2, 'HR', '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(3, 'Sales', '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(4, 'Customer Service', '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(5, 'CV', '2025-05-07 19:18:37', '2025-05-07 19:18:37'),
(6, 'CVV', '2025-05-07 19:19:22', '2025-05-07 19:19:22'),
(7, 'Executives', '2025-05-08 14:17:25', '2025-05-08 14:17:25'),
(8, 'Designing', '2025-05-08 19:36:08', '2025-05-08 19:36:08');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `normalized_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `national_id` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `bank_acc_no` varchar(255) DEFAULT NULL,
  `hired_on` date NOT NULL,
  `is_remote` tinyint(1) NOT NULL DEFAULT 0,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `name`, `normalized_name`, `phone`, `email`, `national_id`, `email_verified_at`, `password`, `address`, `bank_acc_no`, `hired_on`, `is_remote`, `branch_id`, `department_id`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Fatima Zaheer', 'Super Root', '03007520852', 'hr@ml-bench.com', '29904268801154', '2025-05-07 12:23:44', '$2y$10$7BMn8WlpLkUB64fCCCVCvuFbqp4dO34dLL/a7MjMdoITz0FOIOZ.G', 'Lahore', 'SM21Q972699292149PWPYIU313V', '2023-11-27', 0, 3, 2, 'nGKpgd34m6kPOh9Nkp55PF1RGGa2NXz2UBrRuaPtwFe1pXG5QzbzeE3IGYrX', '2025-05-07 12:23:44', '2025-05-08 19:47:57'),
(25, 'Kainat Iqbal', 'Kainat Iqbal', '03464588343', 'Kainat@ml-bench.com', '029', NULL, '$2y$10$8HbdLratqGN2sANEee6HSuJ45p3Au2NOXVWNZqc3BUaBXFjINKGSK', 'toba road shorkot cantt', NULL, '2023-02-22', 0, 3, 8, NULL, '2025-05-08 19:42:46', '2025-05-08 19:42:46'),
(21, 'Aieman Basit', 'Aieman Basit', '03044265509', 'aimanbasit0416@gmail.com', '22345678912', NULL, '$2y$10$nuLlAxWsCc5sCP/cIyyo.O35zX29npS6oGdCOVMVIiSlqYIIWXKpa', 'Iqbal Town, Lahore', NULL, '2025-05-03', 0, 4, 5, NULL, '2025-05-08 11:59:57', '2025-05-08 11:59:57'),
(17, 'Saadat Ali', 'Saadat Ali', '03324574787', 'Saadatalinaqvi@ml-bench.com', '747476477476', NULL, '$2y$10$sdwrfK/WC9mFhGNtV4FIp.KB3WOeWyamWYvgEfC/AIXSZOontWT1K', 'Abubakar Street', NULL, '2025-02-24', 0, 3, 1, NULL, '2025-05-07 13:07:38', '2025-05-08 19:50:24'),
(22, 'Qazi Ammar Arshad', 'Qazi Ammar Arshad', '03355300400', 'qazi@ml-bench.com', '3430232965405', NULL, '$2y$10$EF1S709Mxv/zpmCqEkY0Rea0mklOao8DbV8gMFfi6ktyWcG27MMZi', 'Qazi House, Jalal pur bhattian, Haifzabad', NULL, '2020-01-01', 0, 3, 7, NULL, '2025-05-08 14:19:10', '2025-05-08 14:19:10'),
(23, 'Aieman.B', 'Aieman.B', '03334299710', 'aiemanbasit@gmail.com', '3510251555970', NULL, '$2y$10$w75ALdGOtGqm0fEX2EQ0ReeSx6QKwxKmk9SpTBfimg4T.G.owaZnC', 'Iqbal Town, Lahore', NULL, '2025-05-07', 0, 4, 1, NULL, '2025-05-08 14:57:15', '2025-05-08 14:57:15'),
(24, 'Aiman Batool', 'Aiman Batool', '03017304127', 'aimanbatol674@gmail.com', '1234567890', NULL, '$2y$10$.b7yWRdEpioFcVQaqlbuTevLHLuOesMF3MJ7CJt3vTRKrfpHg5hq6', 'Peshawar', NULL, '2025-05-08', 0, 3, 1, NULL, '2025-05-08 18:35:03', '2025-05-08 18:35:03');

-- --------------------------------------------------------

--
-- Table structure for table `employee_evaluations`
--

CREATE TABLE `employee_evaluations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `payroll_id` bigint(20) UNSIGNED NOT NULL,
  `metric_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date` date NOT NULL,
  `score` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`score`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `employee_evaluations`
--

INSERT INTO `employee_evaluations` (`id`, `employee_id`, `payroll_id`, `metric_id`, `date`, `score`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(2, 1, 1, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(3, 1, 1, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(4, 1, 1, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(5, 1, 1, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(6, 2, 2, 1, '2025-05-07', '[\"Neutral\",1,0.1,1]', '2025-05-07 12:23:46', '2025-05-07 14:39:38'),
(7, 2, 2, 2, '2025-05-07', '[\"Neutral\",1,0.1,1]', '2025-05-07 12:23:46', '2025-05-07 14:39:38'),
(8, 2, 2, 3, '2025-05-07', '[\"Neutral\",1,0.1,1]', '2025-05-07 12:23:46', '2025-05-07 14:39:38'),
(9, 2, 2, 4, '2025-05-07', '[\"Neutral\",2,0.1,1]', '2025-05-07 12:23:46', '2025-05-07 14:39:38'),
(10, 2, 2, 5, '2025-05-07', '[\"Neutral\",1,0.1,1]', '2025-05-07 12:23:46', '2025-05-07 14:39:38'),
(11, 3, 3, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(12, 3, 3, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(13, 3, 3, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(14, 3, 3, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(15, 3, 3, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(16, 4, 4, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(17, 4, 4, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(18, 4, 4, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(19, 4, 4, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(20, 4, 4, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(21, 5, 5, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(22, 5, 5, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(23, 5, 5, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(24, 5, 5, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(25, 5, 5, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(26, 6, 6, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(27, 6, 6, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(28, 6, 6, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(29, 6, 6, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(30, 6, 6, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(31, 7, 7, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(32, 7, 7, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(33, 7, 7, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(34, 7, 7, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(35, 7, 7, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(36, 8, 8, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(37, 8, 8, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(38, 8, 8, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(39, 8, 8, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(40, 8, 8, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(41, 9, 9, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(42, 9, 9, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(43, 9, 9, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(44, 9, 9, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(45, 9, 9, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(46, 10, 10, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(47, 10, 10, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(48, 10, 10, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(49, 10, 10, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(50, 10, 10, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(51, 11, 11, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(52, 11, 11, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(53, 11, 11, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(54, 11, 11, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(55, 11, 11, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(56, 12, 12, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(57, 12, 12, 2, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(58, 12, 12, 3, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(59, 12, 12, 4, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(60, 12, 12, 5, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(61, 13, 13, 1, '2025-05-07', NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(62, 13, 13, 2, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(63, 13, 13, 3, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(64, 13, 13, 4, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(65, 13, 13, 5, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(66, 14, 14, 1, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(67, 14, 14, 2, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(68, 14, 14, 3, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(69, 14, 14, 4, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(70, 14, 14, 5, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(71, 15, 15, 1, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(72, 15, 15, 2, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(73, 15, 15, 3, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(74, 15, 15, 4, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(75, 15, 15, 5, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(76, 16, 16, 1, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(77, 16, 16, 2, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(78, 16, 16, 3, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(79, 16, 16, 4, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(80, 16, 16, 5, '2025-05-07', NULL, '2025-05-07 12:23:47', '2025-05-07 12:23:47');

-- --------------------------------------------------------

--
-- Table structure for table `employee_positions`
--

CREATE TABLE `employee_positions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `position_id` bigint(20) UNSIGNED DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `employee_positions`
--

INSERT INTO `employee_positions` (`id`, `employee_id`, `position_id`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-05-07', '2025-05-08', '2025-05-07 12:23:44', '2025-05-08 19:47:25'),
(2, 2, 2, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(3, 3, 3, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(4, 4, 4, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(5, 5, 1, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(6, 6, 2, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(7, 7, 3, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(8, 8, 4, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(9, 9, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(10, 10, 2, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(11, 11, 3, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(12, 12, 4, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(13, 13, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(14, 14, 2, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(15, 15, 3, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(16, 16, 4, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(17, 17, 4, '2025-05-07', '2025-05-08', '2025-05-07 13:07:38', '2025-05-08 19:50:24'),
(18, 18, 4, '2025-05-07', NULL, '2025-05-07 16:16:04', '2025-05-07 16:16:04'),
(19, 19, 4, '2025-05-05', NULL, '2025-05-07 19:12:30', '2025-05-07 19:12:30'),
(20, 20, 5, '2025-05-02', NULL, '2025-05-07 19:49:23', '2025-05-07 19:49:23'),
(21, 21, 5, '2025-05-03', NULL, '2025-05-08 11:59:57', '2025-05-08 11:59:57'),
(22, 22, 6, '2020-01-01', NULL, '2025-05-08 14:19:10', '2025-05-08 14:19:10'),
(23, 23, 5, '2025-05-07', NULL, '2025-05-08 14:57:15', '2025-05-08 14:57:15'),
(24, 24, 2, '2025-05-08', NULL, '2025-05-08 18:35:03', '2025-05-08 18:35:03'),
(25, 25, 7, '2023-02-22', NULL, '2025-05-08 19:42:46', '2025-05-08 19:42:46'),
(26, 1, 8, '2025-05-08', NULL, '2025-05-08 19:47:25', '2025-05-08 19:47:25'),
(27, 17, 9, '2025-05-08', NULL, '2025-05-08 19:50:24', '2025-05-08 19:50:24');

-- --------------------------------------------------------

--
-- Table structure for table `employee_salaries`
--

CREATE TABLE `employee_salaries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency` enum('EGP','USD','EUR','GBP','CAD','KWD','SAR','AED') NOT NULL DEFAULT 'EGP',
  `salary` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `employee_salaries`
--

INSERT INTO `employee_salaries` (`id`, `employee_id`, `currency`, `salary`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(1, 1, 'EUR', 4111, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(2, 2, 'GBP', 4560, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(3, 3, 'SAR', 5716, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(4, 4, 'GBP', 7513, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(5, 5, 'USD', 7831, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(6, 6, 'USD', 2847, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(7, 7, 'USD', 2645, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(8, 8, 'GBP', 7188, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(9, 9, 'GBP', 2042, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(10, 10, 'SAR', 3052, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(11, 11, 'SAR', 6133, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(12, 12, 'USD', 7289, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(13, 13, 'SAR', 3693, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(14, 14, 'EUR', 5467, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(15, 15, 'EGP', 6789, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(16, 16, 'EUR', 4916, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(17, 17, 'USD', 2000, '2025-06-01', NULL, '2025-05-07 13:07:38', '2025-05-07 13:07:38'),
(18, 18, 'USD', 200, '2025-06-01', NULL, '2025-05-07 16:16:04', '2025-05-07 16:16:04'),
(19, 19, 'USD', 40000, '2025-06-01', NULL, '2025-05-07 19:12:30', '2025-05-07 19:12:30'),
(20, 20, 'USD', 50000, '2025-06-01', NULL, '2025-05-07 19:49:23', '2025-05-07 19:49:23'),
(21, 21, 'USD', 20000, '2025-06-01', NULL, '2025-05-08 11:59:57', '2025-05-08 11:59:57'),
(22, 22, 'USD', 300, '2020-02-01', NULL, '2025-05-08 14:19:10', '2025-05-08 14:19:10'),
(23, 23, 'EGP', 20000, '2025-06-01', NULL, '2025-05-08 14:57:15', '2025-05-08 14:57:15'),
(24, 24, 'EUR', 12345678, '2025-06-01', NULL, '2025-05-08 18:35:03', '2025-05-08 18:35:03'),
(25, 25, 'EUR', 199, '2023-03-01', NULL, '2025-05-08 19:42:46', '2025-05-08 19:42:46');

-- --------------------------------------------------------

--
-- Table structure for table `employee_shifts`
--

CREATE TABLE `employee_shifts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `employee_shifts`
--

INSERT INTO `employee_shifts` (`id`, `employee_id`, `shift_id`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(2, 2, 1, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-08 14:20:15'),
(3, 3, 1, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(4, 4, 1, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-08 14:20:15'),
(5, 5, 1, '2025-05-07', NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(6, 6, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-08 14:20:15'),
(7, 7, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(8, 8, 2, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(9, 9, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(10, 10, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-08 14:20:15'),
(11, 11, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(12, 12, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-08 14:20:15'),
(13, 13, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(14, 14, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-08 14:20:15'),
(15, 15, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-07 12:23:45'),
(16, 16, 1, '2025-05-07', NULL, '2025-05-07 12:23:45', '2025-05-08 14:20:15'),
(17, 17, 1, '2025-05-07', NULL, '2025-05-07 13:07:38', '2025-05-07 13:07:38'),
(18, 18, 1, '2025-05-07', NULL, '2025-05-07 16:16:04', '2025-05-07 16:16:04'),
(19, 19, 1, '2025-05-05', NULL, '2025-05-07 19:12:30', '2025-05-07 19:12:30'),
(20, 20, 3, '2025-05-02', NULL, '2025-05-07 19:49:23', '2025-05-07 19:49:23'),
(21, 21, 3, '2025-05-03', NULL, '2025-05-08 11:59:57', '2025-05-08 11:59:57'),
(22, 22, 1, '2020-01-01', NULL, '2025-05-08 14:19:10', '2025-05-08 14:19:10'),
(23, 23, 3, '2025-05-07', NULL, '2025-05-08 14:57:15', '2025-05-08 14:57:15'),
(24, 24, 1, '2025-05-08', NULL, '2025-05-08 18:35:03', '2025-05-08 18:35:03'),
(25, 25, 1, '2023-02-22', NULL, '2025-05-08 19:42:46', '2025-05-08 19:42:46');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `globals`
--

CREATE TABLE `globals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `organization_name` varchar(255) NOT NULL,
  `timezone` varchar(255) NOT NULL DEFAULT 'Africa/Cairo',
  `organization_address` varchar(255) NOT NULL,
  `absence_limit` smallint(5) UNSIGNED NOT NULL,
  `payroll_day` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `weekend_off_days` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '["friday","saturday"]' CHECK (json_valid(`weekend_off_days`)),
  `email` varchar(255) NOT NULL,
  `income_tax` double(8,2) UNSIGNED NOT NULL DEFAULT 14.00,
  `is_ip_based` tinyint(1) NOT NULL DEFAULT 0,
  `ip` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`ip`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `globals`
--

INSERT INTO `globals` (`id`, `organization_name`, `timezone`, `organization_address`, `absence_limit`, `payroll_day`, `weekend_off_days`, `email`, `income_tax`, `is_ip_based`, `ip`, `created_at`, `updated_at`) VALUES
(1, 'Global Solutions Inc.', 'Africa/Cairo', '123 Main Street, Anytown, USA', 30, 1, '[\"friday\",\"saturday\"]', 'info@globalsolutions.com', 14.00, 0, NULL, '2025-05-07 12:23:44', '2025-05-07 12:23:44');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `managers`
--

CREATE TABLE `managers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `managers`
--

INSERT INTO `managers` (`id`, `employee_id`, `department_id`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(2, 2, 1, NULL, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(3, 1, NULL, 3, '2025-05-07 13:44:14', '2025-05-08 19:45:51'),
(4, 19, NULL, 4, '2025-05-07 19:17:41', '2025-05-07 19:17:41'),
(5, 19, 5, NULL, '2025-05-07 19:18:37', '2025-05-07 19:18:37'),
(6, 2, 6, NULL, '2025-05-07 19:19:22', '2025-05-07 19:19:22');

-- --------------------------------------------------------

--
-- Table structure for table `metrics`
--

CREATE TABLE `metrics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `criteria` varchar(255) NOT NULL,
  `weight` double(8,2) NOT NULL DEFAULT 1.00,
  `step` double(8,2) NOT NULL DEFAULT 0.05,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `metrics`
--

INSERT INTO `metrics` (`id`, `criteria`, `weight`, `step`, `created_at`, `updated_at`) VALUES
(1, 'Et occaecati aut voluptatibus quod omnis et aspernatur vero.', 1.00, 0.10, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(2, 'At cupiditate pariatur nesciunt deserunt deleniti corrupti consequatur qui est.', 1.00, 0.10, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(3, 'Natus ut dignissimos molestias sit praesentium saepe vitae sapiente.', 1.00, 0.10, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(4, 'Et vero aperiam possimus dignissimos sit repudiandae sint ab mollitia nostrum.', 2.00, 0.10, '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(5, 'Deleniti sint similique omnis laborum perferendis ratione.', 1.00, 0.10, '2025-05-07 12:23:44', '2025-05-07 12:23:44');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2013_05_30_080347_create_branches_table', 1),
(2, '2013_05_30_081221_create_departments_table', 1),
(3, '2014_10_12_000000_create_employees_table', 1),
(4, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(5, '2019_08_19_000000_create_failed_jobs_table', 1),
(6, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(7, '2023_05_29_215446_create_permission_tables', 1),
(8, '2023_05_30_075846_create_globals_table', 1),
(9, '2023_05_30_101634_create_employee_salaries_table', 1),
(10, '2023_05_30_104703_create_managers_table', 1),
(11, '2023_05_30_135059_create_positions_table', 1),
(12, '2023_05_30_136931_create_employee_positions_table', 1),
(13, '2023_05_30_172328_create_shifts_table', 1),
(14, '2023_05_30_172331_create_payrolls_table', 1),
(15, '2023_05_30_172332_create_additions_table', 1),
(16, '2023_05_30_172334_create_deductions_table', 1),
(17, '2023_05_30_172340_create_attendances_table', 1),
(18, '2023_05_30_172343_create_metrics_table', 1),
(19, '2023_05_30_172350_create_requests_table', 1),
(20, '2023_05_30_172607_create_employee_shifts_table', 1),
(21, '2023_05_30_172608_create_employee_evaluations_table', 1),
(22, '2023_07_11_043132_create_calendars_table', 1),
(23, '2023_07_24_101801_create_jobs_table', 1),
(24, '2023_07_31_211210_create_activity_log_table', 1),
(25, '2023_07_31_211211_add_event_column_to_activity_log_table', 1),
(26, '2023_07_31_211212_add_batch_uuid_column_to_activity_log_table', 1),
(27, '2023_08_01_122221_create_archived_employees_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\Employee', 1),
(1, 'App\\Models\\Employee', 22),
(2, 'App\\Models\\Employee', 17),
(2, 'App\\Models\\Employee', 21),
(2, 'App\\Models\\Employee', 23),
(2, 'App\\Models\\Employee', 24),
(2, 'App\\Models\\Employee', 25);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payrolls`
--

CREATE TABLE `payrolls` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `currency` varchar(255) NOT NULL,
  `base` decimal(10,2) NOT NULL DEFAULT 0.00,
  `performance_multiplier` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_additions` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_deductions` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_payable` decimal(10,2) NOT NULL DEFAULT 0.00,
  `due_date` date NOT NULL,
  `is_reviewed` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `payrolls`
--

INSERT INTO `payrolls` (`id`, `employee_id`, `currency`, `base`, `performance_multiplier`, `total_additions`, `total_deductions`, `total_payable`, `due_date`, `is_reviewed`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'EGP', 6122.45, 0.76, 5615.01, 7334.89, 1158.51, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(2, 2, 'EGP', 1242.90, 1.00, 1315.26, 2305.06, 253.10, '2025-05-07', 1, 1, '2025-05-07 12:23:46', '2025-05-07 14:39:38'),
(3, 3, 'EGP', 2514.03, 0.11, 8681.90, 9347.12, 6251.81, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(4, 4, 'EGP', 4482.48, 0.40, 1932.33, 3882.48, 2613.34, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(5, 5, 'EGP', 8368.14, 0.52, 7510.98, 7878.62, 7756.97, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(6, 6, 'EGP', 2954.61, 0.06, 6312.77, 4776.19, 7029.27, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(7, 7, 'EGP', 7968.61, 0.52, 8006.59, 3023.93, 5948.75, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(8, 8, 'EGP', 5102.11, 0.89, 2463.22, 1614.39, 1807.95, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(9, 9, 'EGP', 2452.30, 0.48, 8520.67, 4679.67, 4498.71, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(10, 10, 'EGP', 7906.77, 0.12, 2432.26, 2828.08, 3444.58, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(11, 11, 'EGP', 4006.74, 0.83, 8843.21, 7819.51, 6325.57, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(12, 12, 'EGP', 2554.55, 0.01, 6258.71, 8405.54, 9481.24, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(13, 13, 'EGP', 7388.05, 0.24, 6436.23, 4614.42, 1626.78, '2025-05-07', 0, 0, '2025-05-07 12:23:46', '2025-05-07 12:23:46'),
(14, 14, 'EGP', 9587.92, 0.21, 9421.86, 2417.49, 8225.44, '2025-05-07', 0, 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(15, 15, 'EGP', 4041.18, 0.71, 1580.99, 4659.21, 1063.59, '2025-05-07', 0, 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(16, 16, 'EGP', 4444.45, 0.72, 8660.60, 6340.50, 2078.77, '2025-05-07', 0, 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `positions`
--

CREATE TABLE `positions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `positions`
--

INSERT INTO `positions` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'CEO', 'Chief Executive Officer', '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(2, 'Marketing Manager', 'Responsible for all marketing activities', '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(3, 'Graphic Designer', 'Responsible for all graphic design activities', '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(4, 'Developer', 'Responsible for all development activities', '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(5, 'CFO', 'Chief Finance Officer', '2025-05-07 19:22:58', '2025-05-07 19:22:58'),
(6, 'President & Co-Founder', NULL, '2025-05-08 14:17:47', '2025-05-08 14:17:47'),
(7, 'UI/UX Designer', NULL, '2025-05-08 19:35:46', '2025-05-08 19:35:46'),
(8, 'HR Executive', NULL, '2025-05-08 19:47:18', '2025-05-08 19:47:18'),
(9, 'MERN Stack Developer Intern', NULL, '2025-05-08 19:50:08', '2025-05-08 19:50:08'),
(10, 'Android Developer', NULL, '2025-05-08 20:08:37', '2025-05-08 20:08:37');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('complaint','payment','leave','other') NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `admin_response` text DEFAULT NULL,
  `is_seen` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `employee_id`, `type`, `start_date`, `end_date`, `message`, `status`, `admin_response`, `is_seen`, `created_at`, `updated_at`) VALUES
(1, 1, 'leave', '2025-07-19', NULL, 'Ut mollitia beatae impedit illum et magnam nostrum at mollitia.', 2, 'Natus dolores accusamus itaque dolores cumque dolorem consequatur sunt sit expedita.', 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(2, 2, 'payment', '2025-05-12', NULL, 'Eos provident earum est qui aut eos eos sed ut ut voluptatum neque fuga.', 1, NULL, 1, '2025-05-07 12:23:47', '2025-05-07 20:18:28'),
(20, 21, 'leave', '2025-05-08', NULL, 'I am sick', 2, 'This is a testing rejection by Ammar.', 1, '2025-05-08 14:28:34', '2025-05-08 14:30:23'),
(3, 3, 'leave', '2025-06-07', NULL, 'Soluta iste quas et fugit esse repellat et optio quae quis.', 0, 'Maiores mollitia est voluptatem repellendus iusto consequatur adipisci omnis id molestiae dicta possimus.', 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(4, 4, 'payment', '2025-07-05', NULL, 'Quasi dolore velit ut officiis nisi quae voluptatem amet alias omnis dolores.', 1, 'Deleniti laborum et praesentium non labore atque minus consequatur asperiores consequatur.', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(5, 5, 'complaint', '2025-05-13', NULL, 'Qui dignissimos quis fuga iusto voluptas qui ducimus vel quibusdam alias earum.', 0, 'Aut quibusdam rerum labore quia ea sit quo qui modi ut commodi quo eos.', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(6, 6, 'leave', '2025-06-12', NULL, 'Ut quisquam aliquid qui rerum consectetur atque nemo temporibus adipisci.', 0, 'Voluptatibus est cupiditate velit placeat repellat qui ullam debitis perferendis consectetur odit voluptas officiis.', 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(7, 7, 'leave', '2025-05-14', NULL, 'Deserunt commodi repellendus porro sit quod doloribus sed dolor iusto rem.', 0, 'Repellendus ut pariatur iusto odit ea nulla natus quaerat.', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(8, 8, 'leave', '2025-06-27', NULL, 'Nisi quibusdam quod consequatur recusandae officia atque aut.', 0, 'Suscipit corrupti dicta et non vel et quod ut qui possimus non.', 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(18, 1, 'payment', '2025-05-07', NULL, 'I want my money', 0, NULL, 0, '2025-05-07 20:03:48', '2025-05-07 20:03:48'),
(19, 2, 'complaint', '2025-05-07', '2025-05-08', 'I am sick', 1, NULL, 1, '2025-05-07 20:07:39', '2025-05-08 18:59:53'),
(10, 10, 'complaint', '2025-06-27', NULL, 'Sit laborum ut voluptatem id ut doloribus et recusandae.', 1, 'Tempora eum et sed earum dolores dolores.', 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(11, 11, 'other', '2025-05-10', NULL, 'Dolorum et rerum assumenda itaque hic cupiditate expedita quam aut debitis nisi asperiores eius.', 2, 'testing to reject', 0, '2025-05-07 12:23:47', '2025-05-07 13:32:17'),
(12, 12, 'complaint', '2025-07-17', NULL, 'Necessitatibus dolor consectetur eos facere minus nobis qui voluptatem et aut fugit.', 0, 'Voluptatem ad et impedit eum mollitia perferendis.', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(13, 13, 'payment', '2025-06-17', NULL, 'Dolorem ducimus repellat distinctio ullam qui voluptate vel molestiae.', 2, 'Ratione reprehenderit tempore doloribus iste aut aliquam numquam.', 0, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(14, 14, 'payment', '2025-06-26', NULL, 'Harum delectus iusto ut distinctio est nostrum illum earum officia corporis saepe et.', 1, 'Vel qui esse est qui maiores nihil quidem.', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(15, 15, 'complaint', '2025-06-02', NULL, 'Voluptatem voluptate recusandae atque quidem dolores cupiditate explicabo quo ut.', 0, 'Sint odio nobis commodi tenetur error et atque numquam earum tenetur omnis omnis.', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(16, 16, 'other', '2025-07-01', NULL, 'Itaque voluptatibus quam repudiandae earum sit rerum necessitatibus enim.', 0, 'Unde nihil eos et quo unde dolorum unde.', 1, '2025-05-07 12:23:47', '2025-05-07 12:23:47'),
(17, 2, 'complaint', '2025-05-07', NULL, 'testing', 1, NULL, 0, '2025-05-07 13:26:44', '2025-05-07 13:28:22'),
(21, 21, 'payment', '2025-04-20', NULL, 'I want loan', 1, NULL, 0, '2025-05-08 17:20:05', '2025-05-08 17:21:43'),
(22, 1, 'leave', '2025-05-09', '2025-05-11', 'I want a leave of 3 days', 0, NULL, 0, '2025-05-08 18:25:23', '2025-05-08 18:25:23');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2025-05-07 12:23:44', '2025-05-07 12:23:44'),
(2, 'employee', 'web', '2025-05-07 12:23:44', '2025-05-07 12:23:44');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `shift_payment_multiplier` double(8,2) NOT NULL DEFAULT 1.00,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`id`, `name`, `start_time`, `end_time`, `shift_payment_multiplier`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Day Shift', '09:00:00', '18:00:00', 1.00, NULL, '2025-05-07 12:23:44', '2025-05-08 14:20:34'),
(3, 'Shift 3', '21:00:00', '18:53:00', 2.00, NULL, '2025-05-07 19:44:43', '2025-05-08 14:20:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject` (`subject_type`,`subject_id`),
  ADD KEY `causer` (`causer_type`,`causer_id`),
  ADD KEY `activity_log_log_name_index` (`log_name`);

--
-- Indexes for table `additions`
--
ALTER TABLE `additions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `additions_payroll_id_due_date_unique` (`payroll_id`,`due_date`),
  ADD UNIQUE KEY `additions_payroll_id_unique` (`payroll_id`);

--
-- Indexes for table `archived_employees`
--
ALTER TABLE `archived_employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `archived_employees_national_id_unique` (`national_id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attendances_employee_id_date_unique` (`employee_id`,`date`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `calendars`
--
ALTER TABLE `calendars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deductions`
--
ALTER TABLE `deductions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `deductions_payroll_id_due_date_unique` (`payroll_id`,`due_date`),
  ADD UNIQUE KEY `deductions_payroll_id_unique` (`payroll_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_phone_unique` (`phone`),
  ADD UNIQUE KEY `employees_email_unique` (`email`),
  ADD UNIQUE KEY `employees_national_id_unique` (`national_id`),
  ADD KEY `employees_branch_id_foreign` (`branch_id`),
  ADD KEY `employees_department_id_foreign` (`department_id`);

--
-- Indexes for table `employee_evaluations`
--
ALTER TABLE `employee_evaluations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_payroll_metric_date_unique` (`employee_id`,`payroll_id`,`metric_id`,`date`),
  ADD KEY `employee_evaluations_payroll_id_foreign` (`payroll_id`),
  ADD KEY `employee_evaluations_metric_id_foreign` (`metric_id`);

--
-- Indexes for table `employee_positions`
--
ALTER TABLE `employee_positions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_positions_employee_id_foreign` (`employee_id`),
  ADD KEY `employee_positions_position_id_foreign` (`position_id`);

--
-- Indexes for table `employee_salaries`
--
ALTER TABLE `employee_salaries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_salaries_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `employee_shifts`
--
ALTER TABLE `employee_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_shifts_employee_id_foreign` (`employee_id`),
  ADD KEY `employee_shifts_shift_id_foreign` (`shift_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `globals`
--
ALTER TABLE `globals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `managers`
--
ALTER TABLE `managers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `managers_department_id_unique` (`department_id`),
  ADD UNIQUE KEY `managers_branch_id_unique` (`branch_id`),
  ADD KEY `managers_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `metrics`
--
ALTER TABLE `metrics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `metrics_criteria_unique` (`criteria`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payrolls`
--
ALTER TABLE `payrolls`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payrolls_employee_id_due_date_unique` (`employee_id`,`due_date`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`) USING HASH;

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `positions_name_unique` (`name`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `requests_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`) USING HASH;

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shifts_name_unique` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=492;

--
-- AUTO_INCREMENT for table `additions`
--
ALTER TABLE `additions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `archived_employees`
--
ALTER TABLE `archived_employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `calendars`
--
ALTER TABLE `calendars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `deductions`
--
ALTER TABLE `deductions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `employee_evaluations`
--
ALTER TABLE `employee_evaluations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `employee_positions`
--
ALTER TABLE `employee_positions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `employee_salaries`
--
ALTER TABLE `employee_salaries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `employee_shifts`
--
ALTER TABLE `employee_shifts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `globals`
--
ALTER TABLE `globals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `managers`
--
ALTER TABLE `managers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `metrics`
--
ALTER TABLE `metrics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `payrolls`
--
ALTER TABLE `payrolls`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `positions`
--
ALTER TABLE `positions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
