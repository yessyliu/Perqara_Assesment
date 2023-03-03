-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema perqara
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema perqara
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `perqara` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `perqara` ;

-- -----------------------------------------------------
-- Table `perqara`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`state` (
  `state_id` INT NOT NULL AUTO_INCREMENT,
  `state_name` VARCHAR(30) NULL DEFAULT NULL,
  `CreateBy` VARCHAR(50) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `UpdateBy` VARCHAR(50) NULL DEFAULT NULL,
  `UpdateDate` DATETIME NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`state_id`),
  INDEX `idx_state_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(50) NULL DEFAULT NULL,
  `state_id` INT NULL DEFAULT NULL,
  `CreateBy` VARCHAR(50) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `UpdateBy` VARCHAR(50) NULL DEFAULT NULL,
  `UpdateDate` DATETIME NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `FK_city_state_id_idx` (`state_id` ASC) VISIBLE,
  INDEX `idx_city_etl_date_idx` (`etl_date` ASC) VISIBLE,
  CONSTRAINT `FK_city_state_id`
    FOREIGN KEY (`state_id`)
    REFERENCES `perqara`.`state` (`state_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8192
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`customer` (
  `customer_id` VARCHAR(50) NOT NULL,
  `customer_unique_id` VARCHAR(50) NOT NULL,
  `customer_zip_code_prefix` VARCHAR(10) NOT NULL,
  `customer_city` VARCHAR(50) NULL DEFAULT NULL,
  `customer_state` VARCHAR(10) NULL DEFAULT NULL,
  `CreateBy` VARCHAR(50) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `UpdateBy` VARCHAR(50) NULL DEFAULT NULL,
  `UpdateDate` DATETIME NULL DEFAULT NULL,
  `ID` BIGINT NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `idx_customer_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`orders` (
  `order_id` VARCHAR(50) NOT NULL,
  `customer_id` VARCHAR(50) NOT NULL,
  `order_status` VARCHAR(50) NULL DEFAULT NULL,
  `purchase_date` DATETIME NULL DEFAULT NULL,
  `approved_at_date` DATETIME NULL DEFAULT NULL,
  `delivered_carrier_date` DATETIME NULL DEFAULT NULL,
  `delivered_customer_date` DATETIME NULL DEFAULT NULL,
  `estimated_delivery_date` DATETIME NULL DEFAULT NULL,
  `create_by` VARCHAR(50) NULL DEFAULT NULL,
  `create_date` DATETIME NULL DEFAULT NULL,
  `update_by` VARCHAR(50) NULL DEFAULT NULL,
  `update_date` DATETIME NULL DEFAULT NULL,
  `ID` BIGINT NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`, `customer_id`),
  INDEX `idx_orders_etl_date_idx` (`etl_date` ASC) VISIBLE,
  INDEX `FK_orders_customer_id` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `FK_orders_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `perqara`.`customer` (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`product_category` (
  `product_category_id` INT NOT NULL AUTO_INCREMENT,
  `product_category_name` VARCHAR(150) NULL DEFAULT NULL,
  `product_category_name_english` VARCHAR(150) NULL DEFAULT NULL,
  `CreateBy` VARCHAR(50) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `UpdateBy` VARCHAR(50) NULL DEFAULT NULL,
  `UpdateDate` DATETIME NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`product_category_id`),
  INDEX `idx_product_category_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 131
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`product` (
  `product_id` VARCHAR(50) NOT NULL,
  `product_category_id` INT NULL DEFAULT NULL,
  `product_weight_gr` INT NULL DEFAULT NULL,
  `product_length_cm` INT NULL DEFAULT NULL,
  `product_height_cm` INT NULL DEFAULT NULL,
  `product_width_cm` INT NULL DEFAULT NULL,
  `CreateBy` VARCHAR(50) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `UpdateBy` VARCHAR(50) NULL DEFAULT NULL,
  `UpdateDate` DATETIME NULL DEFAULT NULL,
  `ID` BIGINT NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `product_category_id_idx` (`product_category_id` ASC) VISIBLE,
  INDEX `idx_product_etl_date_idx` (`etl_date` ASC) VISIBLE,
  CONSTRAINT `FK_product_category_id`
    FOREIGN KEY (`product_category_id`)
    REFERENCES `perqara`.`product_category` (`product_category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`seller` (
  `seller_id` VARCHAR(50) NOT NULL,
  `seller_zip_code_prefix` VARCHAR(50) NOT NULL,
  `seller_city` VARCHAR(50) NULL DEFAULT NULL,
  `seller_state` VARCHAR(10) NULL DEFAULT NULL,
  `CreateBy` VARCHAR(50) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `UpdateBy` VARCHAR(50) NULL DEFAULT NULL,
  `UpdateDate` DATETIME NULL DEFAULT NULL,
  `ID` BIGINT NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`seller_id`),
  INDEX `idx_seller_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`orders_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`orders_items` (
  `order_id` VARCHAR(50) NOT NULL,
  `seller_id` VARCHAR(50) NOT NULL,
  `product_id` VARCHAR(50) NOT NULL,
  `shipping_limit_date` DATETIME NULL DEFAULT NULL,
  `qty` BIGINT NULL DEFAULT NULL,
  `price` DECIMAL(18,2) NULL DEFAULT NULL,
  `freight_value` DECIMAL(18,2) NULL DEFAULT NULL,
  `create_by` VARCHAR(50) NULL DEFAULT NULL,
  `create_date` DATETIME NULL DEFAULT NULL,
  `update_by` VARCHAR(50) NULL DEFAULT NULL,
  `update_date` DATETIME NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`, `product_id`, `seller_id`),
  INDEX `idx_orders_items_etl_date_idx` (`etl_date` ASC) VISIBLE,
  INDEX `FK_orders_items_seller_id` (`seller_id` ASC) VISIBLE,
  INDEX `FK_orders_items_product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `FK_orders_items_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `perqara`.`orders` (`order_id`),
  CONSTRAINT `FK_orders_items_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `perqara`.`product` (`product_id`),
  CONSTRAINT `FK_orders_items_seller_id`
    FOREIGN KEY (`seller_id`)
    REFERENCES `perqara`.`seller` (`seller_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`payment_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`payment_type` (
  `payment_type_id` INT NOT NULL AUTO_INCREMENT,
  `payment_type_name` VARCHAR(30) NULL DEFAULT NULL,
  `CreateBy` VARCHAR(50) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `UpdateBy` VARCHAR(50) NULL DEFAULT NULL,
  `UpdateDate` DATETIME NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`payment_type_id`),
  INDEX `idx_payment_type_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`orders_payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`orders_payments` (
  `order_id` VARCHAR(50) NOT NULL,
  `payment_seq` INT NOT NULL,
  `payment_type_id` INT NOT NULL,
  `payment_installments` INT NULL DEFAULT NULL,
  `payment_value` DECIMAL(15,2) NULL DEFAULT NULL,
  `CreateBy` VARCHAR(50) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `UpdateBy` VARCHAR(50) NULL DEFAULT NULL,
  `UpdateDate` DATETIME NULL DEFAULT NULL,
  `ID` BIGINT NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`, `payment_seq`, `payment_type_id`),
  INDEX `idx_orders_payments_etl_date_idx` (`etl_date` ASC) VISIBLE,
  INDEX `FK_orders_payments_payment_type_id` (`payment_type_id` ASC) VISIBLE,
  CONSTRAINT `FK_orders_payments_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `perqara`.`orders` (`order_id`),
  CONSTRAINT `FK_orders_payments_payment_type_id`
    FOREIGN KEY (`payment_type_id`)
    REFERENCES `perqara`.`payment_type` (`payment_type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`orders_reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`orders_reviews` (
  `order_id` VARCHAR(50) NOT NULL,
  `review_id` VARCHAR(50) NOT NULL,
  `review_score` INT NOT NULL,
  `review_comment_title` VARCHAR(100) NULL DEFAULT NULL,
  `review_comment_message` VARCHAR(255) NULL DEFAULT NULL,
  `CreateBy` VARCHAR(50) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `UpdateBy` VARCHAR(50) NULL DEFAULT NULL,
  `UpdateDate` DATETIME NULL DEFAULT NULL,
  `ID` BIGINT NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`review_id`, `order_id`),
  INDEX `idx_orders_reviews_etl_date_idx` (`etl_date` ASC) VISIBLE,
  INDEX `FK_orders_reviews_order_id` (`order_id` ASC) VISIBLE,
  CONSTRAINT `FK_orders_reviews_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `perqara`.`orders` (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`postal_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`postal_code` (
  `postal_code` VARCHAR(10) NULL DEFAULT NULL,
  `city_id` INT NULL DEFAULT NULL,
  `state_id` INT NULL DEFAULT NULL,
  `CreateBy` VARCHAR(50) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `UpdateBy` VARCHAR(50) NULL DEFAULT NULL,
  `UpdateDate` DATETIME NULL DEFAULT NULL,
  `ID` BIGINT NULL DEFAULT NULL,
  `etl_date` DATETIME NULL DEFAULT NULL,
  INDEX `FK_postal_code_city_id_idx` (`city_id` ASC) VISIBLE,
  INDEX `FK_postal_code_state_id_idx` (`state_id` ASC) VISIBLE,
  INDEX `idx_postal_code_etl_date_idx` (`etl_date` ASC) VISIBLE,
  CONSTRAINT `FK_postal_code_city_id`
    FOREIGN KEY (`city_id`)
    REFERENCES `perqara`.`city` (`city_id`),
  CONSTRAINT `FK_postal_code_state_id`
    FOREIGN KEY (`state_id`)
    REFERENCES `perqara`.`state` (`state_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`stg_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`stg_customer` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `etl_date` DATETIME NULL DEFAULT NULL,
  `customer_id` VARCHAR(50) NULL DEFAULT NULL,
  `customer_unique_id` VARCHAR(50) NULL DEFAULT NULL,
  `customer_zip_code_prefix` VARCHAR(50) NULL DEFAULT NULL,
  `customer_city` VARCHAR(50) NULL DEFAULT NULL,
  `customer_state` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_stg_customer_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 99442
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`stg_geolocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`stg_geolocation` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `etl_date` DATETIME NULL DEFAULT NULL,
  `geolocation_zip_code_prefix` VARCHAR(10) NULL DEFAULT NULL,
  `geolocation_lat` FLOAT NULL DEFAULT NULL,
  `geolocation_lng` FLOAT NULL DEFAULT NULL,
  `geolocation_city` VARCHAR(50) NULL DEFAULT NULL,
  `geolocation_state` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_stg_geolocation_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1000164
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`stg_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`stg_orders` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `etl_date` DATETIME NULL DEFAULT NULL,
  `order_id` VARCHAR(50) NULL DEFAULT NULL,
  `customer_id` VARCHAR(50) NULL DEFAULT NULL,
  `order_status` VARCHAR(50) NULL DEFAULT NULL,
  `order_purchase_timestamp` DATETIME NULL DEFAULT NULL,
  `order_approved_at` DATETIME NULL DEFAULT NULL,
  `order_delivered_carrier_date` DATETIME NULL DEFAULT NULL,
  `order_delivered_customer_date` DATETIME NULL DEFAULT NULL,
  `order_estimated_delivery_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_stg_orders_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 99442
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`stg_orders_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`stg_orders_items` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `etl_date` DATETIME NULL DEFAULT NULL,
  `order_id` VARCHAR(50) NULL DEFAULT NULL,
  `order_item_id` INT NULL DEFAULT NULL,
  `product_id` VARCHAR(50) NULL DEFAULT NULL,
  `seller_id` VARCHAR(50) NULL DEFAULT NULL,
  `shipping_limit_date` DATETIME NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  `freight_value` DECIMAL(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_stg_orders_items_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 112651
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`stg_orders_payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`stg_orders_payments` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `etl_date` DATETIME NULL DEFAULT NULL,
  `order_id` VARCHAR(50) NULL DEFAULT NULL,
  `payment_sequential` INT NULL DEFAULT NULL,
  `payment_type` VARCHAR(20) NULL DEFAULT NULL,
  `payment_installments` INT NULL DEFAULT NULL,
  `payment_value` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_stg_orders_payments_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 103887
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`stg_orders_reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`stg_orders_reviews` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `etl_date` DATETIME NULL DEFAULT NULL,
  `review_id` VARCHAR(50) NULL DEFAULT NULL,
  `order_id` VARCHAR(50) NULL DEFAULT NULL,
  `review_score` INT NULL DEFAULT NULL,
  `review_comment_title` VARCHAR(100) NULL DEFAULT NULL,
  `review_comment_message` VARCHAR(255) NULL DEFAULT NULL,
  `review_creation_date` DATETIME NULL DEFAULT NULL,
  `review_answer_timestamp` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_stg_orders_reviews_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 99225
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`stg_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`stg_product` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `etl_date` DATETIME NULL DEFAULT NULL,
  `product_id` VARCHAR(50) NOT NULL,
  `product_category_name` VARCHAR(100) NULL DEFAULT NULL,
  `product_name_length` INT NULL DEFAULT NULL,
  `product_description_length` INT NULL DEFAULT NULL,
  `product_photos_qty` INT NULL DEFAULT NULL,
  `product_weight_g` INT NULL DEFAULT NULL,
  `product_length_cm` INT NULL DEFAULT NULL,
  `product_height_cm` INT NULL DEFAULT NULL,
  `product_width_cm` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_stg_product_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 32952
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`stg_product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`stg_product_category` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `etl_date` DATETIME NULL DEFAULT NULL,
  `product_category_name` VARCHAR(100) NULL DEFAULT NULL,
  `product_category_name_english` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_stg_product_category_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 72
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `perqara`.`stg_sellers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`stg_sellers` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `etl_date` DATETIME NULL DEFAULT NULL,
  `seller_id` VARCHAR(50) NOT NULL,
  `seller_zip_code_prefix` VARCHAR(50) NULL DEFAULT NULL,
  `seller_city` VARCHAR(50) NULL DEFAULT NULL,
  `seller_state` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_stg_sellers_etl_date_idx` (`etl_date` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3096
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `perqara` ;

-- -----------------------------------------------------
-- Placeholder table for view `perqara`.`vw_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perqara`.`vw_orders` (`order_id` INT, `purchase_date` INT, `customer_id` INT, `customer_city` INT, `customer_state` INT, `seller_id` INT, `product_id` INT, `product_category_name_english` INT, `qty` INT, `Payment_amount` INT, `review_score` INT);

-- -----------------------------------------------------
-- procedure sp_cleansing_city
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_city`()
BEGIN
	select @maxdate:=ifnull(max(etl_date),'1900-01-01') from city;
    
    update city as c
    inner join stg_geolocation as a on c.city_name=a.geolocation_city
    inner join state as b on a.geolocation_state=b.state_name
    set
		c.city_name=a.geolocation_city,
        c.state_id=b.state_id,
        c.UpdateBy='ETL_CLN',
        c.UpdateDate=now(),
        c.etl_date=a.etl_date
	where a.etl_date >= @maxdate;
    
	insert into city (city_name, state_id, CreateBy, CreateDate,etl_date)
    select distinct a.geolocation_city, b.state_id, 'ETL_CLN', now(), a.etl_date
    from stg_geolocation as a
    inner join state as b on a.geolocation_state=b.state_name
    left join city as c on a.geolocation_city=c.city_name
    where a.etl_date >= @maxdate
    and c.city_id is null;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_customer
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_customer`()
BEGIN
	select @maxid:=ifnull(max(id),0) from customer;
    
    update customer as a
    inner join stg_customer as b on a.customer_id=b.customer_id
    cross join (
		select max(ID) as ID, customer_id
        from stg_customer
        group by customer_id
    ) c on a.customer_id=c.customer_id
    set
		a.customer_unique_id=b.customer_unique_id, 
        a.customer_zip_code_prefix=b.customer_zip_code_prefix, 
        a.customer_city=b.customer_city, 
        a.customer_state=b.customer_state,
        a.UpdateBy='ETL_CLN',
        a.UpdateDate=now(),
        a.ID=c.ID,
        a.etl_date=b.etl_date
	where b.ID > @maxid;
    
    insert into customer (customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state, 
		CreateBy, CreateDate, etl_date, ID)
    select distinct a.customer_id, a.customer_unique_id, a.customer_zip_code_prefix, a.customer_city, a.customer_state, 
		'ETL_CLN', now(), a.etl_date, a.ID
    from stg_customer as a
    left join customer as b on a.customer_id=b.customer_id
    where b.customer_id is null
    and a.ID > @maxid;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_orders
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_orders`()
BEGIN
	select @maxid:=ifnull(max(id),0) from orders;
    
    update orders as a
    inner join stg_orders as b on a.order_id=b.order_id
    set
		a.customer_id=b.customer_id, 
        a.order_status=b.order_status, 
        a.purchase_date=b.order_purchase_timestamp,
        a.approved_at_date=b.order_approved_at,
        a.delivered_carrier_date=b.order_delivered_carrier_date,
        a.delivered_customer_date=b.order_delivered_customer_date,
        a.estimated_delivery_date=b.order_estimated_delivery_date,
        a.Update_By='ETL_CLN',
        a.Update_Date=now(),
        a.ID=b.ID,
        a.etl_date=b.etl_date
	where b.ID > @maxid;
    
    insert into orders (order_id, customer_id, order_status, purchase_date, approved_at_date, 
		delivered_carrier_date, delivered_customer_date, estimated_delivery_date, Create_By, Create_Date, ID, etl_date)
    select a.order_id, a.customer_id, a.order_status, a.order_purchase_timestamp, a.order_approved_at, 
		a.order_delivered_carrier_date, a.order_delivered_customer_date, a.order_estimated_delivery_date, 'ETL_CLN', now(), a.ID, a.etl_date
	from stg_orders as a
    left join orders as b on a.order_id=b.order_id
    where b.order_id is null
    and a.ID > @maxid;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_orders_items
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_orders_items`()
BEGIN
	select @maxdate:=ifnull(max(etl_date),'1900-01-01') from orders_items;
    
    update orders_items as a
    inner join stg_orders_items as b on a.order_id=b.order_id and a.seller_id=b.seller_id and a.product_id=b.product_id
    cross join (
		select count(*) as qty, order_id, seller_id, product_id
        from stg_orders_items
        group by order_id, seller_id, product_id
    ) c on a.order_id=c.order_id and a.seller_id=c.seller_id and a.product_id=c.product_id
    set
		a.shipping_limit_date=b.shipping_limit_date,
        a.qty=c.qty,
        a.price=b.price,
        a.freight_value=b.freight_value,
        a.Update_By='ETL_CLN',
        a.Update_Date=now(),
        a.etl_date=b.etl_date
	where b.etl_date >= @maxdate;
    
    insert into orders_items(order_id, seller_id, product_id, shipping_limit_date, qty, price, freight_value, 
		Create_By, Create_Date, etl_date)
    select a.order_id, a.seller_id, a.product_id, a.shipping_limit_date, count(*) as Qty, a.price, a.freight_value, 
		'ETL_CLN', now(), a.etl_date
	from stg_orders_items as a
    left join orders_items as b on a.order_id=b.order_id and a.seller_id=b.seller_id and a.product_id=b.product_id
    where a.etl_date >= @maxdate
    and b.order_id is null
    group by a.order_id, a.seller_id, a.product_id, a.shipping_limit_date, a.price, a.freight_value, a.etl_date;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_orders_payments
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_orders_payments`()
BEGIN
	select @maxid:=ifnull(max(id),0) from orders_payments;
    
    update orders_payments as a
    inner join stg_orders_payments as b on a.order_id=b.order_id
    inner join payment_type as c on b.payment_type=c.payment_type_name
    set
		a.payment_seq=b.payment_sequential, 
        a.payment_type_id=c.payment_type_id, 
        a.payment_installments=b.payment_installments,
        a.payment_value=b.payment_value,
        a.UpdateBy='ETL_CLN',
        a.UpdateDate=now(),
        a.ID=b.ID,
        a.etl_date=b.etl_date
	where b.ID > @maxid;
    
    insert into orders_payments (order_id, payment_seq, payment_type_id, payment_installments, payment_value, 
		CreateBy, CreateDate, ID, etl_date)
    select a.order_id, a.payment_sequential, b.payment_type_id, a.payment_installments, a.payment_value, 
		'ETL_CLN', now(), a.ID, a.etl_date
	from stg_orders_payments as a
    inner join payment_type as b on a.payment_type=b.payment_type_name
    left join orders_payments as c on a.order_id=c.order_id
    where a.ID > @maxid
    and c.order_id is null;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_orders_reviews
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_orders_reviews`()
BEGIN
	select @maxid:=ifnull(max(id),0) from orders_reviews;
    
    update orders_reviews as a
    inner join stg_orders_reviews as b on a.order_id=b.order_id and a.review_id=b.review_id
    cross join (
		select max(ID) as ID, order_id, review_id
        from stg_orders_reviews
        group by order_id, review_id
    ) c on a.order_id=c.order_id and a.review_id=c.review_id
    set
		a.review_score=b.review_score,
        a.review_comment_title=b.review_comment_title,
        a.review_comment_message=b.review_comment_message,
        a.UpdateBy='ETL_CLN',
        a.UpdateDate=now(),
        a.ID=c.ID,
        a.etl_date=b.etl_date
	where b.id > @maxid;
    
	insert into orders_reviews (order_id, review_id, review_score, review_comment_title, review_comment_message, 
		CreateBy, CreateDate, ID, etl_date)
    select a.order_id, a.review_id, a.review_score, a.review_comment_title, a.review_comment_message, 
		'ETL_CLN', now(), a.ID, a.etl_date
	from stg_orders_reviews as a
	left join orders_reviews as b on a.order_id=b.order_id and a.review_id=b.review_id
    where b.review_id is null
    and a.id > @maxid;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_payment_type
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_payment_type`()
BEGIN
	select @maxid:=ifnull(max(id),0) from orders_payments;
    
    insert into payment_type (payment_type_name, CreateBy, CreateDate, etl_date)
    select distinct a.payment_type, 'ETL_CLN', now(), a.etl_date
    from stg_orders_payments as a
    left join payment_type as b on a.payment_type=b.payment_type_name
    where a.ID > @maxid
    and b.payment_type_id is null;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_postal_code
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_postal_code`()
BEGIN
	select @maxdate:=ifnull(max(etl_date),'1900-01-01') from postal_code;
    
    update postal_code as d
    inner join stg_geolocation as a on a.geolocation_zip_code_prefix=d.postal_code
    inner join state as b on a.geolocation_state=b.state_name and d.state_id=b.state_id 
    inner join city as c on b.state_id=c.state_id and a.geolocation_city=c.city_name and d.city_id=c.city_id
    cross join (
		select max(a.ID) as ID, a.geolocation_zip_code_prefix, a.geolocation_state, a.geolocation_city
        from stg_geolocation a
        group by a.geolocation_zip_code_prefix, a.geolocation_state, a.geolocation_city
    ) e on d.postal_code=e.geolocation_zip_code_prefix
    set
		d.city_id=c.city_id, 
        d.state_id=b.state_id,
        d.UpdateBy='ETL_CLN',
        d.UpdateDate=now(),
        d.ID=e.ID,
        d.etl_date=a.etl_date
	where a.etl_date >= @maxdate;
    
    insert into postal_code (postal_code, city_id, state_id, CreateBy, CreateDate, etl_date, ID)
    select distinct a.geolocation_zip_code_prefix, c.city_id, b.state_id, 'ETL_CLN', now(), a.etl_date, max(a.id)
    from stg_geolocation as a
    left join postal_code as d on a.geolocation_zip_code_prefix=d.postal_code
    inner join state as b on a.geolocation_state=b.state_name
    inner join city as c on b.state_id=c.state_id and a.geolocation_city=c.city_name
    where a.etl_date >= @maxdate
    and d.postal_code is null
    group by a.geolocation_zip_code_prefix, c.city_id, b.state_id, a.etl_date;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_product
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_product`()
BEGIN
	select @maxid:=ifnull(max(id),0) from product;
    
    update product as a
    inner join stg_product as b on a.product_id=b.product_id
    inner join product_category as c on b.product_category_name=c.product_category_name
    set
		a.product_category_id=c.product_category_id, 
        a.product_weight_gr=b.product_weight_g, 
        a.product_length_cm=b.product_length_cm,
        a.product_height_cm=b.product_height_cm,
        a.product_width_cm=b.product_width_cm,
        a.UpdateBy='ETL_CLN',
        a.UpdateDate=now(),
        a.ID=b.ID
	where b.ID > @maxid;
    
    /*insert product_category that not defined in product category csv*/
    insert into product_category (product_category_name, product_category_name_english, CreateBy, CreateDate, etl_date)
	select distinct a.product_category_name, a.product_category_name, 'ETL_CLN', now(), a.etl_date
	from stg_product as a
	left outer join stg_product_category as b on a.product_category_name=b.product_category_name
	where b.product_category_name is null
    and a.id >= @maxid;
    
    /*insert from product csv*/
    insert into product(product_id, product_category_id, product_weight_gr, product_length_cm, 
		product_height_cm, product_width_cm, CreateBy, CreateDate, ID, etl_date)
    select a.product_id, b.product_category_id, a.product_weight_g, a.product_length_cm, 
		a.product_height_cm, a.product_width_cm, 'ETL_CLN', now(), a.ID, a.etl_date
	from stg_product as a
    inner join product_category as b on a.product_category_name=b.product_category_name
    left join product as c on a.product_id=c.product_id
    where a.id >= @maxid
    and c.product_id is null;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_product_category
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_product_category`()
BEGIN
	select @maxdate:=ifnull(max(etl_date),'1900-01-01') from product_category;
    
    update product_category as a
    inner join stg_product_category as b on a.product_category_name=b.product_category_name
    set
		a.product_category_name_english=b.product_category_name_english,
        a.UpdateBy='ETL_CLN',
        a.UpdateDate=now(),
        a.etl_date=b.etl_date
	where b.etl_date >= @maxdate;
    
    insert into product_category (product_category_name, product_category_name_english, CreateBy, CreateDate, etl_date)
    select distinct a.product_category_name, a.product_category_name_english, 'ETL_CLN', now(), a.etl_date
    from stg_product_category as a
    left join product_category as b on a.product_category_name=b.product_category_name
    where a.etl_date >= @maxdate
    and b.product_category_id is null;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_seller
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_seller`()
BEGIN
	select @maxid:=ifnull(max(id),0) from seller;
    
    update seller as a
    inner join stg_sellers as b on a.seller_id=b.seller_id
    cross join (
		select max(ID) as ID, seller_id
        from stg_sellers
        group by seller_id
    ) c on a.seller_id=c.seller_id
    set
		a.seller_zip_code_prefix=b.seller_zip_code_prefix, 
        a.seller_city=b.seller_city, 
        a.seller_state=b.seller_state,
        a.UpdateBy='ETL_CLN',
        a.UpdateDate=now(),
        a.ID=c.ID,
        a.etl_date=b.etl_date
	where b.ID > @maxid;
    
    insert into seller (seller_id, seller_zip_code_prefix, seller_city, seller_state, CreateBy, CreateDate, etl_date, ID)
    select distinct a.seller_id, a.seller_zip_code_prefix, a.seller_city, a.seller_state, 'ETL_CLN', now(), a.etl_date, max(a.ID) as ID
    from stg_sellers as a
    left join seller as b on a.seller_id=b.seller_id
    where b.seller_id is null
    and a.ID > @maxid
    group by a.seller_id, a.seller_zip_code_prefix, a.seller_city, a.seller_state, a.etl_date;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_state
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_state`()
BEGIN
	select @maxdate:=ifnull(max(etl_date),'1900-01-01') from state;
    
    update state as a
    inner join stg_geolocation as b on RTRIM(LTRIM(b.geolocation_state))=RTRIM(LTRIM(a.state_name))
    set
		a.state_name=RTRIM(LTRIM(b.geolocation_state)),
        a.UpdateBy='ETL_CLN',
        a.UpdateDate=now(),
        a.etl_date=b.etl_date
	where a.etl_date >= @maxdate;
    
    insert into state (state_name, CreateBy, CreateDate, etl_date)
    select distinct RTRIM(LTRIM(a.geolocation_state)) as geolocation_state, 'ETL_CLN', now(), a.etl_date
    from stg_geolocation as a
    left join state as b on RTRIM(LTRIM(a.geolocation_state))=RTRIM(LTRIM(b.state_name))
    where a.etl_date >= @maxdate
    and b.state_id is null;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cleansing_table
-- -----------------------------------------------------

DELIMITER $$
USE `perqara`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cleansing_table`()
BEGIN
	CALL sp_cleansing_state;
    CALL sp_cleansing_city;
    CALL sp_cleansing_postal_code;
    CALL sp_cleansing_customer;
    CALL sp_cleansing_seller;
    CALL sp_cleansing_product_category;
    CALL sp_cleansing_product;
    CALL sp_cleansing_payment_type;
    CALL sp_cleansing_orders;
    CALL sp_cleansing_orders_payments;
    CALL sp_cleansing_orders_items;
    CALL sp_cleansing_orders_reviews;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `perqara`.`vw_orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `perqara`.`vw_orders`;
USE `perqara`;
CREATE  OR REPLACE VIEW vw_orders AS
select
	a.order_id
    ,a.purchase_date
    ,a.customer_id
    ,d.customer_city
    ,d.customer_state
    ,b.seller_id
    ,b.product_id
    ,f.product_category_name_english
    ,b.qty
    ,c.Payment_amount
    ,g.review_score
from orders as a
inner join orders_items as b on a.order_id=b.order_id
inner join (
	select order_id, sum(payment_value) as Payment_amount 
    from orders_payments
    group by order_id
) c on a.order_id=c.order_id
inner join customer as d on a.customer_id=d.customer_id
inner join product as e on b.product_id=e.product_id
inner join product_category as f on e.product_category_id=f.product_category_id
inner join (
	select order_id, max(review_score) as review_score from orders_reviews group by order_id
) g on a.order_id=g.order_id;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
