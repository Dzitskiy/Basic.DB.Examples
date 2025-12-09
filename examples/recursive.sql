WITH RECURSIVE subordinates AS (
    -- Не рекурсивная часть: начальный элемент (CTO)
    SELECT id, name, manager_id
    FROM employees
    WHERE id = 2

    UNION ALL

    -- Рекурсивная часть: подчинённые
    SELECT e.id, e.name, e.manager_id
    FROM employees e
    JOIN subordinates s ON e.manager_id = s.id
)
SELECT * FROM subordinates;