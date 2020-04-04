-- ======================================== ЗАПРОСЫ ДАННЫХ ========================================
-- представление efficiency - для контроля текущего рабочего дня, без финансовых данных
SELECT * FROM efficiency;

-- Журнал - все события за день - Исполнитель, бонус за действие, действие, сложность
SELECT * FROM today_log;

-- Журнал - все события для контроля "подделки" сравнительно таблицы actions_history
SELECT * FROM logs;

-- ================ ЗАПРОСЫ ПО ДОСТАВКАМ ================

-- Журнал - все доставки за день
SELECT
	(SELECT CONCAT(name, ' ', surname, ' ', patronymic) FROM employees WHERE emp_id=actions_history.emp_id) AS fio,
	(SELECT `action` FROM actions WHERE id=type_id) AS `action`,
	`condition`,
	quantity,
	created_at
FROM production_estimate.actions_history
WHERE type_id>4 AND created_at LIKE '2020-03-07%'
ORDER BY `action`;

-- Отчет - Исполнители и количество пеших доставок, средняя сложность
SELECT
	(SELECT CONCAT(name, ' ', surname, ' ', patronymic) FROM employees WHERE emp_id=actions_history.emp_id) AS fio,
	COUNT(type_id) AS `count`,
	ROUND(AVG(`condition`), 2) AS avg_condition
FROM actions_history
WHERE type_id=5
GROUP BY FIO
ORDER BY `count` DESC;

-- Отчет - Исполнители и количество доставок на легковом а/м, средняя сложность
SELECT
	(SELECT CONCAT(name, ' ', surname, ' ', patronymic) FROM production_estimate.employees WHERE emp_id=actions_history.emp_id) AS fio,
	COUNT(type_id) AS `count`,
	ROUND(AVG(`condition`), 2) AS avg_condition
FROM production_estimate.actions_history
WHERE type_id=6
GROUP BY FIO
ORDER BY `count` DESC;

-- Отчет - Исполнители и количество доставок на грузовом а/м, средняя сложность
SELECT
	(SELECT CONCAT(name, ' ', surname, ' ', patronymic) FROM production_estimate.employees WHERE emp_id=actions_history.emp_id) AS fio,
	COUNT(type_id) AS `count`,
	ROUND(AVG(`condition`), 2) AS avg_condition
FROM production_estimate.actions_history
WHERE type_id=7
GROUP BY FIO
ORDER BY `count` DESC;

-- Бонусы за ДЕНЬ - Исполнитель, дневной бонус, количество доставок, средняя сложность
-- Данная выборка позволяет судить о количестве выполненной работы
SELECT
	(SELECT CONCAT(surname, ' ', name, ' ', patronymic) FROM employees WHERE emp_id=actions_history.emp_id) AS fio,
	SUM((SELECT salary FROM employees WHERE emp_id=actions_history.emp_id)*`condition`*0.001) AS daily_bonus,
	COUNT(id) AS `actions`,
	ROUND(AVG(`condition`), 2) AS avg_condition
FROM production_estimate.actions_history
WHERE type_id>4 AND created_at LIKE '2020-03-07%'
GROUP BY fio
ORDER BY actions DESC;

-- Бонусы за НЕДЕЛЮ - Исполнитель, дневной бонус, количество доставок, средняя сложность
-- Данная выборка позволяет судить о количестве выполненной работы
SELECT
	(SELECT CONCAT(surname, ' ', name, ' ', patronymic) FROM employees WHERE emp_id=actions_history.emp_id) AS fio,
	SUM((SELECT salary FROM employees WHERE emp_id=actions_history.emp_id)*`condition`*0.001) AS weekly_bonus,
	COUNT(id) AS `actions`,
	ROUND(AVG(`condition`), 2) AS avg_condition
FROM production_estimate.actions_history
WHERE type_id>4 AND created_at BETWEEN '2020-03-01' AND '2020-03-07'
GROUP BY fio
ORDER BY actions DESC;

-- Бонусы за НЕДЕЛЮ - копия расположенного выше запроса, но с таблицы logs - контроль "подделки"
-- Данная выборка позволяет судить о количестве выполненной работы
SELECT
	(SELECT CONCAT(surname, ' ', name, ' ', patronymic) FROM employees WHERE emp_id=logs.emp_id) AS fio,
	SUM((SELECT salary FROM employees WHERE emp_id=logs.emp_id)*`condition`*0.001) AS weekly_bonus,
	COUNT(`condition`) AS `actions`,
	ROUND(AVG(`condition`), 2) AS avg_condition
FROM production_estimate.logs
WHERE type_id>4 AND created_at BETWEEN '2020-03-01' AND '2020-03-07'
GROUP BY fio
ORDER BY actions DESC;

-- ================ ЗАПРОСЫ ПО ЗВОНКАМ ================

-- Бонусы за ДЕНЬ - Исполнитель, дневной бонус, количество звонков
-- Данная выборка позволяет судить о количестве выполненной работы
SELECT
	(SELECT CONCAT(surname, ' ', name, ' ', patronymic) FROM employees WHERE emp_id=actions_history.emp_id) AS fio,
	SUM((SELECT salary FROM employees WHERE emp_id=actions_history.emp_id)*`condition`*0.001) AS daily_bonus,
	COUNT(id) AS `actions`
FROM production_estimate.actions_history
WHERE type_id<5 AND created_at LIKE '2020-03-07%'
GROUP BY fio
ORDER BY actions DESC;

-- Бонусы за НЕДЕЛЮ - Исполнитель, дневной бонус, количество звонков
-- Данная выборка позволяет судить о количестве выполненной работы
SELECT
	(SELECT CONCAT(surname, ' ', name, ' ', patronymic) FROM employees WHERE emp_id=actions_history.emp_id) AS fio,
	SUM((SELECT salary FROM employees WHERE emp_id=actions_history.emp_id)*`condition`*0.001) AS weekly_bonus,
	COUNT(id) AS `actions`
FROM production_estimate.actions_history
WHERE type_id<5 AND created_at BETWEEN '2020-03-01' AND '2020-03-07'
GROUP BY fio
ORDER BY actions DESC;

-- Бонусы за НЕДЕЛЮ - копия расположенного выше запроса, но с таблицы logs - контроль "подделки"
-- Данная выборка позволяет судить о количестве выполненной работы
SELECT
	(SELECT CONCAT(surname, ' ', name, ' ', patronymic) FROM employees WHERE emp_id=logs.emp_id) AS fio,
	SUM((SELECT salary FROM employees WHERE emp_id=logs.emp_id)*`condition`*0.001) AS weekly_bonus,
	COUNT(`condition`) AS `actions`
FROM production_estimate.logs
WHERE type_id<5 AND created_at BETWEEN '2020-03-01' AND '2020-03-07'
GROUP BY fio
ORDER BY actions DESC;
