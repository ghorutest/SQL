-- 1. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT
	COUNT(*) AS messages_count,
	(SELECT CONCAT(firstname, ' ', lastname) FROM users WHERE id=from_user_id) AS username,
	to_user_id
FROM messages WHERE
	to_user_id=2 AND
	(SELECT status FROM friend_requests WHERE initiator_user_id=to_user_id AND target_user_id=from_user_id)='approved'
GROUP BY username ORDER BY messages_count DESC LIMIT 1;

-- Вывод:
-- messages_count|username      |to_user_id|
-- --------------|--------------|----------|
--              2|Marcelina Metz|         2|




-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет

-- базовый запрос
-- SELECT
-- 	COUNT(*) AS likes_count,
-- 	media_id,
-- 	(SELECT user_id FROM media WHERE id=media_id) AS media_id_owner,
-- 	(SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE user_id=media_id_owner AND TIMESTAMPDIFF(YEAR, birthday, NOW())<10) AS owner_age
-- FROM likes GROUP BY media_id ORDER BY likes_count DESC;


-- подзапрос по возрасту
SELECT COUNT(*) FROM (
SELECT
	COUNT(*) AS likes_count,
	media_id,
	(SELECT user_id FROM media WHERE id=media_id) AS media_id_owner,
	(SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE user_id=media_id_owner AND TIMESTAMPDIFF(YEAR, birthday, NOW())<10) AS owner_age
FROM likes GROUP BY media_id ORDER BY likes_count DESC
) AS tab WHERE owner_age<10;

-- Вывод:
-- COUNT(*)|
-- --------|
--       19|


-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
-- Решение работает, но мне не нравится


SELECT
	(SELECT COUNT(*) FROM profiles WHERE user_id=user_id AND gender='M') AS male
FROM likes LIMIT 1;

-- Вывод:
-- gender|
-- ------|
--     46|


SELECT
	(SELECT COUNT(*) FROM profiles WHERE user_id=user_id AND gender='F') AS female
FROM likes LIMIT 1;
-- Вывод:
-- gender|
-- ------|
--     54|

