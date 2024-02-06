-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 06, 2024 at 01:25 PM
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
  `user_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `article_positions`
--

CREATE TABLE `article_positions` (
  `id` int(11) NOT NULL,
  `article_id` int(11) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(57, 'movement_sprint_speed', 'Movement Sprint Speed', 'How would you rate your movement sprint speed?'),
(58, 'weight', 'wegiht', 'How would you rate your weight?'),
(59, 'height', 'height', 'How would you rate your weight?'),
(60, 'prefered_foot', 'Foot Preference', 'How would you rate your weight?');

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `user_id` int(11) NOT NULL,
  `birth_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_attributes2`
--

CREATE TABLE `player_attributes2` (
  `user_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `prefered_foot` varchar(20) DEFAULT NULL,
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
  `player_alike1` varchar(255) DEFAULT NULL,
  `player_alike2` varchar(255) DEFAULT NULL,
  `player_alike3` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(2, 'admin', '$2a$12$2Xtn5uT78LeTTHTkF88CUO6Aut.XbfBoGQ4Co8ARuEtobexw6KG7y', 2, 'User Admin', 'user2@example.com', '081234567890', 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `article_positions`
--
ALTER TABLE `article_positions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `attribute_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `player_attributes2`
--
ALTER TABLE `player_attributes2`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_positions`
--
ALTER TABLE `player_positions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user_articles`
--
ALTER TABLE `user_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
