CREATE DATABASE  IF NOT EXISTS `leave_management` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `leave_management`;
-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: leave_management
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `EMPLOYEE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `EMAIL_ID` varchar(45) NOT NULL,
  `PASSWORD` varchar(45) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `CREATED_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ROLE_ID` int(11) NOT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  UNIQUE KEY `EMAIL_ID_UNIQUE` (`EMAIL_ID`),
  KEY `fk_employee_1_idx` (`ROLE_ID`),
  CONSTRAINT `fk_employee_1` FOREIGN KEY (`ROLE_ID`) REFERENCES `role` (`ROLE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'sai.kiran@gmail.com','employee123','Active','2015-05-05 18:30:00',1),(2,'manoj.kumar@gmail.com','employee123','Active','2017-06-05 18:30:00',1),(3,'sonu.swati@gmail.com','employee123','Active','2019-12-11 18:30:00',1),(4,'bala.krishna@gmail.com','employee123','Active','2011-08-24 18:30:00',1),(5,'vinay.kumar@gmail.com','manager123','Active','2009-12-31 18:30:00',2);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_address`
--

DROP TABLE IF EXISTS `employee_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_address` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STREET_ADDRESS` varchar(255) NOT NULL,
  `CITY` varchar(255) NOT NULL,
  `STATE` varchar(255) NOT NULL,
  `ZIP_CODE` int(6) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_address`
--

LOCK TABLES `employee_address` WRITE;
/*!40000 ALTER TABLE `employee_address` DISABLE KEYS */;
INSERT INTO `employee_address` VALUES (1,'A.S Rao Nagar','Hyderabad','Telangana',500060),(2,'Gachibowli','Hyderabad','Telangana',500063),(3,'Jubliee Hills','Hyderabad','Telangana',500090),(4,'Hitec City','Hyderabad','Andhra Pradesh',500012),(5,'Banjara Hills','Hyderabad','Delhi',500016);
/*!40000 ALTER TABLE `employee_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_profile`
--

DROP TABLE IF EXISTS `employee_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_profile` (
  `PROFILE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `EMPLOYEE_ID` int(11) NOT NULL,
  `FIRST_NAME` varchar(50) NOT NULL,
  `LAST_NAME` varchar(50) NOT NULL,
  `DOB` date NOT NULL,
  `PHONE_NUMBER` varchar(45) NOT NULL,
  `DOJ` date NOT NULL,
  `QUALIFICATION` varchar(45) NOT NULL,
  `ADDRESS` int(11) NOT NULL,
  `JOB_TITLE` varchar(45) NOT NULL,
  `GENDER` varchar(45) NOT NULL,
  PRIMARY KEY (`PROFILE_ID`),
  KEY `fk_employee_profile_1_idx` (`ADDRESS`),
  KEY `fk_employee_profile_2_idx` (`EMPLOYEE_ID`),
  CONSTRAINT `fk_employee_profile_1` FOREIGN KEY (`ADDRESS`) REFERENCES `employee_address` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_profile_2` FOREIGN KEY (`EMPLOYEE_ID`) REFERENCES `employee` (`EMPLOYEE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_profile`
--

LOCK TABLES `employee_profile` WRITE;
/*!40000 ALTER TABLE `employee_profile` DISABLE KEYS */;
INSERT INTO `employee_profile` VALUES (6,1,'Sai','Kiran','1990-03-05','7306689456','2011-08-15','B. Tech',1,'Tester','Male'),(7,2,'Manoj','Kumar','1995-01-07','5478961233','2017-03-15','B. Tech',2,'Developer ','Male'),(8,3,'Sonu','Swati','1985-04-11','8945123212','2015-08-05','Degree',3,'Developer','Female'),(9,4,'Bala','Krishna','1991-06-27','4567891365','2009-01-12','MCA',4,'Architect','Male'),(10,5,'Vinay','Kumar','1995-03-20','9845621411','2005-09-16','Masters',5,'Manager','Male');
/*!40000 ALTER TABLE `employee_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaves`
--

DROP TABLE IF EXISTS `leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leaves` (
  `LEAVE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `EMPLOYEE_ID` int(11) NOT NULL,
  `LEAVE_TYPE` varchar(45) NOT NULL,
  `LEAVE_DATE` date NOT NULL,
  `APPLY_DATE` date NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `APPLY_REASON` varchar(255) NOT NULL,
  `REASON` varchar(255) NOT NULL,
  PRIMARY KEY (`LEAVE_ID`),
  KEY `fk_leaves_1_idx` (`EMPLOYEE_ID`),
  CONSTRAINT `fk_leaves_1` FOREIGN KEY (`EMPLOYEE_ID`) REFERENCES `employee` (`EMPLOYEE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
INSERT INTO `leaves` VALUES (1,1,'Casual Leave','2019-07-22','2019-07-01','Approved','Going Out','Ok'),(2,1,'Sick Leave','2019-07-23','2019-07-22','Approved','Fever','Ok'),(3,1,'Sick Leave','2019-07-25','2019-07-24','Rejected','Cold','Work pending'),(4,2,'Casual Leave','2019-07-22','2019-07-01','Approved','Going Out','Ok'),(5,2,'Sick Leave','2019-07-26','2019-07-21','Approved','Cold','Ok'),(6,2,'Casual Leave','2019-07-27','2019-07-21','Rejected','Going Out','No'),(7,3,'Casual Leave','2019-07-22','2019-07-01','Approved','Going Out','Ok'),(8,3,'Sick Leave','2019-07-24','2019-07-23','Approved','Sick','Ok'),(9,1,'Casual Leave','2019-07-22','2019-07-22','Rejected','Going Out','No'),(10,2,'Study Leave','2019-07-29','2019-07-15','Approved','Please Consider.','Okay take'),(11,2,'Study Leave','2019-07-30','2019-07-15','Approved','Studying','ok'),(12,4,'Casual Leave','2019-07-26','2019-07-15','Approved','Casually','Done'),(13,2,'Casual Leave','2019-07-17','2019-07-16','Pending','Fever',''),(14,2,'Casual Leave','2019-07-17','2019-07-16','Pending','Fever',''),(15,2,'Peternity Leave','2019-07-26','2019-07-16','Pending','Lazy','');
/*!40000 ALTER TABLE `leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `ROLE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE_TYPE` varchar(45) NOT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Employee'),(2,'Manager');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-07-16 16:24:47
