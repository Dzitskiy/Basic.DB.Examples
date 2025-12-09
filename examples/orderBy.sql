-- Сотрудники по имени (A-Z)
SELECT * FROM employees
ORDER BY name ASC;

-- Сотрудники по зарплате (от высокой к низкой)
SELECT name, salary FROM employees
ORDER BY salary DESC;