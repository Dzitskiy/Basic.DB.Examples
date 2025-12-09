CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    credits INT
);

-- Связующая таблица для отношения "многие ко многим"
CREATE TABLE student_courses (
    student_id INT REFERENCES students(id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(id) ON DELETE CASCADE,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (student_id, course_id)  -- Составной первичный ключ
);

INSERT INTO students (name) VALUES 
('Alice'), ('Bob'), ('Charlie'), ('Diana');

INSERT INTO courses (title, credits) VALUES
('Math 101', 4),
('Physics 201', 3),
('Literature 150', 2);

-- Связи: 
-- Alice посещает Math и Physics
-- Bob посещает Math и Literature
-- Charlie посещает Physics
-- Diana посещает все курсы
INSERT INTO student_courses (student_id, course_id) VALUES
(1, 1), (1, 2),
(2, 1), (2, 3),
(3, 2),
(4, 1), (4, 2), (4, 3);


SELECT 
    s.name AS student,
    c.title AS course,
    sc.enrollment_date
FROM students s
INNER JOIN student_courses sc ON s.id = sc.student_id
INNER JOIN courses c ON c.id = sc.course_id
ORDER BY s.name, c.title;