-- Создаем таблицы
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department_id INT REFERENCES departments(id),
    salary INT
);

CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    lead_employee_id INT REFERENCES employees(id)
);

-- Заполняем данными
INSERT INTO departments (name) VALUES 
('IT'),
('HR'),
('Sales'),
('Marketing');

INSERT INTO employees (name, department_id, salary) VALUES
('Alice', 1, 60000),    -- IT
('Bob', 1, 55000),      -- IT
('Charlie', 2, 50000),  -- HR
('David', 3, 65000),    -- Sales
('Eva', NULL, 70000)   -- Без отдела


INSERT INTO projects (name, lead_employee_id) VALUES
('Website Redesign', 7),  -- Alice
('Recruiting Portal', 8), -- Charlie
('Mobile App', NULL);     -- Без руководителя