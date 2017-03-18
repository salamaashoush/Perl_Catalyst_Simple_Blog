-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: salamadb
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.21-MariaDB-1~yakkety

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  `content` longtext,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_comments_1_idx` (`pid`),
  KEY `fk_comments_2_idx` (`uid`),
  CONSTRAINT `fk_comments_1` FOREIGN KEY (`pid`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_2` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (4,34,8,'sdsadsadasd','2017-03-18 01:00:34','2017-03-18 01:00:34');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `body` longtext,
  `image` varchar(255) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_new_table_1_idx` (`uid`),
  CONSTRAINT `fk_new_table_1` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (13,'updated   adasd','dsdsd','',NULL,'2017-03-17 20:33:40','2017-03-17 22:11:43'),(14,'test','sadsdsad','',NULL,'2017-03-17 20:34:54','2017-03-17 20:34:54'),(15,'asdasd','asdasdasd',NULL,NULL,'2017-03-17 21:22:30','2017-03-17 21:22:30'),(16,'sdasdasdasdasdsadsa','dsadsadasdas',NULL,NULL,'2017-03-17 21:55:46','2017-03-17 21:55:46'),(17,'sadasd','sadasdasda',NULL,NULL,'2017-03-17 21:56:18','2017-03-17 21:56:18'),(18,'asdsad','sadsadasd',NULL,NULL,'2017-03-17 21:58:06','2017-03-17 21:58:06'),(19,'asdsad','sadsadasd',NULL,NULL,'2017-03-17 21:58:26','2017-03-17 21:58:26'),(20,'sadsad','sadsDAS',NULL,NULL,'2017-03-17 21:58:38','2017-03-17 21:58:38'),(21,'asdsdas','dsadasdasd',NULL,NULL,'2017-03-17 22:01:26','2017-03-17 22:01:26'),(22,'dasdsad','sadasdasd',NULL,NULL,'2017-03-17 22:02:32','2017-03-17 22:02:32'),(23,'asdsad','sadasdsad',NULL,NULL,'2017-03-17 22:03:34','2017-03-17 22:03:34'),(24,'dsadas','dsadasdas',NULL,NULL,'2017-03-17 22:06:45','2017-03-17 22:06:45'),(25,'dsadas','dsadasdas',NULL,NULL,'2017-03-17 22:10:58','2017-03-17 22:10:58'),(27,'sadasd','asdsadas',NULL,NULL,'2017-03-17 22:11:26','2017-03-17 22:11:26'),(28,'sadasdsasdsd sadasd','adasdasdasdasdasd',NULL,NULL,'2017-03-17 22:12:45','2017-03-17 22:12:45'),(29,'sadasdsasdsd sadasd','adasdasdasdasdasd',NULL,NULL,'2017-03-17 22:13:31','2017-03-17 22:13:31'),(30,'asdasdsa','dsadasdas',NULL,NULL,'2017-03-17 22:16:12','2017-03-17 22:16:12'),(31,'asdsad','dsadasdasasdasd',NULL,NULL,'2017-03-17 22:23:36','2017-03-17 22:23:36'),(32,'sdsadasdsad','dsadasdasasdasdsad',NULL,NULL,'2017-03-17 22:25:03','2017-03-17 22:25:03'),(33,'asdasd','asdsadsadsadsad',NULL,NULL,'2017-03-17 23:17:45','2017-03-17 23:17:45'),(34,'ssdasdasd','asdsadadasdas',NULL,8,'2017-03-17 23:19:12','2017-03-17 23:19:12'),(35,'ssss','asdasdasdasd',NULL,8,'2017-03-18 00:09:15','2017-03-18 00:09:15');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `address` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `gender` enum('male','female') NOT NULL DEFAULT 'male',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (8,'admin','admin@admin.admin','123456789','Salama','Ashoush','admin','Elross, khaleeg bahry','YKR7Xt6Hom.jpg','egypt','male','2017-02-28 21:43:03','2017-03-18 01:11:25');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-18  1:13:01
