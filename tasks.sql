Задача 1: Хранимая процедура
Цель: Создать процедуру для добавления нового клиента.
Задача:
Напишите хранимую процедуру add_client(name VARCHAR, email VARCHAR), которая:

Вставляет данные в таблицу clients (поля: id SERIAL, name, email).

Проверяет уникальность email. При дубликате генерирует ошибку: Email already exists.
Структура таблицы:

sql
CREATE TABLE clients (id SERIAL PRIMARY KEY, name VARCHAR(100), email VARCHAR(100) UNIQUE);

------------------------------------------------------------

Задача 2: Функция с условием
Цель: Использовать функцию для расчёта скидки.
Задача:
Создайте функцию calculate_discount(total_amount NUMERIC) RETURNS NUMERIC, которая:

Возвращает total_amount * 0.9 при сумме заказа > 1000.

Возвращает исходную сумму в остальных случаях.
Применение:

sql
SELECT id, calculate_discount(total) FROM orders;

------------------------------------------------------------

Задача 3: Триггер для аудита
Цель: Автоматизировать логирование изменений.
Задача:
Создайте триггер log_order_changes, который:

При обновлении статуса в orders записывает старые и новые значения в таблицу order_audit (поля: order_id, old_status, new_status, change_time).
Структура order_audit:

sql
CREATE TABLE order_audit (id SERIAL, order_id INT, old_status VARCHAR, new_status VARCHAR, change_time TIMESTAMP);

------------------------------------------------------------

Задача 4: Кастомный тип данных
Цель: Реализовать сложную структуру данных.
Задача:

Создайте составной тип address_type (поля: city VARCHAR, street VARCHAR, house INT).

Используйте тип в таблице branches:

sql
CREATE TABLE branches (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(100), 
    address address_type
);
Вставьте данные: ('Main Branch', ('Moscow', 'Arbat', 25)).

------------------------------------------------------------

Задача 5: Временная таблица в процедуре
Цель: Обработать данные сессии.
Задача:
Напишите процедуру generate_monthly_report(month DATE), которая:

Создает временную таблицу temp_sales (поля: product_id INT, total_sold NUMERIC).

Заполняет её суммарными продажами товаров за указанный месяц из order_items.

Возвращает данные из temp_sales.

------------------------------------------------------------

Задача 6: Представление с JOIN
Цель: Упростить частый запрос.
Задача:
Создайте представление client_orders_view, которое выводит:

Имя клиента (clients.name),

Количество заказов (из orders),

Общую сумму покупок (из orders.total).
Запрос в представлении:

sql
SELECT c.name, COUNT(o.id), SUM(o.total) 
FROM clients c 
LEFT JOIN orders o ON c.id = o.client_id 
GROUP BY c.id;

------------------------------------------------------------

Задача 7: Материализованное представление
Цель: Оптимизировать тяжёлые агрегации.
Задача:

Создайте материализованное представление monthly_sales_mv, которое кэширует:

Месяц (дата без дня),

Сумму продаж (SUM(total) из orders).

Напишите запрос для его обновления (REFRESH MATERIALIZED VIEW monthly_sales_mv).

------------------------------------------------------------

Задача 8: Процедура с транзакцией
Цель: Обеспечить атомарность операций.
Задача:
Создайте процедуру transfer_funds(from_account INT, to_account INT, amount NUMERIC), которая:

Начинает транзакцию.

Выполняет два UPDATE: списание с from_account и зачисление на to_account в таблице accounts.

Фиксирует изменения только если оба UPDATE успешны. Иначе откатывает транзакцию.

------------------------------------------------------------

Задача 9: Функция, возвращающая таблицу
Цель: Вернуть набор строк.
Задача:
Напишите функцию get_clients_by_city(city_name VARCHAR) RETURNS TABLE (id INT, name VARCHAR):

Возвращает клиентов из clients, у которых адрес (address_type) содержит заданный город.
Пример вызова:

sql
SELECT * FROM get_clients_by_city('Moscow');

------------------------------------------------------------

Задача 10: Триггер на кастомный тип
Цель: Валидация данных в составном типе.
Задача:
Создайте триггер validate_address перед вставкой/обновлением в branches:

Проверяет, что в address_type поле city не пустое и house > 0.

При нарушении генерирует ошибку: Invalid address data.