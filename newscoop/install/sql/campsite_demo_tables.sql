-- MySQL dump 10.13  Distrib 5.1.49, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: newscoop
-- ------------------------------------------------------
-- Server version	5.1.49-1ubuntu8.1

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
-- Table structure for table `Aliases`
--

DROP TABLE IF EXISTS `Aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Aliases` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` char(128) NOT NULL DEFAULT '',
  `IdPublication` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ArticleAttachments`
--

DROP TABLE IF EXISTS `ArticleAttachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArticleAttachments` (
  `fk_article_number` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_attachment_id` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `article_attachment_index` (`fk_article_number`,`fk_attachment_id`),
  KEY `fk_article_number` (`fk_article_number`),
  KEY `fk_attachment_id` (`fk_attachment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ArticleAuthors`
--

DROP TABLE IF EXISTS `ArticleAuthors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArticleAuthors` (
  `fk_article_number` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_language_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fk_article_number`,`fk_language_id`,`fk_author_id`,`fk_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ArticleComments`
--

DROP TABLE IF EXISTS `ArticleComments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArticleComments` (
  `fk_article_number` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_language_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_comment_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_first` tinyint(1) NOT NULL DEFAULT '0',
  KEY `fk_comment_id` (`fk_comment_id`),
  KEY `article_index` (`fk_article_number`,`fk_language_id`),
  KEY `first_message_index` (`fk_article_number`,`fk_language_id`,`is_first`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ArticleImages`
--

DROP TABLE IF EXISTS `ArticleImages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArticleImages` (
  `NrArticle` int(10) unsigned NOT NULL DEFAULT '0',
  `IdImage` int(10) unsigned NOT NULL DEFAULT '0',
  `Number` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`NrArticle`,`IdImage`),
  UNIQUE KEY `ArticleImage` (`NrArticle`,`Number`),
  KEY `IdImage` (`IdImage`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ArticleIndex`
--

DROP TABLE IF EXISTS `ArticleIndex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArticleIndex` (
  `IdPublication` int(10) unsigned NOT NULL DEFAULT '0',
  `IdLanguage` int(10) unsigned NOT NULL DEFAULT '0',
  `IdKeyword` int(10) unsigned NOT NULL DEFAULT '0',
  `NrIssue` int(10) unsigned NOT NULL DEFAULT '0',
  `NrSection` int(10) unsigned NOT NULL DEFAULT '0',
  `NrArticle` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`IdPublication`,`IdLanguage`,`IdKeyword`,`NrIssue`,`NrSection`,`NrArticle`),
  UNIQUE KEY `article_keyword_idx` (`NrArticle`,`IdLanguage`,`IdKeyword`),
  KEY `keyword_idx` (`IdKeyword`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ArticlePublish`
--

DROP TABLE IF EXISTS `ArticlePublish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArticlePublish` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_article_number` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_language_id` int(10) unsigned NOT NULL DEFAULT '0',
  `time_action` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_action` enum('P','U') DEFAULT NULL,
  `publish_on_front_page` enum('S','R') DEFAULT NULL,
  `publish_on_section_page` enum('S','R') DEFAULT NULL,
  `is_completed` enum('N','Y') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `article_index` (`fk_article_number`,`fk_language_id`),
  KEY `event_time_index` (`time_action`,`is_completed`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ArticleTopics`
--

DROP TABLE IF EXISTS `ArticleTopics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArticleTopics` (
  `NrArticle` int(10) unsigned NOT NULL DEFAULT '0',
  `TopicId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`NrArticle`,`TopicId`),
  KEY `article_topics_nrarticle_idx` (`NrArticle`),
  KEY `article_topics_topicid_idx` (`TopicId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ArticleTypeMetadata`
--

DROP TABLE IF EXISTS `ArticleTypeMetadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArticleTypeMetadata` (
  `type_name` varchar(166) NOT NULL DEFAULT '',
  `field_name` varchar(166) NOT NULL DEFAULT 'NULL',
  `field_weight` int(11) DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `comments_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `fk_phrase_id` int(10) unsigned DEFAULT NULL,
  `field_type` varchar(255) DEFAULT NULL,
  `field_type_param` varchar(255) DEFAULT NULL,
  `is_content_field` tinyint(1) NOT NULL DEFAULT '0',
  `max_size` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`type_name`,`field_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Articles`
--

DROP TABLE IF EXISTS `Articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Articles` (
  `IdPublication` int(10) unsigned NOT NULL DEFAULT '0',
  `NrIssue` int(10) unsigned NOT NULL DEFAULT '0',
  `NrSection` int(10) unsigned NOT NULL DEFAULT '0',
  `Number` int(10) unsigned NOT NULL DEFAULT '0',
  `IdLanguage` int(10) unsigned NOT NULL DEFAULT '0',
  `Name` varchar(140) NOT NULL DEFAULT '',
  `Type` varchar(70) NOT NULL DEFAULT '',
  `IdUser` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_default_author_id` int(10) unsigned DEFAULT NULL,
  `OnFrontPage` enum('N','Y') NOT NULL DEFAULT 'N',
  `OnSection` enum('N','Y') NOT NULL DEFAULT 'N',
  `Published` enum('N','S','M','Y') NOT NULL DEFAULT 'N',
  `PublishDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UploadDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Keywords` varchar(255) NOT NULL DEFAULT '',
  `Public` enum('N','Y') NOT NULL DEFAULT 'N',
  `IsIndexed` enum('N','Y') NOT NULL DEFAULT 'N',
  `LockUser` int(10) unsigned NOT NULL DEFAULT '0',
  `LockTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ShortName` varchar(32) NOT NULL DEFAULT '',
  `ArticleOrder` int(10) unsigned NOT NULL DEFAULT '0',
  `comments_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `comments_locked` tinyint(1) NOT NULL DEFAULT '0',
  `time_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `object_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`IdPublication`,`NrIssue`,`NrSection`,`Number`,`IdLanguage`),
  UNIQUE KEY `IdPublication` (`IdPublication`,`NrIssue`,`NrSection`,`IdLanguage`,`Name`),
  UNIQUE KEY `Number` (`Number`,`IdLanguage`),
  UNIQUE KEY `other_key` (`IdPublication`,`NrIssue`,`NrSection`,`IdLanguage`,`Number`),
  UNIQUE KEY `ShortName` (`IdPublication`,`NrIssue`,`NrSection`,`IdLanguage`,`ShortName`),
  KEY `Type` (`Type`),
  KEY `ArticleOrderIdx` (`ArticleOrder`),
  FULLTEXT KEY `articles_name_skey` (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Attachments`
--

DROP TABLE IF EXISTS `Attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_language_id` int(10) unsigned DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `extension` varchar(50) DEFAULT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `content_disposition` enum('attachment') DEFAULT NULL,
  `http_charset` varchar(50) DEFAULT NULL,
  `size_in_bytes` bigint(20) unsigned DEFAULT NULL,
  `fk_description_id` int(11) DEFAULT NULL,
  `fk_user_id` int(10) unsigned DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AuthorAliases`
--

DROP TABLE IF EXISTS `AuthorAliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthorAliases` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fk_author_id` int(11) unsigned NOT NULL,
  `alias` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AuthorAssignedTypes`
--

DROP TABLE IF EXISTS `AuthorAssignedTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthorAssignedTypes` (
  `fk_author_id` int(11) unsigned NOT NULL DEFAULT '0',
  `fk_type_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fk_author_id`,`fk_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AuthorBiographies`
--

DROP TABLE IF EXISTS `AuthorBiographies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthorBiographies` (
  `fk_author_id` int(11) unsigned NOT NULL DEFAULT '0',
  `fk_language_id` int(11) unsigned NOT NULL DEFAULT '0',
  `biography` text NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fk_author_id`,`fk_language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AuthorTypes`
--

DROP TABLE IF EXISTS `AuthorTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthorTypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Authors`
--

DROP TABLE IF EXISTS `Authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Authors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL DEFAULT '',
  `last_name` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(255) DEFAULT NULL,
  `type` int(10) unsigned DEFAULT NULL,
  `skype` varchar(255) DEFAULT NULL,
  `jabber` varchar(255) DEFAULT NULL,
  `aim` varchar(255) DEFAULT NULL,
  `biography` text,
  `image` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authors_name_ukey` (`first_name`,`last_name`),
  FULLTEXT KEY `authors_name_skey` (`first_name`,`last_name`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AutoId`
--

DROP TABLE IF EXISTS `AutoId`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoId` (
  `ArticleId` int(10) unsigned NOT NULL DEFAULT '0',
  `LogTStamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TopicId` int(10) unsigned NOT NULL DEFAULT '0',
  `translation_phrase_id` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnumerationElements`
--

DROP TABLE IF EXISTS `EnumerationElements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EnumerationElements` (
  `fk_enumeration_id` int(10) unsigned NOT NULL,
  `element_id` int(10) unsigned NOT NULL,
  `fk_phrase_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`fk_enumeration_id`,`element_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Enumerations`
--

DROP TABLE IF EXISTS `Enumerations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Enumerations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Images`
--

DROP TABLE IF EXISTS `Images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Images` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) NOT NULL DEFAULT '',
  `Photographer` varchar(255) NOT NULL DEFAULT '',
  `Place` varchar(255) NOT NULL DEFAULT '',
  `Caption` varchar(255) NOT NULL DEFAULT '',
  `Date` date NOT NULL DEFAULT '0000-00-00',
  `ContentType` varchar(64) NOT NULL DEFAULT '',
  `Location` enum('local','remote') NOT NULL DEFAULT 'local',
  `URL` varchar(255) NOT NULL DEFAULT '',
  `ThumbnailFileName` varchar(50) NOT NULL DEFAULT '',
  `ImageFileName` varchar(50) NOT NULL DEFAULT '',
  `UploadedByUser` int(11) DEFAULT NULL,
  `LastModified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TimeCreated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Id`),
  FULLTEXT KEY `Description` (`Description`),
  FULLTEXT KEY `Photographer` (`Photographer`),
  FULLTEXT KEY `Place` (`Place`),
  FULLTEXT KEY `Caption` (`Caption`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IssuePublish`
--

DROP TABLE IF EXISTS `IssuePublish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IssuePublish` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_publication_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_issue_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_language_id` int(10) unsigned NOT NULL DEFAULT '0',
  `time_action` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_action` enum('P','U') NOT NULL DEFAULT 'P',
  `do_publish_articles` enum('N','Y') NOT NULL DEFAULT 'Y',
  `is_completed` enum('N','Y') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `issue_index` (`fk_publication_id`,`fk_issue_id`,`fk_language_id`),
  KEY `action_time_index` (`time_action`,`is_completed`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Issues`
--

DROP TABLE IF EXISTS `Issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Issues` (
  `IdPublication` int(10) unsigned NOT NULL DEFAULT '0',
  `Number` int(10) unsigned NOT NULL DEFAULT '0',
  `IdLanguage` int(10) unsigned NOT NULL DEFAULT '0',
  `Name` varchar(140) NOT NULL DEFAULT '',
  `PublicationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Published` enum('N','Y') NOT NULL DEFAULT 'N',
  `IssueTplId` int(10) unsigned DEFAULT NULL,
  `SectionTplId` int(10) unsigned DEFAULT NULL,
  `ArticleTplId` int(10) unsigned DEFAULT NULL,
  `ShortName` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`IdPublication`,`Number`,`IdLanguage`),
  UNIQUE KEY `ShortName` (`IdPublication`,`IdLanguage`,`ShortName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `KeywordIndex`
--

DROP TABLE IF EXISTS `KeywordIndex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `KeywordIndex` (
  `Keyword` varchar(70) NOT NULL DEFAULT '',
  `Id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Keyword`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LocationContents`
--

DROP TABLE IF EXISTS `LocationContents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LocationContents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `poi_name` varchar(1023) NOT NULL,
  `poi_link` varchar(1023) NOT NULL DEFAULT '',
  `poi_perex` varchar(15100) NOT NULL DEFAULT '',
  `poi_content_type` tinyint(4) NOT NULL DEFAULT '0',
  `poi_content` text NOT NULL,
  `poi_text` text NOT NULL,
  `IdUser` int(10) unsigned NOT NULL DEFAULT '0',
  `time_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `location_contents_poi_name` (`poi_name`(64))
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Locations`
--

DROP TABLE IF EXISTS `Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `poi_location` geometry NOT NULL,
  `poi_type` varchar(40) NOT NULL,
  `poi_type_style` int(11) NOT NULL DEFAULT '0',
  `poi_center` point NOT NULL,
  `poi_radius` double NOT NULL DEFAULT '0',
  `IdUser` int(10) unsigned NOT NULL DEFAULT '0',
  `time_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  SPATIAL KEY `locations_poi_location` (`poi_location`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Log`
--

DROP TABLE IF EXISTS `Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Log` (
  `time_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fk_event_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_user_id` int(10) unsigned DEFAULT NULL,
  `text` varchar(255) NOT NULL DEFAULT '',
  `user_ip` int(10) unsigned DEFAULT NULL,
  KEY `IdEvent` (`fk_event_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MapLocationLanguages`
--

DROP TABLE IF EXISTS `MapLocationLanguages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MapLocationLanguages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_maplocation_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_language_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_content_id` int(10) unsigned NOT NULL DEFAULT '0',
  `poi_display` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `map_location_languages_maplocation_id` (`fk_maplocation_id`),
  KEY `map_location_languages_content_id` (`fk_content_id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MapLocationMultimedia`
--

DROP TABLE IF EXISTS `MapLocationMultimedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MapLocationMultimedia` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_maplocation_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_multimedia_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `maplocationmultimedia_maplocation_id` (`fk_maplocation_id`),
  KEY `maplocationmultimedia_multimedia_id` (`fk_multimedia_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MapLocations`
--

DROP TABLE IF EXISTS `MapLocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MapLocations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_map_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_location_id` int(10) unsigned NOT NULL DEFAULT '0',
  `poi_style` varchar(1023) NOT NULL,
  `rank` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `map_locations_point_id` (`fk_location_id`),
  KEY `map_locations_map_id` (`fk_map_id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Maps`
--

DROP TABLE IF EXISTS `Maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Maps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_article_number` int(10) unsigned NOT NULL DEFAULT '0',
  `MapRank` int(10) unsigned NOT NULL DEFAULT '1',
  `MapUsage` tinyint(4) NOT NULL DEFAULT '1',
  `MapCenterLongitude` double NOT NULL DEFAULT '0',
  `MapCenterLatitude` double NOT NULL DEFAULT '0',
  `MapDisplayResolution` smallint(6) NOT NULL DEFAULT '0',
  `MapProvider` varchar(255) NOT NULL DEFAULT '',
  `MapWidth` int(11) NOT NULL DEFAULT '0',
  `MapHeight` int(11) NOT NULL DEFAULT '0',
  `MapName` varchar(1023) NOT NULL,
  `IdUser` int(10) unsigned NOT NULL DEFAULT '0',
  `time_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `maps_article_number` (`fk_article_number`),
  KEY `maps_map_name` (`MapName`(64))
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Multimedia`
--

DROP TABLE IF EXISTS `Multimedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Multimedia` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `media_type` varchar(255) NOT NULL DEFAULT '',
  `media_spec` varchar(255) NOT NULL DEFAULT '',
  `media_src` varchar(1023) NOT NULL DEFAULT '',
  `media_height` int(11) NOT NULL DEFAULT '0',
  `media_width` int(11) NOT NULL DEFAULT '0',
  `options` varchar(1023) NOT NULL DEFAULT '',
  `IdUser` int(10) unsigned NOT NULL DEFAULT '0',
  `time_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `multimedia_media_type` (`media_type`(32)),
  KEY `multimedia_media_src` (`media_src`(64))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ObjectTypes`
--

DROP TABLE IF EXISTS `ObjectTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ObjectTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `OBJECTTYPES_NAME` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Plugins`
--

DROP TABLE IF EXISTS `Plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Plugins` (
  `Name` varchar(255) NOT NULL,
  `Version` varchar(255) NOT NULL DEFAULT '',
  `Enabled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Publications`
--

DROP TABLE IF EXISTS `Publications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Publications` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL DEFAULT '',
  `IdDefaultLanguage` int(10) unsigned NOT NULL DEFAULT '0',
  `TimeUnit` enum('D','W','M','Y') NOT NULL DEFAULT 'D',
  `UnitCost` float(10,2) unsigned NOT NULL DEFAULT '0.00',
  `UnitCostAllLang` float(10,2) unsigned NOT NULL DEFAULT '0.00',
  `Currency` varchar(140) NOT NULL DEFAULT '',
  `TrialTime` int(10) unsigned NOT NULL DEFAULT '0',
  `PaidTime` int(10) unsigned NOT NULL DEFAULT '0',
  `IdDefaultAlias` int(10) unsigned NOT NULL DEFAULT '0',
  `IdURLType` int(10) unsigned NOT NULL DEFAULT '1',
  `fk_forum_id` int(11) DEFAULT NULL,
  `comments_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `comments_article_default_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `comments_subscribers_moderated` tinyint(1) NOT NULL DEFAULT '0',
  `comments_public_moderated` tinyint(1) NOT NULL DEFAULT '0',
  `comments_captcha_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `comments_spam_blocking_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `url_error_tpl_id` int(10) unsigned DEFAULT NULL,
  `seo` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Alias` (`IdDefaultAlias`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RequestObjects`
--

DROP TABLE IF EXISTS `RequestObjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RequestObjects` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_type_id` int(11) NOT NULL DEFAULT '0',
  `request_count` int(11) NOT NULL DEFAULT '0',
  `last_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`object_id`)
) ENGINE=MyISAM AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RequestStats`
--

DROP TABLE IF EXISTS `RequestStats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RequestStats` (
  `object_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `hour` int(11) NOT NULL,
  `request_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`date`,`hour`),
  KEY `stats_object_idx` (`object_id`),
  KEY `stats_object_date_idx` (`object_id`,`date`),
  KEY `stats_object_hour_idx` (`object_id`,`hour`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Requests`
--

DROP TABLE IF EXISTS `Requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Requests` (
  `session_id` varchar(255) NOT NULL,
  `object_id` int(11) NOT NULL,
  `last_stats_update` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`session_id`,`object_id`),
  KEY `requests_session_idx` (`session_id`),
  KEY `requests_object_idx` (`object_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Sections`
--

DROP TABLE IF EXISTS `Sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sections` (
  `IdPublication` int(10) unsigned NOT NULL DEFAULT '0',
  `NrIssue` int(10) unsigned NOT NULL DEFAULT '0',
  `IdLanguage` int(10) unsigned NOT NULL DEFAULT '0',
  `Number` int(10) unsigned NOT NULL DEFAULT '0',
  `Name` varchar(255) NOT NULL DEFAULT '',
  `ShortName` varchar(32) NOT NULL DEFAULT '',
  `Description` blob,
  `SectionTplId` int(10) unsigned DEFAULT NULL,
  `ArticleTplId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`IdPublication`,`NrIssue`,`IdLanguage`,`Number`),
  UNIQUE KEY `IdPublication` (`IdPublication`,`NrIssue`,`IdLanguage`,`Name`),
  UNIQUE KEY `ShortName` (`IdPublication`,`NrIssue`,`IdLanguage`,`ShortName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SubsDefTime`
--

DROP TABLE IF EXISTS `SubsDefTime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SubsDefTime` (
  `CountryCode` char(21) NOT NULL DEFAULT '',
  `IdPublication` int(10) unsigned NOT NULL DEFAULT '0',
  `TrialTime` int(10) unsigned NOT NULL DEFAULT '0',
  `PaidTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`CountryCode`,`IdPublication`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SubsSections`
--

DROP TABLE IF EXISTS `SubsSections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SubsSections` (
  `IdSubscription` int(10) unsigned NOT NULL DEFAULT '0',
  `SectionNumber` int(10) unsigned NOT NULL DEFAULT '0',
  `IdLanguage` int(10) NOT NULL DEFAULT '0',
  `StartDate` date NOT NULL DEFAULT '0000-00-00',
  `Days` int(10) unsigned NOT NULL DEFAULT '0',
  `PaidDays` int(10) unsigned NOT NULL DEFAULT '0',
  `NoticeSent` enum('N','Y') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`IdSubscription`,`SectionNumber`,`IdLanguage`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Subscriptions`
--

DROP TABLE IF EXISTS `Subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Subscriptions` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdUser` int(10) unsigned NOT NULL DEFAULT '0',
  `IdPublication` int(10) unsigned NOT NULL DEFAULT '0',
  `Active` enum('Y','N') NOT NULL DEFAULT 'Y',
  `ToPay` float(10,2) unsigned NOT NULL DEFAULT '0.00',
  `Currency` varchar(70) NOT NULL DEFAULT '',
  `Type` enum('T','P') NOT NULL DEFAULT 'T',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IdUser` (`IdUser`,`IdPublication`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Templates`
--

DROP TABLE IF EXISTS `Templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Templates` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` char(255) NOT NULL DEFAULT '',
  `Type` int(10) unsigned NOT NULL DEFAULT '1',
  `Level` int(10) unsigned NOT NULL DEFAULT '0',
  `CacheLifetime` int(11) DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=MyISAM AUTO_INCREMENT=1228 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TopicFields`
--

DROP TABLE IF EXISTS `TopicFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TopicFields` (
  `ArticleType` varchar(166) NOT NULL DEFAULT '',
  `FieldName` varchar(166) NOT NULL DEFAULT '',
  `RootTopicId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ArticleType`,`FieldName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TopicNames`
--

DROP TABLE IF EXISTS `TopicNames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TopicNames` (
  `fk_topic_id` int(10) unsigned NOT NULL,
  `fk_language_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`fk_topic_id`,`fk_language_id`),
  UNIQUE KEY `fk_language_id` (`fk_language_id`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Topics`
--

DROP TABLE IF EXISTS `Topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Topics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `node_left` int(10) unsigned NOT NULL,
  `node_right` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `node_left` (`node_left`),
  KEY `node_right` (`node_right`)
) ENGINE=MyISAM AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Translations`
--

DROP TABLE IF EXISTS `Translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phrase_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_language_id` int(10) unsigned NOT NULL DEFAULT '0',
  `translation_text` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phrase_language_index` (`phrase_id`,`fk_language_id`),
  KEY `phrase_id` (`phrase_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Xlink`
--

DROP TABLE IF EXISTS `Xlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Xlink` (
  `NrArticle` int(10) unsigned NOT NULL,
  `IdLanguage` int(10) unsigned NOT NULL,
  `Furl` varchar(255) NOT NULL,
  PRIMARY KEY (`NrArticle`,`IdLanguage`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Xnews`
--

DROP TABLE IF EXISTS `Xnews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Xnews` (
  `NrArticle` int(10) unsigned NOT NULL,
  `IdLanguage` int(10) unsigned NOT NULL,
  `Fdeck` mediumblob NOT NULL,
  `Ffull_text` mediumblob NOT NULL,
  `Fhighlight` tinyint(1) NOT NULL,
  PRIMARY KEY (`NrArticle`,`IdLanguage`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Xpage`
--

DROP TABLE IF EXISTS `Xpage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Xpage` (
  `NrArticle` int(10) unsigned NOT NULL,
  `IdLanguage` int(10) unsigned NOT NULL,
  `Ffull_text` mediumblob NOT NULL,
  PRIMARY KEY (`NrArticle`,`IdLanguage`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liveuser_grouprights`
--

DROP TABLE IF EXISTS `liveuser_grouprights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveuser_grouprights` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `right_id` int(11) NOT NULL DEFAULT '0',
  `right_level` int(11) NOT NULL DEFAULT '3',
  UNIQUE KEY `grouprights_id_i_idx` (`group_id`,`right_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liveuser_groups`
--

DROP TABLE IF EXISTS `liveuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveuser_groups` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `group_type` int(11) NOT NULL DEFAULT '0',
  `group_define_name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `groups_define_name_i_idx` (`group_define_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liveuser_groups_group_id_seq`
--

DROP TABLE IF EXISTS `liveuser_groups_group_id_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveuser_groups_group_id_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liveuser_groupusers`
--

DROP TABLE IF EXISTS `liveuser_groupusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveuser_groupusers` (
  `perm_user_id` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `groupusers_id_i_idx` (`perm_user_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liveuser_perm_users`
--

DROP TABLE IF EXISTS `liveuser_perm_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveuser_perm_users` (
  `perm_user_id` int(11) NOT NULL DEFAULT '0',
  `auth_user_id` varchar(32) NOT NULL DEFAULT '',
  `auth_container_name` varchar(32) NOT NULL DEFAULT '',
  `perm_type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`perm_user_id`),
  UNIQUE KEY `perm_users_auth_id_i_idx` (`auth_user_id`,`auth_container_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liveuser_perm_users_perm_user_id_seq`
--

DROP TABLE IF EXISTS `liveuser_perm_users_perm_user_id_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveuser_perm_users_perm_user_id_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liveuser_rights`
--

DROP TABLE IF EXISTS `liveuser_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveuser_rights` (
  `right_id` int(11) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `right_define_name` varchar(32) NOT NULL DEFAULT '',
  `has_implied` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`right_id`),
  UNIQUE KEY `rights_define_name_i_idx` (`area_id`,`right_define_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liveuser_rights_right_id_seq`
--

DROP TABLE IF EXISTS `liveuser_rights_right_id_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveuser_rights_right_id_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=240 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liveuser_users`
--

DROP TABLE IF EXISTS `liveuser_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveuser_users` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `KeyId` int(10) unsigned DEFAULT NULL,
  `Name` varchar(255) NOT NULL DEFAULT '',
  `UName` varchar(70) NOT NULL DEFAULT '',
  `Password` varchar(64) NOT NULL DEFAULT '',
  `EMail` varchar(255) NOT NULL DEFAULT '',
  `Reader` enum('Y','N') NOT NULL DEFAULT 'Y',
  `fk_user_type` int(10) unsigned DEFAULT NULL,
  `City` varchar(100) NOT NULL DEFAULT '',
  `StrAddress` varchar(255) NOT NULL DEFAULT '',
  `State` varchar(32) NOT NULL DEFAULT '',
  `CountryCode` varchar(21) DEFAULT NULL,
  `Phone` varchar(20) NOT NULL DEFAULT '',
  `Fax` varchar(20) NOT NULL DEFAULT '',
  `Contact` varchar(64) NOT NULL DEFAULT '',
  `Phone2` varchar(20) NOT NULL DEFAULT '',
  `Title` enum('Mr.','Mrs.','Ms.','Dr.') NOT NULL DEFAULT 'Mr.',
  `Gender` enum('M','F') DEFAULT NULL,
  `Age` enum('0-17','18-24','25-39','40-49','50-65','65-') NOT NULL DEFAULT '0-17',
  `PostalCode` varchar(70) NOT NULL DEFAULT '',
  `Employer` varchar(140) NOT NULL DEFAULT '',
  `EmployerType` varchar(140) NOT NULL DEFAULT '',
  `Position` varchar(70) NOT NULL DEFAULT '',
  `Interests` mediumblob,
  `How` varchar(255) NOT NULL DEFAULT '',
  `Languages` varchar(100) NOT NULL DEFAULT '',
  `Improvements` mediumblob,
  `Pref1` enum('N','Y') NOT NULL DEFAULT 'N',
  `Pref2` enum('N','Y') NOT NULL DEFAULT 'N',
  `Pref3` enum('N','Y') NOT NULL DEFAULT 'N',
  `Pref4` enum('N','Y') NOT NULL DEFAULT 'N',
  `Field1` varchar(150) NOT NULL DEFAULT '',
  `Field2` varchar(150) NOT NULL DEFAULT '',
  `Field3` varchar(150) NOT NULL DEFAULT '',
  `Field4` varchar(150) NOT NULL DEFAULT '',
  `Field5` varchar(150) NOT NULL DEFAULT '',
  `Text1` mediumblob,
  `Text2` mediumblob,
  `Text3` mediumblob,
  `time_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time_created` timestamp NULL DEFAULT NULL,
  `lastLogin` datetime DEFAULT '1970-01-01 00:00:00',
  `isActive` tinyint(1) DEFAULT '1',
  `password_reset_token` varchar(85) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UName` (`UName`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liveuser_users_auth_user_id_seq`
--

DROP TABLE IF EXISTS `liveuser_users_auth_user_id_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveuser_users_auth_user_id_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_banlists`
--

DROP TABLE IF EXISTS `phorum_banlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_banlists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forum_id` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `pcre` tinyint(4) NOT NULL DEFAULT '0',
  `string` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `forum_id` (`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_files`
--

DROP TABLE IF EXISTS `phorum_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_files` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `filesize` int(11) NOT NULL DEFAULT '0',
  `file_data` mediumtext,
  `add_datetime` int(10) unsigned NOT NULL DEFAULT '0',
  `message_id` int(10) unsigned NOT NULL DEFAULT '0',
  `link` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`file_id`),
  KEY `add_datetime` (`add_datetime`),
  KEY `message_id_link` (`message_id`,`link`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_forum_group_xref`
--

DROP TABLE IF EXISTS `phorum_forum_group_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_forum_group_xref` (
  `forum_id` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  `permission` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`forum_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_forums`
--

DROP TABLE IF EXISTS `phorum_forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_forums` (
  `forum_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `active` smallint(6) NOT NULL DEFAULT '0',
  `description` text,
  `template` varchar(50) NOT NULL DEFAULT '',
  `folder_flag` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `list_length_flat` int(10) unsigned NOT NULL DEFAULT '0',
  `list_length_threaded` int(10) unsigned NOT NULL DEFAULT '0',
  `moderation` int(10) unsigned NOT NULL DEFAULT '0',
  `threaded_list` tinyint(4) NOT NULL DEFAULT '0',
  `threaded_read` tinyint(4) NOT NULL DEFAULT '0',
  `float_to_top` tinyint(4) NOT NULL DEFAULT '0',
  `check_duplicate` tinyint(4) NOT NULL DEFAULT '0',
  `allow_attachment_types` varchar(100) NOT NULL DEFAULT '',
  `max_attachment_size` int(10) unsigned NOT NULL DEFAULT '0',
  `max_totalattachment_size` int(10) unsigned NOT NULL DEFAULT '0',
  `max_attachments` int(10) unsigned NOT NULL DEFAULT '0',
  `pub_perms` int(10) unsigned NOT NULL DEFAULT '0',
  `reg_perms` int(10) unsigned NOT NULL DEFAULT '0',
  `display_ip_address` smallint(5) unsigned NOT NULL DEFAULT '1',
  `allow_email_notify` smallint(5) unsigned NOT NULL DEFAULT '1',
  `language` varchar(100) NOT NULL DEFAULT 'english',
  `email_moderators` tinyint(1) NOT NULL DEFAULT '0',
  `message_count` int(10) unsigned NOT NULL DEFAULT '0',
  `sticky_count` int(10) unsigned NOT NULL DEFAULT '0',
  `thread_count` int(10) unsigned NOT NULL DEFAULT '0',
  `last_post_time` int(10) unsigned NOT NULL DEFAULT '0',
  `display_order` int(10) unsigned NOT NULL DEFAULT '0',
  `read_length` int(10) unsigned NOT NULL DEFAULT '0',
  `vroot` int(10) unsigned NOT NULL DEFAULT '0',
  `edit_post` tinyint(1) NOT NULL DEFAULT '1',
  `template_settings` text,
  `count_views` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `display_fixed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reverse_threading` tinyint(1) NOT NULL DEFAULT '0',
  `inherit_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`forum_id`),
  KEY `name` (`name`),
  KEY `active` (`active`,`parent_id`),
  KEY `group_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_groups`
--

DROP TABLE IF EXISTS `phorum_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '0',
  `open` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_messages`
--

DROP TABLE IF EXISTS `phorum_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_messages` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `forum_id` int(10) unsigned NOT NULL DEFAULT '0',
  `thread` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `author` varchar(37) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `email` varchar(100) NOT NULL DEFAULT '',
  `ip` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '2',
  `msgid` varchar(100) NOT NULL DEFAULT '',
  `modifystamp` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `thread_count` int(10) unsigned NOT NULL DEFAULT '0',
  `moderator_post` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `sort` tinyint(4) NOT NULL DEFAULT '2',
  `datestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `meta` mediumtext NOT NULL,
  `viewcount` int(10) unsigned NOT NULL DEFAULT '0',
  `closed` tinyint(4) NOT NULL DEFAULT '0',
  `thread_depth` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `thread_order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`),
  KEY `thread_message` (`thread`,`message_id`),
  KEY `thread_forum` (`thread`,`forum_id`),
  KEY `special_threads` (`sort`,`forum_id`),
  KEY `status_forum` (`status`,`forum_id`),
  KEY `list_page_float` (`forum_id`,`parent_id`,`modifystamp`),
  KEY `list_page_flat` (`forum_id`,`parent_id`,`thread`),
  KEY `post_count` (`forum_id`,`status`,`parent_id`),
  KEY `dup_check` (`forum_id`,`author`,`subject`,`datestamp`),
  KEY `forum_max_message` (`forum_id`,`message_id`,`status`,`parent_id`),
  KEY `last_post_time` (`forum_id`,`status`,`modifystamp`),
  KEY `next_prev_thread` (`forum_id`,`status`,`thread`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_pm_buddies`
--

DROP TABLE IF EXISTS `phorum_pm_buddies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_pm_buddies` (
  `pm_buddy_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pm_buddy_id`),
  UNIQUE KEY `userids` (`user_id`,`buddy_user_id`),
  KEY `buddy_user_id` (`buddy_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_pm_folders`
--

DROP TABLE IF EXISTS `phorum_pm_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_pm_folders` (
  `pm_folder_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `foldername` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`pm_folder_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_pm_messages`
--

DROP TABLE IF EXISTS `phorum_pm_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_pm_messages` (
  `pm_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `from_username` varchar(50) NOT NULL DEFAULT '',
  `subject` varchar(100) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `datestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `meta` mediumtext NOT NULL,
  PRIMARY KEY (`pm_message_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_pm_xref`
--

DROP TABLE IF EXISTS `phorum_pm_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_pm_xref` (
  `pm_xref_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `pm_folder_id` int(10) unsigned NOT NULL DEFAULT '0',
  `special_folder` varchar(10) DEFAULT NULL,
  `pm_message_id` int(10) unsigned NOT NULL DEFAULT '0',
  `read_flag` tinyint(1) NOT NULL DEFAULT '0',
  `reply_flag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pm_xref_id`),
  KEY `xref` (`user_id`,`pm_folder_id`,`pm_message_id`),
  KEY `read_flag` (`read_flag`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_search`
--

DROP TABLE IF EXISTS `phorum_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_search` (
  `message_id` int(10) unsigned NOT NULL DEFAULT '0',
  `forum_id` int(10) unsigned NOT NULL DEFAULT '0',
  `search_text` mediumtext NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `forum_id` (`forum_id`),
  FULLTEXT KEY `search_text` (`search_text`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_settings`
--

DROP TABLE IF EXISTS `phorum_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_settings` (
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` enum('V','S') NOT NULL DEFAULT 'V',
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_subscribers`
--

DROP TABLE IF EXISTS `phorum_subscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_subscribers` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `forum_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sub_type` int(10) unsigned NOT NULL DEFAULT '0',
  `thread` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`forum_id`,`thread`),
  KEY `forum_id` (`forum_id`,`thread`,`sub_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_user_custom_fields`
--

DROP TABLE IF EXISTS `phorum_user_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_user_custom_fields` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `data` text,
  PRIMARY KEY (`user_id`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_user_group_xref`
--

DROP TABLE IF EXISTS `phorum_user_group_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_user_group_xref` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_user_newflags`
--

DROP TABLE IF EXISTS `phorum_user_newflags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_user_newflags` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `forum_id` int(11) NOT NULL DEFAULT '0',
  `message_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`forum_id`,`message_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_user_permissions`
--

DROP TABLE IF EXISTS `phorum_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_user_permissions` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `forum_id` int(10) unsigned NOT NULL DEFAULT '0',
  `permission` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`forum_id`),
  KEY `forum_id` (`forum_id`,`permission`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phorum_users`
--

DROP TABLE IF EXISTS `phorum_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phorum_users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_campsite_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  `cookie_sessid_lt` varchar(50) NOT NULL DEFAULT '',
  `sessid_st` varchar(50) NOT NULL DEFAULT '',
  `sessid_st_timeout` int(10) unsigned NOT NULL DEFAULT '0',
  `password_temp` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `email_temp` varchar(110) NOT NULL DEFAULT '',
  `hide_email` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `user_data` text,
  `signature` text,
  `threaded_list` tinyint(4) NOT NULL DEFAULT '0',
  `posts` int(10) NOT NULL DEFAULT '0',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `threaded_read` tinyint(4) NOT NULL DEFAULT '0',
  `date_added` int(10) unsigned NOT NULL DEFAULT '0',
  `date_last_active` int(10) unsigned NOT NULL DEFAULT '0',
  `last_active_forum` int(10) unsigned NOT NULL DEFAULT '0',
  `hide_activity` tinyint(1) NOT NULL DEFAULT '0',
  `show_signature` tinyint(1) NOT NULL DEFAULT '0',
  `email_notify` tinyint(1) NOT NULL DEFAULT '0',
  `pm_email_notify` tinyint(1) NOT NULL DEFAULT '1',
  `tz_offset` tinyint(2) NOT NULL DEFAULT '-99',
  `is_dst` tinyint(1) NOT NULL DEFAULT '0',
  `user_language` varchar(100) NOT NULL DEFAULT '',
  `user_template` varchar(100) NOT NULL DEFAULT '',
  `moderator_data` text,
  `moderation_email` tinyint(2) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `fk_campsite_user_id` (`fk_campsite_user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `active` (`active`),
  KEY `userpass` (`username`,`password`),
  KEY `sessid_st` (`sessid_st`),
  KEY `cookie_sessid_lt` (`cookie_sessid_lt`),
  KEY `activity` (`date_last_active`,`hide_activity`,`last_active_forum`),
  KEY `date_added` (`date_added`),
  KEY `email_temp` (`email_temp`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_blog_blog`
--

DROP TABLE IF EXISTS `plugin_blog_blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_blog_blog` (
  `blog_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_language_id` int(10) unsigned NOT NULL,
  `fk_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `info` text NOT NULL,
  `admin_remark` text NOT NULL,
  `request_text` text NOT NULL,
  `status` enum('online','offline','moderated') NOT NULL DEFAULT 'online',
  `admin_status` enum('online','offline','moderated','readonly','pending') NOT NULL DEFAULT 'pending',
  `entries_online` int(10) unsigned NOT NULL DEFAULT '0',
  `entries_offline` int(10) unsigned NOT NULL DEFAULT '0',
  `comments_online` int(10) unsigned NOT NULL,
  `comments_offline` int(10) unsigned NOT NULL,
  `feature` varchar(255) NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`blog_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_blog_comment`
--

DROP TABLE IF EXISTS `plugin_blog_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_blog_comment` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_entry_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_blog_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_language_id` int(10) unsigned NOT NULL,
  `fk_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_name` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `fk_mood_id` varchar(255) NOT NULL,
  `status` enum('online','offline','pending') NOT NULL DEFAULT 'pending',
  `admin_status` enum('online','offline','pending') NOT NULL DEFAULT 'pending',
  `feature` varchar(255) NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_blog_entry`
--

DROP TABLE IF EXISTS `plugin_blog_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_blog_entry` (
  `entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_blog_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_language_id` int(10) unsigned NOT NULL,
  `fk_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `date` datetime NOT NULL,
  `released` datetime NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `fk_mood_id` int(10) unsigned NOT NULL,
  `status` enum('online','offline') NOT NULL DEFAULT 'online',
  `admin_status` enum('online','offline','pending') NOT NULL DEFAULT 'pending',
  `comments_online` int(10) unsigned NOT NULL DEFAULT '0',
  `comments_offline` int(10) unsigned NOT NULL DEFAULT '0',
  `feature` varchar(255) NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_blog_entry_topic`
--

DROP TABLE IF EXISTS `plugin_blog_entry_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_blog_entry_topic` (
  `fk_entry_id` int(10) unsigned NOT NULL,
  `fk_topic_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`fk_entry_id`,`fk_topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_blog_topic`
--

DROP TABLE IF EXISTS `plugin_blog_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_blog_topic` (
  `fk_blog_id` int(10) unsigned NOT NULL,
  `fk_topic_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`fk_blog_id`,`fk_topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_interview_interviews`
--

DROP TABLE IF EXISTS `plugin_interview_interviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_interview_interviews` (
  `interview_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_language_id` int(10) unsigned NOT NULL,
  `fk_moderator_user_id` int(10) unsigned NOT NULL,
  `fk_guest_user_id` int(10) unsigned NOT NULL,
  `title` varchar(256) NOT NULL,
  `fk_image_id` int(10) unsigned DEFAULT NULL,
  `description_short` varchar(256) NOT NULL,
  `description` text NOT NULL,
  `interview_begin` datetime NOT NULL,
  `interview_end` datetime NOT NULL,
  `questions_begin` datetime NOT NULL,
  `questions_end` datetime NOT NULL,
  `questions_limit` int(10) unsigned NOT NULL,
  `status` enum('draft','pending','published','rejected') NOT NULL,
  `invitation_sender` varchar(256) NOT NULL,
  `invitation_subject` varchar(256) NOT NULL,
  `invitation_template_guest` text NOT NULL,
  `invitation_template_questioneer` text NOT NULL,
  `guest_invitation_sent` datetime DEFAULT NULL,
  `questioneer_invitation_sent` datetime DEFAULT NULL,
  `invitation_password` varchar(10) NOT NULL,
  `position` int(10) unsigned NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`interview_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_interview_items`
--

DROP TABLE IF EXISTS `plugin_interview_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_interview_items` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_interview_id` int(10) unsigned NOT NULL,
  `fk_questioneer_user_id` int(11) DEFAULT NULL,
  `question` text NOT NULL,
  `question_date` datetime NOT NULL,
  `status` enum('draft','pending','published','rejected') NOT NULL DEFAULT 'draft',
  `answer` text NOT NULL,
  `answer_date` datetime NOT NULL,
  `position` int(10) unsigned NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_poll`
--

DROP TABLE IF EXISTS `plugin_poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_poll` (
  `poll_nr` int(10) unsigned NOT NULL,
  `fk_language_id` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_poll_nr` int(11) NOT NULL,
  `is_extended` tinyint(4) NOT NULL,
  `title` varchar(255) NOT NULL,
  `question` varchar(255) NOT NULL,
  `date_begin` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  `nr_of_answers` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `votes_per_user` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `nr_of_votes` int(10) unsigned NOT NULL,
  `nr_of_votes_overall` int(10) unsigned NOT NULL,
  `percentage_of_votes_overall` float unsigned NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reset_token` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`poll_nr`,`fk_language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_poll_answer`
--

DROP TABLE IF EXISTS `plugin_poll_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_poll_answer` (
  `fk_poll_nr` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_language_id` int(10) unsigned NOT NULL DEFAULT '0',
  `nr_answer` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `answer` varchar(255) NOT NULL,
  `nr_of_votes` int(10) unsigned NOT NULL DEFAULT '0',
  `percentage` float unsigned NOT NULL,
  `percentage_overall` float unsigned NOT NULL,
  `value` int(11) NOT NULL,
  `average_value` float NOT NULL,
  `on_hitlist` tinyint(4) NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `NrPoll` (`fk_poll_nr`,`fk_language_id`,`nr_answer`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_poll_article`
--

DROP TABLE IF EXISTS `plugin_poll_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_poll_article` (
  `fk_poll_nr` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_article_nr` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_article_language_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`fk_poll_nr`,`fk_article_nr`,`fk_article_language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_poll_issue`
--

DROP TABLE IF EXISTS `plugin_poll_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_poll_issue` (
  `fk_poll_nr` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_issue_nr` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_issue_language_id` int(10) unsigned NOT NULL,
  `fk_publication_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fk_poll_nr`,`fk_issue_nr`,`fk_issue_language_id`,`fk_publication_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_poll_publication`
--

DROP TABLE IF EXISTS `plugin_poll_publication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_poll_publication` (
  `fk_poll_nr` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_publication_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fk_poll_nr`,`fk_publication_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_poll_section`
--

DROP TABLE IF EXISTS `plugin_poll_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_poll_section` (
  `fk_poll_nr` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_section_nr` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_section_language_id` int(10) unsigned NOT NULL,
  `fk_issue_nr` int(10) unsigned NOT NULL DEFAULT '0',
  `fk_publication_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fk_poll_nr`,`fk_section_nr`,`fk_section_language_id`,`fk_issue_nr`,`fk_publication_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_pollanswer_attachment`
--

DROP TABLE IF EXISTS `plugin_pollanswer_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_pollanswer_attachment` (
  `fk_poll_nr` int(11) NOT NULL,
  `fk_pollanswer_nr` int(11) NOT NULL,
  `fk_attachment_id` int(11) NOT NULL,
  PRIMARY KEY (`fk_poll_nr`,`fk_pollanswer_nr`,`fk_attachment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-03-14 15:31:51
