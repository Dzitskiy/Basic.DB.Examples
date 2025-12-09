1. Простые запросы
Задача: Вывести всех актеров, чье имя начинается на "Penelope"

sql
SELECT * FROM actor WHERE first_name LIKE 'Penelope%';
Задача: Найти фильмы с рейтингом "PG-13" длительностью более 120 минут

sql
SELECT title, length FROM film 
WHERE rating = 'PG-13' AND length > 120;

2. JOIN-запросы

Задача: Вывести названия фильмов и соответствующие категории

sql
SELECT f.title, c.name AS category 
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;

Задача: Показать всех арендованных фильмов с именами клиентов

sql
SELECT c.first_name, c.last_name, f.title 
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;
3. Агрегация и GROUP BY

Задача: Посчитать количество фильмов в каждой категории

sql
SELECT c.name, COUNT(*) 
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

Задача: Найти среднюю продолжительность фильмов по рейтингам

sql
SELECT rating, ROUND(AVG(length), 2) AS avg_length 
FROM film 
GROUP BY rating;

4. Подзапросы
Задача: Вывести клиентов, которые брали в аренду фильмы категории "Horror"

sql
SELECT first_name, last_name 
FROM customer 
WHERE customer_id IN (
    SELECT r.customer_id 
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Horror'
);
5. Оконные функции
Задача: Проранжировать фильмы по продолжительности внутри каждой категории

sql
SELECT 
    title, 
    name AS category, 
    length,
    DENSE_RANK() OVER (PARTITION BY name ORDER BY length DESC) AS rank
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;
6. Сложные JOIN
Задача: Найти топ-5 самых популярных фильмов (по количеству аренд)

sql
SELECT f.title, COUNT(*) AS rental_count 
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title 
ORDER BY rental_count DESC 
LIMIT 5;
7. Работа с датами
Задача: Вычислить общую сумму платежей по месяцам

sql
SELECT 
    TO_CHAR(payment_date, 'YYYY-MM') AS month, 
    SUM(amount) AS total 
FROM payment 
GROUP BY month 
ORDER BY month;
8. Географические запросы
Задача: Найти всех клиентов из Канады

sql
SELECT c.first_name, c.last_name, co.country 
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';
9. Оптимизация производительности
Задача: Создать индекс для ускорения поиска по почте клиентов

sql
CREATE INDEX idx_customer_email ON customer(email);
10. Аналитика магазинов
Задача: Сравнить доходность магазинов

sql
SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue,
    COUNT(*) AS rentals_count
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.store_id;
Пример решения для задачи 3 (агрегация):
sql
-- Количество фильмов в каждой категории
SELECT 
    c.name AS category,
    COUNT(*) AS film_count,
    STRING_AGG(f.title, ', ') AS films  -- Дополнительно
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY film_count DESC;