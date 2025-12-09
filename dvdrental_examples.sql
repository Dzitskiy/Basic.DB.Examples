
-- =====================================================
-- ПРИМЕРЫ ЗАПРОСОВ ДЛЯ УЧЕБНОЙ БД DVDRENTALS
-- =====================================================

-- 1. SELECT (базовый)
SELECT first_name, last_name FROM customer;

-- 2. SELECT со всеми столбцами
SELECT * FROM film LIMIT 5;

-- 3. INNER JOIN
SELECT c.first_name, f.title
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
LIMIT 10;

-- 4. LEFT JOIN
SELECT c.first_name, c.last_name, p.amount
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
LIMIT 10;

-- 5. RIGHT JOIN
SELECT f.title, c.name
FROM film f
RIGHT JOIN film_category fc ON f.film_id = fc.film_id
RIGHT JOIN category c ON fc.category_id = c.category_id
LIMIT 10;

-- 6. FULL OUTER JOIN
SELECT c.first_name, p.amount
FROM customer c
FULL OUTER JOIN payment p ON c.customer_id = p.customer_id
LIMIT 10;

-- 7. GROUP BY с агрегацией
SELECT customer_id, COUNT(*) as rental_count
FROM rental
GROUP BY customer_id
ORDER BY rental_count DESC
LIMIT 10;

-- 8. GROUP BY с HAVING
SELECT customer_id, SUM(amount) as total_paid
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100
ORDER BY total_paid DESC
LIMIT 10;

-- 9. WHERE с фильтрацией
SELECT title, rental_rate
FROM film
WHERE rental_rate > 2.99;

-- 10. ORDER BY с сортировкой
SELECT first_name, last_name
FROM customer
ORDER BY last_name, first_name;

-- 11. LIMIT и OFFSET
SELECT title
FROM film
ORDER BY title
LIMIT 5 OFFSET 10;

-- 12. DISTINCT (уникальные значения)
SELECT DISTINCT rating
FROM film;

-- 13. Агрегатные функции
SELECT 
    COUNT(*) as total_films,
    AVG(rental_rate) as avg_price,
    MAX(rental_rate) as max_price,
    MIN(rental_rate) as min_price
FROM film;

-- 14. CASE в SELECT
SELECT 
    title,
    rental_rate,
    CASE 
        WHEN rental_rate > 4.00 THEN 'Дорогой'
        WHEN rental_rate > 2.00 THEN 'Средний'
        ELSE 'Дешевый'
    END as price_category
FROM film
LIMIT 10;

-- 15. Базовый подзапрос
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id 
    FROM payment 
    WHERE amount > 10
)
LIMIT 10;

-- Клиенты принесшие доход >= 100 уе
select c.customer_id, c.first_name, count(p.customer_id), avg(p.amount), sum(p.amount) 
from public.customer c
join public.payment p 
on c.customer_id = p.customer_id
group by c.first_name, c.customer_id
having sum(p.amount) >= 100
order by sum(p.amount) desc