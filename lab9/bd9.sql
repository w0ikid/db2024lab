-- Task 1: Stored Procedure to Increase Value by 10
CREATE PROCEDURE increase_value(IN input_value INT, OUT result_value INT)
BEGIN
    SET result_value = input_value + 10;
END;

-- CALL increase_value(5, @result);
-- SELECT @result;  


-- Task 2: Compare Numbers Stored Procedure
CREATE PROCEDURE compare_numbers(IN num1 INT, IN num2 INT, OUT comparison_result VARCHAR(10))
BEGIN
    IF num1 > num2 THEN
        SET comparison_result = 'Greater';
    ELSEIF num1 = num2 THEN
        SET comparison_result = 'Equal';
    ELSE
        SET comparison_result = 'Lesser';
    END IF;
END;

-- CALL compare_numbers(10, 20, @result_value);
-- SELECT @result; 

-- Task 3: Number Series Stored Procedure
CREATE PROCEDURE number_series(IN n INT, OUT series TEXT)
BEGIN
    DECLARE i INT DEFAULT 1;
    SET series = '';
    WHILE i <= n DO
        SET series = CONCAT(series, i, IF(i < n, ',', ''));
        SET i = i + 1;
    END WHILE;
END;

-- CALL number_series(5, @series);
-- SELECT @series; -- will return -> '1,2,3,4,5'

-- Task 4: Find Employee Details Stored Procedure
CREATE PROCEDURE find_employee(IN employee_name VARCHAR(100))
BEGIN
    SELECT * FROM employees WHERE name = employee_name;
END;

-- CALL find_employee('Doni Pepperoni');


-- Task 5: List Products by Category Stored Procedure
CREATE PROCEDURE list_products(IN category_name VARCHAR(100))
BEGIN
    SELECT * FROM products WHERE category = category_name;
END;

-- CALL list_products('TV');


-- Task 6: Nested Procedure Example: Calculate Bonus and Update Salary
CREATE PROCEDURE calculate_bonus(IN salary DECIMAL(10,2), OUT bonus DECIMAL(10,2))
BEGIN
    SET bonus = salary * 0.1;
END;

CREATE PROCEDURE update_salary(IN employee_id INT)
BEGIN
    DECLARE current_salary DECIMAL(10,2);
    DECLARE bonus DECIMAL(10,2);

    SELECT salary INTO current_salary FROM employees WHERE id = employee_id;
    CALL calculate_bonus(current_salary, bonus);
    UPDATE employees SET salary = salary + bonus WHERE id = employee_id;
END;

-- CALL update_salary(7); -- we will give bonus salary for emplyee ID 7

-- Task 7: Complex Calculation with Nested Subblocks
CREATE PROCEDURE complex_calculation(IN num1 INT, IN str1 VARCHAR(100), OUT result TEXT)
BEGIN
    DECLARE numeric_result INT;
    DECLARE string_result VARCHAR(100);

    -- Subblock 1: Numeric Computation
    BEGIN
        SET numeric_result = num1 * 2;
    END;

    -- Subblock 2: String Manipulation
    BEGIN
        SET string_result = CONCAT('Processed: ', str1);
    END;

    -- Combine Results
    SET result = CONCAT(string_result, ' | Numeric Result: ', numeric_result);
END;

-- CALL complex_calculation(10, 'Test', @result);
-- SELECT @result; -- Возвращает 'Processed: Test | Numeric Result: 20'
