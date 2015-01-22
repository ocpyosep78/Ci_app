-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ci_app
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ci_app
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ci_app` DEFAULT CHARACTER SET latin1 ;
USE `ci_app` ;

-- -----------------------------------------------------
-- Table `ci_app`.`user_accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ci_app`.`user_accounts` ;

CREATE TABLE IF NOT EXISTS `ci_app`.`user_accounts` (
  `uacc_id` INT NOT NULL AUTO_INCREMENT,
  `uacc_email` VARCHAR(45) NOT NULL,
  `uacc_password` VARCHAR(45) NOT NULL,
  `uacc_active` INT NOT NULL DEFAULT 1,
  `uacc_deleted` INT NOT NULL DEFAULT 0,
  `uacc_date_last_login` DATETIME NULL,
  `uacc_date_insert` DATETIME NULL,
  `uacc_date_update` DATETIME NULL,
  `uacc_date_delete` DATETIME NULL,
  PRIMARY KEY (`uacc_id`),
  UNIQUE INDEX `uacc_email_UNIQUE` (`uacc_email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_bin;


-- -----------------------------------------------------
-- Table `ci_app`.`user_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ci_app`.`user_groups` ;

CREATE TABLE IF NOT EXISTS `ci_app`.`user_groups` (
  `ugrp_id` INT NOT NULL AUTO_INCREMENT,
  `ugrp_name` VARCHAR(45) NOT NULL,
  `ugrp_desc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ugrp_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_bin;


-- -----------------------------------------------------
-- Table `ci_app`.`user_privileges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ci_app`.`user_privileges` ;

CREATE TABLE IF NOT EXISTS `ci_app`.`user_privileges` (
  `upriv_id` INT NOT NULL,
  `upriv_groups_fk` INT NOT NULL,
  `upriv_name` VARCHAR(45) NOT NULL COMMENT 'contexto en el que se aplica',
  `upriv_desc` VARCHAR(45) NOT NULL,
  `upriv_insert` INT NOT NULL DEFAULT 0,
  `upriv_update` INT NOT NULL DEFAULT 0,
  `upriv_delete` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`upriv_id`),
  INDEX `fk_user_privileges_user_groups1_idx` (`upriv_groups_fk` ASC),
  CONSTRAINT `fk_user_privileges_user_groups1`
    FOREIGN KEY (`upriv_groups_fk`)
    REFERENCES `ci_app`.`user_groups` (`ugrp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_bin;


-- -----------------------------------------------------
-- Table `ci_app`.`user_profiles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ci_app`.`user_profiles` ;

CREATE TABLE IF NOT EXISTS `ci_app`.`user_profiles` (
  `upro_id` INT NOT NULL AUTO_INCREMENT,
  `upro_uacc_fk` INT NOT NULL,
  `upro_company` VARCHAR(45) NULL,
  `upro_first_name` VARCHAR(45) NULL,
  `upro_last_name` VARCHAR(45) NULL,
  `upro_phone` VARCHAR(45) NULL,
  PRIMARY KEY (`upro_id`),
  INDEX `fk_user_profiles_user_accounts1_idx` (`upro_uacc_fk` ASC),
  CONSTRAINT `fk_user_profiles_user_accounts1`
    FOREIGN KEY (`upro_uacc_fk`)
    REFERENCES `ci_app`.`user_accounts` (`uacc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_bin;


-- -----------------------------------------------------
-- Table `ci_app`.`user_accounts_has_user_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ci_app`.`user_accounts_has_user_groups` ;

CREATE TABLE IF NOT EXISTS `ci_app`.`user_accounts_has_user_groups` (
  `uacc_fk` INT NOT NULL,
  `ugrp_fk` INT NOT NULL,
  PRIMARY KEY (`uacc_fk`, `ugrp_fk`),
  INDEX `fk_user_accounts_has_user_groups_user_groups1_idx` (`ugrp_fk` ASC),
  INDEX `fk_user_accounts_has_user_groups_user_accounts1_idx` (`uacc_fk` ASC),
  CONSTRAINT `fk_user_accounts_has_user_groups_user_accounts1`
    FOREIGN KEY (`uacc_fk`)
    REFERENCES `ci_app`.`user_accounts` (`uacc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_accounts_has_user_groups_user_groups1`
    FOREIGN KEY (`ugrp_fk`)
    REFERENCES `ci_app`.`user_groups` (`ugrp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_bin;


-- -----------------------------------------------------
-- Table `ci_app`.`user_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ci_app`.`user_address` ;

CREATE TABLE IF NOT EXISTS `ci_app`.`user_address` (
  `uadd_id` INT NOT NULL AUTO_INCREMENT,
  `uadd_uacc_fk` INT NOT NULL,
  `uadd_alias` VARCHAR(45) NULL,
  `uadd_address` VARCHAR(45) NOT NULL,
  `uadd_city` VARCHAR(45) NULL,
  `uadd_county` VARCHAR(45) NULL,
  `uadd_post_code` VARCHAR(45) NULL,
  `uadd_country` VARCHAR(45) NULL,
  PRIMARY KEY (`uadd_id`),
  INDEX `fk_user_address_user_accounts1_idx` (`uadd_uacc_fk` ASC),
  CONSTRAINT `fk_user_address_user_accounts1`
    FOREIGN KEY (`uadd_uacc_fk`)
    REFERENCES `ci_app`.`user_accounts` (`uacc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_bin;


-- -----------------------------------------------------
-- Table `ci_app`.`user_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ci_app`.`user_log` ;

CREATE TABLE IF NOT EXISTS `ci_app`.`user_log` (
  `ulog_id` INT NOT NULL AUTO_INCREMENT,
  `ulog_uacc_fk` INT NOT NULL,
  `ulog_ip` VARCHAR(45) NULL,
  `ulog_user_agent` VARCHAR(45) NULL,
  `ulog_action` VARCHAR(45) NULL,
  PRIMARY KEY (`ulog_id`),
  INDEX `fk_user_log_user_accounts1_idx` (`ulog_uacc_fk` ASC),
  CONSTRAINT `fk_user_log_user_accounts1`
    FOREIGN KEY (`ulog_uacc_fk`)
    REFERENCES `ci_app`.`user_accounts` (`uacc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_bin;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
