-- MySQL dump 10.13  Distrib 5.7.30, for Linux (x86_64)
--
-- Host: localhost    Database: tia_db
-- ------------------------------------------------------
-- Server version	5.7.30-0ubuntu0.18.04.1

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
-- Table structure for table `course_tbl`
--

DROP TABLE IF EXISTS `course_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_tbl` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_code` varchar(50) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `course_desc` text NOT NULL,
  `course_units` int(11) NOT NULL,
  `course_img` varchar(255) NOT NULL,
  `course_sem` int(11) NOT NULL,
  `course_publish` int(11) DEFAULT '0',
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_tbl`
--

LOCK TABLES `course_tbl` WRITE;
/*!40000 ALTER TABLE `course_tbl` DISABLE KEYS */;
INSERT INTO `course_tbl` VALUES (1,'CS100','Fundamentals of Algorithms','This course covers the fundamental concepts and principles of algorithms; program logic formulation using flowcharts and pseudocodes; problem-solving techniques and strategies; algorithm analysis and design; searching and sorting algorithms.',3,'/images/courses/course_img-1587498814272',1,0),(2,'CS200','Principles of Programming Languages','This course covers the significant concepts and principles of programming languages necessary to improve the student’s abilities to develop effective algorithms and use of existing programming constructs, increase their vocabularies of useful programming ',3,'/images/courses/course_img-1587499145117',1,0),(3,'CS201A','Data Structures and Algorithms Analysis','The course focuses on data abstraction, data structure, analysis and design of algorithms, and object-oriented techniques. Classic data structure – lists, queues, stacks, tress, tables, graphs - shall emphasize on the analysis of implementation techniques',4,'/images/no-thumbnail.jpg',1,0),(5,'CS301','Software Engineering 1','Topics included in this course are: development of software intensive system, software quality factors, software engineering principles, system life cycle models and paradigms, requirements definition and analysis, behavioural specification, software desi',3,'/images/no-thumbnail.jpg',1,0),(6,'CS302','Modeling and Simulation','This course introduces a wide range of problem solving techniques, methods, and tools to improve decision-making and efficieny of computer-based systems, such as mathematical optimization, computer simulation, queueing theory and other stochastic-process ',3,'/images/courses/course_img-1587499399751',1,0),(7,'CS305','Computer Security','This course provides an introduction to information security with emphasis on cybersecurity. It provides awareness on social engineering techniques such as phishing and password harvesting. A discussion on risk assessment is also covered in the course. ',3,'/images/courses/course_img-1587499464110',1,0),(22,'CS402','Internship In Computing','The course aims to provide knowledge and skills about the social and ethical responsibility in preparation for professional practice and develop student’s competitiveness and employability by providing opportunities to develop winners’ mindset and actual ',3,'/images/courses/course_img-1587564064569',1,0),(23,'IT201','Web Programming','This course provides the students with the fundamental understanding of web programming using the current programming language in constructing web pages.',3,'/images/courses/course_img-1588338588651',1,0),(24,'ITL102','E-commerce and Web design','This course focuses on principles of e-commerce from a business perspective, providing an overview of business and technology topics, business models, virtual value chains, and social innovation and marketing strategies. In addition, some of the major issues associated with e-commerce—security, privacy, intellectual property rights, authentication, encryption, acceptable use policies, and legal liabilities—will be explored. Students will build their own web presence and market it using an online platform.',3,'/images/courses/course_img-1588339047350',2,0);
/*!40000 ALTER TABLE `course_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_tbl`
--

DROP TABLE IF EXISTS `exam_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_tbl` (
  `exam_id` varchar(255) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `exam_title` varchar(255) NOT NULL,
  `exam_items` int(11) NOT NULL,
  `exam_instruction` text NOT NULL,
  `exam_time` int(11) NOT NULL,
  `exam_lo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `exam_published` int(11) DEFAULT '0',
  PRIMARY KEY (`exam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_tbl`
--

LOCK TABLES `exam_tbl` WRITE;
/*!40000 ALTER TABLE `exam_tbl` DISABLE KEYS */;
INSERT INTO `exam_tbl` VALUES ('b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,24,'Midterm Exam in ITL102',10,'Click the LETTER that corresponds to your answer.  Good Luck!',10,'[{\"lo_id\":58,\"n_test_item\":2,\"lo_topic\":\"Introduction to HTML and CSS\"},{\"lo_id\":59,\"n_test_item\":2,\"lo_topic\":\"HTML tags for text, links, lists\"},{\"lo_id\":60,\"n_test_item\":2,\"lo_topic\":\"Forms\"},{\"lo_id\":61,\"n_test_item\":2,\"lo_topic\":\"Table\"},{\"lo_id\":62,\"n_test_item\":2,\"lo_topic\":\"HTML tags for FRAMES\"}]',1);
/*!40000 ALTER TABLE `exam_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_analysis_tbl`
--

DROP TABLE IF EXISTS `item_analysis_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_analysis_tbl` (
  `analysis_id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` varchar(255) NOT NULL,
  `student_id` int(11) NOT NULL,
  `question_identifier` varchar(255) NOT NULL,
  `score` int(11) NOT NULL,
  PRIMARY KEY (`analysis_id`)
) ENGINE=InnoDB AUTO_INCREMENT=400 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_analysis_tbl`
--

LOCK TABLES `item_analysis_tbl` WRITE;
/*!40000 ALTER TABLE `item_analysis_tbl` DISABLE KEYS */;
INSERT INTO `item_analysis_tbl` VALUES (330,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,'d9f1c3488fafa938e02fccc9a424633c9775f2407cde179ad166ee70af60ffec',1),(331,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,'f4df0375247aa000cecb664f8bb139476b2a3ef0c2acfcdc14751e9ae80be059',1),(332,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,'4a61dfb91f73424ea5868da98380e9da2d108426bfe5ef5851956e8759d88212',0),(333,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,'113d91b88ef6b5f46976f072a092ca442d8c6fa8db51ec896677e676efbe9368',0),(334,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,'7b174f58b2604f580270215ada5eeac4384886a76befa60594df7b5e186b7de8',1),(335,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,'91bd109b4a160c2cb0c758021c76b0eae8eb0e5141a70b981325662e0816f558',1),(336,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,'7f64f7a33239bc5d94857a5d6b2123c13a23f87bd7e89fd4f2237d706e3ef481',0),(337,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,'0c9386a651760e0408f6e0b1451a5e705121c09506058b09e329062d7166dc62',1),(338,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,'9d8232d072d4d5e218b623e55498c4720431ee34f13e31f9f56cec1a25f68be6',0),(339,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',56,'8f587187763b815fd5a7e2170646737c77dfca3f4930bef9a852dd40bdbd4f5b',1),(340,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',53,'d9f1c3488fafa938e02fccc9a424633c9775f2407cde179ad166ee70af60ffec',1),(341,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',53,'f4df0375247aa000cecb664f8bb139476b2a3ef0c2acfcdc14751e9ae80be059',1),(342,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',53,'4a61dfb91f73424ea5868da98380e9da2d108426bfe5ef5851956e8759d88212',1),(343,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',53,'113d91b88ef6b5f46976f072a092ca442d8c6fa8db51ec896677e676efbe9368',0),(344,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',53,'7b174f58b2604f580270215ada5eeac4384886a76befa60594df7b5e186b7de8',0),(345,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',53,'91bd109b4a160c2cb0c758021c76b0eae8eb0e5141a70b981325662e0816f558',0),(346,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',53,'7f64f7a33239bc5d94857a5d6b2123c13a23f87bd7e89fd4f2237d706e3ef481',1),(347,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',53,'0c9386a651760e0408f6e0b1451a5e705121c09506058b09e329062d7166dc62',1),(348,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',53,'9d8232d072d4d5e218b623e55498c4720431ee34f13e31f9f56cec1a25f68be6',0),(349,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',53,'8f587187763b815fd5a7e2170646737c77dfca3f4930bef9a852dd40bdbd4f5b',1),(350,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',54,'d9f1c3488fafa938e02fccc9a424633c9775f2407cde179ad166ee70af60ffec',1),(351,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',54,'f4df0375247aa000cecb664f8bb139476b2a3ef0c2acfcdc14751e9ae80be059',0),(352,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',54,'4a61dfb91f73424ea5868da98380e9da2d108426bfe5ef5851956e8759d88212',1),(353,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',54,'113d91b88ef6b5f46976f072a092ca442d8c6fa8db51ec896677e676efbe9368',0),(354,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',54,'7b174f58b2604f580270215ada5eeac4384886a76befa60594df7b5e186b7de8',0),(355,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',54,'91bd109b4a160c2cb0c758021c76b0eae8eb0e5141a70b981325662e0816f558',1),(356,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',54,'7f64f7a33239bc5d94857a5d6b2123c13a23f87bd7e89fd4f2237d706e3ef481',1),(357,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',54,'0c9386a651760e0408f6e0b1451a5e705121c09506058b09e329062d7166dc62',1),(358,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',54,'9d8232d072d4d5e218b623e55498c4720431ee34f13e31f9f56cec1a25f68be6',1),(359,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',54,'8f587187763b815fd5a7e2170646737c77dfca3f4930bef9a852dd40bdbd4f5b',1),(360,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',55,'d9f1c3488fafa938e02fccc9a424633c9775f2407cde179ad166ee70af60ffec',0),(361,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',55,'f4df0375247aa000cecb664f8bb139476b2a3ef0c2acfcdc14751e9ae80be059',0),(362,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',55,'4a61dfb91f73424ea5868da98380e9da2d108426bfe5ef5851956e8759d88212',1),(363,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',55,'113d91b88ef6b5f46976f072a092ca442d8c6fa8db51ec896677e676efbe9368',0),(364,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',55,'7b174f58b2604f580270215ada5eeac4384886a76befa60594df7b5e186b7de8',0),(365,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',55,'91bd109b4a160c2cb0c758021c76b0eae8eb0e5141a70b981325662e0816f558',0),(366,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',55,'7f64f7a33239bc5d94857a5d6b2123c13a23f87bd7e89fd4f2237d706e3ef481',0),(367,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',55,'0c9386a651760e0408f6e0b1451a5e705121c09506058b09e329062d7166dc62',0),(368,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',55,'9d8232d072d4d5e218b623e55498c4720431ee34f13e31f9f56cec1a25f68be6',0),(369,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',55,'8f587187763b815fd5a7e2170646737c77dfca3f4930bef9a852dd40bdbd4f5b',1),(370,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',57,'d9f1c3488fafa938e02fccc9a424633c9775f2407cde179ad166ee70af60ffec',1),(371,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',57,'f4df0375247aa000cecb664f8bb139476b2a3ef0c2acfcdc14751e9ae80be059',1),(372,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',57,'4a61dfb91f73424ea5868da98380e9da2d108426bfe5ef5851956e8759d88212',1),(373,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',57,'113d91b88ef6b5f46976f072a092ca442d8c6fa8db51ec896677e676efbe9368',1),(374,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',57,'7b174f58b2604f580270215ada5eeac4384886a76befa60594df7b5e186b7de8',0),(375,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',57,'91bd109b4a160c2cb0c758021c76b0eae8eb0e5141a70b981325662e0816f558',1),(376,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',57,'7f64f7a33239bc5d94857a5d6b2123c13a23f87bd7e89fd4f2237d706e3ef481',1),(377,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',57,'0c9386a651760e0408f6e0b1451a5e705121c09506058b09e329062d7166dc62',1),(378,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',57,'9d8232d072d4d5e218b623e55498c4720431ee34f13e31f9f56cec1a25f68be6',0),(379,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',57,'8f587187763b815fd5a7e2170646737c77dfca3f4930bef9a852dd40bdbd4f5b',1),(380,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,'d9f1c3488fafa938e02fccc9a424633c9775f2407cde179ad166ee70af60ffec',0),(381,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,'f4df0375247aa000cecb664f8bb139476b2a3ef0c2acfcdc14751e9ae80be059',1),(382,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,'4a61dfb91f73424ea5868da98380e9da2d108426bfe5ef5851956e8759d88212',1),(383,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,'113d91b88ef6b5f46976f072a092ca442d8c6fa8db51ec896677e676efbe9368',0),(384,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,'7b174f58b2604f580270215ada5eeac4384886a76befa60594df7b5e186b7de8',0),(385,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,'91bd109b4a160c2cb0c758021c76b0eae8eb0e5141a70b981325662e0816f558',1),(386,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,'7f64f7a33239bc5d94857a5d6b2123c13a23f87bd7e89fd4f2237d706e3ef481',1),(387,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,'0c9386a651760e0408f6e0b1451a5e705121c09506058b09e329062d7166dc62',1),(388,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,'9d8232d072d4d5e218b623e55498c4720431ee34f13e31f9f56cec1a25f68be6',0),(389,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,'8f587187763b815fd5a7e2170646737c77dfca3f4930bef9a852dd40bdbd4f5b',0),(390,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,'d9f1c3488fafa938e02fccc9a424633c9775f2407cde179ad166ee70af60ffec',1),(391,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,'f4df0375247aa000cecb664f8bb139476b2a3ef0c2acfcdc14751e9ae80be059',1),(392,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,'4a61dfb91f73424ea5868da98380e9da2d108426bfe5ef5851956e8759d88212',1),(393,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,'113d91b88ef6b5f46976f072a092ca442d8c6fa8db51ec896677e676efbe9368',1),(394,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,'7b174f58b2604f580270215ada5eeac4384886a76befa60594df7b5e186b7de8',0),(395,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,'91bd109b4a160c2cb0c758021c76b0eae8eb0e5141a70b981325662e0816f558',1),(396,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,'7f64f7a33239bc5d94857a5d6b2123c13a23f87bd7e89fd4f2237d706e3ef481',1),(397,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,'0c9386a651760e0408f6e0b1451a5e705121c09506058b09e329062d7166dc62',1),(398,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,'9d8232d072d4d5e218b623e55498c4720431ee34f13e31f9f56cec1a25f68be6',0),(399,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,'8f587187763b815fd5a7e2170646737c77dfca3f4930bef9a852dd40bdbd4f5b',1);
/*!40000 ALTER TABLE `item_analysis_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_tbl`
--

DROP TABLE IF EXISTS `items_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` varchar(255) NOT NULL,
  `lo_id` int(11) NOT NULL,
  `item_no` int(11) NOT NULL,
  `question_id` varchar(255) DEFAULT NULL,
  `visibility` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_tbl`
--

LOCK TABLES `items_tbl` WRITE;
/*!40000 ALTER TABLE `items_tbl` DISABLE KEYS */;
INSERT INTO `items_tbl` VALUES (25,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,1,'d9f1c3488fafa938e02fccc9a424633c9775f2407cde179ad166ee70af60ffec',1),(26,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',58,2,'f4df0375247aa000cecb664f8bb139476b2a3ef0c2acfcdc14751e9ae80be059',1),(27,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,3,'4a61dfb91f73424ea5868da98380e9da2d108426bfe5ef5851956e8759d88212',1),(28,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',59,4,'113d91b88ef6b5f46976f072a092ca442d8c6fa8db51ec896677e676efbe9368',1),(29,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',60,5,'7b174f58b2604f580270215ada5eeac4384886a76befa60594df7b5e186b7de8',1),(30,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',60,6,'91bd109b4a160c2cb0c758021c76b0eae8eb0e5141a70b981325662e0816f558',1),(31,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',61,7,'7f64f7a33239bc5d94857a5d6b2123c13a23f87bd7e89fd4f2237d706e3ef481',1),(32,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',61,8,'0c9386a651760e0408f6e0b1451a5e705121c09506058b09e329062d7166dc62',1),(33,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',62,9,'9d8232d072d4d5e218b623e55498c4720431ee34f13e31f9f56cec1a25f68be6',1),(34,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',62,10,'8f587187763b815fd5a7e2170646737c77dfca3f4930bef9a852dd40bdbd4f5b',1);
/*!40000 ALTER TABLE `items_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_tbl`
--

DROP TABLE IF EXISTS `learning_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_tbl` (
  `lo_id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `lo_topic` varchar(255) NOT NULL,
  `lo_desc` text NOT NULL,
  `lo_time` int(11) NOT NULL,
  PRIMARY KEY (`lo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_tbl`
--

LOCK TABLES `learning_tbl` WRITE;
/*!40000 ALTER TABLE `learning_tbl` DISABLE KEYS */;
INSERT INTO `learning_tbl` VALUES (55,48,1,'Recognize the importance of software engineering','Recognize the importance of software engineering',1),(58,56,24,'Introduction to HTML and CSS','Design and develop basic web pages using HTML and CSS.',1),(59,56,24,'HTML tags for text, links, lists','Design and develop basic web pages using HTML.',1),(60,56,24,'Forms','Create a simple Form in HTML',1),(61,56,24,'Table','Create a table with links to another webpage.',1),(62,56,24,'HTML tags for FRAMES','Design and develop a webpage using Frames.',1);
/*!40000 ALTER TABLE `learning_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loading_tbl`
--

DROP TABLE IF EXISTS `loading_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loading_tbl` (
  `loading_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `who_assign_id` int(11) NOT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`loading_id`),
  KEY `course_id` (`course_id`),
  KEY `teacher_id` (`teacher_id`),
  CONSTRAINT `loading_tbl_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course_tbl` (`course_id`),
  CONSTRAINT `loading_tbl_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `user_tbl` (`teacher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loading_tbl`
--

LOCK TABLES `loading_tbl` WRITE;
/*!40000 ALTER TABLE `loading_tbl` DISABLE KEYS */;
INSERT INTO `loading_tbl` VALUES (20,1,48,48,0),(29,1,53,48,0),(30,1,54,48,0),(31,1,55,48,0),(32,1,56,48,0),(33,1,57,48,0),(34,1,58,48,0),(35,1,59,48,0),(40,23,48,48,0),(41,24,56,56,0),(42,24,53,56,0),(43,24,54,56,0),(44,24,55,56,0),(45,24,57,56,0),(46,24,58,56,0),(47,24,59,56,0),(48,24,48,56,0);
/*!40000 ALTER TABLE `loading_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_tbl`
--

DROP TABLE IF EXISTS `question_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_tbl` (
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `lo_id` int(11) NOT NULL,
  `exam_id` varchar(255) DEFAULT NULL,
  `question_identifier` varchar(255) NOT NULL,
  `question_name` varchar(255) NOT NULL,
  `question_type` varchar(255) DEFAULT NULL,
  `question_desc` text NOT NULL,
  `question_pa_1` varchar(255) NOT NULL,
  `question_pa_2` varchar(255) NOT NULL,
  `question_pa_3` varchar(255) NOT NULL,
  `question_pa_4` varchar(255) NOT NULL,
  `question_correct` varchar(255) NOT NULL,
  `question_pts` int(11) NOT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_tbl`
--

LOCK TABLES `question_tbl` WRITE;
/*!40000 ALTER TABLE `question_tbl` DISABLE KEYS */;
INSERT INTO `question_tbl` VALUES (228,56,24,58,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4','d9f1c3488fafa938e02fccc9a424633c9775f2407cde179ad166ee70af60ffec','What does HTML stand for?',NULL,'What does HTML stand for?','Higher Text Methods Loop','Hyper Text Markup Language','Hyper Text Measuring Language','Hyper Talk Marketing Language','B',1),(229,56,24,58,NULL,'55af6a617b2bdf004309ef404f9b4ee9872a1a372c12f94a1054c74aeadd208f','Question 3',NULL,'Who invented HTML?','Tim Berners\' Lee','Blaise Pascal','Charles Babbage','Bill Gates','A',1),(230,56,24,58,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4','f4df0375247aa000cecb664f8bb139476b2a3ef0c2acfcdc14751e9ae80be059','Question 4',NULL,'What made most of the HTML Structure?','Symbols','Commands','Numbers','Tags','D',1),(231,56,24,59,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4','4a61dfb91f73424ea5868da98380e9da2d108426bfe5ef5851956e8759d88212','Question 1',NULL,'An Absolute path is what a server needs to locate the FILE being requested.','True','Maybe','False','None of the Above','A',1),(232,56,24,59,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4','113d91b88ef6b5f46976f072a092ca442d8c6fa8db51ec896677e676efbe9368','Question 2',NULL,'Every HTML Document should have what?','A head section followed by the body','A title section, and within it a header, followed by a body','A body and a header','None of the above ','A',1),(233,56,24,59,NULL,'7ce50787addb6a790cdd5fd658bf4b60615468e137899297ba67183cdd2da785','Question 3',NULL,'What is the tag beginning the section of the Web page that is visible to the viewer/user?','<Head></Head>','<Body></Body>','<Title></Title>','<Html></Html>','B',1),(234,56,24,59,NULL,'c3659f3c2ba5d877318b9406e683e328d71307114d469a3958875cbfbb472775','Question 4',NULL,'Which tag would insert a graphic into a Web page?','<P>P....Glass.jpeg....</P>','<Img file=Glass.jpeg></img>','<Picture=\"Glass.jpeg\"></Picture>','<Img src=\"Glass.jpeg\"> </Img>','D',1),(235,56,24,60,NULL,'53b785011898952d40d4c4e7521016ea6907acf8ca3012d627cf14476bc9c286','Question1',NULL,'If you wanted to display a list of two hundred countries which control should you use?','radio button','checkbox','select list','slide widget','C',1),(236,56,24,60,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4','7b174f58b2604f580270215ada5eeac4384886a76befa60594df7b5e186b7de8','Question 2',NULL,'Which of the following is most true?','The <option> tag does not have a value attribute. If selected, it passes its displayed value.','The <option> tag only passes values through its value attributes. The displayed value is never displayed','The <option> tag passes values through the value tag if it is present, and passes the value displayed if the value attribute is not given.','The purpose of the <option> tag is to specify the type of control to use, not to pass values.','C',1),(237,56,24,60,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4','91bd109b4a160c2cb0c758021c76b0eae8eb0e5141a70b981325662e0816f558','Question 3',NULL,'The default behavior of the select list control is to: ','Display a series of checkboxes',' a drop down list','Display a list in a window with a scroll bar based upon the size attribute.','A select list does not have default behavior.','B',1),(238,56,24,60,NULL,'a05b846375160f0d7dc3ce260a7dff0511bdaf80096c187cfc3be2b514be7fa5','Question 4',NULL,'The developer can choose to allow more than one option to be selected by choosing the ____?____ attribute.','one','multiple','two','HTML does not provide an attribute that allows the developer to enable more than one option to be selectable on a list.','B',1),(239,56,24,60,NULL,'0a04e9b3b54e639ff7f0d5c7bf118323e4ef7073813d34ac0f2ec0f93017953b','Question 5',NULL,'The primary reason for specifying a <input> tag as hidden is:','To ensure the value typed into the field is not visible.','To enable the control to become invisible under specific circumstances.','To pass information to a CGI (JSP) program that does not and should not change.','HTML does not allow <input> tags to be specified as hidden.','C',1),(240,56,24,60,NULL,'aee072daf1a5b2f16ea038df79dc1fb13bc8411759a90f3f5ad21ab0f9d0fcc4','Question 6',NULL,'In order to clear the values in a form, the developer specifies a <input> tag as:','empty','clear','refresh','reset','D',1),(241,56,24,60,NULL,'d1fbc0d78b23f0b8ca8303bcf5a51e8f4a2449eb50255570fa844d215fba7853','Question 7',NULL,'You can mask the input typed into a text field by specifying an <input> tag as ____?____','password','secure','invisible','hidden','A',1),(242,56,24,60,NULL,'ea7544f7fdeb8b1aef0d2eb9a4a9e9613675d918776437e55bc8a89f6ae08568','Question 8',NULL,'The <input> tag has several kinds of controls which are dictated by the ______?______ attribute.','SRC','value','name','type','D',1),(243,56,24,61,NULL,'63fb8da349b36557d93a79a4bb8446552bb75a6b34463e25b27923431163f319','2',NULL,'In HTML tables gap between two cells of same tables are known as','cell difference','cell spacing','cell padding','None of the Above','B',1),(244,56,24,61,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4','7f64f7a33239bc5d94857a5d6b2123c13a23f87bd7e89fd4f2237d706e3ef481','3',NULL,'In HTML tables, table Header us defined by:','<tr> tag','<th> tag','<td> tag','<t head> tag','B',1),(245,56,24,61,NULL,'ac6cf14b3e40ca83424185b9d541a9164930f3bd2756a74afe1f3c5b17731b00','4',NULL,'If you want to merge two or more rows in a table which attribute you can use?','Rowmerge','Rowspan','Colmerge','Colspan','B',1),(246,56,24,61,NULL,'a1b74d0f61f736acf179cc209dfd46ae62125c5ba16df03d879a8ee656c19a67','4',NULL,'Which of the following elements is used for creating a separate table footer?','<footer>','<sepfooter>','<tfoot>','None of the Above','C',1),(247,56,24,61,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4','0c9386a651760e0408f6e0b1451a5e705121c09506058b09e329062d7166dc62','6',NULL,'For adding styles in HTML Tables, what properties can we use?','J-Query','CSS','Java','Php','B',1),(248,56,24,62,NULL,'9c2df9ca83ff5a17c63b333a0c7c2d530ca2b279ffef6035b33f5425bd3689f7','1',NULL,'Which inline function embeds an independent HTML document into current document?<','<div>','<span>','<iframe>','<form>','C',1),(249,56,24,62,NULL,'96458eb0a8d2432ec1ba1469067d86fdbb001dea176082428aec763b03e9b39b','3',NULL,'What is the use of iframe in HTML?','To display a webpage  within a webpage','to display a webpage with animation effect','to display a webpage without browser','All of the above','A',1),(251,56,24,62,NULL,'0a2ff24ec7104addab586be5870587caa965103ea733513993f22829ad0b220c','5',NULL,'<p id=\"greeting\" class=\"hello world\">This is me greeting the world</p>\r\nWhich of the following is the correct behavior with respect to the code above?','Both the classname and paragraph text cannot contain \"world\"','Two different classes \"hello\" and \"world\" will be applied to the paragraph.','The code is invalid because space is not allowed in class attribute\'s valu','One class \"hello world\" will be applied to the paragraph','B',1),(252,56,24,62,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4','9d8232d072d4d5e218b623e55498c4720431ee34f13e31f9f56cec1a25f68be6','6',NULL,'Which of the following is not among \"Best practices\"?','Primarily designed to make your code run faster','Suggested good habits based on experience','Intended to make your code cleaner and more organized','None of the Above','C',1),(253,56,24,62,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4','8f587187763b815fd5a7e2170646737c77dfca3f4930bef9a852dd40bdbd4f5b','7',NULL,'How many elements should your document have?','42','As many as you need or want to make it clear and organized','Less than 128','As few as possibl','B',1),(254,56,24,62,NULL,'6df238e0952b3f16d1bdb96faedf4e817f46f41babde606b80e4dcd0fbfb1da2','8',NULL,'If I told you that an open tag looked like this: <div id=\'mydiv\' class=\'myclass\'>, what would the closing tag look like?','</mydiv','</id>','</div>','None of the given.','C',1),(255,56,24,62,NULL,'006a6a2894843aed0fd2ef86b7ef0fbea707dd618735f5425607c9452d30be70','9',NULL,'What is the difference between HTML and HTTP?','HTTP describes what\'s on the page and HTML allows sites to communicate with each other','HTML describes what\'s on a page and HTTP allows the page to be communicated to a use','HTML and HTTP are the same thing','None of the given.','B',1),(256,56,24,62,NULL,'c14c1c2bd619c3ae0d4f97b8166cfd4b4a9966193cfe1e320d612ba3cbde62c7','10',NULL,'What is the output for the code below? \r\n\r\n&lt;h1&gt;This is a heading &amp; it is the &quot;biggest&quot; one in this page&gt;/h1&lt;','This is a heading & it is the \"biggest\" one in this page','<h1>This is a heading & it is the \"biggest\" one in this page>/h1<','&lt;h1&gt;This is a heading &amp; it is the &quot;biggest&quot; one in this page&gt;/h1&lt;','<h1>This is a heading & it is the \"biggest\" one in this page</h1','B',1);
/*!40000 ALTER TABLE `question_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taken_exam_tbl`
--

DROP TABLE IF EXISTS `taken_exam_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taken_exam_tbl` (
  `taken_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `exam_id` varchar(255) NOT NULL,
  `exam_item` int(11) NOT NULL,
  `exam_score` int(11) NOT NULL,
  PRIMARY KEY (`taken_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taken_exam_tbl`
--

LOCK TABLES `taken_exam_tbl` WRITE;
/*!40000 ALTER TABLE `taken_exam_tbl` DISABLE KEYS */;
INSERT INTO `taken_exam_tbl` VALUES (38,56,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',10,6),(39,53,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',10,6),(40,54,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',10,7),(41,55,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',10,2),(42,57,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',10,8),(43,58,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',10,5),(44,59,'b553c8199bddacf332b5c143f835a0c8fe2c13a9b646918e25fea37f187037c4',10,8);
/*!40000 ALTER TABLE `taken_exam_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tbl`
--

DROP TABLE IF EXISTS `user_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tbl` (
  `teacher_id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `department` varchar(100) NOT NULL,
  `account_type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`teacher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tbl`
--

LOCK TABLES `user_tbl` WRITE;
/*!40000 ALTER TABLE `user_tbl` DISABLE KEYS */;
INSERT INTO `user_tbl` VALUES (48,'Jerone','Alimpia','jeronealimpia@gmail.com','jerone','admin1234','Computer Science',1),(53,'Marione','Suana','marione@gmail.com','marione','admin1234','Computer Science',0),(54,'Vera','Alimpia','vera@gmail.com','vera','admin1234','Computer Science',0),(55,'Vella','Alimpia','j.alimpia@yahoo.com','vella','admin1234','Computer Science',0),(56,'Ana','Dichoso','ana@gmail.com','ana','admin1234','Computer Science',1),(57,'Juan','Dela Cruz','juan@gmail.com','juan','admin1234','Computer Science',0),(58,'Alex','Xander','alex@gmail.com','alex','admin1234','Computer Science',0),(59,'John','Paul','john@gmail.com','john','admin1234','Computer Science',0);
/*!40000 ALTER TABLE `user_tbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-08 16:13:58
