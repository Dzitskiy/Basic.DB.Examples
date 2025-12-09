-- Найти имена, начинающиеся на 'A'
WHERE name LIKE 'A%'

-- Найти email, заканчивающиеся на '@gmail.com'
WHERE email LIKE '%@gmail.com'

-- Найти 4-буквенные имена, где вторая буква 'a'
WHERE name LIKE '_a__'

-- Найдёт 'alice', но не 'Alice' или 'ALICE'
WHERE name LIKE 'alice'

-- Найдёт все варианты: 'alice', 'Alice', 'ALICE'
WHERE name ILIKE 'alice'

-- Найти email в любом регистре, начинающиеся на 'support'
SELECT * FROM contacts 
WHERE LOWER(email) LIKE LOWER('support%@%');
