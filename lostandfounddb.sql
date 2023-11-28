-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 27, 2023 at 07:50 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `createNewItem` (IN `itemName` VARCHAR(255), IN `itemDescription` TEXT, IN `pstrID` INT, IN `userRole` VARCHAR(255))  DETERMINISTIC READS SQL DATA begin

	if userRole = 'user' then

		insert into tbl_items (colItemName,colItemDesc, colPosterID,colStatusID)

		values (itemName, itemDescription, pstrID,getStatusID('lost'));

	elseif userRole = 'admin' then

		insert into tbl_items (colItemName,colItemDesc, colPosterID,colStatusID)

		values (itemName, itemDescription,pstrID, getStatusID('unclaimed'));

	end if;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createUser` (IN `hashed_password` VARCHAR(255), IN `email` VARCHAR(255), IN `username` VARCHAR(100))  DETERMINISTIC READS SQL DATA BEGIN
    INSERT INTO tbl_user (colUsername, colUserPass, colEmail)
    VALUES (username, email, hashed_password);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteItem` (IN `itmID` INT)  DETERMINISTIC READS SQL DATA begin
		delete from tbl_items 
		where colItemID =itmID;

		delete from tbl_item_pic 
		where colItemID =itmID;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUsers` ()   BEGIN
	SELECT colUsername AS `username`,colEmail AS `email`,getRoleName(colRoleID) AS 'role' FROM tbl_user;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getItemByItemName` (IN `itmName` VARCHAR(100), IN `status` VARCHAR(100))  DETERMINISTIC READS SQL DATA BEGIN
	
	IF status = 'claimed' THEN
	SELECT colItemID AS 'itemID', getItemName(colItemID) AS 'itemName',getItemDesc(colItemID) AS 'itemDesc',
	DATE_FORMAT(colDateClaimed , "%b %d, %Y %h:%i %p") AS 'date' , getUsernameByID(colUserID) AS 'username', getEmailByID(colUserID) AS 'userEmail'
	FROM tbl_claimed WHERE getItemName(colItemID)=concat('%',itmName,'%') ; 
	
	ELSE
	SELECT colItemID AS 'itemID', colItemName AS 'itemName',colItemDesc AS 'itemDesc',
	DATE_FORMAT(colDatePosted, "%b %d, %Y %h:%i %p") AS 'date', getUsernameByID(colPosterID) AS 'username', getEmailByID(colPosterID) AS 'userEmail'
	FROM tbl_items WHERE colStatusID = getStatusID(status) AND colItemName LIKE concat('%',itmName,'%') ; 
	
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getItemPic` (IN `in_postID` INT)  DETERMINISTIC READS SQL DATA begin

		select colItemID as 'itemID', colPicURI as 'picURI'
		from tbl_item_pic  WHERE colItemID  = in_postID;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getItems` (IN `status` VARCHAR(255))   BEGIN
	IF status = 'claimed' THEN
	SELECT colItemID AS 'itemID', getItemName(colItemID) AS 'itemName',getItemDesc(colItemID) AS 'itemDesc',
	DATE_FORMAT(colDateClaimed , "%b %d, %Y %h:%i %p") AS 'date' , getUsernameByID(colUserID) AS 'username', getEmailByID(colUserID) AS 'userEmail'
	FROM tbl_claimed; 
	
	ELSE
	SELECT colItemID AS 'itemID', colItemName AS 'itemName',colItemDesc AS 'itemDesc',
	DATE_FORMAT(colDatePosted, "%b %d, %Y %h:%i %p") AS 'date', getUsernameByID(colPosterID) AS 'username', getEmailByID(colPosterID) AS 'userEmail'
	FROM tbl_items WHERE colStatusID = getStatusID(status); 
	
	END IF;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getItemsFilteredByUserID` (`id` INT)   BEGIN
	SELECT colItemID  as 'itemID',colItemName as 'itemName', colItemDesc  'itemDesc',
    DATE_FORMAT(colDatePosted, "%b %d, %Y %h:%i %p") as 'date',getUsernameByID(colPosterID) AS 'username', 
    getEmailByID(colPosterID) AS 'userEmail'
    from tbl_items WHERE colPosterID = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByUsername` (IN `usrname` VARCHAR(255))  DETERMINISTIC READS SQL DATA BEGIN
	SELECT colUserID AS 'userID', colUserPass AS 'userPassword',
	colEmail AS 'userEmail',getRoleName(colRoleID) as 'userRole'
	FROM tbl_user WHERE colUsername COLLATE utf8mb4_general_ci = usrname COLLATE utf8mb4_general_ci;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewPic` (IN `in_itemID` INT, IN `in_picURI` VARCHAR(255))  DETERMINISTIC READS SQL DATA BEGIN
		INSERT INTO tbl_item_pic (colItemID, colPicURI)
	    VALUES (in_itemID, in_picURI);
end$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getEmailByID` (`id` INT) RETURNS VARCHAR(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC READS SQL DATA BEGIN
	DECLARE email varchar(255) DEFAULT '';

    SELECT colEmail INTO email FROM tbl_user WHERE colUserID= id; 

    RETURN email;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getIDByUsername` (`username` VARCHAR(255)) RETURNS INT(11) DETERMINISTIC READS SQL DATA BEGIN

	DECLARE userid int;
    SELECT colUserID INTO userid FROM tbl_user WHERE colUsername = username limit 1;
    RETURN userid;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getItemDesc` (`id` INT) RETURNS VARCHAR(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
	DECLARE descr varchar(255);
	SELECT colItemDesc INTO descr FROM tbl_items WHERE colItemID = id ; 
	RETURN descr;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getItemName` (`id` INT) RETURNS VARCHAR(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
	DECLARE iname varchar(255);
	SELECT colItemName INTO iname FROM tbl_itmes WHERE colItemID = id; 
	RETURN iname;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getPosterID` (`itmID` INT) RETURNS INT(11)  BEGIN
	DECLARE posterID int;
	SELECT colPosterID INTO posterID FROM tbl_items WHERE colItemID = itmID; 
	RETURN posterID;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getRoleName` (`id` INT) RETURNS VARCHAR(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC READS SQL DATA BEGIN

    DECLARE rlname varchar(255) DEFAULT '';

    SELECT colRoleName INTO rlname FROM tbl_role WHERE colRoleID = id;

    RETURN rlname;

end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getStatusID` (`name` VARCHAR(255)) RETURNS INT(11)  BEGIN
	DECLARE sid int;
	SELECT colStatusID INTO sid FROM tbl_status WHERE colStatusName = name;
 RETURN sid;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getUsernameByID` (`id` INT) RETURNS VARCHAR(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC READS SQL DATA BEGIN
	DECLARE username varchar(255) DEFAULT '';

    SELECT colUsername INTO username FROM tbl_user WHERE colUserID = id;
    RETURN username;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_claimed`
--

CREATE TABLE `tbl_claimed` (
  `colItemID` int(11) NOT NULL,
  `colUserID` int(11) NOT NULL,
  `colDateClaimed` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_claimed`
--

INSERT INTO `tbl_claimed` (`colItemID`, `colUserID`, `colDateClaimed`) VALUES
(36, 8, '2023-11-27 14:02:40'),
(38, 8, '2023-11-27 14:13:01'),
(39, 8, '2023-11-27 14:12:59'),
(40, 8, '2023-11-27 14:12:57'),
(41, 8, '2023-11-27 14:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_comment`
--

CREATE TABLE `tbl_comment` (
  `colCommentID` int(11) NOT NULL,
  `colItemID` int(11) NOT NULL,
  `colUserID` int(11) NOT NULL,
  `colComment` text NOT NULL,
  `colCommentDate` varchar(100) NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_items`
--

CREATE TABLE `tbl_items` (
  `colItemID` int(11) NOT NULL,
  `colItemName` varchar(100) NOT NULL,
  `colItemDesc` text DEFAULT NULL,
  `colPosterID` int(11) NOT NULL,
  `colStatusID` int(11) NOT NULL,
  `colDatePosted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_items`
--

INSERT INTO `tbl_items` (`colItemID`, `colItemName`, `colItemDesc`, `colPosterID`, `colStatusID`, `colDatePosted`) VALUES
(34, 'dasda', 'asdasd', 8, 3, '2023-11-27 02:39:21'),
(36, 'sadasd', 'asdasdasd', 8, 4, '2023-11-27 05:16:49'),
(37, 'dasasda', 'asdasda', 10, 3, '2023-11-27 05:44:02'),
(38, 'qweqwe', 'qwqeqweq', 10, 4, '2023-11-27 05:45:03'),
(39, 'sadas', 'asdasd', 10, 4, '2023-11-27 05:45:33'),
(40, 'asdasd', 'asdasdas', 10, 4, '2023-11-27 05:45:45'),
(41, 'asdsad', 'asdasdas', 10, 4, '2023-11-27 05:45:56'),
(42, 'asdasd', 'asdasd', 10, 2, '2023-11-27 06:17:43');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_item_pic`
--

CREATE TABLE `tbl_item_pic` (
  `colItemID` int(11) NOT NULL,
  `colPicURI` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_item_pic`
--

INSERT INTO `tbl_item_pic` (`colItemID`, `colPicURI`) VALUES
(34, 'pics\\5.jpg'),
(36, 'pics\\1.jpg'),
(37, 'pics\\375024659_694771345317062_1849182749889010258_n.jpg'),
(38, 'pics\\Wallpaper.jpg'),
(39, 'pics\\1500x500.jpg'),
(40, 'pics\\kurisu.jpg'),
(41, 'pics\\5.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_reset_token`
--

CREATE TABLE `tbl_reset_token` (
  `colUserID` int(11) NOT NULL,
  `colToken` varchar(100) NOT NULL,
  `colExpiration` datetime NOT NULL DEFAULT addtime(current_timestamp(),'00:30:00')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_role`
--

CREATE TABLE `tbl_role` (
  `colRoleID` int(11) NOT NULL,
  `colRoleName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_role`
--

INSERT INTO `tbl_role` (`colRoleID`, `colRoleName`) VALUES
(2, 'admin'),
(1, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_status`
--

CREATE TABLE `tbl_status` (
  `colStatusID` int(11) NOT NULL,
  `colStatusName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_status`
--

INSERT INTO `tbl_status` (`colStatusID`, `colStatusName`) VALUES
(4, 'claimed'),
(2, 'found'),
(1, 'lost'),
(3, 'unclaimed');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `colUserID` int(11) NOT NULL,
  `colUsername` varchar(100) NOT NULL,
  `colEmail` varchar(100) NOT NULL,
  `colUserPass` varchar(255) NOT NULL,
  `colRoleID` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`colUserID`, `colUsername`, `colEmail`, `colUserPass`, `colRoleID`) VALUES
(1, 'oli', 'carpioranillo@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$YVFBV0kubjhqTXZTdmY2NQ$/4NkwZCb5SYHfrp0PHOMklnT0am78G1NFX8zSqXjyhg', 2),
(2, 'oliUser', 'carpioranillo@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$TkN0NDVOazExTmVnb09xcQ$WDWTuW5+ZVu6ZU3zCDJu+Mr20nZW0f4nnJuok6VA9J4', 1),
(8, 'dadas', 'johnmillerlorenzo@gmail.com', '$2b$12$mfk5nFj1FrYa4imxK14xTOgh5j8NeFGoNHoxFGfkiacXcUEEakFS6', 2),
(10, 'dada', 'Probinsyano364@gmail.com', '$2b$12$2c4N0qsB0kBoxt7.enWtBeH3q5dNaeqKw8/5Khg0REcHC4sxp6tmC', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_claimed`
--
ALTER TABLE `tbl_claimed`
  ADD PRIMARY KEY (`colItemID`),
  ADD KEY `tbl_claimed_FK_1` (`colUserID`);

--
-- Indexes for table `tbl_comment`
--
ALTER TABLE `tbl_comment`
  ADD PRIMARY KEY (`colCommentID`),
  ADD KEY `tbl_comment_FK` (`colUserID`),
  ADD KEY `tbl_comment_FK_1` (`colItemID`);

--
-- Indexes for table `tbl_items`
--
ALTER TABLE `tbl_items`
  ADD PRIMARY KEY (`colItemID`),
  ADD KEY `tbl_items_FK` (`colStatusID`),
  ADD KEY `tbl_items_FK_1` (`colPosterID`);

--
-- Indexes for table `tbl_item_pic`
--
ALTER TABLE `tbl_item_pic`
  ADD PRIMARY KEY (`colItemID`,`colPicURI`);

--
-- Indexes for table `tbl_reset_token`
--
ALTER TABLE `tbl_reset_token`
  ADD PRIMARY KEY (`colUserID`),
  ADD UNIQUE KEY `tbl_passResetToken_un` (`colToken`);

--
-- Indexes for table `tbl_role`
--
ALTER TABLE `tbl_role`
  ADD PRIMARY KEY (`colRoleID`),
  ADD UNIQUE KEY `tbl_role_un` (`colRoleName`);

--
-- Indexes for table `tbl_status`
--
ALTER TABLE `tbl_status`
  ADD PRIMARY KEY (`colStatusID`),
  ADD UNIQUE KEY `tblStatus_un` (`colStatusName`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`colUserID`),
  ADD UNIQUE KEY `tbl_user_un` (`colUsername`),
  ADD KEY `tbl_user_FK` (`colRoleID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_comment`
--
ALTER TABLE `tbl_comment`
  MODIFY `colCommentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_items`
--
ALTER TABLE `tbl_items`
  MODIFY `colItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `tbl_role`
--
ALTER TABLE `tbl_role`
  MODIFY `colRoleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_status`
--
ALTER TABLE `tbl_status`
  MODIFY `colStatusID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `colUserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_claimed`
--
ALTER TABLE `tbl_claimed`
  ADD CONSTRAINT `tbl_claimed_FK` FOREIGN KEY (`colItemID`) REFERENCES `tbl_items` (`colItemID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_claimed_FK_1` FOREIGN KEY (`colUserID`) REFERENCES `tbl_user` (`colUserID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_comment`
--
ALTER TABLE `tbl_comment`
  ADD CONSTRAINT `tbl_comment_FK` FOREIGN KEY (`colUserID`) REFERENCES `tbl_user` (`colUserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_comment_FK_1` FOREIGN KEY (`colItemID`) REFERENCES `tbl_items` (`colItemID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_items`
--
ALTER TABLE `tbl_items`
  ADD CONSTRAINT `tbl_items_FK` FOREIGN KEY (`colStatusID`) REFERENCES `tbl_status` (`colStatusID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_items_FK_1` FOREIGN KEY (`colPosterID`) REFERENCES `tbl_user` (`colUserID`);

--
-- Constraints for table `tbl_item_pic`
--
ALTER TABLE `tbl_item_pic`
  ADD CONSTRAINT `tbl_item_pic_FK` FOREIGN KEY (`colItemID`) REFERENCES `tbl_items` (`colItemID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_reset_token`
--
ALTER TABLE `tbl_reset_token`
  ADD CONSTRAINT `tbl_passResetToken_FK` FOREIGN KEY (`colUserID`) REFERENCES `tbl_user` (`colUserID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD CONSTRAINT `tbl_user_FK` FOREIGN KEY (`colRoleID`) REFERENCES `tbl_role` (`colRoleID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
