-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 31, 2024 at 01:25 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soccer_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `steps` text DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `title`, `body`, `steps`, `thumbnail`, `create_date`, `user_id`) VALUES
(1, 'Test Uodates2', 'Lorem ipsum dolor sit amet.', 'Step 1, Step 2, Step 3', '/uploads/17044193835015_M._Nabil_Mutofa_eventcampus.png', '2024-01-05', 101),
(2, 'Sample Title 2', 'Consectetur adipiscing elit.', 'Step 1, Step 2', '', '2024-01-02', 102),
(3, 'Sample Title 3', 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Step 1, Step 2, Step 3, Step 4', '', '2024-01-03', 103),
(4, 'Another Title', 'Another body text.', 'Step 1', NULL, '2024-01-04', 104),
(6, 'test', '1312321', '13,23,23', '', '2024-01-04', 2),
(7, '123123', '123123', '123123', '', '2024-01-04', 2),
(8, '123123', '12312', '1231231', '', '2024-01-04', 2),
(9, 'test', '123123', '123123', '/uploads/1704336432027AMERTA.png', '2024-01-04', 2),
(10, 'Sample Title 3', 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.aaaa', 'Step 1, Step 2, Step 3, Step 4', '/uploads/17043531761885_M._Nabil_Mutofa_eventcampus.png', '2024-01-04', 2),
(11, 'Sample Title 1', 'Lorem ipsum dolor sit amet.2', 'Step 1, Step 2, Step 3', '/uploads/17043542998365_M._Nabil_Mutofa_eventcampus.png', '2024-01-04', 2),
(12, 'Sample Title 122', 'Lorem ipsum dolor sit amet.', 'Step 1, Step 2, Step 3', '/uploads/17043544314455_M._Nabil_Mutofa_eventcampus.png', '2024-01-04', 2),
(13, 'Sample Title 122', 'Lorem ipsum dolor sit amet.', 'Step 1, Step 2, Step 3', '/uploads/17043544654275_M._Nabil_Mutofa_eventcampus.png', '2024-01-04', 2);

-- --------------------------------------------------------

--
-- Table structure for table `article_positions`
--

CREATE TABLE `article_positions` (
  `id` int(11) NOT NULL,
  `article_id` int(11) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `article_positions`
--

INSERT INTO `article_positions` (`id`, `article_id`, `position_id`) VALUES
(3, 2, 1),
(4, 3, 1),
(5, 3, 2),
(6, 4, 1),
(8, 6, 1),
(9, 6, 2),
(10, 6, 5),
(11, 7, 1),
(12, 7, 3),
(13, 7, 5),
(14, 8, 3),
(15, 8, 2),
(16, 8, 3),
(17, 9, 3),
(18, 9, 2),
(19, 9, 1),
(20, 10, 1),
(21, 10, 2),
(23, 11, 1),
(24, 11, 2),
(25, 11, 7),
(26, 12, 1),
(27, 12, 2),
(29, 13, 1),
(30, 13, 2),
(48, 1, 2),
(49, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `attribute_id` int(11) NOT NULL,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_display` varchar(255) NOT NULL,
  `attribute_question` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`attribute_id`, `attribute_name`, `attribute_display`, `attribute_question`) VALUES
(29, 'movement_acceleration', 'Movement Acceleration', 'How would you rate your movement acceleration?'),
(30, 'mentality_positioning', 'Mentality Positioning', 'How would you rate your mentality positioning?'),
(31, 'mentality_interceptions', 'Mentality Interceptions', 'How would you rate your mentality interceptions?'),
(32, 'mentality_aggression', 'Mentality Aggression', 'How would you rate your mentality aggression?'),
(33, 'attacking_finishing', 'Attacking Finishing', 'How would you rate your attacking finishing?'),
(34, 'power_shot_power', 'Power Shot Power', 'How would you rate your power shot power?'),
(35, 'power_long_shots', 'Power Long Shots', 'How would you rate your power long shots?'),
(36, 'attacking_volleys', 'Attacking Volleys', 'How would you rate your attacking volleys?'),
(37, 'mentality_penalties', 'Mentality Penalties', 'How would you rate your mentality penalties?'),
(38, 'mentality_vision', 'Mentality Vision', 'How would you rate your mentality vision?'),
(39, 'attacking_crossing', 'Attacking Crossing', 'How would you rate your attacking crossing?'),
(40, 'skill_fk_accuracy', 'Skill Free Kick Accuracy', 'How would you rate your skill free kick accuracy?'),
(41, 'attacking_short_passing', 'Attacking Short Passing', 'How would you rate your attacking short passing?'),
(42, 'skill_long_passing', 'Skill Long Passing', 'How would you rate your skill long passing?'),
(43, 'skill_curve', 'Skill Curve', 'How would you rate your skill curve?'),
(44, 'movement_agility', 'Movement Agility', 'How would you rate your movement agility?'),
(45, 'movement_balance', 'Movement Balance', 'How would you rate your movement balance?'),
(46, 'movement_reactions', 'Movement Reactions', 'How would you rate your movement reactions?'),
(47, 'skill_ball_control', 'Skill Ball Control', 'How would you rate your skill ball control?'),
(48, 'skill_dribbling', 'Skill Dribbling', 'How would you rate your skill dribbling?'),
(49, 'mentality_composure', 'Mentality Composure', 'How would you rate your mentality composure?'),
(50, 'attacking_heading_accuracy', 'Attacking Heading Accuracy', 'How would you rate your attacking heading accuracy?'),
(51, 'defending_marking_awareness', 'Defending Marking Awareness', 'How would you rate your defending marking awareness?'),
(52, 'defending_standing_tackle', 'Defending Standing Tackle', 'How would you rate your defending standing tackle?'),
(53, 'defending_sliding_tackle', 'Defending Sliding Tackle', 'How would you rate your defending sliding tackle?'),
(54, 'power_jumping', 'Power Jumping', 'How would you rate your power jumping?'),
(55, 'power_stamina', 'Power Stamina', 'How would you rate your power stamina?'),
(56, 'power_strength', 'Power Strength', 'How would you rate your power strength?'),
(57, 'movement_sprint_speed', 'Movement Sprint Speed', 'How would you rate your movement sprint speed?');

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `user_id` int(11) NOT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `height` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`user_id`, `weight`, `height`) VALUES
(1, '55.00', '160.00');

-- --------------------------------------------------------

--
-- Table structure for table `player_attributes`
--

CREATE TABLE `player_attributes` (
  `user_id` int(11) NOT NULL,
  `corners` int(11) DEFAULT 0,
  `crossing` int(11) DEFAULT 0,
  `dribbling` int(11) DEFAULT 0,
  `finishing` int(11) DEFAULT 0,
  `first_touch` int(11) DEFAULT 0,
  `free_kick_taking` int(11) DEFAULT 0,
  `heading` int(11) DEFAULT 0,
  `long_shots` int(11) DEFAULT 0,
  `passing` int(11) DEFAULT 0,
  `tackling` int(11) DEFAULT 0,
  `technique` int(11) DEFAULT 0,
  `concentration` int(11) DEFAULT 0,
  `vision` int(11) DEFAULT 0,
  `decision` int(11) DEFAULT 0,
  `determination` int(11) DEFAULT 0,
  `position_1` int(11) DEFAULT 0,
  `teamwork` int(11) DEFAULT 0,
  `balance` int(11) DEFAULT 0,
  `natural_fitness` int(11) DEFAULT 0,
  `pace` int(11) DEFAULT 0,
  `stamina` int(11) DEFAULT 0,
  `strength` int(11) DEFAULT 0,
  `left_foot` int(11) DEFAULT 0,
  `right_foot` int(11) DEFAULT 0,
  `id` int(11) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_attributes`
--

INSERT INTO `player_attributes` (`user_id`, `corners`, `crossing`, `dribbling`, `finishing`, `first_touch`, `free_kick_taking`, `heading`, `long_shots`, `passing`, `tackling`, `technique`, `concentration`, `vision`, `decision`, `determination`, `position_1`, `teamwork`, `balance`, `natural_fitness`, `pace`, `stamina`, `strength`, `left_foot`, `right_foot`, `id`, `created_date`) VALUES
(1, 60, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 53, 0, 57, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 1, '2024-01-20 12:02:56'),
(1, 57, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, 0, 81, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 2, '2024-01-20 12:12:23');

-- --------------------------------------------------------

--
-- Table structure for table `player_attributes2`
--

CREATE TABLE `player_attributes2` (
  `user_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `movement_sprint_speed` int(11) DEFAULT NULL,
  `movement_acceleration` int(11) DEFAULT NULL,
  `mentality_positioning` int(11) DEFAULT NULL,
  `mentality_interceptions` int(11) DEFAULT NULL,
  `mentality_aggression` int(11) DEFAULT NULL,
  `attacking_finishing` int(11) DEFAULT NULL,
  `power_shot_power` int(11) DEFAULT NULL,
  `power_long_shots` int(11) DEFAULT NULL,
  `attacking_volleys` int(11) DEFAULT NULL,
  `mentality_penalties` int(11) DEFAULT NULL,
  `mentality_vision` int(11) DEFAULT NULL,
  `attacking_crossing` int(11) DEFAULT NULL,
  `skill_fk_accuracy` int(11) DEFAULT NULL,
  `attacking_short_passing` int(11) DEFAULT NULL,
  `skill_long_passing` int(11) DEFAULT NULL,
  `skill_curve` int(11) DEFAULT NULL,
  `movement_agility` int(11) DEFAULT NULL,
  `movement_balance` int(11) DEFAULT NULL,
  `movement_reactions` int(11) DEFAULT NULL,
  `skill_ball_control` int(11) DEFAULT NULL,
  `skill_dribbling` int(11) DEFAULT NULL,
  `mentality_composure` float DEFAULT NULL,
  `attacking_heading_accuracy` int(11) DEFAULT NULL,
  `defending_marking_awareness` int(11) DEFAULT NULL,
  `defending_standing_tackle` int(11) DEFAULT NULL,
  `defending_sliding_tackle` int(11) DEFAULT NULL,
  `power_jumping` int(11) DEFAULT NULL,
  `power_stamina` int(11) DEFAULT NULL,
  `power_strength` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_attributes2`
--

INSERT INTO `player_attributes2` (`user_id`, `id`, `created_date`, `movement_sprint_speed`, `movement_acceleration`, `mentality_positioning`, `mentality_interceptions`, `mentality_aggression`, `attacking_finishing`, `power_shot_power`, `power_long_shots`, `attacking_volleys`, `mentality_penalties`, `mentality_vision`, `attacking_crossing`, `skill_fk_accuracy`, `attacking_short_passing`, `skill_long_passing`, `skill_curve`, `movement_agility`, `movement_balance`, `movement_reactions`, `skill_ball_control`, `skill_dribbling`, `mentality_composure`, `attacking_heading_accuracy`, `defending_marking_awareness`, `defending_standing_tackle`, `defending_sliding_tackle`, `power_jumping`, `power_stamina`, `power_strength`) VALUES
(1, 1, '2024-01-28 01:42:04', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 2, '2024-01-28 04:40:02', 50, 87, 42, 75, 43, 50, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 92, 82, 0, 0, 0, 0),
(1, 3, '2024-01-28 04:48:47', 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100),
(1, 4, '2024-01-28 04:49:07', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 61, 0, 0, 0, 0, 82, 0, 0, 0, 0),
(1, 5, '2024-01-28 04:49:10', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 61, 0, 0, 0, 0, 82, 0, 0, 17, 0),
(1, 6, '2024-01-28 04:49:14', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 61, 0, 0, 0, 0, 82, 70, 64, 17, 0),
(1, 7, '2024-01-28 04:50:14', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 61, 0, 0, 0, 0, 82, 70, 64, 17, 0),
(1, 8, '2024-01-28 04:50:33', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 61, 100, 86, 100, 0, 82, 70, 64, 17, 0),
(1, 9, '2024-01-28 04:50:49', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 100, 86, 100, 0, 1, 0, 0, 0, 0),
(1, 10, '2024-01-28 06:51:18', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 11, '2024-01-28 06:51:54', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 12, '2024-01-28 06:52:07', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 13, '2024-01-28 06:53:14', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 14, '2024-01-28 06:54:34', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 15, '2024-01-28 06:55:14', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 16, '2024-01-28 06:56:46', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 17, '2024-01-28 06:57:33', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 18, '2024-01-28 06:58:04', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 19, '2024-01-28 07:01:16', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 20, '2024-01-28 07:02:59', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(6, 22, '2024-01-28 07:23:46', 0, 0, 0, 57, 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 23, '2024-01-28 07:24:52', 30, 49, 19, 59, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 24, '2024-01-28 07:28:11', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 25, '2024-01-28 07:30:16', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 26, '2024-01-28 07:30:39', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 27, '2024-01-28 07:34:40', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 28, '2024-01-28 07:35:09', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 29, '2024-01-28 07:35:44', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 30, '2024-01-28 07:37:03', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 31, '2024-01-28 07:37:03', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 32, '2024-01-28 07:37:19', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 33, '2024-01-28 07:37:31', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 34, '2024-01-28 07:42:40', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 35, '2024-01-28 07:42:44', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 36, '2024-01-28 07:43:08', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 37, '2024-01-28 07:43:38', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 38, '2024-01-28 07:44:52', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 39, '2024-01-28 07:44:52', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 40, '2024-01-28 07:44:52', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 41, '2024-01-28 07:45:33', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 42, '2024-01-28 07:46:25', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 43, '2024-01-28 07:51:16', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 44, '2024-01-28 07:51:33', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 45, '2024-01-28 07:52:04', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 46, '2024-01-28 07:52:32', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 47, '2024-01-28 07:52:32', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43),
(1, 48, '2024-01-28 07:53:09', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 74, 43, 45, 100, 65, 71, 44, 70, 46, 70, 68, 31, 43),
(1, 49, '2024-01-28 07:56:11', 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 74, 43, 45, 100, 65, 71, 44, 70, 46, 70, 68, 31, 43),
(1, 50, '2024-01-28 08:02:31', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 41, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 51, '2024-01-28 08:02:42', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 58, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73),
(1, 52, '2024-01-28 08:02:47', 33, 49, 46, 53, 78, 50, 18, 47, 31, 70, 30, 75, 50, 31, 74, 23, 79, 39, 73, 50, 15, 16, 12, 61, 61, 19, 29, 39, 73);

-- --------------------------------------------------------

--
-- Table structure for table `player_positions`
--

CREATE TABLE `player_positions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `player_attributes_id` int(11) NOT NULL,
  `position_1` int(11) DEFAULT NULL,
  `position_2` int(11) DEFAULT NULL,
  `position_3` int(11) DEFAULT NULL,
  `player_alike` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_positions`
--

INSERT INTO `player_positions` (`id`, `user_id`, `player_attributes_id`, `position_1`, `position_2`, `position_3`, `player_alike`, `created_at`) VALUES
(1, 1, 1, 1, 5, 6, 'Kylian Mbappe', '2024-01-28 01:42:04'),
(2, 1, 2, 1, 5, 6, 'Kylian Mbappe', '2024-01-28 04:40:02'),
(3, 1, 3, 6, 1, 5, 'Kylian Mbappe', '2024-01-28 04:48:47'),
(4, 1, 4, 6, 1, 5, 'Kylian Mbappe', '2024-01-28 04:49:07'),
(5, 1, 5, 5, 6, 1, 'Kylian Mbappe', '2024-01-28 04:49:10'),
(6, 1, 6, 5, 6, 1, 'Kylian Mbappe', '2024-01-28 04:49:14'),
(7, 1, 7, 5, 6, 1, 'Kylian Mbappe', '2024-01-28 04:50:15'),
(8, 1, 8, 5, 1, 6, 'Kylian Mbappe', '2024-01-28 04:50:33'),
(9, 1, 9, 5, 13, 6, 'Kylian Mbappe', '2024-01-28 04:50:49'),
(11, 7, 23, 1, 5, 6, 'Kylian Mbappe', '2024-01-28 07:24:52'),
(12, 1, 24, 1, 5, 6, 'Kylian Mbappe', '2024-01-28 07:28:11'),
(13, 1, 25, 6, 7, 8, 'Kylian Mbappe', '2024-01-28 07:30:16'),
(14, 1, 37, 6, 7, 13, 'Kylian Mbappe', '2024-01-28 07:43:38'),
(15, 1, 46, 6, 7, 13, 'Thibaut Nicolas Marc Courtois', '2024-01-28 07:52:32'),
(16, 1, 46, 6, 7, 13, 'Thibaut Nicolas Marc Courtois', '2024-01-28 07:52:32'),
(17, 1, 48, 3, 5, 6, 'Kléper Laveran de Lima Ferreira', '2024-01-28 07:53:09'),
(18, 1, 49, 6, 3, 5, 'Kléper Laveran de Lima Ferreira', '2024-01-28 07:56:11'),
(19, 1, 50, 1, 5, 6, 'David Olatukunbo Alaba', '2024-01-28 08:02:31'),
(20, 1, 51, 1, 5, 6, 'Joshua Walter Kimmich', '2024-01-28 08:02:43'),
(21, 1, 52, 1, 2, 6, 'Joshua Walter Kimmich', '2024-01-28 08:02:48');

-- --------------------------------------------------------

--
-- Table structure for table `positions`
--

CREATE TABLE `positions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `positions`
--

INSERT INTO `positions` (`id`, `name`) VALUES
(1, 'RWB'),
(2, 'LWB'),
(3, 'RB'),
(4, 'LB'),
(5, 'CB'),
(6, 'CDM'),
(7, 'LM'),
(8, 'RM'),
(9, 'LW'),
(10, 'RW'),
(11, 'CF'),
(13, 'ST');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `name`, `email`, `phone`, `status`) VALUES
(1, 'player1', '$2b$12$TlBtbMdmctdcA.joS75kAuhqzUUuuUe53aQ/j3W3aA7d8m6/2pDY2', 1, 'Player 3', 'player@gmail.com', '082101633045', 1),
(2, 'user2', '$2a$12$2Xtn5uT78LeTTHTkF88CUO6Aut.XbfBoGQ4Co8ARuEtobexw6KG7y', 2, 'User Two', 'user2@example.com', '081234567890', 1),
(3, 'customer', '$2a$12$2Xtn5uT78LeTTHTkF88CUO6Aut.XbfBoGQ4Co8ARuEtobexw6KG7y', 2, 'John Doe', 'john.doe@gmail.com', '085678912345', 1),
(4, 'client3', '$2a$12$2Xtn5uT78LeTTHTkF88CUO6Aut.XbfBoGQ4Co8ARuEtobexw6KG7y', 2, 'Jane Doe', 'jane.doe@example.com', '089876543210', 1),
(5, 'nabilm', '$2b$12$nLjZMg4aUV6OXhi2UvMX.uceFCnlYd70D/HbAZK228k4G8UdjOOgW', 1, 'Nabil Mustofa', 'nabilm@gmail.com', '085748969806', 1),
(6, 'nabillogin', '$2b$12$8eC/bM0qjhbs8J938W0VxedI6leKcckftn8c/UGqgrru83Mf2AvwO', 1, 'nabil', 'nabilmustofa@gmail.com', '085748969806', 1),
(7, 'nabil123', '$2b$12$IU./wVV.jQLtbkLaOCqSkORDXR6ESvgV3mg3eMzEC7uvhKt7zN84S', 1, 'nabil', 'nabil@gmail.com', '0857-4896-9806', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_articles`
--

CREATE TABLE `user_articles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `article_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_articles`
--

INSERT INTO `user_articles` (`id`, `user_id`, `article_id`, `status`) VALUES
(1, 1, 2, '1'),
(2, 1, 2, '1'),
(3, 1, 13, '1'),
(4, 1, 13, '1'),
(5, 1, 13, '1'),
(6, 1, 13, '1'),
(7, 1, 13, '1'),
(8, 1, 13, '1'),
(9, 1, 13, '1'),
(10, 1, 13, '1'),
(11, 1, 13, '1'),
(12, 1, 13, '1'),
(13, 1, 3, '1'),
(14, 1, 3, '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `article_positions`
--
ALTER TABLE `article_positions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `article_id` (`article_id`),
  ADD KEY `position_id` (`position_id`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`attribute_id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `player_attributes`
--
ALTER TABLE `player_attributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_attributes_ibfk_1` (`user_id`);

--
-- Indexes for table `player_attributes2`
--
ALTER TABLE `player_attributes2`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_positions`
--
ALTER TABLE `player_positions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_articles`
--
ALTER TABLE `user_articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `article_id` (`article_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `article_positions`
--
ALTER TABLE `article_positions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `attribute_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `player_attributes`
--
ALTER TABLE `player_attributes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `player_attributes2`
--
ALTER TABLE `player_attributes2`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `player_positions`
--
ALTER TABLE `player_positions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_articles`
--
ALTER TABLE `user_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `article_positions`
--
ALTER TABLE `article_positions`
  ADD CONSTRAINT `article_positions_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`),
  ADD CONSTRAINT `article_positions_ibfk_2` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`);

--
-- Constraints for table `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `player_attributes`
--
ALTER TABLE `player_attributes`
  ADD CONSTRAINT `player_attributes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `player_positions`
--
ALTER TABLE `player_positions`
  ADD CONSTRAINT `player_positions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_articles`
--
ALTER TABLE `user_articles`
  ADD CONSTRAINT `user_articles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_articles_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
