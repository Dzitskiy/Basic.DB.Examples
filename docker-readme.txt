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