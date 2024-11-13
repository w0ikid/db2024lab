-- Create database
CREATE DATABASE lab7;

-- Create tables
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    budget DECIMAL(10, 2) NOT NULL
);

-- Insert data
INSERT INTO countries (name) VALUES
('China'),
('United States'),
('India'),
('Indonesia'),
('Brazil'),
('Pakistan'),
('Nigeria'),
('Bangladesh'),
('Russia'),
('Kazakhstan'),
('Mexico');

INSERT INTO employees (name, surname, salary, department_id) VALUES
('John', 'Doe', 50000.00, 1),
('Jane', 'Smith', 60000.00, 2),
('Emily', 'Johnson', 70000.00, 3),
('Chris', 'Evans', 45000.00, 1),
('Anna', 'Taylor', 80000.00, 2);

INSERT INTO departments (department_name, budget) VALUES
('HR', 100000.00),
('Engineering', 200000.00),
('Marketing', 150000.00);

-- Task 1: Create index for queries like:
-- SELECT * FROM countries WHERE name = 'string';
CREATE INDEX idx_countries_name ON countries (name);

-- Task 2: Create index for queries like:
-- SELECT * FROM employees WHERE name = 'string' AND surname = 'string';
CREATE INDEX idx_employees_name_surname ON employees (name, surname);

-- Task 3: Create unique index for queries like:
-- SELECT * FROM employees WHERE salary < value1 AND salary > value2;
CREATE UNIQUE INDEX idx_employees_salary_range ON employees (salary);

-- Task 4: Create index for queries like:
-- SELECT * FROM employees WHERE substring(name FROM 1 FOR 4) = 'abcd';
CREATE INDEX idx_employees_name_substring
ON employees ((substring(name FROM 1 FOR 4)));

-- Task 5: Create index for queries like:
-- SELECT * FROM employees e JOIN departments d 
-- ON d.department_id = e.department_id
-- WHERE d.budget > value2 AND e.salary < value2;
CREATE INDEX idx_employees_department_id_salary ON employees (department_id, salary);
CREATE INDEX idx_departments_budget ON departments (budget);

-- Task 1: Select countries by name
SELECT * 
FROM countries 
WHERE name = 'China';

-- Task 2: Select employees by name and surname
SELECT * 
FROM employees 
WHERE name = 'Jane' 
  AND surname = 'Smith';

-- Task 3: Select employees with salary in a specific range
SELECT * 
FROM employees 
WHERE salary < 80000 
  AND salary > 50000;

-- Task 4: Select employees where the first 4 characters of the name match
SELECT * 
FROM employees 
WHERE substring(name FROM 1 FOR 4) = 'Jane';

-- Task 5: Select employees and their departments with specific conditions
SELECT e.*, d.*
FROM employees e
JOIN departments d
ON d.department_id = e.department_id
WHERE d.budget > 150000 
  AND e.salary < 60000;
