SELECT 
    d.name AS department,
    COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.name
ORDER BY employee_count DESC;



SELECT 
    d.name AS department,
    COUNT(p.id) AS project_count,
    ROUND(AVG(e.salary), 0) AS avg_salary
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
LEFT JOIN projects p ON e.id = p.lead_employee_id
GROUP BY d.name, e.department_id
ORDER BY department NULLS FIRST;


SELECT 
    d.name,
    AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.id = e.department_id
GROUP BY d.name
HAVING AVG(e.salary) > 55000;


SELECT 
    e.name,
    COUNT(p.id) AS total_projects,
    SUM(CASE WHEN p.name LIKE '%Research%' THEN 1 ELSE 0 END) AS research_projects,
    MAX(p.name) AS last_project_name  -- условный пример
FROM employees e
LEFT JOIN projects p ON e.id = p.lead_employee_id
GROUP BY e.id
ORDER BY total_projects DESC;


