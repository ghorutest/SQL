/* 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными.
 * Заполните их текущими датой и временем.
 * (используется таблица из задания https://github.com/ghorutest/SQL/blob/master/04_lesson/1.sql) */

ALTER TABLE users ADD
	created_at TIMESTAMP
	AFTER phone;

ALTER TABLE users ADD
	updated_at TIMESTAMP
	AFTER created_at;

UPDATE users SET created_at=NOW() WHERE created_at IS NULL;
UPDATE users SET updated_at=NOW() WHERE updated_at IS NULL;




/* 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR
 * и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля
 * к типу DATETIME, сохранив введеные ранее значения.*/

-- сначала "портим" столбцы 1-го задания

ALTER TABLE users MODIFY created_at varchar(20);
ALTER TABLE users MODIFY updated_at varchar(20);

UPDATE users SET created_at='20.10.2017 18:10';
UPDATE users SET updated_at='20.10.2017 18:10';

-- теперь исправляем согласно заданию: сначала применяем формат TIMESTAMP к содержимому

UPDATE users SET created_at=STR_TO_DATE(created_at, '%d.%m.%Y %H:%i') WHERE created_at IS NOT NULL;
UPDATE users SET updated_at=STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i') WHERE updated_at IS NOT NULL;

-- затем меняем тип данных

ALTER TABLE users MODIFY created_at TIMESTAMP;
ALTER TABLE users MODIFY updated_at TIMESTAMP;



/* 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
 * 0, если товар закончился и выше нуля, если на складе имеются запасы.
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
 * Однако, нулевые запасы должны выводиться в конце, после всех записей. */

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	value INT NOT NULL,
	product_type varchar(20) NOT NULL,
	product_name varchar(50) NOT NULL
);

INSERT INTO storehouses_products (value, product_type, product_name) VALUES
	(1, 'Процессор Intel', 'Intel Core i3-8100'),
	(0, 'Процессор Intel', 'Intel Core i5-7400'),
	(3, 'Процессор AMD', 'AMD FX-8320E'),
	(0, 'Процессор AMD', 'AMD FX-8320'),
	(2, 'Процессор Intel', 'Intel Xeon L5530'),
	(4, 'Процессор Intel', 'Intel Core i3 2100T'),
	(0, 'Процессор Intel', 'Intel Core i5 2500K');

SELECT * FROM storehouses_products ORDER BY value=0, value;

/*4. Подсчитайте средний возраст пользователей в таблице users
(используется таблица profiles из задания https://github.com/ghorutest/SQL/blob/master/04_lesson/1.sql) */

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())), 2) FROM profiles;


/* Вывод:

ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())), 2)|
---------------------------------------------------|
                                              24.66|
*/




/* 5. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения. */

-- SELECT birthday FROM profiles;


SELECT
	COUNT(*) AS total,
	WEEKDAY(CONCAT(YEAR(CURDATE()), '-', SUBSTRING(birthday, 6, 9))) AS week_day
FROM profiles GROUP BY week_day;



