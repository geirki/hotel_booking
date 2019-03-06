-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 06, 2019 at 08:21 AM
-- Server version: 5.7.24
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotell`
--

-- --------------------------------------------------------

--
-- Table structure for table `gjest`
--

DROP TABLE IF EXISTS `gjest`;
CREATE TABLE IF NOT EXISTS `gjest` (
  `gjestNr` int(11) NOT NULL AUTO_INCREMENT,
  `navn` varchar(250) DEFAULT NULL,
  `epost` varchar(250) NOT NULL,
  `telefon` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`gjestNr`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gjest`
--

INSERT INTO `gjest` (`gjestNr`, `navn`, `epost`, `telefon`) VALUES
(1, 'Martin', 'martin@rosok.no', '92601477');

-- --------------------------------------------------------

--
-- Table structure for table `reservasjon`
--

DROP TABLE IF EXISTS `reservasjon`;
CREATE TABLE IF NOT EXISTS `reservasjon` (
  `resevasjonsnr` int(11) NOT NULL AUTO_INCREMENT,
  `gjestNr` int(11) DEFAULT NULL,
  `innsjekk` date DEFAULT NULL,
  `utsjekk` date DEFAULT NULL,
  `parkering` tinyint(1) DEFAULT NULL,
  `kommentar` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`resevasjonsnr`),
  KEY `gjestNr` (`gjestNr`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reservasjon`
--

INSERT INTO `reservasjon` (`resevasjonsnr`, `gjestNr`, `innsjekk`, `utsjekk`, `parkering`, `kommentar`) VALUES
(1, 1, '2019-04-10', '2019-04-16', 0, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `reserverte_rom`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `reserverte_rom`;
CREATE TABLE IF NOT EXISTS `reserverte_rom` (
`romnr` smallint(4)
,`type` varchar(50)
,`reservasjonsnr` int(11)
,`innsjekk` date
,`utsjekk` date
);

-- --------------------------------------------------------

--
-- Table structure for table `rom`
--

DROP TABLE IF EXISTS `rom`;
CREATE TABLE IF NOT EXISTS `rom` (
  `romnr` smallint(4) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`romnr`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rom`
--

INSERT INTO `rom` (`romnr`, `type`) VALUES
(307, 'bryllupssuite'),
(105, 'dobbeltrom'),
(106, 'dobbeltrom'),
(107, 'dobbeltrom'),
(205, 'dobbeltrom'),
(206, 'dobbeltrom'),
(207, 'dobbeltrom'),
(303, 'dobbeltrom'),
(304, 'dobbeltrom'),
(101, 'enkeltrom'),
(102, 'enkeltrom'),
(103, 'enkeltrom'),
(104, 'enkeltrom'),
(201, 'enkeltrom'),
(202, 'enkeltrom'),
(203, 'enkeltrom'),
(204, 'enkeltrom'),
(301, 'enkeltrom'),
(302, 'enkeltrom'),
(305, 'suite'),
(306, 'suite');

-- --------------------------------------------------------

--
-- Table structure for table `romtype`
--

DROP TABLE IF EXISTS `romtype`;
CREATE TABLE IF NOT EXISTS `romtype` (
  `type` varchar(50) NOT NULL,
  `maks_sengeplasser` tinyint(4) NOT NULL,
  `beskrivelse` varchar(300) DEFAULT NULL,
  `pris` float DEFAULT NULL,
  `prioritet` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `romtype`
--

INSERT INTO `romtype` (`type`, `maks_sengeplasser`, `beskrivelse`, `pris`, `prioritet`) VALUES
('bryllupssuite', 2, 'for høytidsdager', 999, 4),
('dobbeltrom', 2, 'et flott dobbeltrom', 999, 2),
('enkeltrom', 1, 'et fint enkeltrom', 999, 1),
('suite', 3, 'en stor suite', 999, 3);

-- --------------------------------------------------------

--
-- Table structure for table `rom_reservasjon`
--

DROP TABLE IF EXISTS `rom_reservasjon`;
CREATE TABLE IF NOT EXISTS `rom_reservasjon` (
  `reservasjonsnr` int(11) NOT NULL,
  `romnr` tinyint(4) NOT NULL,
  `antall_personer` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`romnr`),
  KEY `reservasjonsnr` (`reservasjonsnr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rom_reservasjon`
--

INSERT INTO `rom_reservasjon` (`reservasjonsnr`, `romnr`, `antall_personer`) VALUES
(1, 101, 1);

-- --------------------------------------------------------

--
-- Structure for view `reserverte_rom`
--
DROP TABLE IF EXISTS `reserverte_rom`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `reserverte_rom`  AS  (select `rom`.`romnr` AS `romnr`,`rom`.`type` AS `type`,`rom_reservasjon`.`reservasjonsnr` AS `reservasjonsnr`,`reservasjon`.`innsjekk` AS `innsjekk`,`reservasjon`.`utsjekk` AS `utsjekk` from ((`rom` join `rom_reservasjon` on((`rom`.`romnr` = `rom_reservasjon`.`romnr`))) join `reservasjon` on((`rom_reservasjon`.`reservasjonsnr` = `reservasjon`.`resevasjonsnr`)))) ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reservasjon`
--
ALTER TABLE `reservasjon`
  ADD CONSTRAINT `reservasjon_ibfk_1` FOREIGN KEY (`gjestNr`) REFERENCES `gjest` (`gjestNr`);

--
-- Constraints for table `rom`
--
ALTER TABLE `rom`
  ADD CONSTRAINT `rom_ibfk_1` FOREIGN KEY (`type`) REFERENCES `romtype` (`type`);

--
-- Constraints for table `rom_reservasjon`
--
ALTER TABLE `rom_reservasjon`
  ADD CONSTRAINT `rom_reservasjon_ibfk_1` FOREIGN KEY (`reservasjonsnr`) REFERENCES `reservasjon` (`resevasjonsnr`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
