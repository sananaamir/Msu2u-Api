CREATE TABLE `QuestionAnswerTypes` (
  `TypeID` int(8) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`TypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `QuestionAnswerTypes` (`TypeID`, `Name`, `Description`) VALUES
(1, 'Select', 'Drop down form element.'),
(2, 'Radio', 'Radio button form element.'),
(3, 'Checkbox', 'Checkbox form element.'),
(4, 'Text', 'Input text box form element.'),
(5, 'Multi-Select', 'Multi-select form element.'),
(6, 'Null', 'Question has no inputs, but has sub question.'),
(7, 'Date', 'Date field with no time.'),
(8, 'Timestamp', 'Unix timestamp.');