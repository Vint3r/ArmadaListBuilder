-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema armadalistdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `armadalistdb` ;

-- -----------------------------------------------------
-- Schema armadalistdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `armadalistdb` DEFAULT CHARACTER SET utf8 ;
USE `armadalistdb` ;

-- -----------------------------------------------------
-- Table `speed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `speed` ;

CREATE TABLE IF NOT EXISTS `speed` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `speed_one` VARCHAR(45) NULL,
  `speed_two` VARCHAR(45) NULL,
  `speed_three` VARCHAR(45) NULL,
  `speed_four` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ship` ;

CREATE TABLE IF NOT EXISTS `ship` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `hull` INT NOT NULL DEFAULT 0,
  `command` INT NULL DEFAULT 0,
  `squadron` INT NULL,
  `engineering` INT NULL,
  `cost` INT NULL,
  `alignment` VARCHAR(50) NOT NULL,
  `base_size` VARCHAR(45) NULL,
  `af_red` INT NULL,
  `af_blue` INT NULL,
  `af_black` INT NULL,
  `speed_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ship_speed1_idx` (`speed_id` ASC),
  CONSTRAINT `fk_ship_speed1`
    FOREIGN KEY (`speed_id`)
    REFERENCES `speed` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image` ;

CREATE TABLE IF NOT EXISTS `image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defense_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defense_token` ;

CREATE TABLE IF NOT EXISTS `defense_token` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `effect` TEXT NULL,
  `image_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_defense_token_image1_idx` (`image_id` ASC),
  CONSTRAINT `fk_defense_token_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgrade_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upgrade_type` ;

CREATE TABLE IF NOT EXISTS `upgrade_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(100) NULL,
  `image_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_upgrade_type_image1_idx` (`image_id` ASC),
  CONSTRAINT `fk_upgrade_type_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgrade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upgrade` ;

CREATE TABLE IF NOT EXISTS `upgrade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `unique` TINYINT NOT NULL,
  `alignment` VARCHAR(50) NULL,
  `description` TEXT NULL,
  `ship_type` TEXT NULL,
  `cost` INT NOT NULL DEFAULT 0,
  `upgrade_type_id` INT NOT NULL,
  `image_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_upgrade_upgrade_type1_idx` (`upgrade_type_id` ASC),
  INDEX `fk_upgrade_image1_idx` (`image_id` ASC),
  CONSTRAINT `fk_upgrade_upgrade_type1`
    FOREIGN KEY (`upgrade_type_id`)
    REFERENCES `upgrade_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_upgrade_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ship_defense_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ship_defense_token` ;

CREATE TABLE IF NOT EXISTS `ship_defense_token` (
  `ship_id` INT NOT NULL,
  `defense_token_id` INT NOT NULL,
  `amount` INT NULL DEFAULT 1,
  PRIMARY KEY (`ship_id`, `defense_token_id`),
  INDEX `fk_ship_has_defense_token_defense_token1_idx` (`defense_token_id` ASC),
  INDEX `fk_ship_has_defense_token_ship1_idx` (`ship_id` ASC),
  CONSTRAINT `fk_ship_has_defense_token_ship1`
    FOREIGN KEY (`ship_id`)
    REFERENCES `ship` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ship_has_defense_token_defense_token1`
    FOREIGN KEY (`defense_token_id`)
    REFERENCES `defense_token` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ship_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ship_image` ;

CREATE TABLE IF NOT EXISTS `ship_image` (
  `ship_id` INT NOT NULL,
  `image_id` INT NOT NULL,
  PRIMARY KEY (`ship_id`, `image_id`),
  INDEX `fk_ship_has_image_image1_idx` (`image_id` ASC),
  INDEX `fk_ship_has_image_ship1_idx` (`ship_id` ASC),
  CONSTRAINT `fk_ship_has_image_ship1`
    FOREIGN KEY (`ship_id`)
    REFERENCES `ship` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ship_has_image_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hull_zone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hull_zone` ;

CREATE TABLE IF NOT EXISTS `hull_zone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `shields` INT NOT NULL DEFAULT 0,
  `location` VARCHAR(45) NULL,
  `as_red` INT NULL,
  `as_blue` INT NULL,
  `as_black` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ship_hull_zone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ship_hull_zone` ;

