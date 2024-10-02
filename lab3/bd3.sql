-- 1
CREATE DATABASE lab3;
-- 3
SELECT lastname FROM employees;
-- 4
SELECT DISTINCT lastname FROM employees;
-- 5
SELECT ssn, name, lastname, department, city FROM employees
WHERE lastname = 'Smith'
-- 6
SELECT ssn, name, lastname, department, city FROM employees
WHERE lastname = 'Smith' OR lastname = 'Doe'
-- 7
SELECT ssn, name, lastname, department, city FROM employees
WHERE department = 14
-- 8
SELECT * FROM employees WHERE department = 37 OR department = 77;

-- 9
SELECT SUM(budget) FROM departments;

-- 10
SELECT department, COUNT(*) FROM employees INNER JOIN departments ON departments.code = employees.department GROUP BY employees.department;

-- 11
SELECT department, COUNT(*) FROM employees INNER JOIN departments ON departments.code = employees.department GROUP BY employees.department HAVING COUNT(*) > 2;

-- 12
SELECT "name" FROM departments ORDER BY budget DESC OFFSET 1 LIMIT 1;

-- 13
SELECT employees."name", employees.lastname FROM employees INNER JOIN departments ON departments.code = employees.department WHERE departments.budget = (SELECT MIN(budget) FROM departments);

-- 14
SELECT employees."name" from employees INNER JOIN customers ON customers.city = employees.city WHERE employees.city = 'Almaty' GROUP BY employees."name";

-- 15
SELECT * FROM departments WHERE budget > 60000 ORDER BY budget ASC, code DESC;

-- 16
UPDATE departments SET budget = budget - ((SELECT MIN(budget) FROM departments) / 10);

-- 17
UPDATE employees SET department = 14 WHERE department = 77;

-- 18
DELETE FROM employees WHERE employees.department = 14;

-- 19
TRUNCATE employees;