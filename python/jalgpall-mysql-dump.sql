/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.2.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: jalgpall
-- ------------------------------------------------------
-- Server version	12.2.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `klubid`
--

DROP TABLE IF EXISTS `klubid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `klubid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `linn` varchar(50) DEFAULT NULL,
  `nimi` varchar(50) DEFAULT NULL,
  `staadion` varchar(100) DEFAULT NULL,
  `treener` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `klubid`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `klubid` WRITE;
/*!40000 ALTER TABLE `klubid` DISABLE KEYS */;
INSERT INTO `klubid` VALUES
(1,'Manchester','Manchester United','Old Trafford','Ole Gunnar Solskjær'),
(2,'Paris','Paris Saint-Germain','Parc des Princes','Mauricio Pochettino'),
(3,'Munich','Bayern Munich','Allianz Arena','Julian Nagelsmann');
/*!40000 ALTER TABLE `klubid` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `mängijad`
--

DROP TABLE IF EXISTS `mängijad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mängijad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eesnimi` varchar(50) DEFAULT NULL,
  `perekonnanimi` varchar(50) DEFAULT NULL,
  `sünniaeg` date DEFAULT NULL,
  `riik` varchar(50) DEFAULT NULL,
  `klubi` varchar(50) DEFAULT NULL,
  `palk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mängijad`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `mängijad` WRITE;
/*!40000 ALTER TABLE `mängijad` DISABLE KEYS */;
INSERT INTO `mängijad` VALUES
(1,'Cristiano','Ronaldo','1985-02-05','Portugal','Manchester United',50000000),
(2,'Lionel','Messi','1987-06-24','Argentina','Paris Saint-Germain',45000000),
(3,'Neymar','da Silva Santos Júnior','1992-02-05','Brazil','Paris Saint-Germain',35000000),
(4,'Kylian','Mbappé','1998-12-20','France','Paris Saint-Germain',30000000),
(5,'Kevin','De Bruyne','1991-06-28','Belgium','Manchester City',25000000),
(6,'Virgil','van Dijk','1991-07-08','Netherlands','Liverpool',20000000),
(7,'Mohamed','Salah','1992-06-15','Egypt','Liverpool',22000000),
(8,'Sadio','Mané','1992-04-10','Senegal','Liverpool',18000000),
(9,'Robert','Lewandowski','1988-08-21','Poland','Bayern Munich',27000000),
(10,'Erling','Haaland','2000-07-21','Norway','Manchester City',15000000);
/*!40000 ALTER TABLE `mängijad` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `mängud`
--

DROP TABLE IF EXISTS `mängud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mängud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `koduklubi` varchar(50) DEFAULT NULL,
  `võõrklubi` varchar(50) DEFAULT NULL,
  `tulemus` varchar(20) DEFAULT NULL,
  `mängu_alguseaeg` datetime DEFAULT NULL,
  `publiku_arv` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mängud`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `mängud` WRITE;
/*!40000 ALTER TABLE `mängud` DISABLE KEYS */;
INSERT INTO `mängud` VALUES
(1,'Manchester United','Paris Saint-Germain','2-1','2024-08-15 20:00:00',75000),
(2,'Manchester City','Bayern Munich','3-2','2024-08-25 20:00:00',80000);
/*!40000 ALTER TABLE `mängud` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `treenerid`
--

DROP TABLE IF EXISTS `treenerid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `treenerid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eesnimi` varchar(50) DEFAULT NULL,
  `perekonnanimi` varchar(50) DEFAULT NULL,
  `sünniaeg` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treenerid`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `treenerid` WRITE;
/*!40000 ALTER TABLE `treenerid` DISABLE KEYS */;
INSERT INTO `treenerid` VALUES
(1,'Ole Gunnar','Solskjær','1973-02-26'),
(2,'Mauricio','Pochettino','1972-03-02'),
(3,'Julian','Nagelsmann','1987-07-23');
/*!40000 ALTER TABLE `treenerid` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-03-12 13:31:14
