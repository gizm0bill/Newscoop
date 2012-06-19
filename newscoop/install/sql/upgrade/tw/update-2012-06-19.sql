CREATE TABLE IF NOT EXISTS `tw_mobile_upgrade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue` varchar(80) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A0AAB4EAA76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabulky `tw_mobile_upgrade_device`
--

CREATE TABLE IF NOT EXISTS `tw_mobile_upgrade_device` (
  `id` varchar(80) NOT NULL,
  `upgrade_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A16B670598729BBE` (`upgrade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
