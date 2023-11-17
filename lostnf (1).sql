-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: lostnfounddb
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_foundpic`
--

DROP TABLE IF EXISTS `tbl_foundpic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_foundpic` (
  `col_postID` int NOT NULL,
  `col_picURI` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`col_postID`,`col_picURI`),
  CONSTRAINT `tbl_foundpic_FK` FOREIGN KEY (`col_postID`) REFERENCES `tbl_foundpost` (`col_postID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_foundpic`
--

LOCK TABLES `tbl_foundpic` WRITE;
/*!40000 ALTER TABLE `tbl_foundpic` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_foundpic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_foundpost`
--

DROP TABLE IF EXISTS `tbl_foundpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_foundpost` (
  `col_postID` int NOT NULL AUTO_INCREMENT,
  `col_itemName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `col_itemDescription` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `col_date` date NOT NULL DEFAULT (curdate()),
  `col_statusID` int NOT NULL,
  PRIMARY KEY (`col_postID`),
  KEY `tbl_foundPost_FK` (`col_statusID`),
  CONSTRAINT `tbl_foundPost_FK` FOREIGN KEY (`col_statusID`) REFERENCES `tbl_status` (`col_statusID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_foundpost`
--

LOCK TABLES `tbl_foundpost` WRITE;
/*!40000 ALTER TABLE `tbl_foundpost` DISABLE KEYS */;
INSERT INTO `tbl_foundpost` VALUES (2,'laptop',NULL,'2023-11-17',1),(3,'ItemName','ItemDescription','2023-11-17',1);
/*!40000 ALTER TABLE `tbl_foundpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_lostpic`
--

DROP TABLE IF EXISTS `tbl_lostpic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_lostpic` (
  `col_postID` int NOT NULL,
  `col_picURI` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`col_postID`,`col_picURI`),
  CONSTRAINT `tbl_lostPic_FK` FOREIGN KEY (`col_postID`) REFERENCES `tbl_lostpost` (`col_postID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_lostpic`
--

LOCK TABLES `tbl_lostpic` WRITE;
/*!40000 ALTER TABLE `tbl_lostpic` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_lostpic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_lostpost`
--

DROP TABLE IF EXISTS `tbl_lostpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_lostpost` (
  `col_postID` int NOT NULL AUTO_INCREMENT,
  `col_itemName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `col_itemDescription` text COLLATE utf8mb4_general_ci,
  `col_date` date NOT NULL DEFAULT (curdate()),
  `col_statusID` int NOT NULL,
  `col_userID` int NOT NULL,
  PRIMARY KEY (`col_postID`),
  KEY `tbl_lostPost_FK` (`col_statusID`),
  KEY `tbl_lostPost_FK_1` (`col_userID`),
  CONSTRAINT `tbl_lostPost_FK` FOREIGN KEY (`col_statusID`) REFERENCES `tbl_status` (`col_statusID`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_lostPost_FK_1` FOREIGN KEY (`col_userID`) REFERENCES `tbl_user` (`col_userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_lostpost`
--

LOCK TABLES `tbl_lostpost` WRITE;
/*!40000 ALTER TABLE `tbl_lostpost` DISABLE KEYS */;
INSERT INTO `tbl_lostpost` VALUES (1,'glasses','broken','2023-11-16',1,3),(3,'wallet','red','2023-11-16',2,3),(10,'cp',NULL,'2023-11-17',1,3),(11,'laptop',NULL,'2023-11-17',1,3),(12,'ItemName','ItemDescription','2023-11-17',1,3),(13,'ItemName','ItemDescription','2023-11-17',1,3),(14,'ItemName','ItemDescription','2023-11-17',1,3);
/*!40000 ALTER TABLE `tbl_lostpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_roles`
--

DROP TABLE IF EXISTS `tbl_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_roles` (
  `col_roleID` int NOT NULL AUTO_INCREMENT,
  `col_roleTitle` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`col_roleID`),
  UNIQUE KEY `tbl_roles_un` (`col_roleTitle`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_roles`
--

LOCK TABLES `tbl_roles` WRITE;
/*!40000 ALTER TABLE `tbl_roles` DISABLE KEYS */;
INSERT INTO `tbl_roles` VALUES (1,'admin'),(2,'user');
/*!40000 ALTER TABLE `tbl_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_status`
--

DROP TABLE IF EXISTS `tbl_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_status` (
  `col_statusID` int NOT NULL AUTO_INCREMENT,
  `col_statusName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`col_statusID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_status`
--

LOCK TABLES `tbl_status` WRITE;
/*!40000 ALTER TABLE `tbl_status` DISABLE KEYS */;
INSERT INTO `tbl_status` VALUES (1,'lost'),(2,'unclaimed');
/*!40000 ALTER TABLE `tbl_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user` (
  `col_userID` int NOT NULL AUTO_INCREMENT,
  `col_studNum` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `col_username` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `col_password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `col_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `col_roleID` int NOT NULL DEFAULT '2',
  PRIMARY KEY (`col_userID`),
  UNIQUE KEY `tbl_User_un` (`col_username`,`col_studNum`),
  KEY `tbl_User_FK` (`col_roleID`),
  CONSTRAINT `tbl_User_FK` FOREIGN KEY (`col_roleID`) REFERENCES `tbl_roles` (`col_roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
INSERT INTO `tbl_user` VALUES (3,'SUM-12839','user001','Palafin','1056710',2),(9,'SUM2021-00767','Palafin','fajardomarkjerald@gmail.com','10567108',2);
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'lostnfounddb'
--
/*!50003 DROP FUNCTION IF EXISTS `getRoleName` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getRoleName`(`id` INT) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE rlname varchar(255) DEFAULT '';
    SELECT col_roleTitle INTO rlname FROM tbl_roles WHERE col_roleID = id;
    RETURN rlname;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `createpost` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createpost`(in itemName varchar(255),
in itemDescription varchar(255),
in statusID int,
in userID int,
in userRole varchar(255))
begin
	if userRole = 'User' then
		insert into tbl_lostpost (col_itemName,col_itemDescription, col_statusID, col_userID)
		values (itemName, itemDescription, statusID, userID);
	elseif userRole = 'Admin' then
		insert into tbl_foundpost (col_itemName,col_itemDescription, col_statusID)
		values (itemName, itemDescription, statusID);
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `createUser` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createUser`(IN `studnum` VARCHAR(255), IN `password` VARCHAR(255), IN `email` VARCHAR(255), IN `username` VARCHAR(100))
BEGIN

    INSERT INTO tbl_user (col_studNum, col_username, col_password, col_email)

    VALUES (studnum, username, password, email);

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePost` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePost`(IN `postid` INT, IN `tbl` INT)
begin

	if tbl=1 then

		delete from tbl_lostpost

		where col_postID=postid;
		delete from tbl_lostpic
		where col_postID=postid;

	elseif tbl=2 then

		delete from tbl_foundpost

		where col_postID=postid;
		delete from tbl_foundpic 
		where col_postID=postid;

	end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `getpic` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getpic`(IN `in_postID` INT,in `tbl` int)
begin
	if tbl= 1 then
		select col_postID as 'postID', col_picURI as 'picURI'
		from tbl_lostpic;
	elseif tbl=2 then
		select col_postID as 'postID', col_picURI as 'picURI'
		from tbl_foundpic;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `getpostbyID` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getpostbyID`(in postID int, IN `tbl` INT)
begin

	if tbl=1 then
		SELECT col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
		col_date as 'date', col_statusID as 'statusID', col_userID as 'userID'
		from tbl_lostpost
		where col_postID = postID;
	elseif tbl=2 then
		select col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
		col_date as 'date', col_statusID as 'statusID'
		from tbl_foundpost
		where col_postID = postID;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `getPostByItemName` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPostByItemName`(IN `itemname` VARCHAR(100), IN `tbl` INT)
begin

	if tbl=1 then

		SELECT col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
		col_date as 'date', col_statusID as 'statusID', col_userID as 'userID'
		from tbl_lostpost
		where col_itemName COLLATE utf8mb4_general_ci = itemname COLLATE utf8mb4_general_ci;

	elseif tbl=2 then

		select col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
		col_date as 'date', col_statusID as 'statusID'
		from tbl_foundpost
		where col_itemName COLLATE utf8mb4_general_ci = itemname COLLATE utf8mb4_general_ci;

	end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserByUsername` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByUsername`(IN `usrname` VARCHAR(255))
BEGIN

	SELECT col_userID AS 'userID',col_studNum AS 'userStudNum', col_password AS 'userPassword',

	col_email AS 'userEmail',getRoleName(col_roleID) as 'userRole'

	FROM tbl_user WHERE col_username COLLATE utf8mb4_general_ci = usrname COLLATE utf8mb4_general_ci;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `insertpic` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertpic`(IN `in_postID` INT, IN `in_picURI` VARCHAR(255),in `tbl` int)
BEGIN

	if tbl=1 then
		INSERT INTO tbl_lostpic (col_postID, col_picURI)
	    VALUES (in_postID, in_picURI);
	elseif tbl=2 then
		INSERT INTO tbl_foundpic (col_postID, col_picURI)
	    VALUES (in_postID, in_picURI);
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sortby` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sortby`(IN `sort` INT, IN `tbl` INT, IN `orders` INT)
BEGIN
	if tbl=1 then
	    IF sort = 1 then
	    	if orders=1 then
	        	select col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
				col_date as 'date', col_statusID as 'statusID', col_userID as 'userID'
	        	FROM tbl_lostpost order BY col_dateTime;
	        elseif orders=2 then
	        	select col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
				col_date as 'date', col_statusID as 'statusID', col_userID as 'userID'
	        	FROM tbl_lostpost order BY col_dateTime desc;
	        end if;
	    ELSEIF sort = 2 THEN
			if orders=1 then
	        	select col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
				col_date as 'date', col_statusID as 'statusID', col_userID as 'userID'
	        	FROM tbl_lostpost order BY col_itemName;
	        elseif orders=2 then
	        	select col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
				col_date as 'date', col_statusID as 'statusID', col_userID as 'userID'
	        	FROM tbl_lostpost order BY col_itemName desc;
	        end if;
	    END IF;
	elseif tbl=2 then
		IF sort = 1 THEN
	        if orders=1 then
	        	select col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
				col_date as 'date', col_statusID as 'statusID'
	        	FROM tbl_foundpost order BY col_dateTime;
	        elseif orders=2 then
	        	select col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
				col_date as 'date', col_statusID as 'statusID'
	        	FROM tbl_foundpost order BY col_dateTime desc;
	        end if;
	    ELSEIF sort = 2 THEN
			if orders=1 then
	        	select col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
				col_date as 'date', col_statusID as 'statusID'
	        	FROM tbl_foundpost order BY col_itemName;
	        elseif orders=2 then
	        	select  col_postID as 'postID',col_itemName as 'itemName', col_itemDescription 'itemDescription',
				col_date as 'date', col_statusID as 'statusID'
				FROM tbl_foundpost order BY col_itemName desc;
	        end if;
	    END IF;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `updateStat` */;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateStat`(IN `stat` INT, IN `tbl` INT, IN `id` INT)
begin

	if tbl= 1 then
		update tbl_lostpost
		set col_statusID = stat
		where col_postID = id;
	elseif tbl= 2 then
		update tbl_foundpost
		set col_statusID = stat
		where col_postID = id;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `lostnfounddb` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-17 13:52:02
