-- 2
-- Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
SELECT DISTINCT firstname FROM users ORDER BY firstname ASC;



-- 3
-- Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false)
ALTER TABLE profiles ADD active BIT NULL;  -- добавление возможности ативировать/деактивировать
UPDATE profiles set active = 1;  -- всех "активируем" изначально

SELECT birthday, active FROM profiles WHERE DATEDIFF(CURRENT_DATE(), birthday)/365 < 18;  -- выборка несовершеннолетних (их 38)

UPDATE profiles set active = 0 WHERE DATEDIFF(CURRENT_DATE(), birthday)/365 < 18;  -- "деактивируем" несовершеннолетних


-- проверка: выборка несовершеннолетних (теперь у всех active=0)
SELECT birthday, active FROM profiles WHERE DATEDIFF(CURRENT_DATE(), birthday)/365 < 18;


-- 4
-- Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)
DELETE FROM messages WHERE DATEDIFF(CURRENT_DATE(), created_at) < 0;

-- SELECT body, created_at FROM messages WHERE DATEDIFF(CURRENT_DATE(), created_at) < 1000;
