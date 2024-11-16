-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema platzi_pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `platzi_pizzeria` ;

-- -----------------------------------------------------
-- Schema platzi_pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `platzi_pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `platzi_pizzeria` ;

-- -----------------------------------------------------
-- Table `platzi_pizzeria`.`pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platzi_pizzeria`.`pizza` ;

CREATE TABLE IF NOT EXISTS `platzi_pizzeria`.`pizza` (
  `id_pizza` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(150) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `vegetarian` TINYINT NULL,
  `vegan` TINYINT NULL,
  `available` TINYINT NOT NULL,
  PRIMARY KEY (`id_pizza`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platzi_pizzeria`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platzi_pizzeria`.`customer` ;

CREATE TABLE IF NOT EXISTS `platzi_pizzeria`.`customer` (
  `id_customer` VARCHAR(15) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `address` VARCHAR(100) NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(20) NULL,
  PRIMARY KEY (`id_customer`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platzi_pizzeria`.`pizza_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platzi_pizzeria`.`pizza_order` ;

CREATE TABLE IF NOT EXISTS `platzi_pizzeria`.`pizza_order` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `id_customer` VARCHAR(15) NOT NULL,
  `date` DATETIME NOT NULL,
  `total` DECIMAL(6,2) NOT NULL,
  `method` CHAR(1) NOT NULL COMMENT 'D = delivery\nS = on site\nC = carryout',
  `additional_notes` VARCHAR(200) NULL,
  PRIMARY KEY (`id_order`),
  INDEX `fk_ORDER_CUSTOMER1_idx` (`id_customer` ASC) ,
  CONSTRAINT `fk_ORDER_CUSTOMER1`
    FOREIGN KEY (`id_customer`)
    REFERENCES `platzi_pizzeria`.`customer` (`id_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platzi_pizzeria`.`order_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platzi_pizzeria`.`order_item` ;

CREATE TABLE IF NOT EXISTS `platzi_pizzeria`.`order_item` (
  `id_item` INT NOT NULL AUTO_INCREMENT,
  `id_order` INT NOT NULL,
  `id_pizza` INT NOT NULL,
  `quantity` DECIMAL(2,1) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id_item`, `id_order`),
  INDEX `fk_ORDER_ITEM_ORDER_idx` (`id_order` ASC) ,
  INDEX `fk_ORDER_ITEM_PIZZA1_idx` (`id_pizza` ASC) ,
  CONSTRAINT `fk_ORDER_ITEM_ORDER`
    FOREIGN KEY (`id_order`)
    REFERENCES `platzi_pizzeria`.`pizza_order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDER_ITEM_PIZZA1`
    FOREIGN KEY (`id_pizza`)
    REFERENCES `platzi_pizzeria`.`pizza` (`id_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platzi_pizzeria`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platzi_pizzeria`.`user` ;

CREATE TABLE IF NOT EXISTS `platzi_pizzeria`.`user` (
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` VARCHAR(50) NULL,
  `locked` TINYINT NOT NULL,
  `disabled` TINYINT NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platzi_pizzeria`.`user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platzi_pizzeria`.`user_role` ;

CREATE TABLE IF NOT EXISTS `platzi_pizzeria`.`user_role` (
  `username` VARCHAR(20) NOT NULL,
  `role` VARCHAR(20) NOT NULL COMMENT 'CUSTOMER\nADMIN',
  `granted_date` DATETIME NOT NULL,
  PRIMARY KEY (`username`, `role`),
  CONSTRAINT `fk_user_role_user1`
    FOREIGN KEY (`username`)
    REFERENCES `platzi_pizzeria`.`user` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- TRUNCATE TABLES
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE `platzi_pizzeria`.`order_item`;
TRUNCATE `platzi_pizzeria`.`pizza_order`;
TRUNCATE `platzi_pizzeria`.`customer`;
TRUNCATE `platzi_pizzeria`.`pizza`;
SET FOREIGN_KEY_CHECKS = 1;

-- INSERT CUSTOMERS
INSERT INTO `platzi_pizzeria`.`customer` (`id_customer`, `name`, `address`, `email`, `phone_number`)
VALUES
("863264988","Drake Theory","P.O. Box 136, 4534 Lacinia St.","draketheory@hotmail.com","(826) 607-2278"),
("617684636","Alexa Morgan","Ap #732-8087 Dui. Road","aleximorgan@hotmail.com","(830) 212-2247"),
("474771564","Johanna Reigns","925-3988 Purus. St.","johareigns@outlook.com","(801) 370-4041"),
("394022487","Becky Alford","P.O. Box 341, 7572 Odio Rd.","beckytwobelts@icloud.com","(559) 398-7689"),
("885583622","Brock Alford","9063 Aliquam, Road","brockalford595@platzi.com","(732) 218-4844"),
("531254932","Clarke Wyatt","461-4278 Dignissim Av.","wyattplay@google.co","(443) 263-8555"),
("762085429","Cody Rollins","177-1125 Consequat Ave","codyforchamp@google.com","(740) 271-3631"),
("363677933","Bianca Neal","Ap #937-4424 Vestibulum. Street","bianca0402@platzi.com","(792) 406-8858"),
("192758012","Drew Watson","705-6031 Aliquam Street","wangwatson@icloud.com","(362) 881-5943"),
("110410415","Mercedes Balor","Ap #720-1833 Curabitur Av.","mercedesbalorclub@hotmail.com","(688) 944-6619"),
("262132898","Karl Austin","241-9121 Fames St.","stonecold@icloud.com","(559) 596-3381"),
("644337170","Sami Rollins","Ap #308-4700 Mollis Av.","elgenerico@outlook.com","(508) 518-2967"),
("782668115","Charlotte Riddle","Ap #696-6846 Ullamcorper Avenue","amityrogers@outlook.com","(744) 344-7768"),
("182120056","Matthew Heyman","Ap #268-1749 Id St.","heymanboss@hotmail.com","(185) 738-9267"),
("303265780","Shelton Owens","Ap #206-5413 Vivamus St.","figthowens@platzi.com","(821) 880-6661");

-- INSERT PIZZAS
INSERT INTO `platzi_pizzeria`.`pizza` (`id_pizza`, `name`, `description`, `price`, `vegetarian`, `vegan`, `available`)
VALUES
(1,"Pepperoni", "Pepperoni, Homemade Tomato Sauce & Mozzarella.", 23.0, 0, 0, 1),
(2,"Margherita", "Fior de Latte, Homemade Tomato Sauce, Extra Virgin Olive Oil & Basil.", 18.5, 1, 0, 1),
(3,"Vegan Margherita", "Fior de Latte, Homemade Tomato Sauce, Extra Virgin Olive Oil & Basil.", 22.0, 1, 1, 1),
(4,"Avocado Festival", "Hass Avocado, House Red Sauce, Sundried Tomatoes, Basil & Lemon Zest.", 19.95, 1, 0, 1),
(5,"Hawaiian", "Homemade Tomato Sauce, Mozzarella, Pineapple & Ham.", 20.5, 0, 0, 0),
(6,"Goat Chesse", "Portobello Mushrooms, Mozzarella, Parmesan & Goat Cheeses with Alfredo Sauce.", 24.0, 0, 0, 1),
(7,"Mother Earth", "Artichokes, Roasted Peppers, Rapini, Sundried Tomatoes, Onion, Shaved Green Bell Peppers & Sunny Seasoning.", 19.5, 1, 0, 1),
(8,"Meat Lovers", "Mild Italian Sausage, Pepperoni, Bacon, Homemade Tomato Sauce & Mozzarella.", 21.0, 0, 0, 1),
(9,"Marinated BBQ Chicken", "Marinated Chicken with Cilantro, Red Onions, Gouda, Parmesan & Mozzarella Cheeses.", 20.95, 0, 0, 0),
(10,"Truffle Cashew Cream", "Wild mushrooms, Baby Kale, Shiitake Bacon & Lemon Vinaigrette. Soy free.", 22.0, 1, 1, 1),
(11,"Rico Mor", "Beef Chorizo, Sundried Tomatoes, Salsa Verde, Pepper, Jalapeno & pistachios", 23.0, 0, 0, 1),
(12,"Spinach Artichoke", "Fresh Spinach, Marinated Artichoke Hearts, Garlic, Fior de Latte, Mozzarella & Parmesan.", 18.95, 1, 0, 1);

-- INSERT ORDERS
INSERT INTO `platzi_pizzeria`.`pizza_order` (`id_order`, `id_customer`, `date`, `total`, `method`, `additional_notes`)
VALUES
(1, "192758012", DATE_SUB(NOW(), INTERVAL 5 DAY), 42.95, "D", "Don't be late pls."),
(2, "474771564", DATE_SUB(NOW(), INTERVAL 4 DAY), 62.0, "S", null),
(3, "182120056", DATE_SUB(NOW(), INTERVAL 3 DAY), 22.0, "C", null),
(4, "617684636", DATE_SUB(NOW(), INTERVAL 2 DAY), 42.0, "S", null),
(5, "192758012", DATE_SUB(NOW(), INTERVAL 1 DAY), 20.5, "D", "Please bring the jalapeños separately."),
(6, "782668115", NOW(), 23, "D", null);

-- INSERT ORDER ITEMS
INSERT INTO `platzi_pizzeria`.`order_item` (`id_order`, `id_item`, `id_pizza`, `quantity`, `price`)
VALUES
(1, 1, 1, 1, 23.0),
(1, 2, 4, 1, 19.95),
(2, 1, 2, 1, 18.5),
(2, 2, 6, 1, 24.0),
(2, 3, 7, 1, 19.5),
(3, 1, 3, 1, 22.0),
(4, 1, 8, 2, 42.0),
(5, 1, 10, 0.5, 11.0),
(5, 2, 12, 0.5, 9.5),
(6, 1, 11, 1, 23);