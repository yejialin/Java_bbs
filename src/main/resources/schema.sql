DROP DATABASE IF EXISTS ssm;
CREATE DATABASE ssm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ssm;

CREATE TABLE `ssm`.`Topic` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `content` VARCHAR(1000) NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`id`));
ALTER TABLE `ssm`.`Topic`
    ADD COLUMN `createdTime` BIGINT(20) NULL AFTER `userId`,
    ADD COLUMN `updatedTime` BIGINT(20) NULL AFTER `createdTime`;

CREATE TABLE `ssm`.`User` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `username` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
    `password` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
    `role` enum('admin','normal','guest') COLLATE utf8mb4_unicode_ci NOT NULL,
    `avatar` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `email` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdTime` bigint(20) DEFAULT NULL,
    `updatedTime` bigint(20) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ssm`.`TopicComment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(200) NULL,
  `userId` INT NOT NULL,
  `topicId` INT NOT NULL,
  `createdTime` BIGINT(20) NULL,
  `updatedTime` BIGINT(20) NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_TopicComment_Topic_id_idx` (`topicId` ASC),
  CONSTRAINT `FK_TopicComment_Topic_id`
      FOREIGN KEY (`topicId`)
          REFERENCES `ssm`.`Topic` (`id`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

ALTER TABLE `ssm`.`User`
    ADD COLUMN `signature` VARCHAR(100) NULL AFTER `updatedTime`;

ALTER TABLE `ssm`.`Topic`
    ADD COLUMN `viewCount` INT NULL DEFAULT 0 AFTER `updatedTime`;