CREATE TABLE IF NOT EXISTS `ship_hull_zone` (
  `ship_id` INT NOT NULL,
  `hull_zone_id` INT NOT NULL,
  PRIMARY KEY (`ship_id`, `hull_zone_id`),
  INDEX `fk_ship_has_hull_zone_hull_zone1_idx` (`hull_zone_id` ASC),
  INDEX `fk_ship_has_hull_zone_ship1_idx` (`ship_id` ASC),
  CONSTRAINT `fk_ship_has_hull_zone_ship1`
    FOREIGN KEY (`ship_id`)
    REFERENCES `ship` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ship_has_hull_zone_hull_zone1`
    FOREIGN KEY (`hull_zone_id`)
    REFERENCES `hull_zone` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ship_upgrade_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ship_upgrade_type` ;

CREATE TABLE IF NOT EXISTS `ship_upgrade_type` (
  `upgrade_type_id` INT NOT NULL,
  `ship_id` INT NOT NULL,
  `amount` INT NOT NULL DEFAULT 1,
  `filled` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`upgrade_type_id`, `ship_id`),
  INDEX `fk_upgrade_type_has_ship_ship1_idx` (`ship_id` ASC),
  INDEX `fk_upgrade_type_has_ship_upgrade_type1_idx` (`upgrade_type_id` ASC),
  CONSTRAINT `fk_upgrade_type_has_ship_upgrade_type1`
    FOREIGN KEY (`upgrade_type_id`)
    REFERENCES `upgrade_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_upgrade_type_has_ship_ship1`
    FOREIGN KEY (`ship_id`)
    REFERENCES `ship` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ship_build`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ship_build` ;

CREATE TABLE IF NOT EXISTS `ship_build` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ship_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ship_build_ship1_idx` (`ship_id` ASC),
  CONSTRAINT `fk_ship_build_ship1`
    FOREIGN KEY (`ship_id`)
    REFERENCES `ship` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `list` ;

CREATE TABLE IF NOT EXISTS `list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `desired_cost` INT NULL,
  `actual_cost` INT NOT NULL,
  `point_sway` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fighter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fighter` ;

CREATE TABLE IF NOT EXISTS `fighter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `unique` TINYINT NOT NULL DEFAULT 0,
  `health` INT NULL,
  `movement` INT NULL,
  `cost` INT NULL,
  `special_ability` TEXT NULL,
  `alignment` VARCHAR(50) NOT NULL,
  `model` VARCHAR(100) NULL,
  `rating` INT NULL,
  `af_red` INT NULL,
  `af_blue` INT NULL,
  `af_black` INT NULL,
  `as_red` INT NULL,
  `as_blue` INT NULL,
  `as_black` INT NULL,
  `image_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fighter_image1_idx` (`image_id` ASC),
  CONSTRAINT `fk_fighter_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NULL,
  `password` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `keyword` ;

CREATE TABLE IF NOT EXISTS `keyword` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgrade_ship_build`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upgrade_ship_build` ;

CREATE TABLE IF NOT EXISTS `upgrade_ship_build` (
  `upgrade_id` INT NOT NULL,
  `ship_build_id` INT NOT NULL,
  PRIMARY KEY (`upgrade_id`, `ship_build_id`),
  INDEX `fk_upgrade_has_ship_build_ship_build1_idx` (`ship_build_id` ASC),
  INDEX `fk_upgrade_has_ship_build_upgrade1_idx` (`upgrade_id` ASC),
  CONSTRAINT `fk_upgrade_has_ship_build_upgrade1`
    FOREIGN KEY (`upgrade_id`)
    REFERENCES `upgrade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_upgrade_has_ship_build_ship_build1`
    FOREIGN KEY (`ship_build_id`)
    REFERENCES `ship_build` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fighter_defense_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fighter_defense_token` ;

CREATE TABLE IF NOT EXISTS `fighter_defense_token` (
  `defense_token_id` INT NOT NULL,
  `fighter_id` INT NOT NULL,
  `amount` INT NULL,
  PRIMARY KEY (`defense_token_id`, `fighter_id`),
  INDEX `fk_defense_token_has_fighter_fighter1_idx` (`fighter_id` ASC),
  INDEX `fk_defense_token_has_fighter_defense_token1_idx` (`defense_token_id` ASC),
  CONSTRAINT `fk_defense_token_has_fighter_defense_token1`
    FOREIGN KEY (`defense_token_id`)
    REFERENCES `defense_token` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_defense_token_has_fighter_fighter1`
    FOREIGN KEY (`fighter_id`)
    REFERENCES `fighter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `list_ship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `list_ship` ;

CREATE TABLE IF NOT EXISTS `list_ship` (
  `list_id` INT NOT NULL,
  `ship_build_id` INT NOT NULL,
  PRIMARY KEY (`list_id`, `ship_build_id`),
  INDEX `fk_list_has_ship_build_ship_build1_idx` (`ship_build_id` ASC),
  INDEX `fk_list_has_ship_build_list1_idx` (`list_id` ASC),
  CONSTRAINT `fk_list_has_ship_build_list1`
    FOREIGN KEY (`list_id`)
    REFERENCES `list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_list_has_ship_build_ship_build1`
    FOREIGN KEY (`ship_build_id`)
    REFERENCES `ship_build` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `list_fighter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `list_fighter` ;

CREATE TABLE IF NOT EXISTS `list_fighter` (
  `fighter_id` INT NOT NULL,
  `list_id` INT NOT NULL,
  `amount` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`fighter_id`, `list_id`),
  INDEX `fk_fighter_has_list_list1_idx` (`list_id` ASC),
  INDEX `fk_fighter_has_list_fighter1_idx` (`fighter_id` ASC),
  CONSTRAINT `fk_fighter_has_list_fighter1`
    FOREIGN KEY (`fighter_id`)
    REFERENCES `fighter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fighter_has_list_list1`
    FOREIGN KEY (`list_id`)
    REFERENCES `list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_list` ;

CREATE TABLE IF NOT EXISTS `user_has_list` (
  `user_id` INT NOT NULL,
  `list_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `list_id`),
  INDEX `fk_user_has_list_list1_idx` (`list_id` ASC),
  INDEX `fk_user_has_list_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_list_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_list_list1`
    FOREIGN KEY (`list_id`)
    REFERENCES `list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fighter_keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fighter_keyword` ;

CREATE TABLE IF NOT EXISTS `fighter_keyword` (
  `fighter_id` INT NOT NULL,
  `keyword_id` INT NOT NULL,
  PRIMARY KEY (`fighter_id`, `keyword_id`),
  INDEX `fk_fighter_has_keyword_keyword1_idx` (`keyword_id` ASC),
  INDEX `fk_fighter_has_keyword_fighter1_idx` (`fighter_id` ASC),
  CONSTRAINT `fk_fighter_has_keyword_fighter1`
    FOREIGN KEY (`fighter_id`)
    REFERENCES `fighter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fighter_has_keyword_keyword1`
    FOREIGN KEY (`keyword_id`)
    REFERENCES `keyword` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS user@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'user'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `speed`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (1, '2', '1-1', '0-1-1', NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (2, '1', '1-1', NULL, NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (3, '1', '1-0', '1-0-1', NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (4, '1', '1-1', '0-1-1', NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (5, '1', '1-1', '0-1-2', '0-1-1-0');
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (6, '2', '1-1', NULL, NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (7, '1', '1-1', '0-1-2', NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (8, '2', '1-2', '0-1-2', '0-1-1-2');
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (9, '2', '2-1', '1-1-0', NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (10, '2', '1-2', '0-1-2', NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (11, '1', '0-1', NULL, NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (12, '2', '0-2', '0-0-2', NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (13, '2', '2-2', '0-1-1', '0-1-1-1');
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (14, '2', '1-1', '1-1-0', NULL);
INSERT INTO `speed` (`id`, `speed_one`, `speed_two`, `speed_three`, `speed_four`) VALUES (15, '0', '0-0', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ship`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (1, 'MC-75 Armored Cruiser', 9, 3, 3, 4, 104, 'Rebel Alliance', 'Large', 0, 1, 1, 1);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (2, 'MC-75 Ordnance Cruiser', 9, 3, 2, 4, 100, 'Rebel Alliance', 'Large', 0, 0, 1, 1);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (3, 'MC-80 Assault Cruiser', 8, 3, 3, 4, 114, 'Rebel Alliance', 'Large', 0, 2, 0, 2);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (4, 'MC-80 Command Cruiser', 8, 3, 4, 4, 106, 'Rebel Alliance', 'Large', 0, 1, 1, 2);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (5, 'MC-80 Battle Cruiser', 8, 3, 2, 4, 103, 'Rebel Alliance', 'Large', 0, 0, 2, 3);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (6, 'MC-80 Star Cruiser', 8, 3, 2, 4, 96, 'Rebel Alliance', 'Large', 0, 0, 1, 3);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (7, 'Assault Frigate Mark II A', 6, 3, 2, 4, 81, 'Rebel Alliance', 'Medium', 0, 2, 0, 4);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (8, 'Assault Frigate Mark II B', 6, 3, 3, 4, 72, 'Rebel Alliance', 'Medium', 0, 1, 0, 4);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (9, 'MC-30c Scout Frigate', 4, 2, 1, 3, 69, 'Rebel Alliance', 'Small', 0, 1, 0, 5);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (10, 'MC-30c Torpedo Frigate', 4, 2, 1, 3, 63, 'Rebel Alliance', 'Small', 0, 1, 0, 5);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (11, 'Modified Pelta-class Command Ship', 5, 2, 3, 4, 60, 'Rebel Alliance', 'Small', 0, 1, 0, 6);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (12, 'Modified Pelta-class Assault Ship', 5, 2, 1, 4, 56, 'Rebel Alliance', 'Small', 0, 1, 1, 6);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (13, 'Nebulon-B Escort Frigate', 5, 2, 2, 3, 57, 'Rebel Alliance', 'Small', 0, 2, 0, 7);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (14, 'Nebulon-B Support Refit', 5, 2, 1, 3, 51, 'Rebel Alliance', 'Small', 0, 1, 0, 7);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (15, 'CR-90 Corvette A', 4, 1, 1, 2, 44, 'Rebel Alliance', 'Small', 0, 1, 0, 8);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (16, 'CR-90 Corvette B', 4, 1, 1, 2, 39, 'Rebel Alliance', 'Small', 0, 1, 0, 8);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (17, 'Hammerhead Scout Corvette', 5, 1, 1, 2, 41, 'Rebel Alliance', 'Small', 0, 1, 0, 9);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (18, 'Hammerhead Torpedo Corvette', 5, 1, 1, 2, 36, 'Rebel Alliance', 'Small', 0, 0, 1, 9);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (19, 'GR-75 Combat Retrofits', 3, 1, 2, 2, 24, 'Rebel Alliance', 'Small', 0, 1, 0, 10);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (20, 'GR-75 Medium Transports', 3, 1, 2, 2, 18, 'Rebel Alliance', 'Small', 0, 0, 1, 10);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (21, 'Imperial II-class Star Destroyer', 11, 3, 4, 4, 120, 'Empire', 'Large', 0, 2, 0, 4);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (22, 'Imperial Star Destroyer Cymoon 1 Refit', 11, 3, 3, 4, 112, 'Empire', 'Large', 0, 0, 2, 4);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (23, 'Imperial Star Destroyer Kuat Refit', 11, 3, 2, 4, 112, 'Empire', 'Large', 0, 1, 1, 4);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (24, 'Imperial I-class Star Destroyer', 11, 3, 4, 4, 110, 'Empire', 'Large', 0, 1, 1, 4);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (25, 'Interdictor Combat Refit', 9, 2, 2, 5, 93, 'Empire', 'Medium', 0, 1, 1, 2);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (26, 'Interdictor Suppression Refit', 9, 2, 2, 5, 90, 'Empire', 'Medium', 0, 1, 0, 2);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (27, 'Victory II-class Star Destroyer', 8, 3, 3, 4, 85, 'Empire', 'Medium', 0, 1, 0, 11);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (28, 'Victory I-class Star Destroyer', 8, 3, 3, 4, 73, 'Empire', 'Medium', 0, 1, 0, 11);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (29, 'Gladiator II-class Star Destroyer', 5, 2, 2, 3, 62, 'Empire', 'Small', 0, 2, 0, 1);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (30, 'Gladiator I-class Star Destroyer', 5, 2, 2, 3, 56, 'Empire', 'Small', 0, 1, 0, 1);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (31, 'Quasar Fire II-class Cruiser-Carrier', 6, 2, 4, 2, 61, 'Empire', 'Medium', 1, 0, 0, 1);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (32, 'Quasar Fire I-class Cruiser-Carrier', 6, 2, 4, 2, 54, 'Empire', 'Medium', 0, 1, 0, 1);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (33, 'Arquitens-class Command Cruiser', 5, 2, 2, 3, 59, 'Empire', 'Small', 0, 1, 0, 12);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (34, 'Arquitens-class Light Cruiser', 5, 2, 1, 3, 54, 'Empire', 'Small', 0, 0, 1, 12);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (35, 'Raider II-class Corvette', 4, 1, 1, 2, 48, 'Empire', 'Small', 0, 1, 1, 13);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (36, 'Raider I-class Corvette', 4, 1, 1, 2, 44, 'Empire', 'Small', 0, 0, 2, 13);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (37, 'Gozanti-class Assault Carriers', 3, 1, 2, 2, 28, 'Empire', 'Small', 0, 1, 0, 14);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (38, 'Gozanti-class Cruisers', 3, 1, 2, 2, 23, 'Empire', 'Small', 0, 0, 1, 14);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (39, 'Executor II-class Star Dreadnought', 33, 4, 6, 5, 411, 'Empire', 'Huge', 1, 1, 1, 15);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (40, 'Executor I-class Star Dreadnought', 33, 4, 6, 5, 381, 'Empire', 'Huge', 0, 2, 1, 15);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (41, 'Star Dreadnought Assault Prototype', 22, 4, 5, 4, 250, 'Empire', 'Huge', 1, 1, 0, 15);
INSERT INTO `ship` (`id`, `name`, `hull`, `command`, `squadron`, `engineering`, `cost`, `alignment`, `base_size`, `af_red`, `af_blue`, `af_black`, `speed_id`) VALUES (42, 'Star Dreadnought Command Prototype', 22, 4, 5, 4, 220, 'Empire', 'Huge', 0, 2, 0, 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `image`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `image` (`id`, `url`) VALUES (1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `defense_token`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `defense_token` (`id`, `name`, `effect`, `image_id`) VALUES (1, 'Brace', 'After damage is totaled, the defender reduces the total by half, rounded up.', 1);
INSERT INTO `defense_token` (`id`, `name`, `effect`, `image_id`) VALUES (2, 'Contain', 'A ship can spend this defense token to prevent the attacker from resolving the standard critical effect. The attacker can still resolve a non-standard critical effect, such as one granted by an upgrade card.', 1);
INSERT INTO `defense_token` (`id`, `name`, `effect`, `image_id`) VALUES (3, 'Evade', 'If the attack occurs at long range, the defender chooses and cancels one attack die. At medium range, he chooses one attack die to be rerolled. At close range and distance 1, the token has no effect.', 1);
INSERT INTO `defense_token` (`id`, `name`, `effect`, `image_id`) VALUES (4, 'Redirect', 'The defender chooses one of his hull zones adjacent to the defending hull zone. When the defender suffers damage, it may suffer any amount of damage on the chosen zone’s remaining shields before it must suffer the remaining damage on the defending hull zone.', 1);
INSERT INTO `defense_token` (`id`, `name`, `effect`, `image_id`) VALUES (5, 'Scatter', 'The defender cancels all attack dice.', 1);
INSERT INTO `defense_token` (`id`, `name`, `effect`, `image_id`) VALUES (6, 'Salvo', 'A ship may spend this Defense Token to perform a Salvo Attack after resolving damage. If the attack was made by a ship, the defender performs a Salvo Attack against the attacking hull zone using its printed rear battery armament. If the attacker was a squadron, the defender uses its printed anti-squadron armament. You can\'t resolve this effect during Counter, Salvo, and Ignition Attacks. During Salvo attacks, range and line of sight are treated the same as the triggering attack, you ignore firing arcs. You cannot add dice to a Salvo attack, though you may still resolve other attack effects. You may only resolve standard critical effects (those on the dice). If the ship that is resolving a Salvo attack has been destroyed, it performs the Salvo attack before being removed from play.', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `upgrade_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (1, 'Commander', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (2, 'Defensive Retrofit', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (3, 'Experimental Retrofit', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (4, 'Fleet Command', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (5, 'Fleet Support', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (6, 'Ion Cannons', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (7, 'Offensive Retrofit', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (8, 'Officer', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (9, 'Ordnance', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (10, 'Superweapon', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (11, 'Support Team', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (12, 'Title', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (13, 'Turbolaser', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (14, 'Weapons Team', NULL);
INSERT INTO `upgrade_type` (`id`, `type`, `image_id`) VALUES (15, 'Weapons Team & Offensive Retrofit', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `upgrade`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (1, 'Admiral Ackbar', 1, 'Rebel Alliance', 'Before a friendly ship\'s attack step, it may choose to attack from only its left and right hull zones this round. If it does, it may add 2 red dice to its attack pool while attacking a ship', 'None', 38, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (2, 'Leia Organa', 1, 'Rebel Alliance', 'When a friendly ship resolves a command by spending a command dial, if it has not resolved another command this round, it may resolve that command as if it spent a matching command token. If it does, that ship cannot resolve additional commands this round.', 'None', 38, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (3, 'Commander Sato', 1, 'Rebel Alliance', 'While a friendly ship is attacking a ship at distance 1 of a friendly squadron, before rolling attack dice, the attacker may replace up to 2 dice in its attack pool with an equal number of dice of any color or colors.', 'None', 32, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (4, 'General Madine', 1, 'Rebel Alliance', 'When a friendly ship resolves a navigate command, if it spend a navigate dial it may increase 1 additional yaw value by 1. If it spent a navigate token, it may either change its speed or increase 1 yaw value by 1.', 'None', 30, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (5, 'General Rieekan', 1, 'Rebel Alliance', 'When a friendly ship or friendly unique squadron is destroyed, it remains in the play area and is treated as if it was not destroyed until the end of the status phase.', 'None', 30, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (6, 'General Cracken', 1, 'Rebel Alliance', 'While a friendly small or medium ship is defending against a ship, if the defender is at speed 3 or higher, the attack is treated as obstructed.', 'None', 26, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (7, 'Admiral Raddus', 1, 'Rebel Alliance', 'Before deploying fleets, you may set aside 1 other friendly ship. At the start of any round, you may deploy that ship at distance 1 of a friendly ship. That ship cannot be deployed overlapping squadrons and cannot be the first ship to activate that round.', 'None', 26, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (8, 'Garm Bel Iblis', 1, 'Rebel Alliance', 'At the start of the first round and the fifth round, each friendly ship may gain a number of command tokens equal to its command value.', 'None', 25, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (9, 'General Dodonna', 1, 'Rebel Alliance', 'Before an enemy ship is dealt a faceup damage card, look at the top 4 cards of the damage deck, place 1 on top of the deck, and discard the others.', 'None', 20, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (10, 'Grand Moff Tarkin', 1, 'Empire', 'At the start of each ship phase, you may choose 1 command. Each friendly ship gains a command token matching that command.', 'None', 38, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (11, 'Darth Vader', 1, 'Empire', 'While a friendly ship is attacking a ship, it may spend 1 defense token to reroll any number of dice in its attack pool.', 'None', 36, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (12, 'Emperor Palpatine', 1, 'Empire', 'After deploying fleets, place 1 defense token of each type on this card. At the start of each ship phase you may discard 1 of those tokens. If you do, until the end of the round, if an enemy ship or squadron spends a matching token during its spend defense tokens step, discard that token.', 'None', 35, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (13, 'Grand Admiral Thrawn', 1, 'Empire', 'After deploying fleets, place 3 facedown command dials on this card. At the start of each ship phase, you may reveal and discard 1 of those dials. If you do, until the end of the round, before each friendly ship activates, it gains 1 additional dial matching that discarded dial.', 'None', 32, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (14, 'Admiral Screed', 1, 'Empire', 'Once per activation, while a friendly ship is attacking, it may spend 1 die to change a die to a face with a crit icon.', 'None', 26, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (15, 'General Tagge', 1, 'Empire', 'At the start of the third round and the fifth round, each friendly ship may recover 1 of its discarded defense tokens.', 'None', 25, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (16, 'Admiral Sloane', 1, 'Empire', 'While a friendly squadron without ROGUE is attacking, it may spend 1 die with a accuracy icon to choose and spend 1 of the defender\'s defense tokens. While attacking a ship, it may also reroll 1 die with a crit icon.', 'None', 24, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (17, 'Admiral Konstantine', 1, 'Empire', 'At the start of each status phase, for each enemy ship at distance 1-5 of at least 2 friendly medium or large ships, you may increase or decrease that enemy ship\'s speed by 1 to a minimum of speed 1.', 'None', 23, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (18, 'Moff Jerjerrod', 1, 'Empire', 'During a friendly ship\'s determine course step, it may suffer 1 damage to change the first yaw value of its current speed to \"II\" until the end of its activation.', 'None', 23, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (19, 'Admiral Piett', 1, 'Empire', 'When a friendly ship spends only a command token to resolve a command, you may exhaust this card. If you do, that ship resolves that command as if it had spent a dial of the same type instead.', 'None', 22, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (20, 'Admiral Ozzel', 1, 'Empire', 'When a friendly ship resolves a navigate command, it may change its speed by an additional 1.', 'None', 20, 1, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (21, 'Profundity', 1, 'Rebel Alliance', 'Before deploying fleets, you may set aside 1 small ship with a command value of 1. At the start of any round, you may deploy the set-aside ship at distance 1. You may unequip up to 1 commander and 1 officer upgrade cards and equip them to it (if able).', 'MC-75 Ordnance Cruiser|MC-75 Armored Cruiser', 7, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (22, 'Aspiration', 1, 'Rebel Alliance', 'When you deploy this ship, you may move shields to up to 2 of your hull zones from your other hull zones. If you do, the number of shields in a zone cannot exceed a maximum of \"6\". You cannot recover shields while any zone is greater than its maximum shield value.', 'MC-75 Ordnance Cruiser|MC-75 Armored Cruiser', 3, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (23, 'Independence', 1, 'Rebel Alliance', 'On squadron command: Each squadron you activate may increase its speed to 4 until the end of its activation. Squadrons that change speed in this way cannot attack this activation.', 'MC-80 Assault Cruiser|MC-80 Command Cruiser', 8, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (24, 'Home One', 1, 'Rebel Alliance', 'While another friendly ship at distance 1-5 is attacking, it may change 1 die to a face with an accuracy icon.', 'MC-80 Assault Cruiser|MC-80 Command Cruiser', 7, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (25, 'Defiance', 1, 'Rebel Alliance', 'While attacking a ship that has already activated this round, add 1 die of any color to your attack pool.', 'MC-80 Assault Cruiser|MC-80 Command Cruiser', 5, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (26, 'Mon Karren', 1, 'Rebel Alliance', 'While attacking a ship, the defender cannot spend more than 1 defense token.', 'MC-80 Battle Cruiser|MC-80 Star Cruiser', 8, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (27, 'Endeavor', 1, 'Rebel Alliance', 'At the start of the first round, gain 1 CONTAIN defense token.', 'MC-80 Battle Cruiser|MC-80 Star Cruiser', 4, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (28, 'Liberty', 1, 'Rebel Alliance', 'On squadron command: If you spent a squadron token, you may activate 1 additional squadron.', 'MC-80 Battle Cruiser|MC-80 Star Cruiser', 3, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (29, 'Gallant Haven', 1, 'Rebel Alliance', 'Before a friendly squadron at distance 1 suffers damage from an attack, reduce the total damage by 1.', 'Assault Frigate Mark II A|Assault Frigate Mark II B', 8, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (30, 'Paragon', 1, 'Rebel Alliance', 'While attacking a ship you have already attacked this round, add 1 black die to your attack pool.', 'Assault Frigate Mark II A|Assault Frigate Mark II B', 5, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (31, 'Admonition', 1, 'Rebel Alliance', 'While defending, during the spend defense token step, you may discard a defense token to cancel 1 attack die.', 'MC-30c Scout Frigate|MC-30c Torpedo Frigate', 8, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (32, 'Foresight', 1, 'Rebel Alliance', 'When you resolve the EVADE defense effect, you can affect 1 additional die. When you resolve the REDIRECT defense effect, you can choose 1 additional adjacent hull zone to suffer damage.', 'MC-30c Scout Frigate|MC-30c Torpedo Frigate', 8, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (33, 'Phoenix Home', 1, 'Rebel Alliance', 'You can 1 additional OFFICER icon in your upgrade bar. You can be assigned up to 4 command tokens instead of a number of command tokens equal to your command value.', 'Modified Pelta-class Command Ship|Modified Pelta-class Assault Ship', 3, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (34, 'Redemption', 1, 'Rebel Alliance', 'When a friendly ship at distance 1-5 resolves a REPAIR command, it gains 1 additional engineering point', 'Nebulon-B Escort Frigate|Nebulon-B Support Refit', 8, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (35, 'Dodonna\'s Pride', 1, 'Rebel Alliance', 'BLUE CRIT: Cancel all attack dice to deal 1 faceup damage card to the defender.', 'CR-90 Corvette A|CR-90 Corvette B', 6, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (36, 'Garel\'s Honor', 1, 'Rebel Alliance', 'When you overlap an enemy ship, the enemy ship suffers a faceup damage card instead of a facedown damage card.', 'Hammerhead Scout Corvette|Hammerhead Torpedo Corvette', 4, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (37, 'Task Force Antilles', 0, 'Rebel Alliance', 'When you suffer damage from an attack, you may choose and exhaust a copy of this card on another friendly ship at distance 1-3. If you do, that ship suffers 1 of your damage instead. While this card is exhausted, you cannot spend engineering points.', 'Hammerhead Scout Corvette|Hammerhead Torpedo Corvette', 3, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (38, 'Task Force Organa', 0, 'Rebel Alliance', 'While attacking, you may choose and exhaust a copy of this card on another friendly ship at distance 1-3 to reroll up to 2 attack dice. While this card is exhausted, you cannot attack ships.', 'Hammerhead Scout Corvette|Hammerhead Torpedo Corvette', 1, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (39, 'Bright Hope', 1, 'Rebel Alliance', 'While defending against an attack that does not target your rear hull zone, before you suffer damage reduce the total damage by 1.', 'GR-75 Combat Retrofits|GR-75 Medium Transports', 2, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (40, 'Quantum Storm', 1, 'Rebel Alliance', 'NAVIGATE: After you execute a maneuver, you may exhaust this card to execute a 1-speed maneuver with a yaw of \"-\".', 'GR-75 Combat Retrofits|GR-75 Medium Transports', 1, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (41, 'Mon Calamari Exodus Fleet', 0, 'Rebel Alliance', '\"MC\" only. REPAIR: You may choose and exhaust another copy of this card on a friendly ship at distance 1-4 if you do, you gain 2 additional engineering points.', 'MC', 5, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (42, 'Devastator', 1, 'Empire', 'Once per round, while attacking from your front hull zone, you may add 1 blue die to your attack pool for each of your discarded defense tokens.', 'Imperial II-class Star Destroyer|Imperial Star Destroyer Cymoon 1 Refit|Imperial Star Destroyer Kuat Refit|Imperial I-class Star Destroyer', 10, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (43, 'Avenger', 1, 'Empire', 'While attacking, the defender cannot spend exhausted defense tokens.', 'Imperial II-class Star Destroyer|Imperial Star Destroyer Cymoon 1 Refit|Imperial Star Destroyer Kuat Refit|Imperial I-class Star Destroyer', 5, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (44, 'Chimaera', 1, 'Empire', 'You gain 1 FLEET COMMAND icon in your upgrade bar. You cannot equip this card if you have a FLEET COMMAND icon in your upgrade bar. At the start of the command phase, you may discard 1 FLEET COMMAND upgrade card you have equipped and replace it with another FLEET COMMAND upgrade card.', 'Imperial II-class Star Destroyer|Imperial Star Destroyer Kuat Refit|Imperial I-class Star Destroyer', 4, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (45, 'Sovereign', 1, 'Empire', 'At the start of the ship phase, you may exhaust this card to discard 1 command token from up to 3 friendly ships at distance 1-5. If you do, each of those ships may gain 1 command token of any type.', 'Imperial II-class Star Destroyer|Imperial Star Destroyer Cymoon 1 Refit|Imperial Star Destroyer Kuat Refit|Imperial I-class Star Destroyer', 4, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (46, 'Relentless', 1, 'Empire', 'The total number of command dials that must be assigned to your ship during the command phase is reduced by 1.', 'Imperial II-class Star Destroyer|Imperial Star Destroyer Cymoon 1 Refit|Imperial Star Destroyer Kuat Refit|Imperial I-class Star Destroyer', 3, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (47, 'Interdictor', 1, 'Empire', 'When a ship activates, you may exhaust this card to ready 1 other upgrade card equipped to this ship.', 'Interdictor Combat Refit|Interdictor Suppression Refit', 3, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (48, 'Dominator', 1, 'Empire', 'While attacking at close-medium range, you may spend up to 2 shields from any of you hull zones to add that number of blue dice to your attack pool.', 'Victory II-class Star Destroyer|Victory I-class Star Destroyer', 12, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (49, 'Demolisher', 1, 'Empire', 'During your activation, you can perform 1 of your attacks after you execute a maneuver.', 'Gladiator II-class Star Destroyer|Gladiator I-class Star Destroyer', 10, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (50, 'Insidious', 1, 'Empire', 'The black dice in your battery armament can be used at medium range. This effect applies only while attacking the rear hull zone of a ship.', 'Gladiator II-class Star Destroyer|Gladiator I-class Star Destroyer', 3, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (51, 'Stronghold', 1, 'Empire', 'While a friendly squadron with SWARM at distance 1-2 is defending, the attack is treated as obstructed.', 'Quasar Fire II-class Cruiser-Carrier|Quasar Fire I-class Cruiser-Carrier', 5, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (52, 'Squall', 1, 'Empire', 'When you activate, you may choose up to 3 unengaged friendly squadrons at close-medium range. Those squadrons may move up to distance 2. If they do, they cannot end their movement engaged.', 'Quasar Fire II-class Cruiser-Carrier|Quasar Fire I-class Cruiser-Carrier', 3, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (53, 'Pursuant', 1, 'Empire', 'When you reveal a command other than a SQUADRON command, you may discard this card to resolve a SQUADRON command. Treat this command as if you spent a SQUADRON dial.', 'Quasar Fire II-class Cruiser-Carrier|Quasar Fire I-class Cruiser-Carrier', 2, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (54, 'Hand of Justice', 1, 'Empire', 'Before you reveal a command, you may exhaust this card to choose another friendly ship at distance 1-5 and ready 1 of its defense tokens.', 'Arquitens-class Command Cruiser|Arquitens-class Light Cruiser', 4, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (55, 'Centicore', 1, 'Empire', 'When another friendly ship resolves a SQUADRON command, up to 2 of the squadrons it activates can be at close-medium range of you.', 'Arquitens-class Command Cruiser|Arquitens-class Light Cruiser', 3, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (56, 'Instigator', 1, 'Empire', 'Enemy squadrons at distance 1 are treated as if they are engaged by 2 additional squadrons, even if they are not currently engaged.', 'Raider II-class Corvette|Raider I-class Corvette', 4, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (57, 'Impetuous', 1, 'Empire', 'At the end of your attack step, choose 1 of your hull zones. You may perform an attack against 1 enemy squadron from that hull zone, even if you have already attacked from that zone this round.', 'Raider II-class Corvette|Raider I-class Corvette', 4, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (58, 'Suppressor', 1, 'Empire', 'After an enemy ship ends its activation, if it is at distance 1-3, you may choose and exhaust 1 of its defense tokens.', 'Gozanti-class Assault Carriers|Gozanti-class Cruisers', 4, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (59, 'Vector', 1, 'Empire', 'SQUADRON: The speed of each squadron without HEAVY you activate is increased by 1, to a maximum of 5, until the end of its activation.', 'Gozanti-class Assault Carriers|Gozanti-class Cruisers', 2, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (60, 'Annihilator', 1, 'Empire', 'While attacking a squadron, you may reroll 1 attack die.', 'Executor II-class Star Dreadnought|Executor I-class Star Dreadnought|Star Dreadnought Assault Prototype|Star Dreadnought Command Prototype', 8, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (61, 'Ravager', 1, 'Empire', 'CONCENTRATE FIRE: Your CONCENTRATE FIRE tokens can either reroll 1 attack die or add 1 die to your attack pool. If you add a die, that die must be of a color already in your attack pool.', 'Executor II-class Star Dreadnought|Executor I-class Star Dreadnought|Star Dreadnought Assault Prototype|Star Dreadnought Command Prototype', 4, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (62, 'Eclipse', 1, 'Empire', 'When an enemy ship overlaps you, the enemy ship suffers a faceup damage card instead of a facedown damage card.', 'Executor II-class Star Dreadnought|Executor I-class Star Dreadnought|Star Dreadnought Assault Prototype|Star Dreadnought Command Prototype', 3, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (63, 'Executor', 1, 'Empire', 'You can be assigned any number of command tokens of any types, instead of a number of command tokens equal to your command value.', 'Executor II-class Star Dreadnought|Executor I-class Star Dreadnought|Star Dreadnought Assault Prototype|Star Dreadnought Command Prototype', 2, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (64, 'Seventh Fleet Star Destroyer', 0, 'Empire', '\"Star Destroyer\" only. While defending against an attack that targets your front hull zone, before you suffer damage, you may choose and exhaust a copy of this card on another friendly ship at distance 1-4 to reduce the total damage by 1.', 'Star Destroyer', 5, 12, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (65, 'G7-X Grav Well Projector', 0, 'None', 'Before deploying fleets, place 1 grav well token anywhere in the play area. When a ship deploys at distance 1-3 of a grav well token, its speed dial must be set to 0.', 'None', 2, 3, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (66, 'Grav Shift Reroute', 1, 'None', 'Before deploying fleets, place 1 grav shift token anywhere in the play area. After deploying fleets, you may move each obstacle at distance 1-3 of that token to within distance 2 of that obstacle\'s current location. Obstacles cannot overlap tokens, obstacles, or ships.', 'None', 2, 3, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (67, 'G-8 Experimental Projector', 1, 'None', 'Before an enemy ship at distance 1-5 resolves the determine course step, you may exhaust this card to temporarily reduce its speed by 1 to a minimum of speed 0 until the end of the maneuver.', 'None', 8, 3, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (68, 'Targeting Scrambler', 0, 'None', 'While a friendly ship at distance 1-3 is defending at close range, during the spend defense tokens step, you may exhaust this card to force the attacker to reroll up to 4 dice of your choice.', 'None', 5, 3, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (69, 'Redundant Shields', 0, 'None', 'Modification. At the start of each status phase, you may recover 1 shield.', 'None', 8, 2, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (70, 'Electronic Countermeasures', 0, 'None', 'While defending, you may exhaust this card to spend 1 defense token that your opponent targeted with an ACCURACY result.', 'None', 7, 2, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (71, 'Early Warning System', 0, 'None', 'At the start of each ship phase, you may choose 1 of your hull zones and mark it with a chaff token. Until the end of the round, while a ship or squadron is attacking that hull zone, the attack is obstructed. After the status phase, remove that chaff token.', 'None', 7, 2, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (72, 'Advanced Projectors', 0, 'None', 'When you resolve the REDIRECT token effect, you can choose more than 1 hull zone to suffer damage, which may include a nonadjacent hull zone.', 'None', 6, 2, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (73, 'Reinforced Blast Doors', 0, 'None', 'At the start of the ship phase, you may discard this card to discard up to 3 of your facedown damage cards.', 'None', 5, 2, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (74, 'Cluster Bombs', 0, 'None', 'After a squadron performs an attack against you, even if you are destroyed, you may discard this card to roll 4 blue dice. That squadron suffers 1 damage for each HIT or CRIT icon rolled.', 'None', 5, 2, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (75, 'Intensify Firepower!', 1, 'None', 'At the start of the ship phase, you may discard this card or spend a CONCENTRATE FIRE token. If you do, until the end of the round, while each friendly ship is attacking a ship, it may change 1 die to a face with 1 HIT icon and no other icons.', 'None', 6, 4, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (76, 'Shields To Maximum!', 1, 'None', 'At the start of the ship phase, you may discard this card or spend a REPAIR token. If you do, until the end of the round, before a friendly ship reveals a command, it may recover 1 shield.', 'None', 6, 4, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (77, 'Entrapment Formation!', 1, 'None', 'At the start of the ship phase, you may discard this card or spend a NAVIGATE token. If you do, until the end of the round, each friendly ship may change its speed by 1 during the determine course step.', 'None', 5, 4, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (78, 'All Fighters, Follow Me!', 1, 'None', 'At the start of the ship phase, you may discard this card or spend a SQUADRON token. If you do, until the end of the round, the speed of each squadron that a friendly ship activates is increased by 1, to a maximum of 5, until the end of that squadrons activation.', 'None', 5, 4, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (79, 'Bomber Command Center', 0, 'None', 'While a friendly squadron with BOMBER at distance 1-5 is attacking a ship, it may reroll 1 die.', 'None', 8, 5, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (80, 'Slicer Tools', 0, 'None', 'After you execute a maneuver, you may exhaust this card to choose an enemy ship at distance 1-3. You may choose a new command on its top command dial.', 'None', 7, 5, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (81, 'Repair Crews', 0, 'None', 'REPAIR: Instead of spending engineering points, you may discard 1 damage card form 1 friendly ship at distance 1-2.', 'None', 4, 5, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (82, 'Comms Net', 0, 'None', 'After the reveal command dial step, you may remove 1 command token from this ship to assign a matching token to another friendly ship at distance 1-5.', 'None', 2, 5, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (83, 'Jamming Field', 0, 'None', 'While a squadron at distance 1-2 is attacking or defending against a squadron, the attack is treated as obstructed.', 'None', 2, 5, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (84, 'NK-7 Ion Cannons', 0, 'None', 'Blue CRIT: You may exhaust this card to force the defender to choose and discard 1 of his defense tokens.', 'None', 10, 6, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (85, 'Heavy Ion Emplacements', 0, 'None', 'Blue CRIT: You may exhaust this card. If you do, the defending hull zone and each adjacent hull zone loses 1 shield.', 'None', 9, 6, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (86, 'Overload Pulse', 0, 'None', 'Blue CRIT: Exhaust all of the defender\'s defense tokens.', 'None', 8, 6, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (87, 'High-Capacity Ion Turbines', 0, 'None', 'Modification. The battery armaments for your left and right hull zones are increased by 1 blue die.', 'None', 8, 6, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (88, 'SW-7 Ion Batteries', 0, 'None', 'While attacking a ship, each of your unspent blue ACCURACY icons adds 1 damage to the damage total.', 'None', 5, 6, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (89, 'Leading Shots', 0, 'None', 'While attacking, you may spend 1 blue die to reroll any number of dice in your attack pool.', 'None', 4, 6, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (90, 'MS-1 Ion Cannons', 0, 'None', 'Blue CRIT: Choose and exhaust 1 of the defender\'s upgrade cards.', 'None', 2, 6, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (91, 'Rapid Launch Bays', 0, 'None', 'Before deploying fleets, you may set aside a number of friendly squadrons up to your squadron value next to your ship card. SQUADRON: For each squadron you would activate with this command, you may instead place 1 of your set-aside squadrons within distance 1. It cannot move this activation.', 'None', 6, 7, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (92, 'Phylon Q7 Tractor Beams', 0, 'None', 'Modification. When you activate, you may exhaust this card to choose 1 enemy ship of your size class or smaller at distance 1-5. That ship must spend a NAVIGATE token or reduce its speed by 1 to a minimum of 1.', 'None', 6, 7, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (93, 'Expanded Hanger Bay', 0, 'None', 'Your squadron value is increased by 1.', 'None', 5, 7, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (94, 'Quad Laser Turrets', 0, 'None', 'While defending at distance 1, if the attacker is a squadron, you have COUNTER 1.', 'None', 5, 7, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (95, 'Hardened Bulkheads', 0, 'None', 'Large ship only. When you overlap a ship of a smaller size class (or are overlapped by a ship of a smaller size class), deal 1 fewer facedown damage card to your ship.', 'Large', 5, 7, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (96, 'Point-Defense Reroute', 0, 'None', 'While attacking a squadron at close range, you may reroll your CRIT icons.', 'None', 5, 7, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (97, 'Boosted Comms', 0, 'None', 'SQUADRON: You can activate friendly squadrons at close-long range (instead of close-medium).', 'None', 4, 7, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (98, 'Disposable Capacitors', 0, 'None', 'Small or medium ship only. When you activate, you may discard this card. If you do, the blue dice in your battery armament can be used while attacking ships at close-long range until the end of the round.', 'Small|Medium', 3, 7, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (99, 'Adar Tallon', 1, 'Rebel Alliance', 'After you resolve a SQUADRON command, exhaust this card to toggle the activation slider of 1 squadron activated with that command.', 'None', 10, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (100, 'Toryn Farr', 1, 'Rebel Alliance', 'While another friendly ship or squadron at distance 1-3 is attacking, it may reroll 1 blue die.', 'None', 7, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (101, 'Bail Organa', 1, 'Rebel Alliance', 'Medium or Large ship only. After deploying fleets, you may place 1 round token on this card. At the start of the ship phase of the round matching that round token, if you are the second player, you must activate; if you are the first player, you may gain up to 2 command tokens of your choice.', 'Medium|Large', 7, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (102, 'Major Derlin', 1, 'Rebel Alliance', 'Before you suffer damage from an attack, you may exhaust this card to reduce the total damage by 1.', 'None', 7, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (103, 'Walex Blissex', 1, 'Rebel Alliance', 'When you activate, you may discard this card to recover 1 of your discarded defense tokens.', 'None', 5, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (104, 'Lando Calrissian', 1, 'Rebel Alliance', 'While defending, during the spend defense tokens step, you may discard this card to force the attacker to reroll 1 or more dice of your choice.', 'None', 4, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (105, 'General Draven', 1, 'Rebel Alliance', 'While attacking a squadron with counter or intel, add 1 die of any color to your attack pool.', 'None', 3, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (106, 'Leia Organa', 1, 'Rebel Alliance', 'When you reveal a command, you may choose another friendly ship at distance 1-5 and change that ship\'s top command to your revealed command.', 'None', 3, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (107, 'Ahsoka Tano', 1, 'Rebel Alliance', 'During the activation of a friendly ship at distance 1-5, you may exhaust this card to discard 1 command token from that ship. If you do, that ship may gain 1 command token of any type.', 'None', 2, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (108, 'Admiral Chiraneau', 1, 'Empire', 'SQUADRON: Squadrons that you activate can move even if they are engaged. When an engaged squadron moves in this way, treat it as having a printed speed of \"2\".', 'None', 10, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (109, 'Director Krennic', 1, 'Empire', 'CONCENTRATE FIRE: While attacking at medium-long range, if you spent a CONCENTRATE FIRE dial, you may also reroll any number of red dice in your attack pool. If you spent a CONCENTRATE FIRE token, you may also reroll up to 2 red dice in your attack pool.', 'None', 8, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (110, 'Commandant Aresko', 1, 'Empire', 'When another friendly ship at distance 1-3 reveals a command, you may exhaust this card to gain 1 command token of the same type.', 'None', 7, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (111, 'Wulff Yularen', 1, 'Empire', 'When you spend a command token, you may exhaust this card to gain 1 command token of the same type.', 'None', 7, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (112, 'Instructor Goran', 1, 'Empire', 'While a friendly non-HEAVY squadron is at distance 1-2, it has counter 1 or increases its counter value by 1.', 'None', 7, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (113, 'Governor Pryce', 1, 'Empire', 'Medium or Large ship only. After deploying fleets, you may place 1 round token on this card. If you do, during the round matching that round token, you must activate at the end of the ship phase. (After all other ships have activated)', 'Medium|Large', 7, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (114, 'Admiral Montferrat', 1, 'Empire', 'While defending against a ship, if your speed is 3 or higher, the attack is treated as obstructed. After you execute a maneuver, if you overlapped a ship, discard this card.', 'None', 5, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (115, 'Captain Brunson', 1, 'Empire', 'While defending at distance 1-2 of an obstacle, during the spend defense tokens step, you may exhaust this card to choose and cancel 1 attack die.', 'None', 5, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (116, 'Taskmaster Grint', 1, 'Empire', 'After deploying fleets, choose and place 1 command token on this card. When you reveal a command matching that token, you may gain 1 matching command token without spending the command dial.', 'None', 5, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (117, 'The Grand Inquisitor', 1, 'Empire', 'When an enemy ship at distance 1-5 changes its speed, you may exhaust this card to increase or decrease your speed by 1.', 'None', 4, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (118, 'Emperor Palpatine', 1, 'Empire', 'When an enemy ship or unique squadron declares you as the target of an attack, it must spend 1 of its defense tokens (if able).', 'None', 3, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (119, 'Agent Kallus', 1, 'Empire', 'While attacking a unique squadron, add 1 die of any color to you attack pool.', 'None', 3, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (120, 'Admiral Titus', 1, 'Empire', 'At the start of the first round, you may change 1 enemy ship\'s speed by 1.', 'None', 2, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (121, 'Captain Needa', 1, 'Empire', 'At the start of the first round, you may replace 1 of your defense tokens with an EVADE defense token.', 'None', 2, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (122, 'Lira Wessex', 1, 'Empire', 'When you are dealt a faceup damage card, you may spend 1 REPAIR token to flip that card facedown (without resolving its effect).', 'None', 2, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (123, 'Minister Tua', 1, 'Empire', 'You gain 1 additional DEFENSIVE RETROFIT icon in your upgrade bar. You cannot equip this card to a medium or large ship with a DEFENSIVE RETROFIT icon in its upgrade bar.', 'None', 2, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (124, 'Admiral Ozzel', 1, 'Empire', 'At the start of the first round, you may execute a speed-1 maneuver.', 'None', 2, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (125, 'Commander Gherant', 1, 'Empire', 'While you are defending, the attacker cannot resolve critical effects. After you perform an attack against a ship, discard this card.', 'None', 2, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (126, 'Darth Vader', 1, 'Empire', 'While a friendly ship at distance 1-5 is attacking a ship, it may discard 1 of its COMMANDER or OFFICER cards (other than Darth Vader) to reroll any number of dice in its attack pool.', 'None', 1, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (127, 'Wing Commander', 0, 'None', 'Before you reveal a command, you may change that command to a SQUADRON command.', 'None', 6, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (128, 'Engineering Captain', 0, 'None', 'Before you reveal a command, you may change that command to a REPAIR command.', 'None', 6, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (129, 'Tactical Expert', 0, 'None', 'Before you reveal a command, you may change that command to a CONCENTRATE FIRE command.', 'None', 6, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (130, 'Navigation Officer', 0, 'None', 'Before you reveal a command, you may change that command to a NAVIGATE command.', 'None', 6, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (131, 'Damage Control Officer', 0, 'None', 'When you resolve the CONTAIN defensive effect, you can prevent the attacker from resolving any critical effects.', 'None', 5, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (132, 'Support Officer', 0, 'None', 'At the start of the command phase, you may discard this card to discard all of your command dials.', 'None', 4, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (133, 'Strategic Adviser', 0, 'None', 'Large ship only. When it is your turn to activate, you may exhaust this card to pass your turn (your opponent activates a ship instead).', 'None', 4, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (134, 'Defense Liaison', 0, 'None', 'Before you reveal a command, you may spend 1 command token to change that command to a NAVIGATE or REPAIR command.', 'None', 3, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (135, 'Weapons Liaison', 0, 'None', 'Before you reveal a command, you may spend 1 command token to change that command to a CONCENTRATE FIRE or SQUADRON command.', 'None', 3, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (136, 'Veteran Captain', 0, 'None', 'When you reveal a command, you may discard this card to gain 1 command token of your choice.', 'None', 3, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (137, 'Flight Commander', 0, 'None', 'During your activation, you can resolve your SQUADRON command after you execute a maneuver.', 'None', 3, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (138, 'Chart Officer', 0, 'None', 'After you execute a maneuver, if you overlapped an obstacle, you may discard this card instead of resolving the effects of overlapping that obstacle.', 'None', 2, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (139, 'Hondo Ohnaka', 1, 'None', 'At the start of the ship phase, you may discard this card to choose 2 different command tokens and place them on 2 different ships. Then your opponent chooses 2 different command tokens you did not choose and places them on 2 different ships.', 'None', 2, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (140, 'Skilled First Officer', 0, 'None', 'Before you reveal a command, you may discard this card to discard your top command dial.', 'None', 1, 8, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (141, 'Expanded Launchers', 0, 'None', 'Modification. The battery armament for your front hull zone is increased by 2 black dice.', 'None', 13, 9, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (142, 'Rapid Reload', 0, 'None', 'Modification. The battery armaments for your left and right hull zones are increased by 1 black die.', 'None', 8, 9, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (143, 'Assault Concussion Missiles', 0, 'None', 'Black CRIT: Each hull zone adjacent to the defending hull zone suffers 1 damage.', 'None', 7, 9, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (144, 'Assault Proton Torpedoes', 0, 'None', 'Black CRIT: Deal 1 faceup damage card to the defender.', 'None', 5, 9, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (145, 'Ordnance Pods', 0, 'None', 'Medium or large ship only. At the end of your attack step, you may exhaust this card and choose 1 of your hull zones. Then, perform an attack from that hull zone with an anti-squadron armament of 1 black die, even if you have already attacked from that zone this round.', 'Medium|Large', 3, 9, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (146, 'External Racks', 0, 'None', 'While attacking at close range, you may discard this card to add 2 black dice to your attack pool.', 'None', 3, 9, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (147, 'Flechette Torpedoes', 0, 'None', 'While attacking a squadron, you may spend 1 black die with a CRIT icon to toggle its activation slider to the activated side.', 'None', 3, 9, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (148, 'Wide-Area Barrage', 0, 'None', 'Black CRIT: If the defender is a ship, choose 1 other ship or squadron at close range of the defender. That ship or squadron suffers damage equal to half of the total number of black HIT icons in your attack pool, rounded up.', 'None', 2, 9, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (149, 'Engine Techs', 0, 'None', 'NAVIGATE: After you execute a maneuver, you may exhaust this card to execute a 1-speed maneuver.', 'None', 8, 11, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (150, 'Projection Experts', 0, 'None', 'REPAIR: You may spend up to 2 engineering points to move that many shields from your ship to a friendly ship at distance 1-5.', 'None', 6, 11, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (151, 'Engineering Team', 0, 'None', 'REPAIR: Gain 1 additional engineering point.', 'None', 5, 11, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (152, 'Nav Team', 0, 'None', 'NAVIGATE: Your NAVIGATE tokens can either change your speed or increase 1 yaw value by 1.', 'None', 4, 11, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (153, 'Fighter Coordination Team', 0, 'None', 'After you execute a maneuver, you may select a number of unengaged friendly squadrons up to your squadron value at close-medium range. Those squadrons may move up to distance 1.', 'None', 3, 11, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (154, 'Medical Team', 0, 'None', 'Before you are dealt a faceup damage card with the CREW trait, you may discard this card to discard that damage card.', 'None', 1, 11, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (155, 'Quad Turbolaser Cannons', 0, 'None', 'While attacking, if at least 1 red die face has an ACCURACY icon, add 1 red die set to the ACCURACY icon to your attack pool.', 'None', 10, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (156, 'Enhanced Armament', 0, 'None', 'Modification. The battery armaments for your left and right hull zones are increased by 1 red die.', 'None', 10, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (157, 'Spinal Armament', 0, 'None', 'Modification. The battery armaments for your front and rear hull zones are increased by 1 red die.', 'None', 9, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (158, 'H9 Turbolasers', 0, 'None', 'While attacking, you may change 1 die face with a HIT or CRIT icon to a face with an ACCURACY icon.', 'None', 8, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (159, 'Turbolaser Reroute Circuits', 0, 'None', 'While attacking, you may spend 1 EVADE defense token to change 1 red die to a face with a CRIT icon or a 2 HIT icons.', 'None', 7, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (160, 'Slaved Turrets', 0, 'None', 'Modification. You cannot attack more than once per round. While attacking a ship, add 1 red die to your attack pool.', 'None', 6, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (161, 'Heavy Turbolaser Turrets', 0, 'None', 'While attacking, the BRACE defense effect cannot reduce the damage total by more than 1 unless it is the only defense token spent by the defender during the attack.', 'None', 6, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (162, 'X17 Turbolasers', 0, 'None', 'While attacking, if the defender spends a REDIRECT token, it cannot suffer more than 1 damage on hull zones other than the defending hull zone.', 'None', 6, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (163, 'XX-9 Turbolasers', 0, 'None', 'CRIT: The first 2 damage cards dealt to the defender by this attack are dealt faceup.', 'None', 5, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (164, 'Quad Battery Turrets', 0, 'None', 'Modification. While attacking a ship with a higher speed than yours, you may add 1 blue die to your attack pool.', 'None', 5, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (165, 'Dual Turbolaser Turrets', 0, 'None', 'Modification. While attacking, you may exhaust this card to add 1 red dice to your attack pool. If you do, remove 1 die from the attack pool.', 'None', 5, 13, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (166, 'Gunnery Team', 0, 'None', 'You can attack from the same hull zone more than once per activation. That hull zone cannot target the same ship or squadron more than once during that activation.', 'None', 7, 14, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (167, 'Flight Controllers', 0, 'None', 'SQUADRON: The anti-squadron armament of each squadron that you activate is increased by 1 blue die until the end of its activation.', 'None', 6, 14, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (168, 'Veteran Gunners', 0, 'None', 'While attacking, you may exhaust this card to reroll all dice in your attack pool.', 'None', 5, 14, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (169, 'Sensor Team', 0, 'None', 'While attacking, you may exhaust this card and spend 1 die to change 1 of your dice to a face with an ACCURACY icon.', 'None', 5, 14, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (170, 'Ordnance Experts', 0, 'None', 'While attacking, you may reroll any number of your black dice.', 'None', 4, 14, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (171, 'Ruthless Strategists', 0, 'None', 'After attacking a squadron, you may deal 1 damage to a friendly squadron engaged with the defender. If you do, the defender suffers 1 damage.', 'None', 4, 14, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (172, 'Fire-Control Team', 0, 'None', 'During the resolve damage step, you may exhaust this card to resolve 1 additional critical effect. You cannot resolve the same effect twice.', 'None', 2, 14, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (173, 'Caitken And Shollan', 1, 'Rebel Alliance', 'While attacking, you may exhaust this card to reroll any number of dice of 1 color.', 'None', 6, 14, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (174, 'Boarding Troopers', 0, 'None', 'When you reveal a command, you may discard a SQUADRON dial or token and this card to choose 1 enemy ship at close range. Choose and spend a number of its defense tokens up to your squadron value.', 'None', 3, 15, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (175, 'Boarding Engineers', 0, 'None', 'When you reveal a command, you may discard a SQUADRON dial or token and this card to choose 1 enemy ship at close range. Look at its facedown damage cards and flip a number of them faceup up to your engineering value (one at a time).', 'None', 2, 15, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (176, 'Cham Syndulla', 1, 'Rebel Alliance', 'When you reveal a command, you may discard a SQUADRON dial or token and this card to choose 1 enemy ship at close range. If you do, you may choose a new command for each command dial assigned to that ship.', 'None', 5, 15, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (177, 'Jyn Erso', 1, 'Rebel Alliance', 'When you reveal a command, you may discard a SQUADRON dial or token and this card to choose 1 enemy ship at close range. If that ship has no raid tokens, it gains 2 raid tokens of your choice. If that ship has an objective token, you may also gain 1 victory token.', 'None', 4, 15, NULL);
INSERT INTO `upgrade` (`id`, `name`, `unique`, `alignment`, `description`, `ship_type`, `cost`, `upgrade_type_id`, `image_id`) VALUES (178, 'Darth Vader', 1, 'Empire', 'When you reveal a command, you may discard a SQUADRON dial or token and this card to choose 1 enemy ship at close range. Choose and discard 1 non-COMMADER upgrade card equipped to that ship.', 'None', 3, 15, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ship_defense_token`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (1, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (1, 2, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (1, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (2, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (2, 2, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (2, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (3, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (3, 2, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (3, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (4, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (4, 2, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (4, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (5, 1, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (5, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (6, 1, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (6, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (7, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (7, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (7, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (8, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (8, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (8, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (9, 3, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (9, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (10, 3, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (10, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (11, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (11, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (11, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (12, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (12, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (12, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (13, 1, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (13, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (14, 1, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (14, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (15, 3, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (15, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (16, 3, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (16, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (17, 2, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (17, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (17, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (18, 2, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (18, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (18, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (19, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (19, 5, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (20, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (20, 5, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (21, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (21, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (21, 2, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (22, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (22, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (22, 2, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (23, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (23, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (23, 2, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (24, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (24, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (24, 2, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (25, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (25, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (25, 2, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (26, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (26, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (26, 2, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (27, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (27, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (28, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (28, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (29, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (29, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (29, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (30, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (30, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (30, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (31, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (31, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (32, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (32, 4, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (33, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (33, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (33, 2, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (34, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (34, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (34, 2, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (35, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (35, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (36, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (36, 1, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (37, 5, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (37, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (38, 5, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (38, 3, 1);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (39, 1, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (39, 2, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (39, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (40, 1, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (40, 2, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (40, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (41, 1, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (41, 2, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (41, 4, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (42, 1, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (42, 2, 2);
INSERT INTO `ship_defense_token` (`ship_id`, `defense_token_id`, `amount`) VALUES (42, 4, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hull_zone`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (1, 4, 'Forward', 0, 3, 2);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (2, 3, 'Sides', 3, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (3, 3, 'Rear', 0, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (4, 4, 'Forward', 0, 2, 3);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (5, 3, 'Sides', 3, 0, 2);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (6, 3, 'Rear', 0, 0, 2);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (7, 4, 'Front', 2, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (8, 4, 'Sides', 4, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (9, 3, 'Rear', 2, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (10, 4, 'Front', 1, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (11, 4, 'Sides', 3, 3, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (12, 3, 'Rear', 1, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (13, 5, 'Front', 4, 3, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (14, 2, 'Sides', 2, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (15, 2, 'Rear', 1, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (16, 5, 'Front', 3, 4, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (17, 2, 'Sides', 2, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (18, 2, 'Rear', 0, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (19, 4, 'Front', 2, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (20, 3, 'Sides', 3, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (21, 2, 'Rear', 2, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (22, 4, 'Front', 2, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (23, 3, 'Sides', 3, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (24, 2, 'Rear', 2, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (25, 3, 'Front', 2, 0, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (26, 3, 'Sides', 2, 0, 3);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (27, 2, 'Rear', 1, 0, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (28, 3, 'Front', 0, 1, 2);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (29, 3, 'Sides', 0, 2, 3);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (30, 2, 'Rear', 0, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (31, 3, 'Front', 2, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (32, 2, 'Sides', 1, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (33, 1, 'Rear', 2, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (34, 3, 'Front', 2, 0, 2);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (35, 2, 'Sides', 1, 0, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (36, 1, 'Rear', 2, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (37, 3, 'Front', 3, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (38, 1, 'Sides', 1, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (39, 2, 'Rear', 2, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (40, 3, 'Front', 3, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (41, 1, 'Sides', 1, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (42, 2, 'Rear', 2, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (43, 2, 'Front', 2, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (44, 2, 'Sides', 1, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (45, 1, 'Rear', 1, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (46, 2, 'Front', 0, 3, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (47, 2, 'Sides', 0, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (48, 1, 'Rear', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (49, 2, 'Front', 2, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (50, 1, 'Sides', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (51, 1, 'Rear', 0, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (52, 2, 'Front', 1, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (53, 1, 'Sides', 0, 0, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (54, 1, 'Rear', 0, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (55, 1, 'Front', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (56, 1, 'Sides', 0, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (57, 1, 'Rear', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (58, 1, 'Front', 0, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (59, 1, 'Sides', 0, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (60, 1, 'Rear', 0, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (61, 4, 'Front', 4, 4, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (62, 3, 'Sides', 2, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (63, 2, 'Rear', 1, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (64, 4, 'Front', 5, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (65, 3, 'Sides', 1, 3, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (66, 2, 'Rear', 1, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (67, 4, 'Front', 3, 2, 3);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (68, 3, 'Sides', 1, 1, 2);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (69, 2, 'Rear', 1, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (70, 4, 'Front', 3, 2, 3);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (71, 3, 'Sides', 2, 0, 2);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (72, 2, 'Rear', 1, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (73, 3, 'Front', 2, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (74, 2, 'Sides', 2, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (75, 2, 'Rear', 1, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (76, 3, 'Front', 1, 3, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (77, 2, 'Sides', 1, 3, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (78, 2, 'Rear', 1, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (79, 3, 'Front', 3, 3, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (80, 3, 'Sides', 2, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (81, 1, 'Rear', 2, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (82, 3, 'Front', 3, 0, 3);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (83, 3, 'Sides', 2, 0, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (84, 1, 'Rear', 2, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (85, 3, 'Front', 2, 0, 2);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (86, 2, 'Sides', 1, 0, 3);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (87, 1, 'Rear', 1, 0, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (88, 3, 'Front', 2, 0, 2);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (89, 2, 'Sides', 0, 0, 4);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (90, 1, 'Rear', 1, 0, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (91, 2, 'Front', 2, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (92, 2, 'Sides', 1, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (93, 1, 'Rear', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (94, 2, 'Front', 0, 3, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (95, 2, 'Sides', 0, 2, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (96, 1, 'Rear', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (97, 2, 'Front', 1, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (98, 2, 'Sides', 3, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (99, 2, 'Rear', 1, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (100, 2, 'Front', 1, 0, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (101, 2, 'Sides', 3, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (102, 2, 'Rear', 1, 0, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (103, 2, 'Front', 0, 3, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (104, 2, 'Sides', 0, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (105, 2, 'Rear', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (106, 2, 'Front', 0, 2, 2);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (107, 2, 'Sides', 0, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (108, 2, 'Rear', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (109, 1, 'Front', 1, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (110, 1, 'Sides', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (111, 1, 'Rear', 0, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (112, 1, 'Front', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (113, 1, 'Sides', 0, 1, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (114, 1, 'Rear', 0, 0, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (115, 6, 'Front', 5, 5, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (116, 5, 'Auxiliary-Side-Front', 4, 3, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (117, 5, 'Auxiliary-Side-Rear', 3, 3, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (118, 3, 'Rear', 2, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (119, 5, 'Front', 5, 4, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (120, 5, 'Auxiliary-Side-Front', 3, 3, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (121, 5, 'Auxiliary-Side-Rear', 2, 3, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (122, 3, 'Rear', 2, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (123, 6, 'Front', 5, 4, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (124, 3, 'Auxiliary-Side-Front', 3, 2, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (125, 3, 'Auxiliary-Side-Rear', 2, 2, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (126, 2, 'Rear', 1, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (127, 6, 'Front', 4, 4, 0);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (128, 3, 'Auxiliary-Side-Front', 3, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (129, 3, 'Auxiliary-Side-Rear', 2, 1, 1);
INSERT INTO `hull_zone` (`id`, `shields`, `location`, `as_red`, `as_blue`, `as_black`) VALUES (130, 2, 'Rear', 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ship_hull_zone`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (1, 1);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (1, 2);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (1, 3);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (2, 4);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (2, 5);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (2, 6);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (3, 7);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (3, 8);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (3, 9);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (4, 10);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (4, 11);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (4, 12);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (5, 13);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (5, 14);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (5, 15);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (6, 16);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (6, 17);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (6, 18);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (7, 19);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (7, 20);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (7, 21);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (8, 22);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (8, 23);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (8, 24);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (9, 25);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (9, 26);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (9, 27);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (10, 28);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (10, 29);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (10, 30);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (11, 31);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (11, 32);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (11, 33);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (12, 34);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (12, 35);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (12, 36);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (13, 37);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (13, 38);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (13, 39);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (14, 40);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (14, 41);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (14, 42);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (15, 43);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (15, 44);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (15, 45);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (16, 46);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (16, 47);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (16, 48);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (17, 49);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (17, 50);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (17, 51);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (18, 52);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (18, 53);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (18, 54);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (19, 55);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (19, 56);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (19, 57);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (20, 58);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (20, 59);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (20, 60);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (21, 61);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (21, 62);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (21, 63);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (22, 64);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (22, 65);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (22, 66);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (23, 67);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (23, 68);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (23, 69);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (24, 70);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (24, 71);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (24, 72);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (25, 73);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (25, 74);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (25, 75);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (26, 76);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (26, 77);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (26, 78);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (27, 79);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (27, 80);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (27, 81);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (28, 82);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (28, 83);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (28, 84);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (29, 85);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (29, 86);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (29, 87);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (30, 88);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (30, 89);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (30, 90);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (31, 91);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (31, 92);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (31, 93);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (32, 94);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (32, 95);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (32, 96);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (33, 97);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (33, 98);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (33, 99);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (34, 100);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (34, 101);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (34, 102);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (35, 103);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (35, 104);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (35, 105);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (36, 106);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (36, 107);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (36, 108);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (37, 109);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (37, 110);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (37, 111);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (38, 112);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (38, 113);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (38, 114);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (39, 115);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (39, 116);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (39, 117);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (39, 118);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (40, 119);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (40, 120);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (40, 121);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (40, 122);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (41, 123);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (41, 124);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (41, 125);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (41, 126);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (42, 127);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (42, 128);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (42, 129);
INSERT INTO `ship_hull_zone` (`ship_id`, `hull_zone_id`) VALUES (42, 130);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ship_upgrade_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 1, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 1, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 1, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 1, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 1, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 1, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 1, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 1, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 1, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 2, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 2, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 2, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 2, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 2, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 2, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 2, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 3, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 3, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 3, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 3, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 3, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 3, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 3, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 4, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 4, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 4, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 4, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 4, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 4, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 4, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 4, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 5, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 5, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 5, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 5, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 5, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 5, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 5, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 6, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 6, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 6, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 6, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 6, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 6, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 6, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 7, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 7, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 7, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 7, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 7, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 7, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 7, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 8, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 8, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 8, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 8, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 8, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 8, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 8, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 9, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 9, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 9, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 9, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 9, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 9, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 9, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 10, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 10, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 10, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 10, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 10, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 10, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 10, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 11, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 11, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 11, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (4, 11, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 11, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 11, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 12, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 12, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 12, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (4, 12, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 12, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 12, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 13, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 13, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 13, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 13, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 13, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 14, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 14, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 14, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 14, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 14, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 15, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 15, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 15, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 15, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 15, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 15, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 16, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 16, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 16, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 16, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 16, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 16, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 17, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 17, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 17, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 17, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 17, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 17, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 18, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 18, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 18, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 18, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 18, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 18, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 19, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 19, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 19, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (5, 19, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 19, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 20, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 20, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 20, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (5, 20, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 20, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 21, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 21, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 21, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 21, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 21, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 21, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 21, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 21, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 22, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 22, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 22, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 22, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (4, 22, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 22, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 22, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 23, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 23, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 23, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 23, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 23, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 23, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 23, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 23, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 24, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 24, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 24, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 24, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 24, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 24, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 24, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 25, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 25, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 25, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (3, 25, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 25, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 25, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 25, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 26, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 26, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 26, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (3, 26, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 26, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 26, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 26, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 27, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 27, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 27, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 27, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 27, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 27, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 27, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 28, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 28, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 28, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 28, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 28, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 28, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 28, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 29, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 29, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 29, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 29, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 29, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 29, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 30, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 30, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 30, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 30, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 30, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 30, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 31, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 31, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 31, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 31, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 31, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 32, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 32, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 32, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 32, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 32, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 33, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 33, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 33, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 33, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (11, 33, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 33, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 34, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 34, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 34, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (2, 34, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 34, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 35, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 35, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 35, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 35, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 35, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 35, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 36, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 36, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (9, 36, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 36, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 36, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 36, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 37, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 37, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 37, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (5, 37, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 37, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 38, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 38, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 38, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (5, 38, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 38, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 39, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 39, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 39, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 39, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 39, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (4, 39, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 39, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 39, 4, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 40, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 40, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 40, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 40, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 40, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (4, 40, 4, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 40, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 40, 4, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 41, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 41, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 41, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 41, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 41, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 41, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 41, 3, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (1, 42, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (12, 42, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (13, 42, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (6, 42, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (7, 42, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (4, 42, 2, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (14, 42, 1, 0);
INSERT INTO `ship_upgrade_type` (`upgrade_type_id`, `ship_id`, `amount`, `filled`) VALUES (8, 42, 3, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ship_build`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `ship_build` (`id`, `ship_id`) VALUES (1, 1);
INSERT INTO `ship_build` (`id`, `ship_id`) VALUES (2, 3);
INSERT INTO `ship_build` (`id`, `ship_id`) VALUES (3, 9);
INSERT INTO `ship_build` (`id`, `ship_id`) VALUES (4, 9);
INSERT INTO `ship_build` (`id`, `ship_id`) VALUES (5, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `list`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `list` (`id`, `name`, `desired_cost`, `actual_cost`, `point_sway`) VALUES (1, 'First Build', 500, 354, 15);
INSERT INTO `list` (`id`, `name`, `desired_cost`, `actual_cost`, `point_sway`) VALUES (2, 'Second One', 500, 456, 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `fighter`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (1, 'Wedge Antillies', 1, 5, 3, 19, 'While attacking an activated squadron, you may add 2 blue dice to your attack pool.', 'Rebel Alliance', 'X-Wing', NULL, 0, 4, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (2, 'Biggs Darklighter', 1, 5, 3, 19, 'Before a friendly squadron with ESCORT at distance 1 suffers damage during an attack, you may reduce the total damage by 1. If you do, choose a friendly squadron with ESCORT at distance 1. That squadron suffers 1 damage.', 'Rebel Alliance', 'X-Wing', NULL, 0, 4, 0, 1, 0, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (3, 'Luke Skywalker', 1, 5, 3, 20, 'While attacking a ship, treat the defender as having no shields.', 'Rebel Alliance', 'X-Wing', NULL, 0, 4, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (4, 'Rogue Squadron', 1, 5, 3, 14, NULL, 'Rebel Alliance', 'X-Wing', NULL, 0, 4, 0, 1, 0, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (5, 'X-Wing Squadron', 0, 5, 3, 13, NULL, 'Rebel Alliance', 'X-Wing', NULL, 0, 4, 0, 1, 0, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (6, 'Shara Bey', 1, 4, 5, 17, 'While performing a COUNTER attack, each crit icon adds 1 damage to the damage total', 'Rebel Alliance', 'A-Wing', 3, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (7, 'Tycho Celchu', 1, 4, 5, 16, 'You are not prevented from moving or attacking ships while you are engaged', 'Rebel Alliance', 'A-Wing', 2, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (8, 'Green Squadron', 1, 4, 5, 12, NULL, 'Rebel Alliance', 'A-Wing', 1, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (9, 'A-Wing Squadron', 0, 4, 5, 11, NULL, 'Rebel Alliance', 'A-Wing', 2, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (10, '\"Dutch\" Vander', 1, 6, 3, 16, 'When a squadron you attack suffers at least 1 damage, you may toggle its activation slider to the activated side. If it was already activated, it suffers 1 additional damage instead.', 'Rebel Alliance', 'Y-Wing', NULL, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (11, 'Norra Wexley', 1, 6, 3, 17, 'Friendly squadrons with BOMBER at distance 1 gain the following effect: Crit, The defending hull zone loses 1 shield.', 'Rebel Alliance', 'Y-Wing', NULL, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (12, 'Gold Squadron', 1, 6, 3, 12, NULL, 'Rebel Alliance', 'Y-Wing', NULL, 0, 2, 0, 0, 2, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (13, 'Y-Wing Squadron', 0, 6, 3, 10, NULL, 'Rebel Alliance', 'Y-Wing', NULL, 0, 2, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (14, 'Keyan Farlander', 1, 5, 2, 20, 'While attacking a ship, if the defending hull zone has no shields, you may reroll any number of dice in your attack pool.', 'Rebel Alliance', 'B-Wing', NULL, 0, 3, 0, 0, 0, 2, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (15, 'Ten Numb', 1, 5, 2, 19, 'While attacking a squadron, you may spend 1 blue die with a crit icon. If you do, each other enemy squadron at distance 1 of the defender suffers 1 damage.', 'Rebel Alliance', 'B-Wing', NULL, 0, 2, 1, 0, 1, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (16, 'Dagger Squadron', 1, 5, 2, 15, NULL, 'Rebel Alliance', 'B-Wing', NULL, 0, 2, 1, 0, 1, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (17, 'B-Wing Squadron', 0, 5, 2, 14, NULL, 'Rebel Alliance', 'B-Wing', NULL, 0, 3, 0, 0, 1, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (18, 'Corran Horn', 1, 5, 4, 22, NULL, 'Rebel Alliance', 'E-Wing', 4, 0, 4, 0, 1, 0, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (19, 'E-Wing Squadron', 0, 5, 4, 15, NULL, 'Rebel Alliance', 'E-Wing', 3, 0, 4, 0, 1, 0, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (20, 'Hera Syndulla', 1, 8, 3, 28, 'At the start of the squadron phase, choose up to 2 friendly squadrons at distance 1-2. Those squadrons gain ROGUE until the end of the round.', 'Rebel Alliance', 'Ghost (Modified VCX-100 freighter)', NULL, 0, 2, 2, 0, 1, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (21, 'VCX-100 Freighter', 0, 8, 3, 15, NULL, 'Rebel Alliance', 'VCX-100 freighter', 1, 0, 3, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (22, 'Lieutenant Blount', 1, 3, 3, 14, 'While another friendly squadron with SWARM at distance 1 is attacking a squadron, it may reroll 1 die (in addition to any dice rerolled from SWARM).', 'Rebel Alliance', 'Z-95 Headhunter', NULL, 3, 0, 0, 1, 0, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (23, 'Z-95 Headhunter Squadron', 0, 3, 3, 7, NULL, 'Rebel Alliance', 'Z-95 Headhunter', NULL, 3, 0, 0, 1, 0, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (24, 'Han Solo', 1, 7, 3, 26, 'At the start of the ship phase, you may activate as if you were activated by a Squadron Command dial or token.', 'Rebel Alliance', 'Millennium Falcon (Modified YT-1300)', NULL, 0, 2, 2, 0, 1, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (25, 'YT-1300', 0, 7, 2, 13, NULL, 'Rebel Alliance', 'YT-1300', 1, 0, 3, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (26, 'Dash Rendar', 1, 6, 4, 24, 'While attacking, you may reroll 1 die for each enemy squadron or enemy ship at distance 1.', 'Rebel Alliance', 'Outrider (Modified YT-2400)', NULL, 0, 4, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (27, 'YT-2400', 0, 6, 4, 16, NULL, 'Rebel Alliance', 'YT-2400', NULL, 0, 4, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (28, 'Nym', 1, 6, 3, 21, 'Blue crit: If the defender is a ship, you may choose and discard 1 of its defense tokens', 'Rebel Alliance', 'Havoc (Scurrg H-6 Bomber)', NULL, 0, 2, 0, 0, 1, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (29, 'Scurrg H-6 Bomber', 0, 6, 3, 16, NULL, 'Rebel Alliance', 'Scurrg H-6 Bomber', NULL, 0, 2, 0, 0, 1, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (30, 'Ketsu Onyo', 1, 4, 4, 22, 'While an enemy squadron is at distance 1, its speed is reduced by 2 to a minimum of 1.', 'Rebel Alliance', 'Shadow Caster (Modified Lancer-class)', NULL, 0, 3, 0, 0, 2, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (31, 'Lancer-class Pursuit Craft', 0, 4, 4, 15, NULL, 'Rebel Alliance', 'Lancer-class Pursuit craft', NULL, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (32, 'Jan Ors', 1, 4, 3, 19, 'While a friendly squadron at distance 1-2 is defending, it can spend your defense tokens as if they were its own.', 'Rebel Alliance', 'Moldy Crow (Modified HWK-290)', 2, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (33, 'HWK-290', 0, 4, 3, 12, NULL, 'Rebel Alliance', 'HWK-290', 2, 0, 2, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (34, 'Howl-Runner', 1, 3, 4, 16, 'While another friendly with SWARM at distance 1 is attacking a squadron, it may add 1 blue die to its attack pool.', 'Empire', 'TIE Fighter', NULL, 0, 3, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (35, '\"Mauler\" Mithel', 1, 3, 4, 15, 'After you move, each squadron engaged with you suffers 1 damage', 'Empire', 'TIE Fighter', NULL, 0, 3, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (36, 'Valen Rudor', 1, 3, 4, 13, 'While an enemy squadron is engaged with another squadron, it cannot attack you.', 'Empire', 'TIE Fighter', NULL, 0, 0, 3, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (37, 'Black Squadron', 1, 3, 4, 9, NULL, 'Empire', 'TIE Fighter', 1, 0, 3, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (38, 'TIE Fighter Squadron', 0, 3, 4, 8, NULL, 'Empire', 'TIE Fighter', NULL, 0, 3, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (39, 'Soontir Fel', 1, 3, 5, 18, 'After a squadron you are engaged with performs a non-COUNTER attack, it suffers 1 damage if it did not attack you.', 'Empire', 'TIE Interceptor', 2, 0, 4, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (40, 'Ciena Ree', 1, 3, 5, 17, 'While you are defending, the attack is treated as obstructed.', 'Empire', 'TIE Interceptor', 2, 0, 4, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (41, 'Saber Squadron', 1, 3, 5, 12, NULL, 'Empire', 'TIE Interceptor', 4, 0, 4, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (42, 'TIE Interceptor Squadron', 0, 3, 5, 11, NULL, 'Empire', 'TIE Interceptor', 2, 0, 4, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (43, 'Major Rhymer', 1, 5, 4, 16, 'Friendly squadrons at distance 1 can attack enemy ships at close-medium range using all dice in their battery armament.', 'Empire', 'TIE Bomber', NULL, 0, 1, 1, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (44, 'Captain Jonus', 1, 5, 4, 16, 'While a friendly ship is attacking a ship at distance 1 of you, it may change 1 die to a face with an accuracy icon.', 'Empire', 'TIE Bomber', NULL, 0, 0, 1, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (45, 'Gamma Squadron', 1, 5, 4, 10, NULL, 'Empire', 'TIE Bomber', NULL, 0, 0, 1, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (46, 'TIE Bomber Squadron', 0, 5, 4, 9, NULL, 'Empire', 'TIE Bomber', NULL, 0, 0, 1, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (47, 'Darth Vader', 1, 5, 4, 21, 'While attacking, each of your crit icons adds 1 damage to the damage total.', 'Empire', 'TIE Advanced', NULL, 0, 3, 1, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (48, 'Zertik Strom', 1, 5, 4, 15, 'While attack, you may choose another friendly squadron at distance 1. If you do, that squadron suffers 1 damage and you may reroll any number of attack dice', 'Empire', 'TIE Advanced', NULL, 3, 0, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (49, 'Tempest Squadron', 1, 5, 4, 13, NULL, 'Empire', 'TIE Advanced', NULL, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (50, 'TIE Advanced Squadron', 0, 5, 4, 12, NULL, 'Empire', 'TIE Advanced', NULL, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (51, 'Maarek Stele', 1, 6, 5, 21, 'While attacking you may change 1 die to a face with a crit icon.', 'Empire', 'TIE Defender', NULL, 0, 2, 2, 0, 2, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (52, 'TIE Defender Squadron', 0, 6, 5, 16, NULL, 'Empire', 'TIE Defender', NULL, 0, 2, 2, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (53, 'Whisper', 1, 4, 4, 20, 'After defending against an attack, if you spent a defense token, you may move up to distance 1, even if you are engaged.', 'Empire', 'TIE Phantom', NULL, 0, 4, 0, 2, 0, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (54, 'TIE Phantom Squadron', 0, 4, 4, 14, NULL, 'Empire', 'TIE Phantom', NULL, 0, 4, 0, 2, 0, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (55, 'Morna Kee', 1, 8, 3, 27, 'While attacking, you may spend 1 defense token to reroll any number of dice in your attack pool. When you activate, you may recover 1 of your discarded defense tokens.', 'Empire', 'VT-49 Decimator', 1, 0, 0, 3, 0, 3, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (56, 'VT-49 Decimator', 0, 8, 3, 22, NULL, 'Empire', 'VT-49 Decimator', 1, 0, 0, 3, 0, 3, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (57, 'Colonel Jendon', 1, 6, 3, 20, 'During your activation, instead of attacking, you may choose 1 friendly squadron at distance 1-2. That squadron may perform an attack (even if it has already activated).', 'Empire', 'Lambda-class Shuttle', 2, 0, 0, 2, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (58, 'Lambda-class Shuttle', 0, 6, 3, 15, NULL, 'Empire', 'Lambda-class Shuttle', 2, 0, 0, 2, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (59, 'IG-88', 1, 5, 3, 21, 'You ignore the ESCORT and COUNTER keywords on enemy squadrons', 'Empire', 'Aggressor Assault Fighter', 2, 0, 4, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (60, 'Aggressor Assault Fighter', 0, 5, 3, 16, NULL, 'Empire', 'Aggressor Assault Fighter', 1, 0, 4, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (61, 'Gar Saxon', 1, 7, 4, 23, 'When an enemy squadron with INTEL or RELAY at distance 1 activates, it suffers 1 damage.', 'Empire', 'Mandalorian Gautlet Fighter', NULL, 1, 2, 0, 0, 2, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (62, 'Mandalorian Gauntlet Fighter', 0, 7, 4, 20, NULL, 'Empire', 'Mandalorian Gautlet Fighter', NULL, 1, 2, 0, 0, 1, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (63, 'Bossk', 1, 7, 3, 23, 'While attacking, if you have 6 or fewer hull points remaining, you may add 1 blue die set to the accuracy icon to your attack pool.', 'Empire', 'Hound\'s Tooth (Modified YV-666)', NULL, 0, 0, 4, 0, 1, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (64, 'YV-666', 0, 7, 3, 15, NULL, 'Empire', 'YV-666', NULL, 0, 2, 2, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (65, 'Dengar', 1, 4, 4, 20, 'While another friendly squadron is at distance 1-2, it has COUNTER 1 or increases its COUNTER value by 1', 'Empire', 'Punishing one (Modified JumpMaster 5000)', NULL, 0, 3, 0, 0, 0, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (66, 'JumpMaster 5000', 0, 4, 4, 12, NULL, 'Empire', 'JumpMaster 5000', NULL, 0, 2, 0, 0, 1, 0, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (67, 'Boba Fett', 1, 6, 3, 26, 'When you activate, choose 1 enemy ship or squadron at distance 1. That ship or squadron suffers 1 damage.', 'Empire', 'Slave 1 (Modified Firespray-31)', NULL, 0, 4, 0, 0, 1, 1, NULL);
INSERT INTO `fighter` (`id`, `name`, `unique`, `health`, `movement`, `cost`, `special_ability`, `alignment`, `model`, `rating`, `af_red`, `af_blue`, `af_black`, `as_red`, `as_blue`, `as_black`, `image_id`) VALUES (68, 'Firespray-31', 0, 6, 3, 18, NULL, 'Empire', 'Firespray-31', NULL, 0, 3, 0, 0, 2, 0, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `user` (`id`, `username`, `password`) VALUES (1, 'Vint3r', 'Ca$h1matrix');

COMMIT;


-- -----------------------------------------------------
-- Data for table `keyword`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (1, 'Assault', 'While attacking a ship, you may spend 1 die with a hit icon. If you do, the defender gains 1 raid token of your choice.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (2, 'Bomber', 'While attacking a ship, each of your crit icons adds 1 damage to the damage total and you can resolve a critical effect.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (3, 'Cloak', 'At the end of the Squadron Phase, you may move up to distance 1, even if you are engaged.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (4, 'Counter', 'After a squadron performs a non-Counter attack against you, you may attack that squadron with an anti-squadron armament of X blue dice, even if you are destroyed.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (5, 'Escort', 'Squadrons you are engaged with cannot attack squadrons without Escort unless performing a Counter attack.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (6, 'Grit', 'You are not prevented from moving while you are engaged by only 1 squadron.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (7, 'Heavy', 'You do not prevent engaged squadrons from attacking ships or moving.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (8, 'Intel', 'While an enemy squadron is at distance 1 of you, it has Heavy.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (9, 'Relay', 'When a friendly ship resolves a Icon Command Squadron command, if you are in range to be activated, up to X of the squadrons it activates can be at distance 1-3 of you.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (10, 'Rogue', 'You can move and attack during the Squadron Phase.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (11, 'Snipe', 'You can attack squadrons at distance 2 with an anti-squadron armament of X blue dice. This attack ignores the Counter keyword.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (12, 'Strategic', 'When you end your movement at distance 1 of 1 or more objective tokens you may move 1 of those tokens so that it is at distance 1 of you.');
INSERT INTO `keyword` (`id`, `name`, `description`) VALUES (13, 'Swarm', 'While attacking a squadron engaged with another squadron, you may reroll 1 die.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `upgrade_ship_build`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (1, 1);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (69, 2);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (72, 2);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (31, 3);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (32, 4);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (143, 3);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (143, 4);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (1, 5);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (26, 5);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (157, 5);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (73, 5);
INSERT INTO `upgrade_ship_build` (`upgrade_id`, `ship_build_id`) VALUES (85, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `fighter_defense_token`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 1, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 2, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 3, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 6, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 6, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 7, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 7, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 10, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 11, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 14, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 15, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 18, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 20, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 22, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 22, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 24, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 26, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 28, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 30, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 30, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 32, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 34, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 34, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 35, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 35, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 36, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 36, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 39, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 39, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 40, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 40, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 43, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 44, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 47, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 48, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 51, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 53, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 53, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 55, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 57, 2);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 61, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 63, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 65, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (5, 65, 1);
INSERT INTO `fighter_defense_token` (`defense_token_id`, `fighter_id`, `amount`) VALUES (1, 67, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `list_ship`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `list_ship` (`list_id`, `ship_build_id`) VALUES (1, 1);
INSERT INTO `list_ship` (`list_id`, `ship_build_id`) VALUES (1, 2);
INSERT INTO `list_ship` (`list_id`, `ship_build_id`) VALUES (2, 3);
INSERT INTO `list_ship` (`list_id`, `ship_build_id`) VALUES (2, 4);
INSERT INTO `list_ship` (`list_id`, `ship_build_id`) VALUES (2, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `list_fighter`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `list_fighter` (`fighter_id`, `list_id`, `amount`) VALUES (1, 1, 1);
INSERT INTO `list_fighter` (`fighter_id`, `list_id`, `amount`) VALUES (5, 1, 5);
INSERT INTO `list_fighter` (`fighter_id`, `list_id`, `amount`) VALUES (2, 2, 1);
INSERT INTO `list_fighter` (`fighter_id`, `list_id`, `amount`) VALUES (5, 2, 5);
INSERT INTO `list_fighter` (`fighter_id`, `list_id`, `amount`) VALUES (6, 2, 1);
INSERT INTO `list_fighter` (`fighter_id`, `list_id`, `amount`) VALUES (9, 2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `user_has_list` (`user_id`, `list_id`) VALUES (1, 1);
INSERT INTO `user_has_list` (`user_id`, `list_id`) VALUES (1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `fighter_keyword`
-- -----------------------------------------------------
START TRANSACTION;
USE `armadalistdb`;
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (1, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (1, 5);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (2, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (2, 5);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (3, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (3, 5);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (4, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (4, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (5, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (5, 5);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (6, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (7, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (8, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (8, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (9, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (10, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (10, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (11, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (12, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (13, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (13, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (14, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (15, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (16, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (16, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (17, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (17, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (17, 11);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (18, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (18, 11);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (20, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (20, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (21, 12);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (21, 9);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (21, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (22, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (23, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (24, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (24, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (25, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (25, 5);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (26, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (26, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (27, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (28, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (28, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (29, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (29, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (29, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (30, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (30, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (30, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (31, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (31, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (31, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (32, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (32, 8);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (33, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (33, 8);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (34, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (35, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (36, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (37, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (37, 5);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (38, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (39, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (39, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (40, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (40, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (41, 11);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (41, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (42, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (42, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (43, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (43, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (44, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (44, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (44, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (45, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (45, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (46, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (46, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (47, 5);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (48, 5);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (49, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (49, 5);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (50, 5);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (51, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (51, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (52, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (53, 3);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (54, 3);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (55, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (55, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (56, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (56, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (56, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (57, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (57, 9);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (58, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (58, 9);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (58, 12);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (59, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (59, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (60, 4);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (60, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (61, 1);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (61, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (62, 1);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (62, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (63, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (63, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (64, 6);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (64, 7);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (64, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (65, 8);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (65, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (66, 8);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (66, 13);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (67, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (67, 10);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (68, 2);
INSERT INTO `fighter_keyword` (`fighter_id`, `keyword_id`) VALUES (68, 10);

COMMIT;

