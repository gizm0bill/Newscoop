CREATE TABLE IF NOT EXISTS `ArticleRendition` (
  `image_id` int(11) NOT NULL,
  `rendition_id` varchar(255) NOT NULL,
  `articleNumber` int(11) NOT NULL,
  `imageSpecs` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`articleNumber`,`image_id`,`rendition_id`),
  KEY `IDX_794B8A6C3DA5256D` (`image_id`),
  KEY `IDX_794B8A6CFD656AA1` (`rendition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `package` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rendition_id` varchar(255) DEFAULT NULL,
  `headline` varchar(255) NOT NULL,
  `description` longtext,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_DE686795989D9B62` (`slug`),
  KEY `IDX_DE686795FD656AA1` (`rendition_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `package_article` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `package_article_package` (
  `article_id` int(11) NOT NULL,
  `package_id` int(11) NOT NULL,
  PRIMARY KEY (`article_id`,`package_id`),
  KEY `IDX_BB5F0F827294869C` (`article_id`),
  KEY `IDX_BB5F0F82F44CABFF` (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `package_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `package_id` int(11) DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL,
  `offset` int(11) NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `coords` varchar(255) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A45640D6F44CABFF` (`package_id`),
  KEY `IDX_A45640D63DA5256D` (`image_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `rendition` (
  `name` varchar(255) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `specs` varchar(255) NOT NULL,
  `offset` int(11) DEFAULT NULL,
  `label` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `Images`
    ADD `width` int(5) DEFAULT NULL,
    ADD `height` int(5) DEFAULT NULL;

ALTER TABLE `ArticleImage`
    ADD `is_default` int(1) DEFAULT NULL;
    
--
-- Omezení pro tabulku `package_article_package`
--
ALTER TABLE `package_article_package`
  ADD CONSTRAINT `package_article_package_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `package_article` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `package_article_package_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `package` (`id`) ON DELETE CASCADE;

