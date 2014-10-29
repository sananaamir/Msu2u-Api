-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 16, 2014 at 04:53 PM
-- Server version: 5.5.37-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `aii`
--

-- --------------------------------------------------------

--
-- Table structure for table `careTeams`
--

CREATE TABLE IF NOT EXISTS `careTeams` (
  `CareTeamID` int(11) unsigned NOT NULL,
  `PatientID` int(11) unsigned NOT NULL,
  `OriginalFacilityID` int(11) unsigned NOT NULL,
  `CurrentPhaseID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`CareTeamID`,`PatientID`,`OriginalFacilityID`,`CurrentPhaseID`),
  KEY `CareTeam_ibfk_1` (`OriginalFacilityID`),
  KEY `CareTeam_ibfk_2` (`PatientID`),
  KEY `CurrentPhaseID_idx` (`CurrentPhaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `careTeams`
--

INSERT INTO `careTeams` (`CareTeamID`, `PatientID`, `OriginalFacilityID`, `CurrentPhaseID`) VALUES
(1000, 1, 100, 4),
(1001, 2, 100, 6),
(1002, 3, 112, 2);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
