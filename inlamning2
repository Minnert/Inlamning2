-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: bokhandel
-- ------------------------------------------------------
-- Server version	9.5.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '0c8141f4-bfa2-11f0-a25c-e073e728ed1d:1-15564';

--
-- Table structure for table `bestallning`
--

DROP TABLE IF EXISTS `bestallning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bestallning` (
  `BestallningsID` int NOT NULL AUTO_INCREMENT,
  `KundID` int NOT NULL,
  `Datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Totalbelopp` decimal(10,2) NOT NULL,
  PRIMARY KEY (`BestallningsID`),
  KEY `KundID` (`KundID`),
  CONSTRAINT `bestallning_ibfk_1` FOREIGN KEY (`KundID`) REFERENCES `kund` (`KundID`),
  CONSTRAINT `chk_bestallning_totalbelopp` CHECK ((`Totalbelopp` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallning`
--

LOCK TABLES `bestallning` WRITE;
/*!40000 ALTER TABLE `bestallning` DISABLE KEYS */;
INSERT INTO `bestallning` VALUES (1,1,'2026-03-18 19:59:15',264.00),(2,1,'2026-03-18 19:59:15',119.00),(3,1,'2026-03-18 19:59:15',139.00),(4,2,'2026-03-18 19:59:15',367.00),(5,4,'2026-03-18 19:59:15',129.00);
/*!40000 ALTER TABLE `bestallning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bok`
--

DROP TABLE IF EXISTS `bok`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bok` (
  `BokID` int NOT NULL AUTO_INCREMENT,
  `Titel` varchar(200) NOT NULL,
  `ISBN` varchar(20) NOT NULL,
  `Forfattare` varchar(100) NOT NULL,
  `Pris` decimal(10,2) NOT NULL,
  `Lagersaldo` int NOT NULL,
  PRIMARY KEY (`BokID`),
  UNIQUE KEY `ISBN` (`ISBN`),
  CONSTRAINT `chk_bok_lagersaldo` CHECK ((`Lagersaldo` >= 0)),
  CONSTRAINT `chk_bok_pris` CHECK ((`Pris` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bok`
--

LOCK TABLES `bok` WRITE;
/*!40000 ALTER TABLE `bok` DISABLE KEYS */;
INSERT INTO `bok` VALUES (1,'Sagan om ringen: Ringens brodraskap','9789100123451','J.R.R. Tolkien',129.00,18),(2,'Sagan om ringen: De tva tornen','9789100123452','J.R.R. Tolkien',135.00,17),(3,'Sagan om ringen: Konungens aterkomst','9789100123453','J.R.R. Tolkien',139.00,13),(4,'Bilbo - En hobbits aventyr','9789100123450','J.R.R. Tolkien',119.00,22);
/*!40000 ALTER TABLE `bok` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kund` (
  `KundID` int NOT NULL AUTO_INCREMENT,
  `Namn` varchar(100) NOT NULL,
  `Epost` varchar(100) NOT NULL,
  `Telefon` varchar(30) NOT NULL,
  `Adress` varchar(200) NOT NULL,
  PRIMARY KEY (`KundID`),
  KEY `idx_kund_epost` (`Epost`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES (1,'Frodo Bagger','frodo.bagger@shire.me','070-111 11 11','Baggershus, Fylke'),(2,'Sam Gamgi','sam@shire.me','070-222 22 22','Gamgis gård, Fylke'),(3,'Gandalf Grå','gandalf@valinor.ma','070-333 33 33','Vandraren utan adress'),(4,'Aragorn Elessar','aragorn@gondor.nu','070-444 44 44','Minas Tirith, Gondor'),(5,'Legolas Grönblad','legolas@skogarna.se','070-555 55 55','Mörkaskogen, Midgård');
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kundlogg`
--

DROP TABLE IF EXISTS `kundlogg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kundlogg` (
  `LoggID` int NOT NULL AUTO_INCREMENT,
  `KundID` int NOT NULL,
  `Namn` varchar(100) NOT NULL,
  `Registrerad` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LoggID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundlogg`
--

LOCK TABLES `kundlogg` WRITE;
/*!40000 ALTER TABLE `kundlogg` DISABLE KEYS */;
INSERT INTO `kundlogg` VALUES (1,1,'Frodo Bagger','2026-03-18 20:59:15'),(2,2,'Sam Gamgi','2026-03-18 20:59:15'),(3,3,'Gandalf Grå','2026-03-18 20:59:15'),(4,4,'Aragorn Elessar','2026-03-18 20:59:15'),(5,5,'Legolas Grönblad','2026-03-18 20:59:15');
/*!40000 ALTER TABLE `kundlogg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderrad`
--

DROP TABLE IF EXISTS `orderrad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderrad` (
  `OrderradID` int NOT NULL AUTO_INCREMENT,
  `BestallningsID` int NOT NULL,
  `BokID` int NOT NULL,
  `Antal` int NOT NULL,
  `RadPris` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderradID`),
  KEY `BestallningsID` (`BestallningsID`),
  KEY `BokID` (`BokID`),
  CONSTRAINT `orderrad_ibfk_1` FOREIGN KEY (`BestallningsID`) REFERENCES `bestallning` (`BestallningsID`),
  CONSTRAINT `orderrad_ibfk_2` FOREIGN KEY (`BokID`) REFERENCES `bok` (`BokID`),
  CONSTRAINT `chk_orderrad_antal` CHECK ((`Antal` > 0)),
  CONSTRAINT `chk_orderrad_radpris` CHECK ((`RadPris` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderrad`
--

LOCK TABLES `orderrad` WRITE;
/*!40000 ALTER TABLE `orderrad` DISABLE KEYS */;
INSERT INTO `orderrad` VALUES (1,1,1,1,129.00),(2,1,2,1,135.00),(3,2,4,1,119.00),(4,3,3,1,139.00),(5,4,4,2,238.00),(6,4,3,1,129.00),(7,5,1,1,129.00);
/*!40000 ALTER TABLE `orderrad` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-18 21:03:22
