/* 1. Составьте список пользователей users, которые осуществили
хотя бы один заказ orders в интернет магазине. */
 
-- добавление заказов 
INSERT INTO orders (user_id) VALUES (1), (2), (4);
INSERT INTO orders_products (order_id, product_id) VALUES
	(1, 1),
	(2, 3),
	(4, 5);
INSERT INTO orders_products (order_id, product_id, total) VALUES
	(5, 3, 4);
	

-- выборка пользователей выполнявших заказы

-- вложеным SELECT
SELECT name FROM users WHERE id IN (SELECT user_id FROM orders);


-- с помощью JOIN
SELECT
	name
FROM
	users AS u
JOIN
	orders AS o
ON
	u.id=o.user_id;



/* 2. Выведите список товаров products и разделов catalogs,
который соответствует товару. */

-- вложеным SELECT
SELECT
	name AS cat_name,
	(SELECT name FROM catalogs WHERE id=catalog_id) AS prod_name
FROM products;

-- с помощью JOIN
SELECT
	p.name AS cat_name,
	c.name AS prod_name
FROM
	products AS p
JOIN
	catalogs AS c
ON
	p.catalog_id=c.id;



/* 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label,
name). Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов. */

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(30),
  `to` VARCHAR(30)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(30),
  name VARCHAR(30)
);

INSERT INTO flights (`from`, `to`) VALUES
	('moscow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan');

INSERT INTO cities (label, name) VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');

-- вложеным SELECT
SELECT
	(SELECT name FROM cities WHERE label=`from`) AS `from`,
	(SELECT name FROM cities WHERE label=`to`) AS `to`
FROM flights;
