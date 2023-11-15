-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 15, 2023 at 07:59 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lostandfound`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByUsername` (IN `usrname` VARCHAR(255))   BEGIN
	SELECT col_userID AS 'userID',col_studNum AS 'userStudNum', col_password AS 'userPassword',
	col_email AS 'userEmail',getRoleName(col_roleID)
	FROM tbl_user WHERE col_username = usrname ;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getRoleName` (`id` INT) RETURNS VARCHAR(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
	DECLARE rlname varchar(255) DEFAULT '';
	SELECT col_roleTitle INTO rlname FROM tbl_roles WHERE col_roleID = id;
	RETURN rlname;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_foundpic`
--

CREATE TABLE `tbl_foundpic` (
  `col_postID` int(11) NOT NULL,
  `col_picURI` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_foundpost`
--

CREATE TABLE `tbl_foundpost` (
  `col_postID` int(11) NOT NULL,
  `col_itemName` varchar(100) NOT NULL,
  `col_itemDescriptiom` varchar(255) DEFAULT NULL,
  `col_dateTime` datetime NOT NULL DEFAULT current_timestamp(),
  `col_statusID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_lostpic`
--

CREATE TABLE `tbl_lostpic` (
  `col_postID` int(11) NOT NULL,
  `col_picURI` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_lostpost`
--

CREATE TABLE `tbl_lostpost` (
  `col_postID` int(11) NOT NULL,
  `col_itemName` varchar(100) NOT NULL,
  `col_itemDescription` text DEFAULT NULL,
  `col_dateTime` datetime NOT NULL DEFAULT current_timestamp(),
  `col_statusID` int(11) NOT NULL,
  `col_userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `col_roleID` int(11) NOT NULL,
  `col_roleTitle` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_roles`
--

INSERT INTO `tbl_roles` (`col_roleID`, `col_roleTitle`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_status`
--

CREATE TABLE `tbl_status` (
  `col_statusID` int(11) NOT NULL,
  `col_statusName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `col_userID` int(11) NOT NULL,
  `col_studNum` varchar(50) NOT NULL,
  `col_username` varchar(100) NOT NULL,
  `col_password` varchar(255) NOT NULL,
  `col_email` varchar(100) NOT NULL,
  `col_roleID` int(11) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`col_userID`, `col_studNum`, `col_username`, `col_password`, `col_email`, `col_roleID`) VALUES
(1, 'sum-0001', 'admin', '123', 'admin@gmial.com', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_foundpic`
--
ALTER TABLE `tbl_foundpic`
  ADD PRIMARY KEY (`col_postID`,`col_picURI`);

--
-- Indexes for table `tbl_foundpost`
--
ALTER TABLE `tbl_foundpost`
  ADD PRIMARY KEY (`col_postID`),
  ADD KEY `tbl_foundPost_FK` (`col_statusID`);

--
-- Indexes for table `tbl_lostpic`
--
ALTER TABLE `tbl_lostpic`
  ADD PRIMARY KEY (`col_postID`,`col_picURI`);

--
-- Indexes for table `tbl_lostpost`
--
ALTER TABLE `tbl_lostpost`
  ADD PRIMARY KEY (`col_postID`),
  ADD KEY `tbl_lostPost_FK` (`col_statusID`),
  ADD KEY `tbl_lostPost_FK_1` (`col_userID`);

--
-- Indexes for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`col_roleID`),
  ADD UNIQUE KEY `tbl_roles_un` (`col_roleTitle`);

--
-- Indexes for table `tbl_status`
--
ALTER TABLE `tbl_status`
  ADD PRIMARY KEY (`col_statusID`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`col_userID`),
  ADD UNIQUE KEY `tbl_User_un` (`col_username`,`col_studNum`),
  ADD KEY `tbl_User_FK` (`col_roleID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_foundpost`
--
ALTER TABLE `tbl_foundpost`
  MODIFY `col_postID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_lostpost`
--
ALTER TABLE `tbl_lostpost`
  MODIFY `col_postID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `col_roleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_status`
--
ALTER TABLE `tbl_status`
  MODIFY `col_statusID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `col_userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_foundpic`
--
ALTER TABLE `tbl_foundpic`
  ADD CONSTRAINT `tbl_foundpic_FK` FOREIGN KEY (`col_postID`) REFERENCES `tbl_foundpost` (`col_postID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_foundpost`
--
ALTER TABLE `tbl_foundpost`
  ADD CONSTRAINT `tbl_foundPost_FK` FOREIGN KEY (`col_statusID`) REFERENCES `tbl_status` (`col_statusID`);

--
-- Constraints for table `tbl_lostpic`
--
ALTER TABLE `tbl_lostpic`
  ADD CONSTRAINT `tbl_lostPic_FK` FOREIGN KEY (`col_postID`) REFERENCES `tbl_lostpost` (`col_postID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_lostpost`
--
ALTER TABLE `tbl_lostpost`
  ADD CONSTRAINT `tbl_lostPost_FK` FOREIGN KEY (`col_statusID`) REFERENCES `tbl_status` (`col_statusID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_lostPost_FK_1` FOREIGN KEY (`col_userID`) REFERENCES `tbl_user` (`col_userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD CONSTRAINT `tbl_User_FK` FOREIGN KEY (`col_roleID`) REFERENCES `tbl_roles` (`col_roleID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
