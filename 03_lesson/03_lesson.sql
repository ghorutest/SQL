/* Задача 03
Написать крипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)
*/

DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

-- создание таблиц

-- закладки
DROP TABLE IF EXISTS bookmarks;
CREATE TABLE bookmarks(
	PRIMARY KEY (user_id, media_id),			-- пара юзер-закладка уникальна
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),			-- для сортировки при выводе

    INDEX (user_id),							-- запросы будут частыми, должны работать быстро
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id)

);

-- уведомления
DROP TABLE IF EXISTS notofications;
CREATE TABLE notofications (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    readed TINYINT(1) NOT NULL,					-- прочитано?
    media_id BIGINT UNSIGNED NULL,				-- возможность ссылаться на медиа, но не обязательно

    /* на медиа FK не делаем (оно не обязательно), но нужен будет триггер для удаления уведомлений, 
     * ссылающихся на уже удалённое медиа */
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- комментарии
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,			-- кто комментирует
    media_id BIGINT UNSIGNED NOT NULL,			-- под каким медиа расположен
    comm_id BIGINT UNSIGNED NULL,				-- если комментируем комментарий

    body TEXT,
    created_at DATETIME DEFAULT NOW(),

	INDEX (media_id),							-- запросы будут при каждом просмотре медиа в ленте
    /* если медиа удалят, то с комментариями
     * при этом удаление ползователей не должно отражаться на дереве обсуждения (потеряется нить обсуждения)
     * 
     * для удалённых пользователей в поле "Автор" нужно использовать заглушку "Удалённый пользователь"
     * 
     * для удаления комментариев, зависимых от дргих комментариев впоследствии нужен триггер  */
    FOREIGN KEY (media_id) REFERENCES media(id)
);
