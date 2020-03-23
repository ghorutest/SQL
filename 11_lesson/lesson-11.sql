-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
-- catalogs и products в таблицу logs помещается время и дата создания записи, название
-- таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE logs;
CREATE TABLE logs (
	create_time DATETIME DEFAULT NOW(),
	table_name char(40) NOT NULL,
	id_in_table BIGINT UNSIGNED NOT NULL,
	name_in_table char(40) NOT NULL
	) ENGINE=ARCHIVE;

-- 1. users
DROP TRIGGER IF EXISTS log_after_insert_users;
DELIMITER //

CREATE TRIGGER log_after_insert_users AFTER INSERT ON shop.users
FOR EACH ROW
begin
    INSERT INTO logs
	(table_name, id_in_table, name_in_table)
	VALUES
	('users', new.id, new.name);
END//

DELIMITER ;


-- INSERT INTO shop.users
-- (name, birthday_at, created_at, updated_at)
-- VALUES('Андрей', '1961-02-25', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);



-- 2. catalogs
DROP TRIGGER IF EXISTS log_after_insert_catalogs;
DELIMITER //

CREATE TRIGGER log_after_insert_catalogs AFTER INSERT ON shop.catalogs
FOR EACH ROW
begin
    INSERT INTO logs
	(table_name, id_in_table, name_in_table)
	VALUES
	('catalogs', new.id, new.name);
END//

DELIMITER ;

-- INSERT INTO shop.catalogs
-- (name)
-- VALUES('Периферия');


-- 3. products

DROP TRIGGER IF EXISTS log_after_insert_products;
DELIMITER //

CREATE TRIGGER log_after_insert_products AFTER INSERT ON shop.products
FOR EACH ROW
begin
    INSERT INTO logs
	(table_name, id_in_table, name_in_table)
	VALUES
	('products', new.id, new.name);
END//

DELIMITER ;

-- INSERT INTO shop.products
-- (name, description, price, catalog_id, created_at, updated_at)
-- VALUES('Test', 'Desc of test', 500, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


