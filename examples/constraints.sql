CREATE TABLE departments (
    id SERIAL PRIMARY KEY,  -- Автоинкрементный первичный ключ
    name VARCHAR(50) NOT NULL UNIQUE,  -- Не может быть NULL и должен быть уникальным
    budget NUMERIC(10,2) CHECK (budget >= 0)  -- Бюджет не может быть отрицательным
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,  -- Уникальный email
    salary NUMERIC(10,2) CHECK (salary > 0),  -- Зарплата > 0
    department_id INTEGER NOT NULL,
    hire_date DATE DEFAULT CURRENT_DATE,  -- Дата по умолчанию - сегодня
    
    -- Ограничение внешнего ключа с REFERENCES
    CONSTRAINT fk_department
        FOREIGN KEY (department_id) 
        REFERENCES departments(id)
        ON DELETE CASCADE
);
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) 
        CHECK (status IN ('planned', 'active', 'completed', 'cancelled')),
    
    -- Составной CHECK
    CONSTRAINT valid_dates 
        CHECK (start_date < end_date),
    
    -- Составной UNIQUE
    CONSTRAINT unique_project_name 
        UNIQUE (name, status)
);

CREATE TABLE project_assignments (
    employee_id INTEGER NOT NULL,
    project_id INTEGER NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'member',
    assignment_date DATE DEFAULT CURRENT_DATE,
    
    -- Составной первичный ключ
    PRIMARY KEY (employee_id, project_id),
    
    -- Множественные FOREIGN KEY
    CONSTRAINT fk_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(id)
        ON DELETE CASCADE,
    
    CONSTRAINT fk_project
        FOREIGN KEY (project_id)
        REFERENCES projects(id)
        ON DELETE RESTRICT  -- Запрещает удаление проекта с назначениями
);