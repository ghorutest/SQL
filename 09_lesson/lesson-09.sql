-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте
-- транзакции

-- ДО:
SELECT * FROM shop.users;

-- id|name     |birthday_at|created_at         |updated_at         |
-- --|---------|-----------|-------------------|-------------------|
--  1|Геннадий | 1990-10-05|2020-03-15 11:19:33|2020-03-15 11:19:33|
--  2|Наталья  | 1984-11-12|2020-03-15 11:19:33|2020-03-15 11:19:33|
--  3|Александр| 1985-05-20|2020-03-15 11:19:33|2020-03-15 11:19:33|
--  4|Сергей   | 1988-02-14|2020-03-15 11:19:33|2020-03-15 11:19:33|
--  5|Иван     | 1998-01-12|2020-03-15 11:19:33|2020-03-15 11:19:33|
--  6|Мария    | 1992-08-29|2020-03-15 11:19:33|2020-03-15 11:19:33|

SELECT * FROM sample.users;

-- id|name|birthday_at|created_at|updated_at|
-- --|----|-----------|----------|----------|


-- ПЕРЕМЕЩЕНИЕ:
START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id=1;
COMMIT;


-- ПОСЛЕ:
SELECT * FROM shop.users;

-- id|name     |birthday_at|created_at         |updated_at         |
-- --|---------|-----------|-------------------|-------------------|
--  2|Наталья  | 1984-11-12|2020-03-15 11:19:33|2020-03-15 11:19:33|
--  3|Александр| 1985-05-20|2020-03-15 11:19:33|2020-03-15 11:19:33|
--  4|Сергей   | 1988-02-14|2020-03-15 11:19:33|2020-03-15 11:19:33|
--  5|Иван     | 1998-01-12|2020-03-15 11:19:33|2020-03-15 11:19:33|
--  6|Мария    | 1992-08-29|2020-03-15 11:19:33|2020-03-15 11:19:33|
 
SELECT * FROM shop.users;

-- id|name    |birthday_at|created_at         |updated_at         |
-- --|--------|-----------|-------------------|-------------------|
--  1|Геннадий| 1990-10-05|2020-03-15 11:19:33|2020-03-15 11:19:33|


-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы
-- products и соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW cat AS SELECT
	products.name AS prod_name,
	catalogs.name AS cat_name
FROM products, catalogs
WHERE
	products.id=catalogs.id;

SELECT * FROM cat;


-- Администрирование MySQL
/* 1. Создайте двух пользователей которые имеют доступ к базе данных shop.
 Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
 второму пользователю shop — любые операции в пределах базы данных shop. */

CREATE USER 'shop_read'@'localhost' IDENTIFIED BY 'shop_read';
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';
SHOW GRANTS FOR 'shop_read'@'localhost';


CREATE USER 'shop'@'localhost' IDENTIFIED BY 'shop';
GRANT ALL PRIVILEGES ON shop.* TO 'shop'@'localhost';
SHOW GRANTS FOR 'shop'@'localhost'

/* 2. Пусть имеется таблица accounts содержащая три столбца id, name, password,
 * содержащие первичный ключ, имя пользователя и его пароль. Создайте представление username
 * таблицы accounts, предоставляющий доступ к столбца id и name. Создайте пользователя user_read,
 * который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления
 * username. */

DROP TABLE accounts;
CREATE TABLE accounts (
	id bigint,
	name varchar(40),
	`password` varchar(40)
);

INSERT INTO accounts VALUES
	(1, 'alex', 'passs'),
	(2, 'dima', '1234');

-- Создайте представление username...
CREATE OR REPLACE VIEW username AS SELECT
	id,
	name
FROM accounts;

-- Создайте пользователя user_read...
CREATE USER 'users_read'@'localhost' IDENTIFIED BY 'users_read';
GRANT SELECT ON shop.username TO 'users_read'@'localhost';
SHOW GRANTS FOR 'users_read'@'localhost';






