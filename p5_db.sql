-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clients` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Products` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderProduct`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderProduct` (
  `order_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  CONSTRAINT `fk_products`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`Products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`Orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_products_idx` ON `mydb`.`OrderProduct` (`product_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`OrderClient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderClient` (
  `order_id` INT UNSIGNED NOT NULL,
  `client_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`, `client_id`),
  CONSTRAINT `fk_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`Orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clients`
    FOREIGN KEY (`client_id`)
    REFERENCES `mydb`.`Clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_clients_idx` ON `mydb`.`OrderClient` (`client_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Countries` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cities` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`, `country_id`),
  CONSTRAINT `fk_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`Countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_country_idx` ON `mydb`.`Cities` (`country_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Streets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Streets` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `city_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`, `city_id`),
  CONSTRAINT `fk_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`Cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_city_idx` ON `mydb`.`Streets` (`city_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`AddressBook`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AddressBook` (
  `order_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `street_id` INT UNSIGNED NOT NULL,
  `apt_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`order_id`, `street_id`),
  CONSTRAINT `fk_street`
    FOREIGN KEY (`street_id`)
    REFERENCES `mydb`.`Streets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`Orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_street_idx` ON `mydb`.`AddressBook` (`street_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
