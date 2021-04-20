DROP DATABASE   `BarBeerDrinkerSample` ;
CREATE DATABASE  IF NOT EXISTS `BarBeerDrinkerSample` ;
USE `BarBeerDrinkerSample`;

DROP TABLE IF EXISTS `user`;
CREATE TABLE  IF NOT EXISTS `user` (
	`uid` INT(11),
	`uname` varchar(50) NOT NULL unique,
	`password` varchar(50)NOT NULL ,
	`email` varchar(50) NOT NULL ,
	`phone` varchar(50) ,
	`category` varchar(50) NOT NULL DEFAULT 'customer',
	PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `aution`;
CREATE TABLE  IF NOT EXISTS `aution` (
	`aution_id` INT(11),
    PRIMARY KEY (`aution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bid`;
CREATE TABLE  IF NOT EXISTS `bid` (
	`bid_id` INT(11),	
    `aution_id` INT(11)NOT NULL ,
    `buyer_id` INT(11)NOT NULL ,
	`original_price` decimal(9,2) NOT NULL ,
	`increment` decimal(9,2) NOT NULL ,
    `maxprice` decimal(9,2) NOT NULL ,
    `now_bid_price`decimal(9,2) NOT NULL ,
	`last_bid_time` datetime NOT NULL ,
	PRIMARY KEY (`bid_id`),	
    CONSTRAINT FOREIGN KEY (`aution_id`) REFERENCES `aution` (`aution_id`) on delete cascade, 
	CONSTRAINT FOREIGN KEY (`buyer_id`) REFERENCES `user` (`uid`)  on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


alter table `aution` 
add COLUMN `category` varchar(50) NOT NULL DEFAULT '',
add COLUMN 	`subcategory` varchar(50)NOT NULL DEFAULT '',
add COLUMN	`description` varchar(1000)NOT NULL DEFAULT '',
add COLUMN	`seller_id` INT(11) NOT NULL,
add COLUMN   `image`  varchar(1000) ,
add COLUMN   `original_price` decimal(9,2) NOT NULL ,
add COLUMN	`increment` decimal(9,2) NOT NULL ,
add COLUMN    `minprice` decimal(9,2) default NULL ,
add COLUMN   `start_time` datetime NOT NULL ,
add COLUMN	`end_time` datetime NOT NULL ,
add COLUMN   `max_bid_id` INT(11) default -1 ,
add COLUMN   `max_bid_price` decimal(9,2) default 0 ,
ADD CONSTRAINT FOREIGN KEY (`seller_id`) REFERENCES `user` (`uid`)  on delete cascade;

DROP TABLE IF EXISTS `qanda`;
CREATE TABLE  IF NOT EXISTS `qanda` (
	`qanda_id` INT(11),	
	`wen_id` INT(11) default -1,
    `da_id` INT(11),
    `question`  varchar(1000)NOT NULL DEFAULT '',
	`ans`  varchar(1000)NOT NULL DEFAULT '',	
	PRIMARY KEY (`qanda_id`),	
    CONSTRAINT FOREIGN KEY (`wen_id`) REFERENCES `user` (`uid`)  on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `interested`;
CREATE TABLE  IF NOT EXISTS `interested` (
	`interested_id` INT(11),	
	`uid` INT(11) NOT NULL,
    `category` varchar(50) NOT NULL DEFAULT '',
	`subcategory` varchar(50) NOT NULL DEFAULT '',
    `description` varchar(1000)NOT NULL DEFAULT '',
	PRIMARY KEY (`interested_id`),	
    CONSTRAINT FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)  on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;












