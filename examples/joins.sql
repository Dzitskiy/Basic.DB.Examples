-- 1. INNER JOIN (только совпадающие записи)
SELECT 
    e.name AS employee,
    d.name AS department
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- 2. LEFT JOIN (все записи из левой таблицы + совпадения справа)
SELECT 
    e.name AS employee,
    d.name AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- 3. RIGHT JOIN (все записи из правой таблицы + совпадения слева)
SELECT 
    e.name AS employee,
    d.name AS department
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;

-- 4. FULL OUTER JOIN (все записи из обеих таблиц)
SELECT 
    e.name AS employee,
    d.name AS department
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.id;

-- 5. CROSS JOIN (декартово произведение)
SELECT 
    e.name AS employee,
    d.name AS department
FROM employees e
CROSS JOIN departments d;

-- 6. NATURAL JOIN (автоматически по одинаковым именам столбцов)
SELECT 
    e.name AS employee,
    d.name AS department
FROM employees e
NATURAL JOIN departments d; -- Работает как INNER JOIN по department_id

-- 7. SELF JOIN (соединение таблицы с самой собой)
SELECT
    e1.name AS employee,
    e2.name AS colleague
FROM employees e1
INNER JOIN employees e2 
    ON e1.department_id = e2.department_id
    AND e1.id != e2.id;

-- 8. MULTI-TABLE JOIN (соединение 3+ таблиц)
SELECT 
    e.name AS employee,
    d.name AS department,
    p.name AS project
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
LEFT JOIN projects p ON e.id = p.lead_employee_id;

-- 9. NON-EQUI JOIN (соединение по неравенству)
SELECT 
    e1.name AS employee1,
    e2.name AS employee2,
    e1.salary AS salary1,
    e2.salary AS salary2
FROM employees e1
INNER JOIN employees e2 
    ON e1.salary > e2.salary + 10000;

-- 10. ANTI-JOIN (найти отсутствующие соответствия)
SELECT 
    d.name AS department
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
WHERE e.id IS NULL;