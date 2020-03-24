--В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
--INCR не проверяет существование ключа, если нет - создает. Самая простая конструкция "IP-счетчик"

127.0.0.1:6379> INCR 78.168.51.4
(integer) 1
127.0.0.1:6379> INCR 78.168.51.4
(integer) 2
127.0.0.1:6379> INCR 78.168.51.6
(integer) 1
127.0.0.1:6379> INCR 78.168.51.62
(integer) 1
127.0.0.1:6379> KEYS *
1) "78.168.51.4"
2) "78.168.51.6"
3) "65.89.15.35"
4) "78.168.51.62"
127.0.0.1:6379> get 78.168.51.6
"1"
127.0.0.1:6379> get 78.168.51.62
"1"
127.0.0.1:6379> get 65.89.15.35
"1"
127.0.0.1:6379> get 78.168.51.4
"2"
127.0.0.1:6379> INCR 78.168.51.4
(integer) 3
127.0.0.1:6379> INCR 78.168.51.4
(integer) 4
127.0.0.1:6379> INCR 78.168.51.4
(integer) 5
127.0.0.1:6379> get 78.168.51.4
"5"

--При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.
--Поиска по значению нет, следовательно для возможности поиска по значению создаются пары "имя-email" и "e-mail-имя" для каждого пользователя

127.0.0.1:6379> set username1 user1@mail.ru
OK
127.0.0.1:6379> set username2 user2@mail.ru
OK
127.0.0.1:6379> get username1
"user1@mail.ru"
127.0.0.1:6379> get username2
"user2@mail.ru"
127.0.0.1:6379> set user1@mail.ru username1
OK
127.0.0.1:6379> set user2@mail.ru username2
OK
127.0.0.1:6379> get user1@mail.ru
"username1"
127.0.0.1:6379> get user2@mail.ru
"username2"

--Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

db.shop.insert(
{
"products": [
	{
		"id" : 1,
		"name" : "Intel Core i3-8100",
		"description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
		"price" : 7890.00,
		"catalog_name" : "Процессоры",
		"created_at" : "2020-03-15 11:19:33",
		"updated_at" : "2020-03-15 11:19:33"
	},
	{
		"id" : 2,
		"name" : "Intel Core i5-7400",
		"description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
		"price" : 12700.00,
		"catalog_name" : "Процессоры",
		"created_at" : "2020-03-15 11:19:33",
		"updated_at" : "2020-03-15 11:19:33"
	},
	{
		"id" : 3,
		"name" : "AMD FX-8320E",
		"description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
		"price" : 4780.00,
		"catalog_name" : "Процессоры",
		"created_at" : "2020-03-15 11:19:33",
		"updated_at" : "2020-03-15 11:19:33"
	},
	{
		"id" : 4,
		"name" : "AMD FX-8320",
		"description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
		"price" : 7120.00,
		"catalog_name" : "Процессоры",
		"created_at" : "2020-03-15 11:19:33",
		"updated_at" : "2020-03-15 11:19:33"
	},
	{
		"id" : 5,
		"name" : "ASUS ROG MAXIMUS X HERO",
		"description" : "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX",
		"price" : 19310.00,
		"catalog_name" : "Материнские платы",
		"created_at" : "2020-03-15 11:19:33",
		"updated_at" : "2020-03-15 11:19:33"
	},
	{
		"id" : 6,
		"name" : "Gigabyte H310M S2H",
		"description" : "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX",
		"price" : 4790.00,
		"catalog_name" : "Материнские платы",
		"created_at" : "2020-03-15 11:19:33",
		"updated_at" : "2020-03-15 11:19:33"
	},
	{
		"id" : 7,
		"name" : "MSI B250M GAMING PRO",
		"description" : "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX",
		"price" : 5060.00,
		"catalog_name" : "Материнские платы",
		"created_at" : "2020-03-15 11:19:33",
		"updated_at" : "2020-03-15 11:19:33"
	}
]}
)

