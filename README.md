1. Развернуть окружение в Docker
- Установить docker desktop для Win / Установить docker для Linux/macOS
- Перейти в директорию Basic.DB
- Выполнить команду docker compose up -d

2. Настроить pgAdmin 
- Открыть в браузере http://localhost:16543/browser/
- Добавить новое подключение с сервером БД (хост postgres, логин/пароль postgres)

3. Создать и восстановить БД
- Выбрать созданное подключение\Databases и создать новую бд (Create\Database), настройки по умолчанию
- Выбрать созданную БД и в контекстном меню выбрать Restore
- Указать файл с бэкапом dvdrental.tar


Инсталятор БД: https://www.postgresql.org/download/windows/ 

pgadmin: https://www.pgadmin.org/download/pgadmin-4-windows/ 

БД для восстановления: https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/ 

Как восстанавливать БД

https://www.postgresqltutorial.com/postgresql-getting-started/load-postgresql-sample-database/ 


Доп.материалы:

https://tproger.ru/translations/sql-recap/ 
https://habr.com/ru/post/564390/ 
https://www.w3schools.com/sql/sql_syntax.asp 
https://proglib.io/p/sql-cheat-sheet 

https://sql-academy.org/ru/trainer
