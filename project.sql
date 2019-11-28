-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  ven. 17 mai 2019 à 09:09
-- Version du serveur :  5.7.23
-- Version de PHP :  7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `project`
--

-- --------------------------------------------------------

--
-- Structure de la table `clubs`
--

DROP TABLE IF EXISTS `clubs`;
CREATE TABLE IF NOT EXISTS `clubs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clubs_title` varchar(255) NOT NULL,
  `clubs_desc` varchar(255) DEFAULT NULL,
  `jours_semaine` varchar(255) DEFAULT NULL,
  `statut_clubs` tinyint(1) NOT NULL DEFAULT '0',
  `createur` varchar(44) DEFAULT NULL,
  `date_time_publication` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_time_edition` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `clubs`
--

INSERT INTO `clubs` (`id`, `clubs_title`, `clubs_desc`, `jours_semaine`, `statut_clubs`, `createur`, `date_time_publication`, `date_time_edition`) VALUES
(1, 'Football', 'Pour les fans de l\'ol seulement!', NULL, 1, '', '2019-05-15 21:06:24', NULL),
(2, 'Manga', NULL, NULL, 1, '', '2019-05-15 21:06:24', NULL),
(3, 'Natation', 'Short de plage interdis', NULL, 1, '', '2019-05-15 21:06:24', NULL),
(5, 'Cinema', NULL, NULL, 1, '', '2019-05-15 21:06:24', NULL),
(7, 'Politique', 'Ya quelqu\'un?', NULL, 1, '', '2019-05-15 21:06:24', NULL),
(8, 'Php', NULL, NULL, 1, '', '2019-05-15 21:06:24', NULL),
(9, 'Theatre', NULL, NULL, 1, '', '2019-05-15 21:06:24', NULL),
(109, 'Musique', 'doremi', 'Mercredi', 0, 'massi', '2019-05-17 11:05:57', '2019-05-17 11:06:29'),
(110, ' Moto', 'vroum vroum', 'Jeudi', 0, 'bob', '2019-05-17 11:08:06', '2019-05-17 11:08:19'),
(82, ' massiMODIF2', 'oui', 'pas le lundi', 0, 'massi', '2019-05-16 19:06:26', '2019-05-17 11:03:11'),
(97, 'VÃ©lo12', 'Sans dopage, si possible', 'Samedi, dimanche', 0, 'massi', '2019-05-17 09:19:46', '2019-05-17 11:05:10'),
(107, 'Skates', 'yo', 'all week', 0, 'massi', '2019-05-17 09:55:24', '2019-05-17 11:02:18');

-- --------------------------------------------------------

--
-- Structure de la table `dislikes`
--

DROP TABLE IF EXISTS `dislikes`;
CREATE TABLE IF NOT EXISTS `dislikes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_clubs` int(11) NOT NULL,
  `id_users` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `dislikes`
--

INSERT INTO `dislikes` (`id`, `id_clubs`, `id_users`) VALUES
(27, 5, 19),
(29, 5, 21),
(37, 5, 22),
(41, 77, 19);

-- --------------------------------------------------------

--
-- Structure de la table `likes`
--

DROP TABLE IF EXISTS `likes`;
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_clubs` int(11) NOT NULL,
  `id_users` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=122 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `likes`
--

INSERT INTO `likes` (`id`, `id_clubs`, `id_users`) VALUES
(121, 82, 19),
(120, 83, 22),
(119, 82, 22),
(116, 2, 22),
(110, 7, 22),
(97, 8, 22),
(115, 1, 22),
(89, 2, 21),
(90, 1, 21),
(85, 1, 19),
(74, 7, 19),
(87, 1, 20),
(83, 2, 19);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(220) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `created_at`, `email`) VALUES
(10, 'test', '$2y$10$v60Wz5hcg.jJwUfFuP3npeikl8BUhfAYa7URCf4YnPECe/xNL6DPq', '2018-11-23 17:29:13', NULL),
(12, 'testing', '$2y$10$VqDaUyLUybFTBlu.Gyda7eYuhI3xilpWOrlsVapx/NXxUybeD26nG', '2018-11-30 14:31:31', NULL),
(13, 'admin', '$2y$10$5YyjRe8sBM5BqeB3DhnZouhJlLsFG6cIq76W4/7I6Hj2iYPP7JDbe', '2018-12-21 09:31:29', NULL),
(19, 'bob', '$2y$10$0tYfw24eICdA7TUA75z.2.4JAkwr3ALUfy8yaIfwzk1oR4RMhv4Ey', '2019-05-07 10:01:38', NULL),
(20, 'bob1', '$2y$10$C/uwY4od8PtxaJr8HVeJ/ex1CjirqMQ879c/QB0lubRPJ9iHs20P6', '2019-05-15 15:06:59', NULL),
(22, 'massi', '$2y$10$aA7yZdSnawuTAflSsOli4Oqm5HmR/0Tnfc8Fs3Hkz2IaK5NT964tu', '2019-05-15 16:22:41', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `usersclubs`
--

DROP TABLE IF EXISTS `usersclubs`;
CREATE TABLE IF NOT EXISTS `usersclubs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IDCLUBS` int(11) NOT NULL,
  `IDUSERS` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `usersclubs_clubs_fk` (`IDCLUBS`),
  KEY `usersclubs_users_fk` (`IDUSERS`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `usersclubs`
--

INSERT INTO `usersclubs` (`ID`, `IDCLUBS`, `IDUSERS`) VALUES
(49, 8, 22),
(40, 5, 21),
(39, 2, 21),
(41, 1, 21),
(37, 1, 19),
(27, 7, 19),
(34, 2, 19),
(32, 5, 19),
(64, 7, 22),
(57, 9, 22),
(55, 5, 22);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `clubs`
--
ALTER TABLE `clubs` ADD FULLTEXT KEY `blog_title` (`clubs_title`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
