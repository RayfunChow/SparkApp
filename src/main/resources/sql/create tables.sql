-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: spark
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_dim_adpm`
--

DROP TABLE IF EXISTS `t_dim_adpm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_adpm` (
                              `ADPMCode` int DEFAULT NULL,
                              `ADPMName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_adpm`
--

LOCK TABLES `t_dim_adpm` WRITE;
/*!40000 ALTER TABLE `t_dim_adpm` DISABLE KEYS */;
INSERT INTO `t_dim_adpm` VALUES (1,'0-1'),(2,'2-5'),(3,'6-10'),(4,'11-20'),(5,'21-30'),(6,'More than 30');
/*!40000 ALTER TABLE `t_dim_adpm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_age`
--

DROP TABLE IF EXISTS `t_dim_age`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_age` (
                             `ageCode` int DEFAULT NULL,
                             `ageName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_age`
--

LOCK TABLES `t_dim_age` WRITE;
/*!40000 ALTER TABLE `t_dim_age` DISABLE KEYS */;
INSERT INTO `t_dim_age` VALUES (1,'Under 18'),(2,'18-30'),(3,'31-45'),(4,'46-60'),(5,'Over 60');
/*!40000 ALTER TABLE `t_dim_age` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_ces`
--

DROP TABLE IF EXISTS `t_dim_ces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_ces` (
                             `CESCode` int DEFAULT NULL,
                             `CESName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_ces`
--

LOCK TABLES `t_dim_ces` WRITE;
/*!40000 ALTER TABLE `t_dim_ces` DISABLE KEYS */;
INSERT INTO `t_dim_ces` VALUES (1,'Full-time'),(2,'Part-time'),(3,'Self-employed'),(4,'Student'),(5,'Homemaker'),(6,'Unemployed'),(7,'Unable to work'),(8,'Retired'),(9,'Other');
/*!40000 ALTER TABLE `t_dim_ces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_cfda`
--

DROP TABLE IF EXISTS `t_dim_cfda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_cfda` (
                              `CFDACode` int DEFAULT NULL,
                              `CFDAName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_cfda`
--

LOCK TABLES `t_dim_cfda` WRITE;
/*!40000 ALTER TABLE `t_dim_cfda` DISABLE KEYS */;
INSERT INTO `t_dim_cfda` VALUES (1,'Reviews by other users'),(2,'Name of app'),(3,'Number of users who have downloaded the app'),(4,'Icon'),(5,'Description of the app'),(6,'Features'),(7,'Number of users who have rated the app'),(8,'Price'),(9,'Star rating'),(10,'Size of app'),(11,'Screen shots'),(12,'Who developed the app'),(13,'Other');
/*!40000 ALTER TABLE `t_dim_cfda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_fovas`
--

DROP TABLE IF EXISTS `t_dim_fovas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_fovas` (
                               `FOVASCode` int DEFAULT NULL,
                               `FOVASName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_fovas`
--

LOCK TABLES `t_dim_fovas` WRITE;
/*!40000 ALTER TABLE `t_dim_fovas` DISABLE KEYS */;
INSERT INTO `t_dim_fovas` VALUES (1,'Never'),(2,'Less than once a month'),(3,'Once a month'),(4,'More than once a month'),(5,'Once a week'),(6,'More than once a week'),(7,'Once a day'),(8,'Several times a day'),(9,'Other');
/*!40000 ALTER TABLE `t_dim_fovas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_gender`
--

DROP TABLE IF EXISTS `t_dim_gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_gender` (
                                `genderCode` int DEFAULT NULL,
                                `genderName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_gender`
--

LOCK TABLES `t_dim_gender` WRITE;
/*!40000 ALTER TABLE `t_dim_gender` DISABLE KEYS */;
INSERT INTO `t_dim_gender` VALUES (1,'Male'),(2,'Female');
/*!40000 ALTER TABLE `t_dim_gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_hic`
--

DROP TABLE IF EXISTS `t_dim_hic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_hic` (
                             `HICCode` int DEFAULT NULL,
                             `HICName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_hic`
--

LOCK TABLES `t_dim_hic` WRITE;
/*!40000 ALTER TABLE `t_dim_hic` DISABLE KEYS */;
INSERT INTO `t_dim_hic` VALUES (1,'AUD'),(2,'BRL'),(3,'GBP'),(4,'CAD'),(5,'CNY'),(6,'EUR'),(7,'INR'),(8,'JPY'),(9,'MXN'),(10,'RUB'),(11,'KRW'),(12,'USD'),(13,'Other');
/*!40000 ALTER TABLE `t_dim_hic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_htfa`
--

DROP TABLE IF EXISTS `t_dim_htfa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_htfa` (
                              `HTFACode` int DEFAULT NULL,
                              `HTFAName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_htfa`
--

LOCK TABLES `t_dim_htfa` WRITE;
/*!40000 ALTER TABLE `t_dim_htfa` DISABLE KEYS */;
INSERT INTO `t_dim_htfa` VALUES (1,'I compare several apps in order to choose the best ones.'),(2,'I download the first app that I see on the list of apps presented to me.'),(3,'I look for apps that are featured on the front page of the app store.'),(4,'I look at the top downloads chart.'),(5,'I browse randomly for apps that might interest me.'),(7,'I search the app store using keywords/name.'),(8,'I visit websites that review apps.'),(9,'I use search engines.'),(10,'Other');
/*!40000 ALTER TABLE `t_dim_htfa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_loe`
--

DROP TABLE IF EXISTS `t_dim_loe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_loe` (
                             `LOECode` int DEFAULT NULL,
                             `LOEName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_loe`
--

LOCK TABLES `t_dim_loe` WRITE;
/*!40000 ALTER TABLE `t_dim_loe` DISABLE KEYS */;
INSERT INTO `t_dim_loe` VALUES (1,'Primary school'),(2,'Secondary/High school'),(3,'Diploma'),(4,'Vocational training'),(5,'Undergraduate degree'),(6,'Master\'s degree'),(7,'Doctoral degree'),(8,'Other');
/*!40000 ALTER TABLE `t_dim_loe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_lohi`
--

DROP TABLE IF EXISTS `t_dim_lohi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_lohi` (
                              `LOHICode` int DEFAULT NULL,
                              `LOHIName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_lohi`
--

LOCK TABLES `t_dim_lohi` WRITE;
/*!40000 ALTER TABLE `t_dim_lohi` DISABLE KEYS */;
INSERT INTO `t_dim_lohi` VALUES (1,'Low'),(2,'Medium'),(3,'High'),(4,'Prefer not to say');
/*!40000 ALTER TABLE `t_dim_lohi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_ms`
--

DROP TABLE IF EXISTS `t_dim_ms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_ms` (
                            `MSCode` int DEFAULT NULL,
                            `MSName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_ms`
--

LOCK TABLES `t_dim_ms` WRITE;
/*!40000 ALTER TABLE `t_dim_ms` DISABLE KEYS */;
INSERT INTO `t_dim_ms` VALUES (1,'In a relationship'),(2,'Single'),(3,'Married'),(4,'Divorced'),(5,'Widowed'),(6,'Separated'),(7,'Other');
/*!40000 ALTER TABLE `t_dim_ms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_nationality`
--

DROP TABLE IF EXISTS `t_dim_nationality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_nationality` (
                                     `nationalityCode` int DEFAULT NULL,
                                     `nationalityName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_nationality`
--

LOCK TABLES `t_dim_nationality` WRITE;
/*!40000 ALTER TABLE `t_dim_nationality` DISABLE KEYS */;
INSERT INTO `t_dim_nationality` VALUES (1,'United States'),(2,'Australia'),(3,'Brazil'),(4,'United Kingdom'),(5,'Canada'),(6,'China'),(7,'France'),(8,'Germany'),(9,'India'),(10,'Italy'),(11,'Japan'),(12,'Mexico'),(13,'Russian Federation'),(14,'Republic of Korea'),(15,'Spain'),(16,'Other');
/*!40000 ALTER TABLE `t_dim_nationality` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_occupation`
--

DROP TABLE IF EXISTS `t_dim_occupation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_occupation` (
                                    `occupationCode` int DEFAULT NULL,
                                    `occupationName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_occupation`
--

LOCK TABLES `t_dim_occupation` WRITE;
/*!40000 ALTER TABLE `t_dim_occupation` DISABLE KEYS */;
INSERT INTO `t_dim_occupation` VALUES (1,'Management'),(2,'Business and Financial Operations'),(3,'Computer and Mathematical'),(4,'Architecture and Engineering'),(5,'Life, Physical, and Social Science'),(6,'Community and Social Services'),(7,'Legal'),(8,'Education, Training, and Library'),(9,'Arts, Design, Entertainment, Sports, and Media'),(10,'Healthcare Practitioners and Technical'),(11,'Healthcare Support'),(12,'Protective Service'),(13,'Food Preparation and Serving Related'),(14,'Building and Grounds Cleaning and Maintenance'),(15,'Personal Care and Service'),(16,'Sales and Related'),(17,'Office and Administrative Support'),(18,'Farming, Fishing, and Forestry'),(19,'Construction and Extraction'),(20,'Installation, Maintenance, and Repair'),(21,'Production'),(22,'Transportation and Material Moving'),(23,'Military Specific'),(24,'Student'),(25,'Other');
/*!40000 ALTER TABLE `t_dim_occupation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_rfda`
--

DROP TABLE IF EXISTS `t_dim_rfda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_rfda` (
                              `RFDACode` int DEFAULT NULL,
                              `RFDAName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_rfda`
--

LOCK TABLES `t_dim_rfda` WRITE;
/*!40000 ALTER TABLE `t_dim_rfda` DISABLE KEYS */;
INSERT INTO `t_dim_rfda` VALUES (1,'To interact with friends and/or family.'),(2,'To interact with people I do not know.'),(3,'To help me carry out a task.'),(4,'It is featured in the app store.'),(5,'It is on the top downloads chart.'),(6,'It is advertised in the apps that I am using.'),(7,'For entertainment.'),(8,'Out of curiosity.'),(9,'An impulsive purchase.'),(10,'It features brands or celebrities that I like.'),(11,'It was mentioned in the media.'),(12,'It is an extension of the website that I use.'),(13,'It is recommended by friends and/or family.'),(14,'For someone else.'),(15,'Other');
/*!40000 ALTER TABLE `t_dim_rfda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_rfra`
--

DROP TABLE IF EXISTS `t_dim_rfra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_rfra` (
                              `RFRACode` int DEFAULT NULL,
                              `RFRAName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_rfra`
--

LOCK TABLES `t_dim_rfra` WRITE;
/*!40000 ALTER TABLE `t_dim_rfra` DISABLE KEYS */;
INSERT INTO `t_dim_rfra` VALUES (1,'I do not rate apps.'),(2,'To let other users to know that the app is good.'),(3,'Someone asked me to do so.'),(4,'The app asked me to rate it.'),(5,'To let other users know that the app is bad.'),(6,'The app rewards me for rating it.'),(7,'Other');
/*!40000 ALTER TABLE `t_dim_rfra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_rfsm`
--

DROP TABLE IF EXISTS `t_dim_rfsm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_rfsm` (
                              `RFSMCode` int DEFAULT NULL,
                              `RFSMName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_rfsm`
--

LOCK TABLES `t_dim_rfsm` WRITE;
/*!40000 ALTER TABLE `t_dim_rfsm` DISABLE KEYS */;
INSERT INTO `t_dim_rfsm` VALUES (1,'I do not pay for apps.'),(2,'To remove ads from the app.'),(3,'The paid app is on sale for a reduced price.'),(4,'To subscribe to free content.'),(5,'The app is initially free but I have to pay for features that I want.'),(6,'I can not find a free app with similar features.'),(7,'To get additional features or content for a paid app.'),(8,'To subscribe to paid content.'),(9,'The paid app appears to be of better quality.'),(10,'Other'),(11,'I think paid apps have better quality.'),(12,'I think paid apps have more features.');
/*!40000 ALTER TABLE `t_dim_rfsm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_rfsu`
--

DROP TABLE IF EXISTS `t_dim_rfsu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_rfsu` (
                              `RFSUCode` int DEFAULT NULL,
                              `RFSUName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_rfsu`
--

LOCK TABLES `t_dim_rfsu` WRITE;
/*!40000 ALTER TABLE `t_dim_rfsu` DISABLE KEYS */;
INSERT INTO `t_dim_rfsu` VALUES (1,'It crashes.'),(2,'I found better alternatives.'),(3,'The ads are annoying.'),(4,'It is difficult to use.'),(5,'It is no longer used by my friends and/or family.'),(6,'I need to pay extra for the features I need.'),(7,'I forgot about the app.'),(8,'I do not need the features it provides.'),(9,'It invades my privacy.'),(10,'It is too slow.'),(11,'I got bored about it.'),(12,'It does not work.'),(13,'It does not have the features I hoped for.'),(14,'Other'),(15,'I do not need it anymore.');
/*!40000 ALTER TABLE `t_dim_rfsu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_toad`
--

DROP TABLE IF EXISTS `t_dim_toad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_toad` (
                              `TOADCode` int DEFAULT NULL,
                              `TOADName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_toad`
--

LOCK TABLES `t_dim_toad` WRITE;
/*!40000 ALTER TABLE `t_dim_toad` DISABLE KEYS */;
INSERT INTO `t_dim_toad` VALUES (1,'Navigation'),(2,'Business'),(3,'Catalogues'),(4,'Travel'),(5,'Books'),(6,'Photo & video'),(7,'Lifestyle'),(8,'Entertainment'),(9,'Finance'),(10,'News'),(11,'Travel'),(12,'Health & fitness'),(13,'Games'),(14,'Food & drink'),(15,'Education'),(16,'Medical'),(17,'Social networking'),(18,'Reference'),(19,'Sports'),(20,'Utilities'),(21,'Weather'),(22,'Productivity'),(23,'Other'),(24,'Cannot remember or never use app');
/*!40000 ALTER TABLE `t_dim_toad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dim_ttfa`
--

DROP TABLE IF EXISTS `t_dim_ttfa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dim_ttfa` (
                              `TTFACode` int DEFAULT NULL,
                              `TTFAName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dim_ttfa`
--

LOCK TABLES `t_dim_ttfa` WRITE;
/*!40000 ALTER TABLE `t_dim_ttfa` DISABLE KEYS */;
INSERT INTO `t_dim_ttfa` VALUES (1,'When feeling depressed.'),(2,'When I need to carry out a task.'),(3,'When I am feeling bored.'),(4,'When I want to be entertained.'),(5,'When I need to know something.'),(6,'Other');
/*!40000 ALTER TABLE `t_dim_ttfa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-13 17:38:56