-- в CLI:
> use shop
switched to db shop
> db.shop.insert(
... {
... "products": [
... {
... "id" : 1,
... "name" : "Intel Core i3-8100",
... "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
... "price" : 7890.00,
... "catalog_name" : "Процессоры",
... "created_at" : "2020-03-15 11:19:33",
... "updated_at" : "2020-03-15 11:19:33"
... },
... {
... "id" : 2,
... "name" : "Intel Core i5-7400",
... "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
... "price" : 12700.00,
... "catalog_name" : "Процессоры",
... "created_at" : "2020-03-15 11:19:33",
... "updated_at" : "2020-03-15 11:19:33"
... },
... {
... "id" : 3,
... "name" : "AMD FX-8320E",
... "description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
... "price" : 4780.00,
... "catalog_name" : "Процессоры",
... "created_at" : "2020-03-15 11:19:33",
... "updated_at" : "2020-03-15 11:19:33"
... },
... {
... "id" : 4,
... "name" : "AMD FX-8320",
... "description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
... "price" : 7120.00,
... "catalog_name" : "Процессоры",
... "created_at" : "2020-03-15 11:19:33",
... "updated_at" : "2020-03-15 11:19:33"
... },
... {
... "id" : 5,
... "name" : "ASUS ROG MAXIMUS X HERO",
... "description" : "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX",
... "price" : 19310.00,
... "catalog_name" : "Материнские платы",
... "created_at" : "2020-03-15 11:19:33",
... "updated_at" : "2020-03-15 11:19:33"
... },
... {
... "id" : 6,
... "name" : "Gigabyte H310M S2H",
... "description" : "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX",
... "price" : 4790.00,
... "catalog_name" : "Материнские платы",
... "created_at" : "2020-03-15 11:19:33",
... "updated_at" : "2020-03-15 11:19:33"
... },
... {
... "id" : 7,
... "name" : "MSI B250M GAMING PRO",
... "description" : "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX",
... "price" : 5060.00,
... "catalog_name" : "Материнские платы",
... "created_at" : "2020-03-15 11:19:33",
... "updated_at" : "2020-03-15 11:19:33"
... }
... ]}
... )
WriteResult({ "nInserted" : 1 })
> db.shop.find()
{ "_id" : ObjectId("5e78c4c638965f82aa638145"), "products" : [ { "id" : 1, "name" : "Intel Core i3-8100", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.", "price" : 7890, "catalog_name" : "Процессоры", "created_at" : "2020-03-15 11:19:33", "updated_at" : "2020-03-15 11:19:33" }, { "id" : 2, "name" : "Intel Core i5-7400", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.", "price" : 12700, "catalog_name" : "Процессоры", "created_at" : "2020-03-15 11:19:33", "updated_at" : "2020-03-15 11:19:33" }, { "id" : 3, "name" : "AMD FX-8320E", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD.", "price" : 4780, "catalog_name" : "Процессоры", "created_at" : "2020-03-15 11:19:33", "updated_at" : "2020-03-15 11:19:33" }, { "id" : 4, "name" : "AMD FX-8320", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD.", "price" : 7120, "catalog_name" : "Процессоры", "created_at" : "2020-03-15 11:19:33", "updated_at" : "2020-03-15 11:19:33" }, { "id" : 5, "name" : "ASUS ROG MAXIMUS X HERO", "description" : "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX", "price" : 19310, "catalog_name" : "Материнские платы", "created_at" : "2020-03-15 11:19:33", "updated_at" : "2020-03-15 11:19:33" }, { "id" : 6, "name" : "Gigabyte H310M S2H", "description" : "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price" : 4790, "catalog_name" : "Материнские платы", "created_at" : "2020-03-15 11:19:33", "updated_at" : "2020-03-15 11:19:33" }, { "id" : 7, "name" : "MSI B250M GAMING PRO", "description" : "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX", "price" : 5060, "catalog_name" : "Материнские платы", "created_at" : "2020-03-15 11:19:33", "updated_at" : "2020-03-15 11:19:33" } ] }
