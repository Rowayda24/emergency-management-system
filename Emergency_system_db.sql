-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: emergencysystem
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `ambulances`
--

DROP TABLE IF EXISTS `ambulances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ambulances` (
  `AMBULANCE_ID` int NOT NULL,
  `AMBULANCE_NO` int DEFAULT NULL,
  `DRIVER_NAME` varchar(100) DEFAULT NULL,
  `AMBULANCE_STATUS` varchar(50) DEFAULT NULL,
  `GPS_LOCATION` text,
  `PHONE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`AMBULANCE_ID`),
  UNIQUE KEY `AMBULANCE_NO` (`AMBULANCE_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ambulances`
--

LOCK TABLES `ambulances` WRITE;
/*!40000 ALTER TABLE `ambulances` DISABLE KEYS */;
/*!40000 ALTER TABLE `ambulances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_locations`
--

DROP TABLE IF EXISTS `department_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_locations` (
  `LOCATION_ID` int NOT NULL,
  `DEPARTMENT_ID` int DEFAULT NULL,
  `BUILDING_NAME` varchar(50) DEFAULT NULL,
  `FLOOR_NUMBER` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`LOCATION_ID`),
  KEY `DEPARTMENT_ID` (`DEPARTMENT_ID`),
  CONSTRAINT `department_locations_ibfk_1` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_locations`
--

LOCK TABLES `department_locations` WRITE;
/*!40000 ALTER TABLE `department_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `DEPARTMENT_ID` int NOT NULL,
  `HOSPITAL_ID` int DEFAULT NULL,
  `DEPARTMENT_NAME` varchar(100) DEFAULT NULL,
  `DEPARTMENT_CODE` varchar(50) DEFAULT NULL,
  `DEPARTMENT_LOCATION` text,
  `PHONE` varchar(20) DEFAULT NULL,
  `CHAIRMAN_DOCTOR_ID` int DEFAULT NULL,
  `CHAIRMAN_STARTDATE` date DEFAULT NULL,
  PRIMARY KEY (`DEPARTMENT_ID`),
  UNIQUE KEY `DEPARTMENT_NAME` (`DEPARTMENT_NAME`),
  UNIQUE KEY `DEPARTMENT_CODE` (`DEPARTMENT_CODE`),
  KEY `CHAIRMAN_DOCTOR_ID` (`CHAIRMAN_DOCTOR_ID`),
  KEY `HOSPITAL_ID` (`HOSPITAL_ID`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`CHAIRMAN_DOCTOR_ID`) REFERENCES `doctors` (`DOCTOR_ID`),
  CONSTRAINT `departments_ibfk_2` FOREIGN KEY (`HOSPITAL_ID`) REFERENCES `hospital` (`HOSPITAL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `DOCTOR_ID` int NOT NULL,
  `SSN` int DEFAULT NULL,
  `FNAME` varchar(50) DEFAULT NULL,
  `LNAME` varchar(50) DEFAULT NULL,
  `GENDER` varchar(1) DEFAULT NULL,
  `BIRTHDATE` date DEFAULT NULL,
  `SPECIALTY` varchar(50) DEFAULT NULL,
  `DEGREE` varchar(50) DEFAULT NULL,
  `PHONE` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `JOIN_DATE` date DEFAULT NULL,
  `DEPARTMENT_ID` int DEFAULT NULL,
  PRIMARY KEY (`DOCTOR_ID`),
  UNIQUE KEY `SSN` (`SSN`),
  UNIQUE KEY `EMAIL` (`EMAIL`),
  KEY `DEPARTMENT_ID` (`DEPARTMENT_ID`),
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emergency_cases`
--

DROP TABLE IF EXISTS `emergency_cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emergency_cases` (
  `CASE_ID` int NOT NULL,
  `PATIENT_ID` int DEFAULT NULL,
  `DOCTOR_ID` int DEFAULT NULL,
  `ROOM_ID` int DEFAULT NULL,
  `AMBULANCE_ID` int DEFAULT NULL,
  `ARRIVAL_TIME` time DEFAULT NULL,
  `DISCHARGE_TIME` time DEFAULT NULL,
  `TRIAGE_LEVEL` varchar(1) DEFAULT NULL,
  `ARRIVAL_METHOD` varchar(50) DEFAULT NULL,
  `CASE_STATUS` text,
  `SYMPTOMS` text,
  `DIAGNOSIS` varchar(100) DEFAULT NULL,
  `NOTES` text,
  `HEART_RATE` varchar(50) DEFAULT NULL,
  `TEMP` varchar(50) DEFAULT NULL,
  `BP` varchar(50) DEFAULT NULL,
  `DATE_ISSUED` date DEFAULT NULL,
  PRIMARY KEY (`CASE_ID`),
  KEY `PATIENT_ID` (`PATIENT_ID`),
  KEY `DOCTOR_ID` (`DOCTOR_ID`),
  KEY `ROOM_ID` (`ROOM_ID`),
  KEY `AMBULANCE_ID` (`AMBULANCE_ID`),
  CONSTRAINT `emergency_cases_ibfk_1` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patients` (`PATIENT_ID`),
  CONSTRAINT `emergency_cases_ibfk_2` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctors` (`DOCTOR_ID`),
  CONSTRAINT `emergency_cases_ibfk_3` FOREIGN KEY (`ROOM_ID`) REFERENCES `rooms` (`ROOM_ID`),
  CONSTRAINT `emergency_cases_ibfk_4` FOREIGN KEY (`AMBULANCE_ID`) REFERENCES `ambulances` (`AMBULANCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emergency_cases`
--

LOCK TABLES `emergency_cases` WRITE;
/*!40000 ALTER TABLE `emergency_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `emergency_cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital`
--

DROP TABLE IF EXISTS `hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital` (
  `HOSPITAL_ID` int NOT NULL,
  `HOSPITAL_NAME` varchar(100) DEFAULT NULL,
  `PHONE` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`HOSPITAL_ID`),
  UNIQUE KEY `EMAIL` (`EMAIL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital`
--

LOCK TABLES `hospital` WRITE;
/*!40000 ALTER TABLE `hospital` DISABLE KEYS */;
/*!40000 ALTER TABLE `hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investigating`
--

DROP TABLE IF EXISTS `investigating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `investigating` (
  `INVESTIGATING_ID` int NOT NULL,
  `DOCTOR_ID` int DEFAULT NULL,
  `PATIENT_ID` int DEFAULT NULL,
  `INVESTIGATING_DATE` date DEFAULT NULL,
  `HOURS_PER_WEEK` float DEFAULT NULL,
  `NOTES` text,
  PRIMARY KEY (`INVESTIGATING_ID`),
  KEY `DOCTOR_ID` (`DOCTOR_ID`),
  KEY `PATIENT_ID` (`PATIENT_ID`),
  CONSTRAINT `investigating_ibfk_1` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctors` (`DOCTOR_ID`),
  CONSTRAINT `investigating_ibfk_2` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patients` (`PATIENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investigating`
--

LOCK TABLES `investigating` WRITE;
/*!40000 ALTER TABLE `investigating` DISABLE KEYS */;
/*!40000 ALTER TABLE `investigating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_kit`
--

DROP TABLE IF EXISTS `medical_kit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_kit` (
  `KIT_ID` int NOT NULL,
  `KIT_CODE` varchar(50) DEFAULT NULL,
  `KIT_NAME` varchar(50) DEFAULT NULL,
  `KIT_TYPE` varchar(50) DEFAULT NULL,
  `KIT_STATUS` varchar(50) DEFAULT NULL,
  `QUANTITY` int DEFAULT NULL,
  `EXPIRATION_DATE` date DEFAULT NULL,
  `DEPARTMENT_ID` int DEFAULT NULL,
  `ROOM_ID` int DEFAULT NULL,
  PRIMARY KEY (`KIT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_kit`
--

LOCK TABLES `medical_kit` WRITE;
/*!40000 ALTER TABLE `medical_kit` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_kit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medications`
--

DROP TABLE IF EXISTS `medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medications` (
  `MEDICATION_ID` int NOT NULL,
  `MEDICATION_NAME` varchar(100) DEFAULT NULL,
  `MEDICATION_DESCRIPTION` text,
  `SIDE_EFFECTS` text,
  PRIMARY KEY (`MEDICATION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medications`
--

LOCK TABLES `medications` WRITE;
/*!40000 ALTER TABLE `medications` DISABLE KEYS */;
/*!40000 ALTER TABLE `medications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses`
--

DROP TABLE IF EXISTS `nurses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurses` (
  `NURSE_ID` int NOT NULL,
  `SSN` int DEFAULT NULL,
  `FNAME` varchar(50) DEFAULT NULL,
  `LNAME` varchar(50) DEFAULT NULL,
  `GENDER` varchar(1) DEFAULT NULL,
  `BIRTHDATE` date DEFAULT NULL,
  `PHONE` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `SHIFT_TYPE` varchar(50) DEFAULT NULL,
  `DEPARTMENT_ID` int DEFAULT NULL,
  PRIMARY KEY (`NURSE_ID`),
  UNIQUE KEY `SSN` (`SSN`),
  UNIQUE KEY `EMAIL` (`EMAIL`),
  KEY `DEPARTMENT_ID` (`DEPARTMENT_ID`),
  CONSTRAINT `nurses_ibfk_1` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses`
--

LOCK TABLES `nurses` WRITE;
/*!40000 ALTER TABLE `nurses` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses_assignments`
--

DROP TABLE IF EXISTS `nurses_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurses_assignments` (
  `ASSIGNMENT_ID` int NOT NULL,
  `NURSE_ID` int DEFAULT NULL,
  `CASE_ID` int DEFAULT NULL,
  `ASSIGNMENT_TIME` time DEFAULT NULL,
  `NOTES` text,
  PRIMARY KEY (`ASSIGNMENT_ID`),
  KEY `NURSE_ID` (`NURSE_ID`),
  KEY `CASE_ID` (`CASE_ID`),
  CONSTRAINT `nurses_assignments_ibfk_1` FOREIGN KEY (`NURSE_ID`) REFERENCES `nurses` (`NURSE_ID`),
  CONSTRAINT `nurses_assignments_ibfk_2` FOREIGN KEY (`CASE_ID`) REFERENCES `emergency_cases` (`CASE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses_assignments`
--

LOCK TABLES `nurses_assignments` WRITE;
/*!40000 ALTER TABLE `nurses_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurses_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `PATIENT_ID` int NOT NULL,
  `PATIENT_NO` int DEFAULT NULL,
  `SSN` int DEFAULT NULL,
  `FNAME` varchar(50) DEFAULT NULL,
  `LNAME` varchar(50) DEFAULT NULL,
  `GENDER` varchar(1) DEFAULT NULL,
  `BIRTH_DATE` date DEFAULT NULL,
  `PHONE` varchar(20) DEFAULT NULL,
  `BLOODTYPE` varchar(5) DEFAULT NULL,
  `ADDRESS` text,
  `ALLERGIES` text,
  `MEDICAL_HISTORY` text,
  `EMERGENCY_CONTACT_NAME` varchar(100) DEFAULT NULL,
  `EMERGENCY_CONTACT_PHONE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`PATIENT_ID`),
  UNIQUE KEY `PATIENT_NO` (`PATIENT_NO`),
  UNIQUE KEY `SSN` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `PAYMENT_ID` int NOT NULL,
  `CASE_ID` int DEFAULT NULL,
  `AMOUNT` float DEFAULT NULL,
  `PAYMENT_METHOD` varchar(1) DEFAULT NULL,
  `PAYMENT_STATUS` varchar(50) DEFAULT NULL,
  `PAYMENT_DATE` date DEFAULT NULL,
  `INSURANCE_PROVIDOR` varchar(100) DEFAULT NULL,
  `TRANSACTION_REFRENCES` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`PAYMENT_ID`),
  KEY `CASE_ID` (`CASE_ID`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`CASE_ID`) REFERENCES `emergency_cases` (`CASE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription_details`
--

DROP TABLE IF EXISTS `prescription_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription_details` (
  `PRESCRIPTION_DETAILS_ID` int NOT NULL,
  `PRESCRIPTION_ID` int DEFAULT NULL,
  `MEDICATION_ID` int DEFAULT NULL,
  `DOSAGE` varchar(50) DEFAULT NULL,
  `FREQUANCY` varchar(50) DEFAULT NULL,
  `START_DATE` date DEFAULT NULL,
  `END_DATE` date DEFAULT NULL,
  `DIRECTIONS` text,
  PRIMARY KEY (`PRESCRIPTION_DETAILS_ID`),
  KEY `PRESCRIPTION_ID` (`PRESCRIPTION_ID`),
  KEY `MEDICATION_ID` (`MEDICATION_ID`),
  CONSTRAINT `prescription_details_ibfk_1` FOREIGN KEY (`PRESCRIPTION_ID`) REFERENCES `prescriptions` (`PRESCRIPTION_ID`),
  CONSTRAINT `prescription_details_ibfk_2` FOREIGN KEY (`MEDICATION_ID`) REFERENCES `medications` (`MEDICATION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription_details`
--

LOCK TABLES `prescription_details` WRITE;
/*!40000 ALTER TABLE `prescription_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `prescription_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescriptions` (
  `PRESCRIPTION_ID` int NOT NULL,
  `CASE_ID` int DEFAULT NULL,
  `DOCTOR_ID` int DEFAULT NULL,
  `PRESCRIPTION_DATE` date DEFAULT NULL,
  `NOTES` text,
  PRIMARY KEY (`PRESCRIPTION_ID`),
  KEY `CASE_ID` (`CASE_ID`),
  KEY `DOCTOR_ID` (`DOCTOR_ID`),
  CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`CASE_ID`) REFERENCES `emergency_cases` (`CASE_ID`),
  CONSTRAINT `prescriptions_ibfk_2` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctors` (`DOCTOR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescriptions`
--

LOCK TABLES `prescriptions` WRITE;
/*!40000 ALTER TABLE `prescriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `prescriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refunds`
--

DROP TABLE IF EXISTS `refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refunds` (
  `REFUND_ID` int NOT NULL,
  `PAYMENT_ID` int DEFAULT NULL,
  `REFUND_AMOUNT` float DEFAULT NULL,
  `REFUND_DATE` date DEFAULT NULL,
  `REFUND_REASON` text,
  `REFUND_STATUS` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`REFUND_ID`),
  KEY `PAYMENT_ID` (`PAYMENT_ID`),
  CONSTRAINT `refunds_ibfk_1` FOREIGN KEY (`PAYMENT_ID`) REFERENCES `payments` (`PAYMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refunds`
--

LOCK TABLES `refunds` WRITE;
/*!40000 ALTER TABLE `refunds` DISABLE KEYS */;
/*!40000 ALTER TABLE `refunds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `ROOM_ID` int NOT NULL,
  `ROOM_NO` int DEFAULT NULL,
  `ROOM_TYPE` varchar(50) DEFAULT NULL,
  `CAPACITY` varchar(50) DEFAULT NULL,
  `AVAILABILITY_STATUS` varchar(1) DEFAULT NULL,
  `DEPARTMENT_ID` int DEFAULT NULL,
  PRIMARY KEY (`ROOM_ID`),
  UNIQUE KEY `ROOM_NO` (`ROOM_NO`),
  KEY `DEPARTMENT_ID` (`DEPARTMENT_ID`),
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_accounts`
--

DROP TABLE IF EXISTS `user_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_accounts` (
  `USER_ID` int NOT NULL,
  `USERNAME` varchar(50) DEFAULT NULL,
  `PASSWORD_HASH` varchar(50) DEFAULT NULL,
  `USER_ROLE` varchar(50) DEFAULT NULL,
  `LAST_LOGIN` datetime DEFAULT NULL,
  `DOCTOR_ID` int DEFAULT NULL,
  `PATIENT_ID` int DEFAULT NULL,
  `NURSE_ID` int DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `USERNAME` (`USERNAME`),
  KEY `PATIENT_ID` (`PATIENT_ID`),
  KEY `DOCTOR_ID` (`DOCTOR_ID`),
  KEY `NURSE_ID` (`NURSE_ID`),
  CONSTRAINT `user_accounts_ibfk_1` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patients` (`PATIENT_ID`),
  CONSTRAINT `user_accounts_ibfk_2` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctors` (`DOCTOR_ID`),
  CONSTRAINT `user_accounts_ibfk_3` FOREIGN KEY (`NURSE_ID`) REFERENCES `nurses` (`NURSE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_accounts`
--

LOCK TABLES `user_accounts` WRITE;
/*!40000 ALTER TABLE `user_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-13 13:37:00
