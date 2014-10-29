-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 17, 2014 at 02:55 PM
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
-- Table structure for table `alerts`
--

CREATE TABLE IF NOT EXISTS `alerts` (
  `AlertID` int(11) NOT NULL,
  `CareTeamID` int(11) unsigned NOT NULL,
  `Content` varchar(128) NOT NULL,
  `Timestamp` int(11) unsigned NOT NULL,
  PRIMARY KEY (`AlertID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE IF NOT EXISTS `answers` (
  `AnswerID` int(11) unsigned NOT NULL,
  `QuestionID` int(11) unsigned NOT NULL,
  `CareTeamID` int(11) unsigned NOT NULL,
  `PhaseID` int(11) unsigned NOT NULL,
  `Text` text NOT NULL,
  PRIMARY KEY (`AnswerID`,`QuestionID`,`CareTeamID`,`PhaseID`),
  KEY `CareTeamID_idx` (`CareTeamID`),
  KEY `PhaseID_idx` (`PhaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `answerTypes`
--

CREATE TABLE IF NOT EXISTS `answerTypes` (
  `AnswerTypeID` int(11) unsigned NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`AnswerTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `audioAidTypes`
--

CREATE TABLE IF NOT EXISTS `audioAidTypes` (
  `AidTypeID` int(8) unsigned NOT NULL,
  `AidLabel` varchar(64) DEFAULT NULL,
  `AidDescription` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`AidTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `audioAidTypes`
--

INSERT INTO `audioAidTypes` (`AidTypeID`, `AidLabel`, `AidDescription`) VALUES
(1, 'Cochlear Implant', 'A surgically implanted electronic device that provides a sense of sound.'),
(2, 'Hearing Aid', 'An electroacoustic device which is designed to amplify sound for the wearer.'),
(3, 'Plugged', 'placeholder'),
(4, 'Unaided', 'No procedures have been performed.'),
(5, 'Hybrid', 'Create a new dropdown table.'),
(6, 'Acoustic-Only Implant', 'placeholder'),
(7, 'Electric-Only Implant', 'placeholder'),
(8, 'Electro-Acoustic Implant', 'The use of a hearing aid and a cochlear implant together in the same ear.');

-- --------------------------------------------------------

--
-- Table structure for table `audioCategories`
--

CREATE TABLE IF NOT EXISTS `audioCategories` (
  `AudioCategoryID` int(8) unsigned NOT NULL,
  `Category` varchar(64) DEFAULT NULL,
  `CategoryDescription` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`AudioCategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `audioCategories`
--

INSERT INTO `audioCategories` (`AudioCategoryID`, `Category`, `CategoryDescription`) VALUES
(1, 'Comprehensive Diagnostic Audiogram', 'placeholder'),
(2, 'AZBio', 'placeholder'),
(3, 'CNC', 'placeholder'),
(4, 'BKB-SIN', 'placeholder');

-- --------------------------------------------------------

--
-- Table structure for table `audioConditions`
--

CREATE TABLE IF NOT EXISTS `audioConditions` (
  `ConditionID` int(8) unsigned NOT NULL,
  `CareteamID` int(8) unsigned NOT NULL,
  `LeftEarAidID` int(8) unsigned NOT NULL,
  `RightEarAidID` int(8) unsigned NOT NULL,
  PRIMARY KEY (`ConditionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `audioConditions`
--

INSERT INTO `audioConditions` (`ConditionID`, `CareteamID`, `LeftEarAidID`, `RightEarAidID`) VALUES
(1, 1000, 1, 4),
(2, 1001, 4, 2),
(3, 1002, 3, 6);

-- --------------------------------------------------------

--
-- Table structure for table `audioTestResults`
--

CREATE TABLE IF NOT EXISTS `audioTestResults` (
  `AudioTestID` int(8) unsigned NOT NULL,
  `CareTeamID` int(8) NOT NULL,
  `DBValue` int(8) DEFAULT NULL,
  `PercentageValue` int(8) DEFAULT NULL,
  `PDBValue` int(8) DEFAULT NULL,
  `SNRValue` float DEFAULT NULL,
  `ListValue` int(8) DEFAULT NULL,
  PRIMARY KEY (`AudioTestID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `audioTestResults`
--

INSERT INTO `audioTestResults` (`AudioTestID`, `CareTeamID`, `DBValue`, `PercentageValue`, `PDBValue`, `SNRValue`, `ListValue`) VALUES
(2, 2, 45, 0, 60, 0, 0),
(4, 1, 0, 65, 10, 0, 0),
(8, 3, 0, 89, 50, 1.25, 0);

-- --------------------------------------------------------

--
-- Table structure for table `audioTests`
--

CREATE TABLE IF NOT EXISTS `audioTests` (
  `AudioTestID` int(8) unsigned NOT NULL,
  `AudioCategoryID` int(8) unsigned NOT NULL,
  `AudioTestName` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`AudioTestID`,`AudioCategoryID`),
  KEY `fk_AudioTest_AudioTestCategory1_idx` (`AudioTestID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `audioTests`
--

INSERT INTO `audioTests` (`AudioTestID`, `AudioCategoryID`, `AudioTestName`) VALUES
(1, 1, 'Pure Tone Average'),
(2, 1, 'Speech Reception Threshold'),
(3, 1, 'Speech Discrimination Score'),
(4, 2, 'Score in Quiet'),
(5, 2, 'Score in Noise'),
(6, 3, 'Score'),
(7, 4, 'Score in Quiet'),
(8, 4, 'Score in Noise');

-- --------------------------------------------------------

--
-- Table structure for table `audioTestTypes`
--

CREATE TABLE IF NOT EXISTS `audioTestTypes` (
  `AudioTestID` int(8) NOT NULL,
  `AudioTypeID` int(8) NOT NULL,
  KEY `AudioTestID` (`AudioTestID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `audioTestTypes`
--

INSERT INTO `audioTestTypes` (`AudioTestID`, `AudioTypeID`) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(4, 3),
(5, 2),
(5, 3),
(5, 4),
(6, 1),
(6, 3),
(6, 4),
(7, 2),
(7, 3),
(8, 2),
(8, 3),
(8, 4);

-- --------------------------------------------------------

--
-- Table structure for table `audioTypeRanges`
--

CREATE TABLE IF NOT EXISTS `audioTypeRanges` (
  `AudioTypeID` int(8) NOT NULL,
  `Type` varchar(32) NOT NULL,
  `BeginRange` int(8) DEFAULT NULL,
  `EndRange` int(8) DEFAULT NULL,
  PRIMARY KEY (`AudioTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `audioTypeRanges`
--

INSERT INTO `audioTypeRanges` (`AudioTypeID`, `Type`, `BeginRange`, `EndRange`) VALUES
(1, 'Decibels', -100, 100),
(2, 'Percentage', 0, 100),
(3, 'Presented Decibels', -100, 100),
(4, 'Signal-To-Noise Ratio', 0, 10),
(5, 'List', 0, 100);

-- --------------------------------------------------------

--
-- Table structure for table `auditActions`
--

CREATE TABLE IF NOT EXISTS `auditActions` (
  `ActionID` int(11) unsigned NOT NULL,
  `Label` varchar(32) DEFAULT NULL,
  `Description` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ActionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auditTrails`
--

CREATE TABLE IF NOT EXISTS `auditTrails` (
  `UserID` int(11) unsigned NOT NULL COMMENT 'Id of user interacting with system.',
  `QuestionID` int(11) unsigned NOT NULL COMMENT 'Id of question being updated.',
  `ActionID` int(11) unsigned NOT NULL,
  `SessionID` varchar(40) NOT NULL,
  `Timestamp` int(11) unsigned NOT NULL COMMENT 'Time when action occurred.',
  PRIMARY KEY (`UserID`,`Timestamp`),
  KEY `QuestionID` (`QuestionID`),
  KEY `fk_AuditTrail_ci_sessions1_idx` (`SessionID`),
  KEY `Audit_Actions_fk_idx` (`ActionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `careTeamFacilities`
--

CREATE TABLE IF NOT EXISTS `careTeamFacilities` (
  `PrimaryID` int(11) NOT NULL,
  `CareTeamID` int(11) NOT NULL,
  `FacilityID` int(11) NOT NULL,
  PRIMARY KEY (`PrimaryID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `careTeamFacilities`
--

INSERT INTO `careTeamFacilities` (`PrimaryID`, `CareTeamID`, `FacilityID`) VALUES
(1, 1000, 129),
(2, 1000, 128),
(3, 1000, 108),
(4, 1000, 129),
(5, 1001, 106),
(6, 1001, 127),
(7, 1001, 118),
(8, 1001, 109),
(9, 1002, 120),
(10, 1003, 114),
(11, 1003, 109),
(12, 1004, 129),
(13, 1004, 108),
(14, 1004, 106),
(15, 1004, 118),
(16, 1004, 129),
(17, 1005, 119),
(18, 1005, 117),
(19, 1005, 102),
(20, 1006, 112),
(21, 1007, 121),
(22, 1008, 104),
(23, 1008, 106),
(24, 1008, 113),
(25, 1008, 101),
(26, 1008, 110),
(27, 1009, 127),
(28, 1009, 113),
(29, 1009, 114),
(30, 1010, 123),
(31, 1010, 129),
(32, 1010, 100),
(33, 1011, 103),
(34, 1011, 109),
(35, 1011, 111),
(36, 1012, 114),
(37, 1012, 130),
(38, 1012, 120),
(39, 1012, 113),
(40, 1013, 126),
(41, 1013, 109),
(42, 1014, 116),
(43, 1015, 109),
(44, 1015, 110),
(45, 1015, 111),
(46, 1016, 107),
(47, 1017, 127),
(48, 1017, 125),
(49, 1017, 103),
(50, 1017, 119),
(51, 1017, 105),
(52, 1018, 106),
(53, 1018, 120),
(54, 1019, 104),
(55, 1019, 107),
(56, 1019, 110),
(57, 1020, 122),
(58, 1020, 116),
(59, 1020, 126),
(60, 1020, 111),
(61, 1020, 106),
(62, 1021, 124),
(63, 1021, 114),
(64, 1022, 118),
(65, 1022, 104),
(66, 1022, 108),
(67, 1023, 121),
(68, 1023, 129),
(69, 1023, 109),
(70, 1023, 100),
(71, 1023, 112),
(72, 1024, 112),
(73, 1024, 103),
(74, 1025, 110),
(75, 1025, 120),
(76, 1025, 108),
(77, 1025, 116),
(78, 1025, 118),
(79, 1026, 107),
(80, 1026, 128),
(81, 1026, 122),
(82, 1027, 125),
(83, 1028, 117),
(84, 1028, 116),
(85, 1028, 131),
(86, 1029, 123),
(87, 1029, 116),
(88, 1029, 124),
(89, 1029, 101),
(90, 1029, 128),
(91, 1030, 119),
(92, 1030, 130),
(93, 1030, 120),
(94, 1031, 114),
(95, 1031, 101),
(96, 1031, 112),
(97, 1032, 108),
(98, 1033, 111),
(99, 1033, 112),
(100, 1033, 100),
(101, 1033, 123),
(102, 1034, 101),
(103, 1034, 119),
(104, 1035, 123),
(105, 1035, 116),
(106, 1035, 129),
(107, 1036, 127),
(108, 1037, 111),
(109, 1037, 116),
(110, 1037, 131),
(111, 1037, 118),
(112, 1038, 102),
(113, 1038, 124),
(114, 1038, 125),
(115, 1038, 110),
(116, 1038, 100),
(117, 1039, 104),
(118, 1039, 129),
(119, 1039, 128),
(120, 1039, 104),
(121, 1039, 108),
(122, 1040, 105),
(123, 1040, 127),
(124, 1041, 100),
(125, 1041, 106),
(126, 1042, 124),
(127, 1043, 130),
(128, 1044, 103),
(129, 1044, 108),
(130, 1044, 113),
(131, 1044, 131),
(132, 1045, 113),
(133, 1045, 102),
(134, 1045, 113),
(135, 1045, 107),
(136, 1045, 115),
(137, 1046, 106),
(138, 1046, 125),
(139, 1046, 106),
(140, 1047, 105),
(141, 1048, 101),
(142, 1048, 116),
(143, 1049, 109),
(144, 1049, 128),
(145, 1049, 130),
(146, 1049, 103),
(147, 1050, 116),
(148, 1050, 112),
(149, 1051, 104),
(150, 1052, 120),
(151, 1052, 131),
(152, 1052, 116),
(153, 1052, 125),
(154, 1052, 128),
(155, 1053, 116),
(156, 1053, 110),
(157, 1053, 113),
(158, 1054, 125),
(159, 1054, 130),
(160, 1054, 123),
(161, 1054, 114),
(162, 1055, 124),
(163, 1056, 123),
(164, 1057, 119),
(165, 1058, 110),
(166, 1058, 107),
(167, 1058, 110),
(168, 1059, 114),
(169, 1059, 117),
(170, 1059, 104),
(171, 1059, 120),
(172, 1060, 126),
(173, 1060, 130),
(174, 1060, 114),
(175, 1060, 131),
(176, 1060, 110),
(177, 1061, 122),
(178, 1061, 102),
(179, 1062, 111),
(180, 1063, 130),
(181, 1063, 111),
(182, 1063, 107),
(183, 1063, 102),
(184, 1063, 121),
(185, 1064, 123),
(186, 1064, 126),
(187, 1064, 111),
(188, 1064, 113),
(189, 1065, 128),
(190, 1066, 111),
(191, 1066, 131),
(192, 1066, 112),
(193, 1066, 119),
(194, 1066, 107),
(195, 1067, 111),
(196, 1068, 128),
(197, 1069, 124),
(198, 1069, 122),
(199, 1069, 125),
(200, 1070, 104),
(201, 1070, 101),
(202, 1070, 119),
(203, 1070, 130),
(204, 1070, 117),
(205, 1071, 125),
(206, 1071, 130),
(207, 1071, 129),
(208, 1072, 115),
(209, 1072, 131),
(210, 1072, 105),
(211, 1072, 107),
(212, 1072, 126),
(213, 1073, 109),
(214, 1073, 108),
(215, 1074, 128),
(216, 1074, 124),
(217, 1075, 118),
(218, 1076, 127),
(219, 1076, 118),
(220, 1076, 103),
(221, 1076, 119),
(222, 1076, 101),
(223, 1077, 115),
(224, 1077, 124),
(225, 1077, 109),
(226, 1077, 122),
(227, 1078, 111),
(228, 1078, 124),
(229, 1078, 111),
(230, 1078, 130),
(231, 1079, 115),
(232, 1080, 130),
(233, 1080, 110),
(234, 1081, 111),
(235, 1081, 110),
(236, 1081, 125),
(237, 1082, 113),
(238, 1083, 115),
(239, 1083, 129),
(240, 1083, 126),
(241, 1084, 113),
(242, 1085, 113),
(243, 1085, 111),
(244, 1086, 110),
(245, 1086, 102),
(246, 1086, 116),
(247, 1086, 120),
(248, 1086, 110),
(249, 1087, 121),
(250, 1087, 123),
(251, 1087, 112),
(252, 1088, 126),
(253, 1089, 112),
(254, 1090, 117),
(255, 1090, 120),
(256, 1090, 112),
(257, 1090, 106),
(258, 1090, 123),
(259, 1091, 101),
(260, 1092, 124),
(261, 1092, 129),
(262, 1092, 114),
(263, 1092, 116),
(264, 1093, 108),
(265, 1093, 123),
(266, 1093, 107),
(267, 1093, 108),
(268, 1094, 103),
(269, 1095, 113),
(270, 1095, 114),
(271, 1096, 108),
(272, 1096, 105),
(273, 1096, 128),
(274, 1096, 119),
(275, 1097, 107),
(276, 1097, 115),
(277, 1098, 115),
(278, 1099, 131),
(279, 1099, 128),
(280, 1100, 102),
(281, 1100, 119),
(282, 1100, 106),
(283, 1100, 100),
(284, 1101, 115),
(285, 1101, 104),
(286, 1101, 117),
(287, 1101, 110),
(288, 1101, 107),
(289, 1102, 118),
(290, 1102, 129),
(291, 1102, 101),
(292, 1103, 117),
(293, 1103, 117),
(294, 1103, 124),
(295, 1103, 104),
(296, 1103, 106),
(297, 1104, 108),
(298, 1104, 109),
(299, 1104, 128),
(300, 1104, 127),
(301, 1104, 118),
(302, 1105, 120),
(303, 1105, 109),
(304, 1105, 106),
(305, 1105, 122),
(306, 1105, 115),
(307, 1106, 100),
(308, 1106, 123),
(309, 1106, 105),
(310, 1106, 126),
(311, 1106, 101),
(312, 1107, 113),
(313, 1107, 117),
(314, 1107, 123),
(315, 1108, 117),
(316, 1108, 110),
(317, 1108, 128),
(318, 1109, 107),
(319, 1109, 127),
(320, 1109, 130),
(321, 1110, 128),
(322, 1110, 113),
(323, 1110, 119),
(324, 1111, 118),
(325, 1111, 107),
(326, 1112, 124),
(327, 1112, 124),
(328, 1112, 114),
(329, 1112, 127),
(330, 1112, 107),
(331, 1113, 120),
(332, 1113, 109),
(333, 1113, 127),
(334, 1113, 118),
(335, 1114, 109),
(336, 1114, 124),
(337, 1114, 123),
(338, 1114, 128),
(339, 1115, 127),
(340, 1115, 124),
(341, 1115, 127),
(342, 1116, 100),
(343, 1116, 125),
(344, 1116, 108),
(345, 1116, 118),
(346, 1117, 113),
(347, 1117, 118),
(348, 1117, 116),
(349, 1118, 128),
(350, 1118, 127),
(351, 1119, 106),
(352, 1120, 116),
(353, 1120, 112),
(354, 1120, 119),
(355, 1120, 113),
(356, 1121, 123),
(357, 1121, 103),
(358, 1121, 102),
(359, 1122, 120),
(360, 1122, 127),
(361, 1122, 103),
(362, 1122, 126),
(363, 1122, 109),
(364, 1123, 111),
(365, 1123, 112),
(366, 1124, 112),
(367, 1125, 116),
(368, 1125, 119),
(369, 1125, 113),
(370, 1125, 120),
(371, 1126, 109),
(372, 1126, 112),
(373, 1127, 118),
(374, 1128, 101),
(375, 1128, 116),
(376, 1129, 117),
(377, 1129, 115),
(378, 1129, 100),
(379, 1129, 126),
(380, 1129, 102),
(381, 1130, 120),
(382, 1131, 108),
(383, 1131, 104),
(384, 1132, 118),
(385, 1132, 129),
(386, 1132, 131),
(387, 1132, 104),
(388, 1133, 105),
(389, 1133, 119),
(390, 1133, 110),
(391, 1133, 106),
(392, 1133, 101),
(393, 1134, 111),
(394, 1135, 110),
(395, 1136, 109),
(396, 1136, 115),
(397, 1136, 100),
(398, 1136, 116),
(399, 1136, 128),
(400, 1137, 114),
(401, 1137, 131),
(402, 1137, 100),
(403, 1138, 116),
(404, 1138, 118),
(405, 1138, 109),
(406, 1139, 106),
(407, 1139, 117),
(408, 1139, 121),
(409, 1140, 122),
(410, 1140, 127),
(411, 1140, 124),
(412, 1140, 110),
(413, 1141, 130),
(414, 1141, 107),
(415, 1141, 127),
(416, 1141, 106),
(417, 1142, 127),
(418, 1143, 126),
(419, 1143, 125),
(420, 1143, 118),
(421, 1143, 123),
(422, 1143, 121),
(423, 1144, 120),
(424, 1144, 113),
(425, 1144, 131),
(426, 1145, 123),
(427, 1145, 111),
(428, 1145, 100),
(429, 1145, 121),
(430, 1146, 116),
(431, 1146, 131),
(432, 1146, 130),
(433, 1146, 121),
(434, 1146, 113),
(435, 1147, 108),
(436, 1147, 113),
(437, 1147, 122),
(438, 1147, 110),
(439, 1148, 108),
(440, 1148, 129),
(441, 1148, 120),
(442, 1148, 112),
(443, 1148, 100),
(444, 1149, 102),
(445, 1150, 126),
(446, 1150, 116),
(447, 1150, 113),
(448, 1150, 101),
(449, 1151, 118);

-- --------------------------------------------------------

--
-- Table structure for table `careTeamRequests`
--

CREATE TABLE IF NOT EXISTS `careTeamRequests` (
  `RequestID` int(11) unsigned NOT NULL,
  `CareTeamID` int(11) unsigned NOT NULL,
  `FromFacilityID` int(11) unsigned DEFAULT NULL,
  `ToFacilityID` int(11) unsigned DEFAULT NULL,
  `Status` int(2) DEFAULT NULL,
  `SendTime` int(11) unsigned DEFAULT NULL,
  `ReplyTime` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`RequestID`,`CareTeamID`),
  KEY `FromUser_fk_idx` (`FromFacilityID`),
  KEY `CareTeamID_idx` (`CareTeamID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `careTeams`
--

CREATE TABLE IF NOT EXISTS `careTeams` (
  `CareTeamID` int(11) unsigned NOT NULL,
  `PatientID` int(11) unsigned NOT NULL,
  `OriginalFacilityID` int(11) unsigned NOT NULL,
  `CurrentPhaseID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`CareTeamID`,`PatientID`,`OriginalFacilityID`),
  KEY `CareTeam_ibfk_1` (`OriginalFacilityID`),
  KEY `CareTeam_ibfk_2` (`PatientID`),
  KEY `CurrentPhaseID_idx` (`CurrentPhaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `careTeams`
--

INSERT INTO `careTeams` (`CareTeamID`, `PatientID`, `OriginalFacilityID`, `CurrentPhaseID`) VALUES
(1004, 1004, 110, 1),
(1006, 1006, 103, 1),
(1021, 1021, 128, 1),
(1033, 1033, 109, 1),
(1035, 1035, 115, 1),
(1086, 1086, 107, 1),
(1094, 1094, 114, 1),
(1101, 1001, 118, 1),
(1105, 1079, 124, 1),
(1109, 1014, 115, 1),
(1111, 1061, 109, 1),
(1112, 1010, 127, 1),
(1121, 1054, 108, 1),
(1124, 1040, 101, 1),
(1135, 1094, 114, 1),
(1149, 1005, 101, 1),
(1013, 1013, 101, 2),
(1042, 1042, 107, 2),
(1060, 1060, 121, 2),
(1063, 1063, 116, 2),
(1067, 1067, 123, 2),
(1093, 1093, 127, 2),
(1095, 1095, 116, 2),
(1106, 1051, 114, 2),
(1116, 1075, 124, 2),
(1138, 1019, 122, 2),
(1009, 1009, 129, 3),
(1016, 1016, 111, 3),
(1032, 1032, 126, 3),
(1039, 1039, 114, 3),
(1057, 1057, 127, 3),
(1061, 1061, 110, 3),
(1071, 1071, 112, 3),
(1088, 1088, 111, 3),
(1108, 1054, 110, 3),
(1117, 1067, 119, 3),
(1120, 1096, 118, 3),
(1127, 1067, 120, 3),
(1011, 1011, 118, 4),
(1025, 1025, 102, 4),
(1041, 1041, 115, 4),
(1047, 1047, 117, 4),
(1051, 1051, 121, 4),
(1072, 1072, 110, 4),
(1074, 1074, 107, 4),
(1007, 1007, 128, 5),
(1015, 1015, 126, 5),
(1046, 1046, 114, 5),
(1054, 1054, 113, 5),
(1059, 1059, 125, 5),
(1065, 1065, 124, 5),
(1079, 1079, 103, 5),
(1081, 1081, 125, 5),
(1084, 1084, 111, 5),
(1096, 1096, 129, 5),
(1099, 1099, 109, 5),
(1102, 1098, 106, 5),
(1104, 1091, 104, 5),
(1122, 1056, 113, 5),
(1005, 1005, 113, 6),
(1019, 1019, 114, 6),
(1024, 1024, 124, 6),
(1036, 1036, 120, 6),
(1056, 1056, 129, 6),
(1066, 1066, 123, 6),
(1097, 1097, 114, 6),
(1103, 1064, 101, 6),
(1126, 1072, 112, 6),
(1141, 1091, 116, 6),
(1146, 1064, 128, 6),
(1147, 1074, 117, 6),
(1014, 1014, 109, 7),
(1031, 1031, 102, 7),
(1037, 1037, 103, 7),
(1038, 1038, 111, 7),
(1040, 1040, 103, 7),
(1043, 1043, 100, 7),
(1055, 1055, 129, 7),
(1085, 1085, 119, 7),
(1087, 1087, 123, 7),
(1089, 1089, 116, 7),
(1110, 1037, 112, 7),
(1128, 1032, 108, 7),
(1129, 1006, 118, 7),
(1143, 1005, 120, 7),
(1148, 1074, 124, 7),
(1001, 1001, 109, 8),
(1010, 1010, 113, 8),
(1012, 1012, 114, 8),
(1017, 1017, 103, 8),
(1026, 1026, 105, 8),
(1027, 1027, 118, 8),
(1028, 1028, 110, 8),
(1029, 1029, 123, 8),
(1030, 1030, 106, 8),
(1049, 1049, 110, 8),
(1076, 1076, 113, 8),
(1078, 1078, 118, 8),
(1082, 1082, 114, 8),
(1118, 1098, 119, 8),
(1123, 1026, 127, 8),
(1130, 1004, 100, 8),
(1134, 1032, 105, 8),
(1145, 1088, 118, 8),
(1000, 1000, 102, 9),
(1003, 1003, 123, 9),
(1034, 1034, 102, 9),
(1044, 1044, 123, 9),
(1053, 1053, 129, 9),
(1068, 1068, 111, 9),
(1092, 1092, 115, 9),
(1107, 1009, 114, 9),
(1113, 1077, 114, 9),
(1114, 1005, 121, 9),
(1119, 1096, 118, 9),
(1125, 1048, 102, 9),
(1132, 1096, 112, 9),
(1151, 1065, 117, 9),
(1018, 1018, 104, 10),
(1023, 1023, 115, 10),
(1048, 1048, 117, 10),
(1050, 1050, 119, 10),
(1052, 1052, 110, 10),
(1064, 1064, 124, 10),
(1069, 1069, 126, 10),
(1070, 1070, 105, 10),
(1083, 1083, 115, 10),
(1090, 1090, 114, 10),
(1115, 1034, 109, 10),
(1131, 1062, 110, 10),
(1136, 1053, 112, 10),
(1137, 1051, 107, 10),
(1139, 1070, 116, 10),
(1140, 1094, 125, 10),
(1144, 1038, 101, 10),
(1150, 1039, 106, 10),
(1002, 1002, 110, 11),
(1008, 1008, 126, 11),
(1020, 1020, 128, 11),
(1022, 1022, 128, 11),
(1045, 1045, 108, 11),
(1058, 1058, 118, 11),
(1062, 1062, 116, 11),
(1073, 1073, 112, 11),
(1075, 1075, 109, 11),
(1077, 1077, 105, 11),
(1080, 1080, 118, 11),
(1091, 1091, 118, 11),
(1098, 1098, 101, 11),
(1100, 1100, 111, 11),
(1133, 1044, 105, 11),
(1142, 1084, 112, 11);

-- --------------------------------------------------------

--
-- Table structure for table `errorLogLevels`
--

CREATE TABLE IF NOT EXISTS `errorLogLevels` (
  `Level` varchar(32) NOT NULL,
  `Severity` int(3) NOT NULL,
  `Description` varchar(128) NOT NULL,
  PRIMARY KEY (`Level`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `errorLogs`
--

CREATE TABLE IF NOT EXISTS `errorLogs` (
  `UserID` int(11) unsigned NOT NULL,
  `Timestamp` int(11) unsigned NOT NULL,
  `Action` int(11) unsigned NOT NULL,
  `Level` varchar(32) NOT NULL,
  `SessionID` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UserID`,`Timestamp`),
  KEY `Level` (`Level`),
  KEY `session_id_fk_idx` (`SessionID`),
  KEY `action_fk_idx` (`Action`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facilities`
--

CREATE TABLE IF NOT EXISTS `facilities` (
  `FacilityID` int(11) unsigned NOT NULL,
  `FacilityTypeID` int(11) unsigned NOT NULL,
  `Name` varchar(128) NOT NULL,
  `Address1` varchar(128) NOT NULL,
  `Address2` varchar(128) DEFAULT NULL,
  `ZipCode` int(5) NOT NULL,
  `Phone` varchar(14) NOT NULL,
  `GeoLocation` point DEFAULT NULL,
  `Description` text NOT NULL,
  PRIMARY KEY (`FacilityID`,`FacilityTypeID`),
  KEY `TypeID` (`FacilityTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facilities`
--

INSERT INTO `facilities` (`FacilityID`, `FacilityTypeID`, `Name`, `Address1`, `Address2`, `ZipCode`, `Phone`, `GeoLocation`, `Description`) VALUES
(100, 1, 'Nose, Throat, and Ear Facility of North Texas', '4444 Fake St. Wichita Falls, TX', NULL, 76310, '1235554567', NULL, 'North Texas Facility'),
(101, 1, 'Audiology Center of Dallas', '123 Main St. Dallas, TX', NULL, 75032, '1115556543', NULL, 'Audiology Center of Dallas.'),
(102, 2, 'Manchester Cochlear Implant', '4162 Green Estates, Rancho Cucamonga, Washington', '', 99046, '2530523119', '', 'Some surgeons say new tool is easier to use than a scalpel and safer for patients'),
(103, 3, 'Yorkshire Cochlear Implant Service', '816 Lazy Pike, Chuwut Murk, Georgia', '', 39938, '9128839582', '', 'Today, a growing fraction of the half-million Americans who suffer severe hearing loss are using cochlear implants, a sophisticated and controversial technology that many think is nothing short of a miracle.'),
(104, 6, 'Portland Hospital Cochlear Implant Program', '8503 Crystal Thicket, Govan, New Hampshire', '', 3701, '6031695511', '', 'Cochlear implants provide useful hearing to adults and children who get little or no benefit from a hearing aid.'),
(105, 2, 'Midlands Cochlear Implant Center', '5454 Wishing Drive, Undercliff, Ohio', '', 45399, '5671902018', '', 'Our goal is to provide you the best possible hearing care, based upon your individual needs.'),
(106, 3, 'Scottish Cochlear Implant Program', '9211 Gentle Moor, Sambo, Rhode Island', '', 2808, '4010723719', '', 'All of our Audiometric Evaluations are painless and offer us a better understanding of your hearing loss, including the type, cause and severity.'),
(107, 5, 'Emmeline Center Cambridge', 'Quaking Dale Ridge, Port Hope, Alabama', '', 36656, '3347675211', '', 'We provide a full array of services related to prevention, evaluation, and rehabilitation of hearing impairment.'),
(108, 1, 'NYU Cochlear Implant Center', '4261 Thunder Trace, Caribou, Indiana', '', 46462, '5747784378', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(109, 2, 'Johns Hopkins Medicine', '232 Cozy Elk Thicket, Hellhole Palms, California', '', 94637, '3235143555', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(110, 7, 'OHSU Cochlear Implant program', '4045 Shady Bluff Isle, Rollover, Vermont', '', 5309, '8021710339', '', 'Success with a cochlear implant begins with carefully planned evaluations.'),
(111, 3, 'Otolaryngology Clinic', 'Green Gate Island, Marlboro, Arkansas', '', 72264, '4798459000', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(112, 4, 'Cardiff Adult Cochlear Implant Program', '3154 Golden Private, Tick Ridge, New Mexico', '', 87667, '5050279998', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(113, 4, 'Middlesbrough', '6576 Emerald Robin Drive, Tiger Bluff Landing, Iowa', '', 51698, '6419292927', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(114, 5, 'South by Southwest Cochlear Implants', '7191 Merry Lake Glade, Artichoke Lake, West Virginia', '', 25464, '3043236719', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(115, 2, 'United We Stand Cochlear Implant Facility', '6231 Foggy Downs, Funkstown, North Carolina', '', 28129, '2524846953', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(116, 1, 'Massachusetts Eye and Ear', '7651 Merry Autumn Cove, Cowboys Heaven, Massachusetts', '', 20052, '2023674199', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(117, 4, 'HillCrest Cochlear Implants', '204 Quaking Crest, Chuwut Murk, Georgia', '', 39825, '4705933713', '', 'The HillCrest Cochlear Implants Center attempts to help users develop a meaningful connection to the world of sound. '),
(118, 2, 'US Southwestern Medical Center', '2910 Sleepy Sky Field, Homosassa, New Jersey', '', 7692, '9731171421', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(119, 5, 'The Center For Hearing and Speech', '2725 Noble Bend, Shamrock, Wyoming', '', 82623, '3078807710', '', 'We perform thorough Audiometric Evaluations to gauge your hearing abilities before when even consider hearing aids.'),
(120, 2, 'Childrens Medical Center of Baton Rouge', '5102 Broad Meadow, Prescott, Louisiana', '', 71200, '2255387713', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(121, 2, 'Northeastern Memorial Hospital', '1542 Harvest Wharf, Speedsville, Minnesota', '', 55641, '7631317679', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(122, 6, 'Cochlear Implant Outreach Audiology', '5025 Jagged Mews, Frugality, Delaware', '', 19902, '3021265840', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(123, 4, 'Central Kansas Audiology & Hearing Aid Clinic', '9279 Crystal Heath, Styx, Kansas', '', 66111, '3168364235', '', 'At the Central Kansas Audiology & Hearing Aid Clinic, you will experience a comfortable, non-invasive experience during your audiometric evaluation'),
(124, 7, 'Utah Eye and Ear Infirmary', '8969 Red By-pass, Bland, Utah', '', 84133, '3855939610', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(125, 5, 'National Balance and Dizzy Center', '1789 Blue Bear Canyon, Sylvan Lake, Maryland', '', 21019, '4431876856', '', 'We verify hearing aid functionality with Real Ear Measurement, the gold standard in hearing aid benefit verification.'),
(126, 2, 'Medows Ear Nose and Throat', '4628 Misty Cloud Crossing, Crooks, Maine', '', 4166, '2078393430', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(127, 6, 'Henry Ford Hospital', '5870 Quiet Elk Wood, Fate, Michigan', '', 69658, '4024922710', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(128, 3, 'Boys Town National Research Hospital', '9646 Golden Court, Vanscoy, Tennessee', '', 38107, '9018895134', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(129, 5, 'Crouse Hospital', '6960 Cozy Path, Defiance, New York', '', 11930, '5183740640', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(130, 6, 'Cleveland Clinic', '3988 Red Bluff Lane, Wallstreet, Ohio', '', 57318, '6052875393', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.'),
(131, 2, 'Ahrens Hearing Aid Center', '6516 Gentle Prairie Extension, Gothic, California', '', 90634, '7145499087', '', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.');

-- --------------------------------------------------------

--
-- Table structure for table `facilityTypes`
--

CREATE TABLE IF NOT EXISTS `facilityTypes` (
  `FacilityTypeID` int(11) unsigned NOT NULL,
  `Type` varchar(128) NOT NULL COMMENT 'Short description of a facility.',
  `Description` text NOT NULL COMMENT 'Detailed description of type of facility.',
  PRIMARY KEY (`FacilityTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `menuItems`
--

CREATE TABLE IF NOT EXISTS `menuItems` (
  `MenuID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL DEFAULT '0',
  `Text` varchar(32) DEFAULT NULL,
  `Description` varchar(128) DEFAULT NULL,
  `LinkURI` varchar(128) DEFAULT NULL,
  `Glyphicon` varchar(64) DEFAULT NULL,
  `Order` int(8) DEFAULT NULL,
  `ToolTip` varchar(128) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT NULL,
  `UserLevelID` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`ItemID`),
  KEY `UserLevel_fk_idx` (`UserLevelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menuItems`
--

INSERT INTO `menuItems` (`MenuID`, `ItemID`, `Text`, `Description`, `LinkURI`, `Glyphicon`, `Order`, `ToolTip`, `Active`, `UserLevelID`) VALUES
(1, 1, 'Contact Us', 'Link to direct user to contact page', '#/contactUs', NULL, NULL, 'Contact Us....', NULL, 3),
(1, 2, 'Messages', 'user messages', '#/messages', NULL, NULL, NULL, NULL, 3),
(1, 3, 'Alerts', 'alerts about patients'' care phase', '#/alerts', NULL, NULL, NULL, NULL, 3),
(1, 4, 'Notifications', 'notifications about invitations', '#/notifications', NULL, NULL, NULL, NULL, 2),
(1, 5, 'User', 'Drop down for users', '#', NULL, NULL, NULL, NULL, 3),
(1, 6, 'My Profile', 'user child', '#/myprofile', NULL, NULL, NULL, NULL, 3),
(1, 7, 'Log out', 'user child', '#/logout', NULL, NULL, NULL, NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE IF NOT EXISTS `menus` (
  `MenuID` int(11) unsigned NOT NULL,
  `Type` varchar(32) DEFAULT NULL,
  `Description` text NOT NULL,
  PRIMARY KEY (`MenuID`),
  KEY `type_fk_idx` (`Type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`MenuID`, `Type`, `Description`) VALUES
(1, 'Top Nav Bar', 'Navigation Bar at top of screen'),
(2, 'Sidebar', 'Sidebar menu'),
(3, 'Footer', 'Menu placed at bottom of screen');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `MessageID` int(11) NOT NULL,
  `SenderID` int(11) unsigned NOT NULL,
  `ReceiverID` int(11) unsigned NOT NULL,
  `Subject` varchar(128) DEFAULT NULL,
  `Content` mediumtext NOT NULL,
  `Timestamp` int(11) DEFAULT NULL,
  `Sent` tinyint(1) DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`MessageID`),
  KEY `SenderID_idx` (`SenderID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE IF NOT EXISTS `notifications` (
  `NotificationID` int(11) NOT NULL,
  `CareTeamID` int(11) unsigned NOT NULL,
  `Content` varchar(128) NOT NULL,
  `Timestamp` int(11) unsigned NOT NULL,
  PRIMARY KEY (`NotificationID`),
  KEY `EventAnswersOther_ibfk_1_idx` (`Content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `patient2`
--

CREATE TABLE IF NOT EXISTS `patient2` (
  `patient_id` varchar(11) NOT NULL,
  `fname` varchar(32) NOT NULL,
  `lname` varchar(32) NOT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `patient2`
--

INSERT INTO `patient2` (`patient_id`, `fname`, `lname`) VALUES
('112', 'JAck', 'rowe'),
('12', 'Sarah', 'Jules'),
('123', 'john', 'doe'),
('1235454', 'Yaaaass', 'asdfaa'),
('222', 'boo', 'you'),
('4', 'Mando', 'Garcia'),
('46', 'testing 1 more', 'time'),
('564', 'Sanan', 'Aamir'),
('645', 'Travis', 'Osteen'),
('789', 'Testing aii db', 'yeahhh'),
('7895', 'Yang', 'Yen');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE IF NOT EXISTS `patients` (
  `PatientID` int(11) unsigned NOT NULL,
  `First` varchar(32) NOT NULL,
  `Last` varchar(32) NOT NULL,
  `DOB` int(11) DEFAULT NULL,
  `Sex` varchar(1) NOT NULL,
  `Race` varchar(128) NOT NULL,
  `BMI` float(5,2) NOT NULL,
  `Height` int(4) NOT NULL,
  `Weight` int(4) NOT NULL,
  PRIMARY KEY (`PatientID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`PatientID`, `First`, `Last`, `DOB`, `Sex`, `Race`, `BMI`, `Height`, `Weight`) VALUES
(1000, 'mathew', 'weaver', 16087802, 'm', 'Hispanic', 21.00, 50, 90),
(1001, 'dean', 'cunningham', 74653699, 'm', 'African America', 34.00, 32, 96),
(1002, 'jason', 'myers', 244601289, 'm', 'Hispanic', 21.00, 45, 144),
(1003, 'terrence', 'hoffman', 282827565, 'm', 'White', 20.00, 84, 164),
(1004, 'randall', 'obrien', 251136810, 'm', 'Hispanic', 28.00, 45, 154),
(1005, 'greg', 'burns', 203263767, 'm', 'White', 18.00, 78, 149),
(1006, 'donald', 'bryant', 108594565, 'm', 'Asian', 25.00, 72, 151),
(1007, 'leta', 'long', 103231251, 'f', 'Native American', 33.00, 67, 121),
(1008, 'jeff', 'stone', 14020064, 'm', 'Asian', 23.00, 50, 93),
(1009, 'alice', 'williams', 459918376, 'f', 'Asian', 19.00, 51, 110),
(1010, 'ida', 'bradley', 47734188, 'f', 'African America', 24.00, 82, 68),
(1011, 'nicholas', 'frazier', 390527507, 'm', 'White', 20.00, 81, 158),
(1012, 'clifton', 'frazier', 158793724, 'm', 'Hispanic', 32.00, 49, 63),
(1013, 'carlos', 'bell', 105437445, 'm', 'Hispanic', 24.00, 74, 68),
(1014, 'terrence', 'wells', 220439102, 'm', 'Hispanic', 20.00, 31, 137),
(1015, 'vivan', 'carlson', 196616625, 'f', 'White', 23.00, 65, 65),
(1016, 'curtis', 'sims', 383429737, 'm', 'White', 27.00, 26, 71),
(1017, 'tracey', 'scott', 373367041, 'f', 'Asian', 25.00, 58, 125),
(1018, 'arnold', 'harvey', 218242510, 'm', 'White', 25.00, 30, 64),
(1019, 'brandy', 'sullivan', 74309923, 'f', 'Asian', 28.00, 47, 173),
(1020, 'gail', 'montgomery', 239396912, 'f', 'Native American', 20.00, 72, 132),
(1021, 'tyrone', 'lewis', 166416671, 'm', 'White', 31.00, 66, 112),
(1022, 'travis', 'richards', 380242420, 'm', 'Hispanic', 34.00, 66, 172),
(1023, 'gertrude', 'jimenez', 217037283, 'f', 'Hispanic', 26.00, 80, 134),
(1024, 'katrina', 'adams', 459960650, 'f', 'Native American', 26.00, 57, 140),
(1025, 'rodney', 'hansen', 394915958, 'm', 'Hispanic', 26.00, 80, 110),
(1026, 'nelson', 'jones', 305605408, 'm', 'African America', 25.00, 76, 80),
(1027, 'taylor', 'brewer', 362528948, 'f', 'African America', 34.00, 43, 131),
(1028, 'brayden', 'montgomery', 68508484, 'm', 'African America', 25.00, 29, 145),
(1029, 'judith', 'cunningham', 463710621, 'f', 'White', 35.00, 70, 173),
(1030, 'sonia', 'jensen', 390962676, 'f', 'Asian', 32.00, 59, 79),
(1031, 'connor', 'russell', 338027650, 'm', 'Asian', 21.00, 79, 61),
(1032, 'candice', 'curtis', 223465328, 'f', 'Hispanic', 35.00, 73, 137),
(1033, 'alfred', 'stephens', 304253785, 'm', 'Native American', 27.00, 34, 86),
(1034, 'elmer', 'carter', 113277555, 'm', 'White', 18.00, 83, 90),
(1035, 'carla', 'king', 219100149, 'f', 'African America', 19.00, 30, 160),
(1036, 'jerome', 'may', 450182040, 'm', 'Asian', 29.00, 79, 134),
(1037, 'edgar', 'hoffman', 170877204, 'm', 'Asian', 21.00, 32, 153),
(1038, 'arnold', 'crawford', 464950168, 'm', 'White', 21.00, 63, 102),
(1039, 'tyler', 'alvarez', 352358580, 'm', 'White', 18.00, 78, 103),
(1040, 'jeremy', 'harris', 253012166, 'm', 'White', 19.00, 56, 132),
(1041, 'letitia', 'lambert', 5599863, 'f', 'Hispanic', 19.00, 56, 102),
(1042, 'warren', 'day', 386727451, 'm', 'White', 25.00, 70, 92),
(1043, 'julia', 'boyd', 457244404, 'f', 'Native American', 35.00, 58, 174),
(1044, 'ashley', 'franklin', 492118914, 'f', 'Native American', 30.00, 77, 69),
(1045, 'bob', 'black', 389749097, 'm', 'Hispanic', 34.00, 60, 121),
(1046, 'dennis', 'ellis', 197655949, 'm', 'Hispanic', 19.00, 61, 63),
(1047, 'esther', 'collins', 283877214, 'f', 'Hispanic', 28.00, 73, 100),
(1048, 'carmen', 'knight', 191651291, 'f', 'White', 31.00, 25, 177),
(1049, 'nelson', 'snyder', 297086232, 'm', 'African America', 22.00, 45, 97),
(1050, 'natalie', 'cunningham', 372331165, 'f', 'Hispanic', 27.00, 49, 99),
(1051, 'jessie', 'duncan', 35440243, 'f', 'African America', 20.00, 47, 132),
(1052, 'constance', 'steward', 111184878, 'f', 'Hispanic', 25.00, 82, 142),
(1053, 'hugh', 'gardner', 29355160, 'm', 'Asian', 29.00, 45, 102),
(1054, 'clinton', 'perez', 500288709, 'm', 'Native American', 28.00, 55, 106),
(1055, 'terri', 'chavez', 63795224, 'f', 'African America', 30.00, 68, 147),
(1056, 'brad', 'howard', 26442753, 'm', 'Asian', 29.00, 32, 141),
(1057, 'nicole', 'morgan', 57995331, 'f', 'White', 28.00, 37, 176),
(1058, 'corey', 'ray', 40402352, 'm', 'Asian', 35.00, 68, 74),
(1059, 'kurt', 'campbell', 418705770, 'm', 'African America', 27.00, 38, 171),
(1060, 'norman', 'flores', 409658728, 'm', 'White', 34.00, 79, 66),
(1061, 'terra', 'ross', 429391749, 'f', 'Hispanic', 25.00, 60, 73),
(1062, 'cory', 'bowman', 209708634, 'm', 'White', 28.00, 68, 97),
(1063, 'peyton', 'hunt', 194873590, 'f', 'Hispanic', 22.00, 25, 153),
(1064, 'cherly', 'lee', 61520619, 'f', 'Native American', 20.00, 68, 103),
(1065, 'darrell', 'harrison', 55906650, 'm', 'Native American', 25.00, 58, 86),
(1066, 'lois', 'freeman', 110674687, 'f', 'White', 23.00, 68, 133),
(1067, 'wayne', 'martin', 479877198, 'm', 'African America', 19.00, 26, 121),
(1068, 'emily', 'snyder', 488142601, 'f', 'African America', 31.00, 80, 121),
(1069, 'neil', 'alexander', 424057488, 'm', 'Asian', 34.00, 65, 116),
(1070, 'dan', 'white', 337049474, 'm', 'Asian', 31.00, 54, 63),
(1071, 'june', 'simmmons', 309349070, 'f', 'African America', 26.00, 40, 157),
(1072, 'carla', 'mitchell', 222765455, 'f', 'Native American', 23.00, 78, 180),
(1073, 'mattie', 'howard', 268707206, 'f', 'White', 32.00, 57, 60),
(1074, 'eileen', 'stone', 409732271, 'f', 'Native American', 22.00, 29, 180),
(1075, 'bill', 'henry', 362917830, 'm', 'Native American', 35.00, 32, 65),
(1076, 'elaine', 'garza', 98830341, 'f', 'Hispanic', 30.00, 43, 135),
(1077, 'ted', 'harris', 184781254, 'm', 'Native American', 34.00, 77, 141),
(1078, 'gordon', 'cox', 351665417, 'm', 'African America', 35.00, 71, 107),
(1079, 'michelle', 'james', 280310747, 'f', 'Native American', 25.00, 37, 151),
(1080, 'marcus', 'perkins', 104887878, 'm', 'Hispanic', 31.00, 30, 89),
(1081, 'suzanne', 'harper', 464967913, 'f', 'African America', 26.00, 60, 88),
(1082, 'karl', 'hamilton', 68038932, 'm', 'Asian', 25.00, 64, 75),
(1083, 'jeanne', 'richards', 6179316, 'f', 'Native American', 19.00, 26, 64),
(1084, 'paula', 'ruiz', 144704703, 'f', 'White', 31.00, 25, 74),
(1085, 'kelly', 'freeman', 441485872, 'f', 'Asian', 32.00, 71, 142),
(1086, 'lewis', 'murphy', 70284593, 'm', 'African America', 35.00, 66, 154),
(1087, 'rodney', 'murray', 235355005, 'm', 'Asian', 24.00, 50, 160),
(1088, 'beth', 'franklin', 54256682, 'f', 'African America', 24.00, 65, 62),
(1089, 'regina', 'jacobs', 314354350, 'f', 'Asian', 25.00, 78, 178),
(1090, 'brittany', 'sutton', 449491787, 'f', 'African America', 34.00, 57, 135),
(1091, 'fernando', 'harris', 462983325, 'm', 'Native American', 20.00, 42, 71),
(1092, 'clifford', 'douglas', 158408816, 'm', 'Asian', 31.00, 48, 112),
(1093, 'doris', 'robertson', 244412464, 'f', 'Asian', 23.00, 47, 105),
(1094, 'leah', 'medina', 98877032, 'f', 'Hispanic', 21.00, 50, 112),
(1095, 'arron', 'banks', 363566938, 'm', 'Asian', 26.00, 32, 179),
(1096, 'beth', 'craig', 66233717, 'f', 'White', 26.00, 58, 83),
(1097, 'andrea', 'griffin', 500733333, 'f', 'African America', 20.00, 42, 159),
(1098, 'jeanette', 'moreno', 360502508, 'f', 'Asian', 35.00, 41, 93),
(1099, 'charlene', 'howard', 436312984, 'f', 'Native American', 26.00, 71, 65);

-- --------------------------------------------------------

--
-- Table structure for table `phaseQuestions`
--

CREATE TABLE IF NOT EXISTS `phaseQuestions` (
  `PhaseID` int(11) unsigned NOT NULL,
  `QuestionID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`PhaseID`,`QuestionID`),
  KEY `QuestionID` (`QuestionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phases`
--

CREATE TABLE IF NOT EXISTS `phases` (
  `PhaseID` int(11) unsigned NOT NULL,
  `Name` varchar(128) DEFAULT NULL,
  `Description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`PhaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phases`
--

INSERT INTO `phases` (`PhaseID`, `Name`, `Description`) VALUES
(1, 'Demographics', 'collect demographic information'),
(2, 'Candidacy Testing', 'testing to tell whether someone is a candidate for cochlear implant'),
(3, 'Initial Surgical Consultation', 'Medical Assistant performs Data Entry'),
(4, 'Preoperative Visit', 'data collection before surgery'),
(5, 'One week Postoperative Check', 'One week Postoperative Check'),
(6, 'Activation (3 week)', 'Activation (3 week)'),
(7, '1 Month ', '1 Month '),
(8, '3 Month', '3 Month'),
(9, '6 Month', '6 Month'),
(10, '12 Month', '12 Month'),
(11, '24 Month', '24 Month');

-- --------------------------------------------------------

--
-- Table structure for table `potentialAnswers`
--

CREATE TABLE IF NOT EXISTS `potentialAnswers` (
  `QuestionID` int(11) unsigned NOT NULL,
  `IsNumberRange` tinyint(1) DEFAULT NULL,
  `BeginRange` int(11) DEFAULT NULL,
  `EndRange` int(11) DEFAULT NULL,
  `AnswerText` varchar(128) DEFAULT NULL,
  `Interval` double DEFAULT NULL,
  `Trigger` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`QuestionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
  `QuestionID` int(11) unsigned NOT NULL,
  `AnswerTypeID` int(11) unsigned NOT NULL COMMENT 'Format for answers to be displayed.',
  `QuestionText` text NOT NULL,
  `QuestionHelp` text NOT NULL,
  `Trigger` varchar(128) DEFAULT NULL COMMENT 'If this field is populated it triggers the sub question',
  PRIMARY KEY (`QuestionID`,`AnswerTypeID`),
  KEY `fk_TypeID_idx` (`AnswerTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `questionsChildren`
--

CREATE TABLE IF NOT EXISTS `questionsChildren` (
  `QuestionsId` int(11) unsigned NOT NULL,
  `ChildId` int(11) DEFAULT NULL,
  PRIMARY KEY (`QuestionsId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sessionLogs`
--

CREATE TABLE IF NOT EXISTS `sessionLogs` (
  `SessionID` varchar(40) NOT NULL DEFAULT '0',
  `UserID` int(11) unsigned NOT NULL DEFAULT '0',
  `IpAddress` varchar(45) NOT NULL DEFAULT '0',
  `UserAgent` varchar(120) NOT NULL,
  `LastActivity` int(11) unsigned NOT NULL DEFAULT '0',
  `SessionData` text NOT NULL,
  PRIMARY KEY (`SessionID`,`UserID`),
  KEY `last_activity_idx` (`LastActivity`),
  KEY `user_id_fk_idx` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userLevels`
--

CREATE TABLE IF NOT EXISTS `userLevels` (
  `UserLevelID` int(11) unsigned NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Description` varchar(128) NOT NULL,
  `Level` int(11) unsigned NOT NULL,
  PRIMARY KEY (`UserLevelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userLevels`
--

INSERT INTO `userLevels` (`UserLevelID`, `Name`, `Description`, `Level`) VALUES
(1, 'Coordinator', 'Provides office services by implementing administrative systems, procedures, and policies; monitoring administrative projects; m', 1),
(2, 'Nurse', 'a person who is trained to care for sick or injured people and who usually works in a hospital or doctor''s office', 11),
(3, 'Physician', 'Doctors work to improve the health and well-being of individuals.', 21);

-- --------------------------------------------------------

--
-- Table structure for table `userLoginAttempts`
--

CREATE TABLE IF NOT EXISTS `userLoginAttempts` (
  `id` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `UserID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `FacilityID` int(11) unsigned NOT NULL,
  `UserLevelID` int(11) unsigned NOT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(80) NOT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `TitleID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`UserID`,`FacilityID`,`UserLevelID`),
  KEY `FacilityID` (`FacilityID`),
  KEY `UserLevelID` (`UserLevelID`),
  KEY `Title` (`TitleID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=151 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `FacilityID`, `UserLevelID`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `phone`, `TitleID`) VALUES
(1, 100, 1, '118.100.46.130', 'user1', 'password', 'B61E7C127E45216685E99A9B5AC2AB4DDCBBDCE5', 'uyb@ely.com', 'D1C9C26DA288D87CA622E7CE32E46EC529E2CBC9', NULL, NULL, NULL, 1374177302, 1374177547, 1, 'Jose', 'Beasley', '7498873344', 1),
(2, 100, 11, '91.199.158.21', 'user2', 'password', '904E591A854A9106B74A9AC202368BEEB53327EA', 'gor@trd.com', '004EEEC77D1030BBB322ECEDD76EAB7E48B0AECD', NULL, NULL, NULL, 1380333094, 1380333240, 1, 'Maria', 'Mcgee', '0953737026', 4),
(3, 100, 21, '198.249.174.189', 'user3', 'password', '9320BC54B574E6400D017844AC9CC1B06182D99E', 'fzn@hyo.com', '3B6158B8EED60A293E0A614439C01E0C7BC6228D', NULL, NULL, NULL, 1378549533, 1378550004, 1, 'Bill', 'Levy', '0770572528', 1),
(4, 100, 21, '1.174.63.135', 'user4', 'password', 'A63A4BDCAD219EB3620BBC8411D6150AA61D535C', 'vkt@nwm.com', '442EB1CBEAE65E2765249C560AC25BA35898B117', NULL, NULL, NULL, 1395526113, 1395526566, 1, 'Isaac', 'Gould', '6565869516', 3),
(5, 100, 21, '212.167.17.134', 'user5', 'password', 'D32B74E343E7775EA596725A1A099C7616D44AB5', 'ynb@xsm.com', '8B6A4781AE40C82D7B2C94417E1AEA411A9CE931', NULL, NULL, NULL, 1388995696, 1388995999, 1, 'Harvey', 'Doyle', '8511972860', 3),
(6, 101, 1, '127.239.9.194', 'user6', 'password', '9B071CD3CDDAE4ABEA60E519B37D0AA6106D0978', 'cuo@bte.com', 'B36A0941E9A6B433CE0A70ECEBE50B0D8090C850', NULL, NULL, NULL, 1399187615, 1399187656, 1, 'Henri', 'Parsons', '7856845866', 3),
(7, 101, 21, '250.135.183.127', 'user7', 'password', '6D4E437C08E6685909E3BED08D718D2C33238BCA', 'oks@fvq.com', '51DCCAEDAD06D0D8D70CE2EEE7994E47668DB8EC', NULL, NULL, NULL, 1374647269, 1374647336, 1, 'Rebekah', 'Gates', '7047754640', 1),
(8, 101, 21, '20.104.157.43', 'user8', 'password', '1B54C6981DAA9A4A4CB57AAD0A15CE79ABA3479D', 'voj@rbc.com', '32EB272D0929106D041BD2A70B37AB4E01706B9D', NULL, NULL, NULL, 1388895539, 1388895612, 1, 'Erin', 'Hancock', '5017665248', 2),
(9, 101, 11, '250.253.227.124', 'user9', 'password', '1BD7218C8E752855842EBAE0D44A7EC900AB749D', 'znu@wir.com', '7B33DAC59EDA7D092B897CB750E95AAC7B91A8A2', NULL, NULL, NULL, 1387089827, 1387089827, 1, 'Michelle', 'Watts', '8404746592', 1),
(10, 101, 11, '94.114.254.197', 'user10', 'password', '25B85507EBAC6E83D005C59B4E4EC1A89E6AB3E0', 'qwi@fca.com', 'A387A5111595C379D322189CD738E858761C7D0B', NULL, NULL, NULL, 1394193257, 1394193607, 1, 'Erin', 'Wilkerson', '2519292930', 2),
(11, 102, 1, '115.107.119.173', 'user11', 'password', 'EA58E2D081987A44EE881C2BAE7B6675ECAD89BC', 'bng@zrq.com', '172A86BDCD6AB677DCC8C4C4AECA087D659CAB0A', NULL, NULL, NULL, 1390614577, 1390614958, 1, 'Iris', 'Green', '4119140173', 2),
(12, 102, 11, '240.149.211.170', 'user12', 'password', 'B77B4A4A1D7A5CB2B007ABD9015E09D1E9420A75', 'sxl@ono.com', '2D933D8E8ACCEB42EA1C77948DD2A431EC7CCA9C', NULL, NULL, NULL, 1399757738, 1399757801, 1, 'Sebastien', 'Burks', '1203429502', 2),
(13, 102, 21, '250.147.82.80', 'user13', 'password', 'B850072430EA446C3A22C848ACCC439A9D789D7B', 'ecb@bwc.com', '856A9A9C8377051A316BDB103B6E3009885538D9', NULL, NULL, NULL, 1382357418, 1382357511, 1, 'Kumiko', 'Dillon', '3356621338', 4),
(14, 102, 11, '75.137.31.209', 'user14', 'password', 'DC53B8D84B5B94CC8D7ABA8B27C37A1765867A4A', 'ovd@rej.com', 'A00EBC8A5EA59E356AEEC86E082D4BB6D6431D7E', NULL, NULL, NULL, 1378136386, 1378136571, 1, 'Alex', 'Stafford', '3006010585', 4),
(15, 102, 21, '115.217.51.93', 'user15', 'password', '71033BA9D54C7DE591A717701ECB21064D069327', 'yax@ecu.com', '399673D9CC29DEE65EB9BC148129977630B3E56D', NULL, NULL, NULL, 1388939839, 1388939940, 1, 'Debby', 'Key', '7064567675', 2),
(16, 103, 1, '77.52.150.230', 'user16', 'password', 'DEBE228A03DE1E670D47B6CE0A8B4A9920ED804D', 'oyb@amf.com', 'BEC0D03D4436189B437A9C02D8E80ED1A4840285', NULL, NULL, NULL, 1375178871, 1375179244, 1, 'Tony', 'Farmer', '7980958381', 2),
(17, 103, 11, '131.194.5.67', 'user17', 'password', 'E5230B791739641E180DE45E8E2A539C6C2C27E1', 'zyu@ndj.com', 'EBEBBB96E4EA7C53DC142552BBAE653C34D23864', NULL, NULL, NULL, 1375969532, 1375969862, 1, 'Etsuko', 'Hobbs', '1148123816', 1),
(18, 103, 21, '129.97.50.24', 'user18', 'password', 'D7B52B0891D10310552C415D1AB382B37DD080B1', 'wtz@lzd.com', 'B297C621A33223A7284BD901CBB1245D30183DB9', NULL, NULL, NULL, 1374733943, 1374734045, 1, 'Lili', 'Cannon', '4512954829', 3),
(19, 103, 21, '105.33.19.150', 'user19', 'password', '148642E25CC80DE3494ACE39E421ECCA5547539D', 'bzf@zxb.com', 'E908125EE89EAB43B20512521A30CE0492DAE5E4', NULL, NULL, NULL, 1402378187, 1402378449, 1, 'Stan', 'Walls', '9925857693', 3),
(20, 103, 11, '176.37.24.95', 'user20', 'password', '45847002A916B716A089BEBB4EEDEB6CB4A50325', 'ypt@mwa.com', '84586E0BE4755393C8134D15A71082DABB8E8E4C', NULL, NULL, NULL, 1399874267, 1399874612, 1, 'Hitomi', 'Durham', '3391138190', 2),
(21, 104, 1, '239.152.59.192', 'user21', 'password', 'C980B6EAC905D974D7360A2BE9ADB1944395B021', 'hht@qrf.com', '39B8B1B5BC7012C5058467C7377274288A7D8622', NULL, NULL, NULL, 1398031959, 1398032387, 1, 'Odette', 'Watkins', '9673554673', 3),
(22, 104, 21, '39.167.41.28', 'user22', 'password', 'E7B7B77D387B9280EB90EB1D2D49680695AD7085', 'yxw@pui.com', 'B5CD27CEA57B5C1B1DCCDC013E6B5E07AC39C3D1', NULL, NULL, NULL, 1391817421, 1391817708, 1, 'Otto', 'Crawford', '1123885438', 1),
(23, 104, 11, '46.13.127.167', 'user23', 'password', '0512140E7B8D4B7CCE7DEAC29CAC13A09372420A', 'aur@zwp.com', 'C55089E820BA3883986806D05DB20ADD7164253A', NULL, NULL, NULL, 1376201626, 1376201977, 1, 'Teddy', 'Bradford', '8224522337', 1),
(24, 104, 11, '236.254.76.152', 'user24', 'password', '2C88227D0282ECEC2C317EEB7D72C1211209D2D1', 'elv@vbz.com', 'DD13643ECC4B18D26726A32A5960000189CA99E6', NULL, NULL, NULL, 1384365369, 1384365425, 1, 'Teddy', 'Villarreal', '0048175163', 2),
(25, 104, 21, '105.230.136.244', 'user25', 'password', '1628AC64BB5D02AEA55BE318D4EC4B09C1421C76', 'qry@ypp.com', '837B80BB4DBB5AA2B2CBBE8C2D77C9A5893804A0', NULL, NULL, NULL, 1398434513, 1398434620, 1, 'Omar', 'Patrick', '7819575193', 2),
(26, 105, 1, '61.42.123.152', 'user26', 'password', '2083A55CB5E466A380D3E73156DA03B28D724C31', 'ehl@xfq.com', '7B5597C96E127D2780BE309D92DC91CA917E5A08', NULL, NULL, NULL, 1384265212, 1384265342, 1, 'Philippe', 'Frye', '9476531907', 1),
(27, 105, 11, '60.109.150.171', 'user27', 'password', 'BD8053954B94DDE61D9AC1AC42156BC874189DAA', 'jmz@ydx.com', 'B0B8B0BAE32C90E0892944412B81B2B3294AC37B', NULL, NULL, NULL, 1374835063, 1374835151, 1, 'Paloma', 'Newton', '5198533655', 1),
(28, 105, 21, '161.176.246.101', 'user28', 'password', 'A5E334DE76EDE1B8351DCBAC8722920248E422CD', 'ebx@gma.com', '9B2644647E199D0B56A685E5D0A6ED7EB198CE57', NULL, NULL, NULL, 1393581722, 1393582095, 1, 'Charley', 'Roach', '4805527935', 2),
(29, 105, 11, '140.177.157.156', 'user29', 'password', '9BB09DD54AA4C5255302A079B44E937BE5583E30', 'yem@lpa.com', 'A179C6EC73D9514E2E9468DBA16B6D4D5E9B85B2', NULL, NULL, NULL, 1398318947, 1398319446, 1, 'Kirk', 'Brewer', '9267563678', 1),
(30, 105, 11, '49.122.7.138', 'user30', 'password', 'D0D459C325A9D1368EC5C22BA8255A5B28D09146', 'lyo@asa.com', '4E6EC62C31E4D379108899B8DD49E6A35E831080', NULL, NULL, NULL, 1392447254, 1392447356, 1, 'Karen', 'Rice', '2395124797', 1),
(31, 106, 1, '92.99.144.249', 'user31', 'password', '4438484C353CC995771AD2A0CB3E33D617318D90', 'owa@ftj.com', 'E337BD17E033D72AAEBD2A921B1E12E4A9ED90AC', NULL, NULL, NULL, 1392306649, 1392307082, 1, 'Beryl', 'Carrillo', '9291445015', 2),
(32, 106, 21, '43.71.229.37', 'user32', 'password', 'CB96CB8CC00E06DBCE2ACD5E3DE1A617AD8031A9', 'bmd@nui.com', '931397A51C29114567D123B29034124ACC6720AE', NULL, NULL, NULL, 1376541581, 1376541766, 1, 'Dennis', 'Hamilton', '3645609473', 1),
(33, 106, 11, '2.251.150.46', 'user33', 'password', '31200AE8DC702E83E58D1AAC1B47BDD5A983361D', 'uvz@jmq.com', '887E1BAE86E3C4922A8E144A7C455C9537569124', NULL, NULL, NULL, 1397049652, 1397050144, 1, 'Kazuko', 'Burris', '3399091668', 1),
(34, 106, 21, '162.222.29.144', 'user34', 'password', '916981760456888AEB4C621007408DB4029B3190', 'kal@ulf.com', 'A16ABC5D74C298AC00A0CA07DCCCDDE0B66CAAAE', NULL, NULL, NULL, 1375228949, 1375229253, 1, 'Danielle', 'Thomas', '4112029859', 1),
(35, 106, 21, '19.63.250.226', 'user35', 'password', 'CCC4A1C43E7E8408A8A305ED3DE7AB62035B48BB', 'qkd@nnn.com', '35189DD249D5514E368B835D1DD009D125B341B2', NULL, NULL, NULL, 1382958359, 1382958375, 1, 'Junko', 'Guy', '6408268455', 2),
(36, 107, 1, '170.205.15.148', 'user36', 'password', 'D2938613B35C1121A51C563A5491DE13A6EBC541', 'rld@etc.com', '3760231BBCCAB5C05CC79350B804A505EB4B346A', NULL, NULL, NULL, 1398678163, 1398678610, 1, 'Kumiko', 'Mills', '2972114117', 2),
(37, 107, 11, '128.182.134.45', 'user37', 'password', '03437B644E94261A56A99D5BE5A5A5D2EA6E0978', 'vbv@nkk.com', '36C6ED547EEAB63317BCBEE1397E5E243C003ECA', NULL, NULL, NULL, 1373800751, 1373800861, 1, 'Nana', 'English', '9373600357', 4),
(38, 107, 11, '116.136.38.181', 'user38', 'password', '0BAD22B2017A1A0256E92CA3C642519A639EA0CD', 'qhp@wqo.com', '7B290816BE6A62B250D851DE10740CE2B67D29C1', NULL, NULL, NULL, 1387584833, 1387585301, 1, 'Bill', 'Stevenson', '5576252838', 1),
(39, 107, 21, '76.43.23.137', 'user39', 'password', '7C534B1181BA50A06411BC74E35670082BA4308D', 'ggw@whp.com', '70303BC080EC6B2B526D2C018E76A37E906D1A36', NULL, NULL, NULL, 1387391261, 1387391700, 1, 'Miyuki', 'Mathis', '7238085548', 4),
(40, 107, 11, '222.187.108.152', 'user40', 'password', '63E3D8D6DA563722A6CB3544E3242C7C4523EB22', 'ijk@uwq.com', '87A4955C58A5B09E603D8D44B7DD35235C77C28A', NULL, NULL, NULL, 1382037686, 1382037972, 1, 'Miwa', 'Beach', '0221204648', 3),
(41, 108, 1, '138.96.180.40', 'user41', 'password', '3C27656513864B73275438E10682410C9E1BA2BE', 'ipx@wbe.com', 'D678D2635191884A59B9ACCA2234A5872D7B1BA1', NULL, NULL, NULL, 1381665950, 1381666235, 1, 'Teddy', 'Fisher', '5256645944', 1),
(42, 108, 21, '122.73.230.135', 'user42', 'password', 'B5184014B3BC473B9EA9E69D1704E5D6D2AA59CB', 'xix@poo.com', 'E5AACEDC216EA13416C80B1EE56979907DC2097E', NULL, NULL, NULL, 1392445328, 1392445449, 1, 'Gabielle', 'Mcclain', '4111726937', 2),
(43, 108, 11, '144.61.199.150', 'user43', 'password', 'DD9C4698BDCE0836DC273772CB27945198CE28E5', 'nhp@rgq.com', '70B6DCEA189886B721EEBA745525B1966DD5739D', NULL, NULL, NULL, 1394163402, 1394163529, 1, 'Naoko', 'Leonard', '9868250749', 2),
(44, 108, 21, '155.134.205.112', 'user44', 'password', 'E636646D0C530DEE54E77438DA99B5E9C02CA55B', 'wqo@eus.com', '32D4601850D138981937E95E41D08B318148A561', NULL, NULL, NULL, 1377101111, 1377101395, 1, 'Tony', 'Conley', '6863395930', 4),
(45, 108, 21, '54.116.60.50', 'user45', 'password', '03B7BE288136828857DD58E899572788781CA69A', 'njg@smh.com', 'EE21E3B5EC25D821E5C07DB511A4D5B3A53C27A0', NULL, NULL, NULL, 1398919888, 1398920291, 1, 'Emi', 'Dixon', '1442724449', 3),
(46, 109, 1, '72.146.71.64', 'user46', 'password', '761A47ABC153B45A71C3CD44BE46D407D731118E', 'vry@gep.com', 'B32E2AC9AED6DD1BC4CADDD6E27C769EEE8B2380', NULL, NULL, NULL, 1377417953, 1377417978, 1, 'Ernesto', 'Saunders', '2468516930', 3),
(47, 109, 21, '61.16.228.164', 'user47', 'password', 'A75A86AB437E3C6430054E7ECAC911AC1830785E', 'dny@qrz.com', 'DAC6ECE16C3A1DA107A309BB14633E8DC9D7AB2E', NULL, NULL, NULL, 1394882798, 1394882862, 1, 'Miyuki', 'Cox', '2488530752', 3),
(48, 109, 11, '126.146.28.8', 'user48', 'password', 'B4713A9A2ABC322A67CA2B390057BC1E3EE1C677', 'svo@mth.com', '4CC549DCBA00916590E18BCEE362E3161441398E', NULL, NULL, NULL, 1386495628, 1386495828, 1, 'Allison', 'Valenzuela', '1605512008', 1),
(49, 109, 21, '78.92.142.211', 'user49', 'password', '9C9EE9C8B7EC9289726B91B3EDB2BAA75D48A431', 'rrw@adz.com', '0BC3DCCDA68EE4BD11C2AD5581CE37BD9C43EBA2', NULL, NULL, NULL, 1387940197, 1387940255, 1, 'Rebekah', 'Chen', '6623398370', 4),
(50, 109, 21, '91.85.33.241', 'user50', 'password', '0C300408AA497C80DA64D12ADAAA533EA7ED1CA3', 'zls@oit.com', 'D5365BD064B1D11A399001D24516B56784650590', NULL, NULL, NULL, 1372983125, 1372983591, 1, 'Ayumi', 'Andrews', '9418769754', 3),
(51, 110, 1, '91.141.133.9', 'user51', 'password', '40C848C90601785A1527968880DBBE3D27D0B606', 'rnj@tja.com', '5A726EAE0122EE4C2CE4153D95A626B99371A7D5', NULL, NULL, NULL, 1384738068, 1384738453, 1, 'Sally', 'Smith', '0626938594', 2),
(52, 110, 21, '10.197.176.65', 'user52', 'password', 'E177574C8EA31CD2626CC0223ED0878977BB97C2', 'lgm@esb.com', '8E72E3641132E8910AE2134B6CD01C6707E8C9A0', NULL, NULL, NULL, 1397635184, 1397635219, 1, 'Harvey', 'Burgess', '6201860437', 3),
(53, 110, 11, '40.4.201.156', 'user53', 'password', 'DAC54D3EE40037911D1A3C1689E22826614609E4', 'dco@lpa.com', 'D126BA70C28021329B72D33BB8B0712D4C243E08', NULL, NULL, NULL, 1373619699, 1373620122, 1, 'Charley', 'Landry', '6890232442', 3),
(54, 110, 11, '246.231.71.33', 'user54', 'password', '9C2BA6AD35E3A00D62A4E94859B409779C18A4CB', 'ugl@xcu.com', '521A7A5B93849BEEA15E0C87D821DD962A262549', NULL, NULL, NULL, 1393013525, 1393013629, 1, 'Virginie', 'Fischer', '8847427655', 2),
(55, 110, 11, '63.19.244.247', 'user55', 'password', '8DCC1ED6696A55291AB88EB8E84CE5088EC85968', 'gxc@wqe.com', '6665AAEC40A41C73B97898AB887334E7E76384EE', NULL, NULL, NULL, 1374445992, 1374446169, 1, 'Lili', 'Goff', '0370189721', 2),
(56, 111, 1, '188.11.69.92', 'user56', 'password', 'A4D61071927D9AB6A71DB390EE1977A7D523C6C5', 'fti@sib.com', 'E4BD3237C3943505D7D3203ADC6A4105E466459C', NULL, NULL, NULL, 1383646937, 1383647181, 1, 'Richard', 'Franco', '9796632346', 1),
(57, 111, 21, '35.78.214.78', 'user57', 'password', '936A60924B6D4531A7319206B2861428CC0ADA27', 'wwy@dms.com', '58A26A65811A4CC315629ABE058A22EB2968593A', NULL, NULL, NULL, 1389046737, 1389047138, 1, 'Miharu', 'Reese', '2329596696', 1),
(58, 111, 21, '128.208.98.196', 'user58', 'password', '4ED55BA0CC30B89CADE303B9E08E7892DE13D978', 'smg@smu.com', 'A54A79B8D73426D9085CACAE1418B80A9247D17B', NULL, NULL, NULL, 1400350012, 1400350360, 1, 'Emi', 'Tucker', '6549142539', 1),
(59, 111, 21, '236.37.36.145', 'user59', 'password', '48ED5E48214BECD764B6512A022988248D79C4E5', 'for@caf.com', '07475459E3902B6D748CB5EAA0C5955C7A53A8EB', NULL, NULL, NULL, 1382177328, 1382177406, 1, 'Gordon', 'Griffith', '4519836452', 2),
(60, 111, 11, '9.30.23.2', 'user60', 'password', 'B61D23941275D80BA27744BA857812AD1A83D95D', 'zcu@jyy.com', '92290C4C4C00D0698E486B7BBB5D0515912DEC5D', NULL, NULL, NULL, 1399766406, 1399766886, 1, 'Michelle', 'Waller', '1111374245', 3),
(61, 112, 1, '205.9.129.35', 'user61', 'password', '10A4A99B83145D19D4A3E36576AA11AE7C02A806', 'gbu@ttc.com', '6BE4082544BBD43B6199CBD2CCE15C4051898D3E', NULL, NULL, NULL, 1400610997, 1400611109, 1, 'Isabel', 'Edwards', '3974874139', 2),
(62, 112, 11, '159.146.100.125', 'user62', 'password', '9B6409A3CE44A5EA6E459BB47E7782CC977DB563', 'pew@icp.com', '2B60308A093ADCAD82EA65EEC49EA17ED3B69B2E', NULL, NULL, NULL, 1395311353, 1395311443, 1, 'Michelle', 'Mcdowell', '6561917169', 3),
(63, 112, 11, '233.22.248.146', 'user63', 'password', '55E3E1B652DAA584184268C65DED84127D14DB39', 'exl@joq.com', '236E65664AB864296DB62E3DE0A1BD89A44A8B84', NULL, NULL, NULL, 1392214197, 1392214455, 1, 'Gaston', 'Snider', '1894651540', 1),
(64, 112, 21, '53.222.49.131', 'user64', 'password', '0D47A075AE131A78B3226AAB532781D7691E2494', 'wih@wgk.com', 'EAB63C0AB3B4586BB73A81D03138874332367B7D', NULL, NULL, NULL, 1379741784, 1379742061, 1, 'Miwa', 'Blanchard', '8245524678', 4),
(65, 112, 21, '79.161.8.168', 'user65', 'password', '9B5EEC38ECE4408D41E93D6A9D7A5594A2D88B67', 'lxi@amw.com', '6A5B295B52B8EAD9E243D626633672205BA2811A', NULL, NULL, NULL, 1373294189, 1373294345, 1, 'Humberto', 'Weaver', '1583366668', 4),
(66, 113, 1, '157.99.167.198', 'user66', 'password', '37B03A61DEBB7C4102B7CA43D40AEBCDA49BCDC8', 'qas@rqn.com', 'E06A6764E1839C159EB894A55E8405CC533135D4', NULL, NULL, NULL, 1397719932, 1397719935, 1, 'Stan', 'Tran', '2625857179', 2),
(67, 113, 21, '58.55.105.52', 'user67', 'password', '27E7ACB1C5D4C66A3DB8B09167D466B87B4948AC', 'pki@mmx.com', '238590A37E4B5113D583183EDC05EB1129219E92', NULL, NULL, NULL, 1395326762, 1395326816, 1, 'Danny', 'Carr', '3689619742', 3),
(68, 113, 11, '161.61.182.216', 'user68', 'password', 'B5D400EECA72A69821E3C377BC1DE8755905B371', 'mzb@tsc.com', 'DC02A1C26867D7B89D20730EDBCD31A7B387C3B5', NULL, NULL, NULL, 1376898871, 1376899054, 1, 'Leslie', 'Harrington', '1200035831', 4),
(69, 113, 21, '110.137.64.100', 'user69', 'password', '31EBC1AA7519D7DB2513D1C22E5666D4A3A45A57', 'tid@fsp.com', '61583282D00028A4BBC5EBBB62BCACC4D401A8DE', NULL, NULL, NULL, 1397380940, 1397381219, 1, 'Fay', 'Browning', '6720813399', 2),
(70, 113, 21, '72.69.156.100', 'user70', 'password', '7A857E0477E2DDAE48DA029B4039EC725168C522', 'ndm@yxg.com', 'CD49E810B1D521E1388697AD5A3411BEB7A589C4', NULL, NULL, NULL, 1392278721, 1392279106, 1, 'Naoko', 'Koch', '7049577108', 4),
(71, 114, 1, '122.54.175.153', 'user71', 'password', '46EDAEAC3C56BC728D93179A1D16850686E0E06E', 'qga@jck.com', '409CBB4CBA927C6ADD4AD8CB8408BA31EC578E81', NULL, NULL, NULL, 1386530297, 1386530478, 1, 'Paula', 'Benjamin', '1939143580', 2),
(72, 114, 21, '192.37.85.6', 'user72', 'password', 'D46209D1114CC5D6042D142D1C8C81994C7C6C14', 'ohn@bli.com', 'E2D2478C44ECAE0184CE06E6A1E3EEC338D833D5', NULL, NULL, NULL, 1396157871, 1396158197, 1, 'Arlene', 'Osborn', '2407212155', 2),
(73, 114, 11, '93.190.132.171', 'user73', 'password', 'D4399BBD81873D7DCC63A8AAC06A403B995D83D3', 'qqu@dqh.com', '003896E596D26CE2AD0492C865D8851E3D85A31E', NULL, NULL, NULL, 1373033203, 1373033648, 1, 'Lili', 'Peterson', '3749035856', 4),
(74, 114, 11, '130.228.159.183', 'user74', 'password', '0724BD1873CB766B356AE3D497808BA8CBC47B3E', 'ujs@elo.com', '4A695BCEBD757C0D21E7562BA0A65970A35475C0', NULL, NULL, NULL, 1395989338, 1395989604, 1, 'Chris', 'Willis', '5143998930', 3),
(75, 114, 11, '15.234.105.61', 'user75', 'password', 'E16E2EBD4700D2E7C8DD689A179868C2E5678559', 'blg@xvy.com', 'E01C3936CDE76A479EB56EA10E541715A680A976', NULL, NULL, NULL, 1375141312, 1375141466, 1, 'Nana', 'Mcclain', '3441322938', 1),
(76, 115, 1, '158.226.233.210', 'user76', 'password', '6AB8EEC1070000C885915C41D9DCADE2634AD3AD', 'ujk@bas.com', '8D21D274D9B4CD8CE04AAA24AD1C943A1BB4072A', NULL, NULL, NULL, 1383867474, 1383867681, 1, 'Tony', 'Morrison', '2946953277', 4),
(77, 115, 11, '139.221.62.123', 'user77', 'password', '1DC9736830AC074432E7D4B42BE209519909D657', 'zpy@tvw.com', '14347D77B9CE866B730CC8B7363ADE427E21422B', NULL, NULL, NULL, 1385699188, 1385699224, 1, 'Chris', 'Barr', '8036145262', 1),
(78, 115, 11, '123.71.141.94', 'user78', 'password', '86E23B134E7D47709870DAAE0184E071007683BE', 'gxz@vzq.com', 'C141DA4C368EECD8607CADA6A862331EE5CCC386', NULL, NULL, NULL, 1401856216, 1401856321, 1, 'Nanaho', 'Herring', '5114875876', 3),
(79, 115, 21, '226.21.109.225', 'user79', 'password', 'A53E5DB3AEE646B7134B9AB1C9D1C21CD1002C0E', 'irk@oqd.com', 'E0A9B74289935DEEE0B3A5B4726BCBC2BB97BA78', NULL, NULL, NULL, 1401560561, 1401560877, 1, 'Yumi', 'Morrison', '6005487016', 4),
(80, 115, 21, '196.210.251.206', 'user80', 'password', '54128108334CD365A4D524429BBB035C41D7DD95', 'qfu@eed.com', '88991D85172354B83BA9E4C6A82175B2E925C6CE', NULL, NULL, NULL, 1402278993, 1402279155, 1, 'Tanya', 'Bush', '3388111068', 3),
(81, 116, 1, '14.2.145.140', 'user81', 'password', '6836A6789E31593376E29165398E8760A7A15E34', 'ymt@qmt.com', '7AB9671B4536774558ECB939EE91911C836D4B03', NULL, NULL, NULL, 1387350813, 1387350908, 1, 'Katrina', 'Acosta', '1691121642', 2),
(82, 116, 11, '159.11.159.182', 'user82', 'password', '98ACB1B04AE741CD8358E842651D1A5DCA6A12CB', 'cdg@ckz.com', 'DD277DB0642C89AB5B4CCAAE1B4968DC68CCD3A4', NULL, NULL, NULL, 1385241741, 1385241910, 1, 'Tony', 'Hart', '1913738052', 3),
(83, 116, 11, '239.51.133.225', 'user83', 'password', '9D095279005E14B7859E1D8CC9E7466B5D0CA5E9', 'iay@oql.com', '461089D50220AA17EE61A03DD1A99CEC035792AB', NULL, NULL, NULL, 1385527766, 1385528165, 1, 'Richard', 'Beard', '3598008920', 4),
(84, 116, 11, '50.81.251.176', 'user84', 'password', '614C0B844A14CC821D83B50B804A5BE04AB2D817', 'kjp@lcj.com', '7A368E904C90842D143B5232869486A8B5C1CA81', NULL, NULL, NULL, 1377036587, 1377037009, 1, 'Wilma', 'Baldwin', '7975790488', 3),
(85, 116, 11, '103.231.75.78', 'user85', 'password', 'EDD7D79A2ECE7749E1AC945DB7EC3C4D2CB77419', 'hrn@ead.com', '5C1433239D9D586B9DE4D8B2CEBBEDCA1068C81B', NULL, NULL, NULL, 1374564447, 1374564560, 1, 'Lisa', 'Rutledge', '1000874743', 4),
(86, 117, 1, '88.12.154.219', 'user86', 'password', '7E0A715A56BE498AAA2621E00041D0EE6E6676A3', 'lgc@ucy.com', 'C25CAD1BE6A749C921A31217CA1EA8AD84BE86C6', NULL, NULL, NULL, 1377285053, 1377285215, 1, 'Bonnie', 'Lewis', '0580819480', 4),
(87, 117, 11, '208.224.16.98', 'user87', 'password', '3D29DDAD1C6784C275098265DA4E8BA59B31B3E3', 'ztr@rsg.com', 'D3A47611B0D6D62DEE9EBAC81AEC8BB3B99CDCCB', NULL, NULL, NULL, 1390242841, 1390242897, 1, 'Wilfred', 'Rojas', '8716717769', 3),
(88, 117, 11, '13.14.17.101', 'user88', 'password', '6AA0A1ECE7682B29C754DAC5CCAAB22A154B3073', 'umv@ood.com', '3B00A3D613E859A9D717980ECDDBAC55C5503CB5', NULL, NULL, NULL, 1373020684, 1373020918, 1, 'Kate', 'Sharp', '9317348031', 3),
(89, 117, 21, '19.7.15.143', 'user89', 'password', '95931559EC899A6AB53C5194B9C4EED711CD3D0A', 'ylw@qie.com', 'CABB9C9BD029EC515620AE5A00E03E55C38B9A18', NULL, NULL, NULL, 1391935876, 1391936287, 1, 'Vince', 'Everett', '7681458918', 1),
(90, 117, 21, '16.127.200.149', 'user90', 'password', '462354DE7A739A94D136D6A28D24BEE19A883971', 'kpv@jsn.com', '0892E1B46C91A8CCE5BC08594BD7B7023E4AAC8C', NULL, NULL, NULL, 1399157760, 1399158153, 1, 'Arlene', 'Brooks', '3303307824', 2),
(91, 118, 1, '71.205.217.84', 'user91', 'password', '8D3A996CCBEDEDAD0EE404002AB8A0820BD1BEB8', 'qvt@zvm.com', 'E174ED4BADCDED2C48ECA454489B6A7E12A8E32D', NULL, NULL, NULL, 1373471390, 1373471402, 1, 'Dennis', 'Bridges', '2124124490', 2),
(92, 118, 11, '241.78.66.44', 'user92', 'password', '0C9C479A463CBB6D7B23412BEC85BD8004C045C1', 'ffb@wle.com', '4793569E12AE594C71992676AD8A020AA0A3A233', NULL, NULL, NULL, 1375666172, 1375666259, 1, 'Lili', 'Doyle', '7415910120', 1),
(93, 118, 21, '208.243.253.148', 'user93', 'password', 'AE283EBE752516B99719488D18BC167B71405A87', 'ugp@vdq.com', '9DE22BC2C9091208646958BE79DE870E6869D1E9', NULL, NULL, NULL, 1382522099, 1382522371, 1, 'Hanna', 'Mcintosh', '0945668531', 1),
(94, 118, 21, '93.69.34.251', 'user94', 'password', '49B544394B327817EC5A938B4721D7EBD11A2587', 'zxi@jgq.com', '395901A2653B7B170519A71EAA469E2E68D34B54', NULL, NULL, NULL, 1398916036, 1398916240, 1, 'Rie', 'Olsen', '0498367272', 3),
(95, 118, 21, '55.170.25.155', 'user95', 'password', 'E13D50777344E81E9481C9279ACC439276B209C8', 'xsj@zaz.com', 'E4C699A19B71C6B974157C3BAD975B5E2B35A33B', NULL, NULL, NULL, 1402344481, 1402344797, 1, 'Fay', 'Todd', '0606065569', 2),
(96, 119, 1, '118.172.51.76', 'user96', 'password', 'CD1406C701AE7D32470D32060EBC93593EE7DA9C', 'tmx@vnh.com', '2E8B0B3B9D85CD12D1DD39DAA04517E47DBADACA', NULL, NULL, NULL, 1380310944, 1380311185, 1, 'Harvey', 'Nolan', '9876393853', 1),
(97, 119, 21, '134.30.202.83', 'user97', 'password', 'C24DA5D447B4CC98BA60CEE0EBE434BA03021C74', 'bhw@wdk.com', '3097A9CC4D13A020904766BB1E6D76E2C03A35CC', NULL, NULL, NULL, 1399718253, 1399718389, 1, 'Stan', 'Jennings', '9415159232', 3),
(98, 119, 21, '112.141.228.223', 'user98', 'password', '6E153E31466EEB31362D44EA712E70A7B619B7EB', 'sjx@fzh.com', '9C23D8CC413EE0B8197A034BEA0D4DD58A73C22C', NULL, NULL, NULL, 1375491861, 1375492006, 1, 'Hitomi', 'Chase', '9692121787', 1),
(99, 119, 11, '177.65.4.252', 'user99', 'password', '6C56C356130DBDC7A116291B945B493B956CB51C', 'njr@tvc.com', '4AC76B14C5D08BE1E032D8763E5B169DC9007EAC', NULL, NULL, NULL, 1385097284, 1385097727, 1, 'Mindy', 'Cook', '3281773084', 4),
(100, 119, 11, '60.184.39.163', 'user100', 'password', 'CAA8D04612C678DC579CE9474232A02C72A4E496', 'zyz@qzu.com', '5A402823490A51E0E53038ED2E9C4DAB587ED4C7', NULL, NULL, NULL, 1383717239, 1383717622, 1, 'Emi', 'Reynolds', '9672215331', 1),
(101, 120, 1, '79.4.227.144', 'user101', 'password', '08A39CB00DD56E80C44A7DB481B694502D43BBAA', 'cov@dvk.com', '7928D78C676C15084943C0224C2D3196A9BE509B', NULL, NULL, NULL, 1392258497, 1392258650, 1, 'Kumiko', 'Hunter', '1669713863', 2),
(102, 120, 11, '210.9.233.207', 'user102', 'password', 'A94C6E9283D8ADA4E12A3078CB96285850994E2C', 'iis@cir.com', '6983EE6B81DDEEE7201BE3A27B25DA376881AAA4', NULL, NULL, NULL, 1374800393, 1374800862, 1, 'Vince', 'Wiggins', '9188013050', 3),
(103, 120, 21, '66.148.86.160', 'user103', 'password', '5EBABC433462DDB49072B9DBE218DB79A91E6951', 'lgi@btn.com', '5A7CD44ADCC2891E7BE0D1B9E902EC5D41AA1C34', NULL, NULL, NULL, 1375611278, 1375611338, 1, 'Ayumi', 'Moon', '7336084518', 4),
(104, 120, 11, '166.219.4.119', 'user104', 'password', '50280E7A954E01E3A7E4AE7A769BC1E2E8E8C803', 'aco@rou.com', 'B624BDDC885E5AD61A0549C39DEBC2BA9B94533A', NULL, NULL, NULL, 1391801050, 1391801155, 1, 'Tony', 'Hensley', '3694330213', 3),
(105, 120, 21, '36.202.164.83', 'user105', 'password', '50CA0ABB6AA184923210DB4E061756BAD4B7D5A5', 'lde@dug.com', 'A4A5198B1D1BA4B7B0086316B1AD971ECDA0C20B', NULL, NULL, NULL, 1383249199, 1383249650, 1, 'Fabian', 'Cruz', '8549628257', 3),
(106, 121, 1, '46.13.39.63', 'user106', 'password', 'CEB05A4A4B35228CAA8E3E3875D9E769C769BA95', 'rxq@int.com', '5CC51E3C4A26366A711C242CE32865A5C788231D', NULL, NULL, NULL, 1387578092, 1387578460, 1, 'Wilfred', 'Pate', '7780295854', 4),
(107, 121, 21, '14.153.192.98', 'user107', 'password', '144A599476A1BAA7BA3102982155ACC510BCB977', 'jxi@eoh.com', 'D43EED7107D8AB49D4AA59A796D8CCC27DA035A7', NULL, NULL, NULL, 1398360358, 1398360730, 1, 'Cindy', 'Sherman', '7568286618', 1),
(108, 121, 11, '38.221.251.143', 'user108', 'password', '1B10A42819264767D5599723117D01A0B72A97DC', 'ryx@uig.com', 'DB88DA0D072DBD42948C6C6B52E53E161219D284', NULL, NULL, NULL, 1394249113, 1394249428, 1, 'Iris', 'Joyner', '2608049180', 3),
(109, 121, 21, '108.21.75.144', 'user109', 'password', '506E616B4984D682A11D6D64B232B73E80A39813', 'dvo@hzy.com', 'C38EEC373A240E45312C06EB896D24BAD6E5DAB2', NULL, NULL, NULL, 1402087347, 1402087604, 1, 'Itoe', 'Kaufman', '8479674097', 2),
(110, 121, 11, '19.211.234.28', 'user110', 'password', '7873D8253874A037AE578720583741911E231CCB', 'sua@wxn.com', 'A5933B08A898BC44492BCC21B60CEE5C88CD541B', NULL, NULL, NULL, 1399713438, 1399713575, 1, 'Rene', 'Weeks', '2861297892', 2),
(111, 122, 1, '247.103.73.157', 'user111', 'password', 'E94666C9149767399711B108D7B040DA7B5873A3', 'fpf@pdd.com', 'E5143A1ED2286957BA95D2D7E791C39B4CA3A476', NULL, NULL, NULL, 1373127582, 1373127839, 1, 'Danielle', 'Montoya', '3984349545', 3),
(112, 122, 11, '141.41.15.115', 'user112', 'password', 'A270674D13A55EC7204E3933D8AB15C929611CCB', 'oei@xww.com', '735C8D325740BDB88398A144AE1740D904C2082E', NULL, NULL, NULL, 1383164451, 1383164779, 1, 'Jeanne', 'Edwards', '4557765197', 3),
(113, 122, 21, '209.85.185.150', 'user113', 'password', 'E7957407C0D09E631DA6D34CD97AA617183662A2', 'cre@uii.com', 'B4AA3326C0396DA72319986A8260DB32D576DA60', NULL, NULL, NULL, 1396754960, 1396755027, 1, 'Rene', 'Morales', '2874047709', 1),
(114, 122, 21, '21.205.178.26', 'user114', 'password', '671945B5D37C7E2EE03D43A4CBE973DE70AE0CE6', 'ztr@fvt.com', '8C07A46DA63276B04B3AC43D15B4224A94E57687', NULL, NULL, NULL, 1396803112, 1396803294, 1, 'Bret', 'Meyers', '4142112790', 3),
(115, 122, 21, '140.234.113.164', 'user115', 'password', '7C2A518C551E579E8599C7EB31354BABC792B49C', 'pmw@sxk.com', 'D518734A4A52BBCB1244C3D183569EC70EB799C4', NULL, NULL, NULL, 1392823805, 1392823980, 1, 'Kumiko', 'Puckett', '3865092317', 2),
(116, 123, 1, '52.52.89.179', 'user116', 'password', '12D4C400A75BC5EA5BE161C08CC9EA4A0B9D46E2', 'sxw@dzv.com', 'CCA9A7613E8E3576B920BB50EE23571028699C85', NULL, NULL, NULL, 1397705487, 1397705935, 1, 'Shary', 'Wilkins', '7090544051', 4),
(117, 123, 11, '81.36.74.209', 'user117', 'password', '2802D87C9448A281C210ACAB30BD26C57719CC30', 'mnf@bpy.com', '804317242D873CD4CC4C5D7681706D1C86CED432', NULL, NULL, NULL, 1386817285, 1386817338, 1, 'Earl', 'Keller', '0880719008', 4),
(118, 123, 11, '150.106.112.176', 'user118', 'password', 'D99CE28A039C13B69ED39CD7BB3B352CDC77DE87', 'kqg@hdq.com', '09B144040CC787B83D8016A0B3D4759831A0773C', NULL, NULL, NULL, 1395932518, 1395932715, 1, 'Chantal', 'Haynes', '7752157895', 1),
(119, 123, 11, '127.147.175.136', 'user119', 'password', '231DE439C15C9283A3DA6E87ACEE1BB7BE5AB4B3', 'jmm@qub.com', '62AB16854AA534BB8B9496CC28A8C43C9BE6D305', NULL, NULL, NULL, 1382001091, 1382001484, 1, 'Larry', 'Mills', '2122035230', 4),
(120, 123, 11, '162.209.13.249', 'user120', 'password', 'E3BEEA837BE755B5D1E810A0CEA7CE6AE42C850D', 'jgs@qof.com', '5D4C5A25D465B90A00C9947A1A96017C35E574C9', NULL, NULL, NULL, 1385080913, 1385081193, 1, 'Nicholas', 'Osborn', '8660812415', 2),
(121, 124, 1, '74.244.22.197', 'user121', 'password', 'B25B4C2707ACE26846B24119305CC83882AB35E7', 'jrm@vpa.com', '4A03EC2C245827C42E31D030D462D177ED13BE6C', NULL, NULL, NULL, 1393792629, 1393792985, 1, 'Bret', 'Mullen', '8217532630', 2),
(122, 124, 21, '97.35.233.21', 'user122', 'password', 'AA3BBBD9C779CE80CC99D93EBDCB0AEEA05D5D85', 'ozu@bun.com', '8874EC0E919D0973E8154B6277C9CE5067BB8694', NULL, NULL, NULL, 1377389062, 1377389455, 1, 'Bill', 'Patterson', '6712562839', 1),
(123, 124, 21, '219.41.121.141', 'user123', 'password', 'E904B6D58CE662826D0089E882DD85CAB1D77D94', 'hmi@elo.com', '2213609021B23D8D6E3670B692A435DE67362334', NULL, NULL, NULL, 1392625417, 1392625474, 1, 'Isidore', 'Hunt', '8721317108', 3),
(124, 124, 11, '156.251.129.153', 'user124', 'password', '32BED41E2900B6EEB24A77AD527DD3991031E608', 'qby@drg.com', '0E348DBA0D9938E296BE0E035595BE5EE384CB61', NULL, NULL, NULL, 1392315316, 1392315568, 1, 'Chantal', 'Stephens', '1531924497', 2),
(125, 124, 21, '224.103.159.244', 'user125', 'password', '18935A767E6D06E4EDDADEA07D9B447E28A817B2', 'nyr@otz.com', 'CA9E426792A611D3198D5A4A0EE8B85C75B8D75C', NULL, NULL, NULL, 1396416931, 1396417380, 1, 'Michiyo', 'Sears', '0355074051', 2),
(126, 125, 1, '136.30.213.194', 'user126', 'password', 'E12AB1D1ABC3A5AD5C4E3319620108BCA7127273', 'vnf@rwj.com', 'EAA0E0865D3A704456CBDA5401AE30AD2DEB1ED6', NULL, NULL, NULL, 1402912678, 1402912878, 1, 'Chantal', 'Davidson', '1691187758', 3),
(127, 125, 21, '48.111.82.27', 'user127', 'password', 'B773BB86CA386D285BAAA67624A6E09154AE953D', 'msg@cmj.com', '19AD8ABD69A498ED0DD2845D39BEAD4CC850995D', NULL, NULL, NULL, 1382029982, 1382030373, 1, 'Erin', 'Gilbert', '7432403612', 3),
(128, 125, 11, '145.205.94.99', 'user128', 'password', '8BC12B05E1976A160033380A33A6EAA7E8647DAE', 'bsd@agt.com', '51C85235C5D867D2E69D87C9CB57DE6BBB77B03B', NULL, NULL, NULL, 1401160897, 1401161194, 1, 'Sachiko', 'Hood', '9410280502', 4),
(129, 125, 11, '113.128.238.224', 'user129', 'password', '4453ACE2DE7A0A8DB81967CDC30D2AEAE0ED66B9', 'yyg@kzn.com', 'D2CE55CB96423AC4CC8AA8610B1CA3BEC5E9D21D', NULL, NULL, NULL, 1402193282, 1402193383, 1, 'Gaston', 'Goff', '6562149124', 2),
(130, 125, 21, '250.251.52.227', 'user130', 'password', '1B178688D07B8C9DBD0251AB1CBD2C60BCAA06D3', 'vaa@ufo.com', '6416D1E0C690193BEEEBCBBA402B4D6180DABE89', NULL, NULL, NULL, 1384257508, 1384257609, 1, 'Shary', 'Carter', '8100106760', 3),
(131, 126, 1, '171.199.187.103', 'user131', 'password', '011564B374E29249A57E2B4C2A8CDD5A6DC5E730', 'lzu@spd.com', 'E7D8BB3C6201DC22522BEE6B2B27B8DB48B0C1BA', NULL, NULL, NULL, 1383366690, 1383366729, 1, 'Mieko', 'Malone', '0394502747', 2),
(132, 126, 11, '238.47.49.106', 'user132', 'password', '6022274B3065B40BC856E4EDEA90BCCA998BAA80', 'mgd@bri.com', '8C525E7755CB9C2EBE89D11583469DE877C23DA8', NULL, NULL, NULL, 1381951975, 1381952400, 1, 'Ivan', 'Goodwin', '4197983823', 1),
(133, 126, 11, '130.86.87.85', 'user133', 'password', '8610432E66506C3C1DB160B5C86333AA95EEA2B5', 'gtd@njt.com', 'DBA0E94B37326E0A5CA96721B7BDD57053ACC410', NULL, NULL, NULL, 1395905553, 1395905896, 1, 'Fabian', 'Shepherd', '9691131479', 1),
(134, 126, 11, '34.19.29.180', 'user134', 'password', '014D78DAB3894C661286B839326A912ED3A0651A', 'tvq@eox.com', '5C65148DB36EA21BA0AE2E73D4C9855C1D6EE485', NULL, NULL, NULL, 1393939976, 1393940101, 1, 'Fay', 'Williams', '6392840291', 3),
(135, 126, 21, '253.235.24.194', 'user135', 'password', '9CD425D9C285B021C8A41934A99818C89D328EEB', 'cil@vnl.com', '2D96ACE70E7A2C83BA42BA2BB5081A25A223DE13', NULL, NULL, NULL, 1402138389, 1402138693, 1, 'Reina', 'George', '7699759728', 2),
(136, 127, 1, '35.116.90.179', 'user136', 'password', '7E59E35CEBE139E004DE88D9239C17489A1693A0', 'jtd@dsr.com', '76AAA7CBEA98961C0DDB1C3EE726499DECEC3586', NULL, NULL, NULL, 1395459663, 1395459784, 1, 'Gert', 'Joyce', '2312196095', 1),
(137, 127, 11, '177.139.167.118', 'user137', 'password', 'E4674D692A515B4BA2AC49D59E83DBD02516A9AE', 'rll@kau.com', '83E72DB5A5E41456469C215CB32914B20EAD9415', NULL, NULL, NULL, 1382055984, 1382056137, 1, 'Tanya', 'Farley', '3760585675', 2),
(138, 127, 21, '121.148.112.88', 'user138', 'password', 'D91BD0A911840DAEB8EA838562D0000AACBC783C', 'oux@qfz.com', 'EB1C5AC1673AD8D5494D78293D9A6E735B168AD2', NULL, NULL, NULL, 1391739415, 1391739641, 1, 'Rie', 'Shelton', '0546702043', 1),
(139, 127, 21, '114.197.54.228', 'user139', 'password', '87E321CE94BE8AC131B78AD197A451557B6851A2', 'bon@kup.com', 'A61D541959BDCE927D8A2ED67C9240E454A4EA12', NULL, NULL, NULL, 1371371949, 1371372327, 1, 'Van', 'Nichols', '6542871116', 3),
(140, 127, 11, '110.34.10.49', 'user140', 'password', 'B4E5049CADE103B8AC54867DC946E2AA5C764C83', 'jiv@mxn.com', '4DE5225B87B53A1BB1CA53B2D84C66E135ED5678', NULL, NULL, NULL, 1400680337, 1400680662, 1, 'Nanaho', 'Marquez', '3988815116', 4),
(141, 128, 1, '168.10.136.176', 'user141', 'password', '56537DDD236D00A02D1443D8A1460065CD5C67D0', 'sbb@eye.com', '82CE9DAEA8C9A22B825B5A2E9EC6DA4B3D4E6921', NULL, NULL, NULL, 1392652383, 1392652713, 1, 'Iris', 'Sexton', '8248140658', 4),
(142, 128, 11, '84.193.73.85', 'user142', 'password', '10B990CBE0E8A002DBD77D28A432294C24691830', 'txq@iku.com', '508BCAED58590AA4EA24ACBE1D6470D354211450', NULL, NULL, NULL, 1385208998, 1385209028, 1, 'Walter', 'David', '3497601174', 3),
(143, 128, 21, '250.246.16.30', 'user143', 'password', 'D3D7E456C24617270E84AD2EC38DE3E69845C6CE', 'wfu@tva.com', 'B6D9DD1BB9589379BC81D3024EC5E91C31E537B0', NULL, NULL, NULL, 1373937504, 1373937676, 1, 'Ernesto', 'Howard', '2718113624', 4),
(144, 128, 11, '69.253.125.196', 'user144', 'password', 'A2C4E2EA0ADED77E9DA27E84B8301D800B437E11', 'mud@eqs.com', 'D07A7EB666CE2EE5D8BD8116A4CDABCC3A814B08', NULL, NULL, NULL, 1388017241, 1388017548, 1, 'Sally', 'Steele', '1488389861', 4),
(145, 128, 21, '36.12.78.138', 'user145', 'password', '268127640C66D2024502326B5A064D12A3BE7280', 'fmj@eoj.com', 'EB5AED4ADE42AA209EAACCC9CB582AB50BD0B8AE', NULL, NULL, NULL, 1378596722, 1378596815, 1, 'Miyuki', 'Clay', '4196667324', 1),
(146, 129, 1, '63.79.41.89', 'user146', 'password', '3C39EECBEDD55841A7EC799606CE7BD86229C87D', 'idp@grg.com', 'BC9B639A4D738AEEC097C0984D913509ECD73188', NULL, NULL, NULL, 1402871267, 1402871277, 1, 'Kate', 'Hunt', '4126094267', 2),
(147, 129, 11, '220.206.233.82', 'user147', 'password', 'A93A68AA2DB1C082E465E705BD804B3BB684EEAC', 'ioz@ilj.com', '06AA317D0E7CBB957CBE87A25399165D918E1713', NULL, NULL, NULL, 1391993659, 1391993823, 1, 'Isabel', 'Medina', '9576029526', 3),
(148, 129, 11, '178.59.33.145', 'user148', 'password', '22A4B33A46C3A8963CA8DBDBCC11AA7D521D1123', 'wmo@iux.com', '05AC9D5C943CB12BA17890368C82A12DC728C102', NULL, NULL, NULL, 1377120372, 1377120404, 1, 'Naoko', 'Mcintosh', '0013696355', 4),
(149, 129, 21, '254.180.57.207', 'user149', 'password', 'B045DBCD1EB2CE87B1D6E135B4913BC74A8877D5', 'qal@kvh.com', '56ED1B2A7E02685B406232CEB8054071C90988D1', NULL, NULL, NULL, 1396949495, 1396949995, 1, 'Debby', 'Gibbs', '1323445321', 2),
(150, 129, 11, '80.68.143.23', 'user150', 'password', '7942DEA00305ABAB14A8E4B1C968986AAA6306EA', 'bci@onn.com', 'E43DD707C17B05B1388A0522A43A7C4DE2D4C7BC', NULL, NULL, NULL, 1376251704, 1376251816, 1, 'Leslie', 'Osborne', '3275681394', 1);

-- --------------------------------------------------------

--
-- Table structure for table `userTitles`
--

CREATE TABLE IF NOT EXISTS `userTitles` (
  `TitleID` int(11) unsigned NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Abbreviation` varchar(32) NOT NULL,
  PRIMARY KEY (`TitleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userTitles`
--

INSERT INTO `userTitles` (`TitleID`, `Name`, `Abbreviation`) VALUES
(1, 'Doctor of Medicine', 'MD'),
(2, 'Registered nurse', 'RN'),
(3, 'Doctor of Audiology', 'Au.D.'),
(4, 'Nurse Practitioner', 'NP');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
