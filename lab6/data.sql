INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
('123 Main St', '12345', 'New York', 'NY'),
('456 Elm St', '54321', 'Los Angeles', 'CA'),
('789 Maple St', '67890', 'Chicago', 'IL'),
('101 Oak St', '11223', 'Houston', 'TX'),
('202 Pine St', '33445', 'Phoenix', 'AZ'),
('303 Cedar St', '55667', 'Philadelphia', 'PA'),
('404 Birch St', '77889', 'San Antonio', 'TX'),
('505 Walnut St', '99001', 'San Diego', 'CA'),
('606 Chestnut St', '22334', 'Dallas', 'TX'),
('707 Willow St', '44556', 'San Jose', 'CA');

INSERT INTO departments (department_name, budget, location_id) VALUES
('HR', 50000, 1),
('IT', 150000, 2),
('Finance', 100000, 3),
('Marketing', 120000, 4),
('Sales', 90000, 5),
('Customer Service', 70000, 6),
('Legal', 110000, 7),
('R&D', 160000, 8),
('Operations', 130000, 9),
('Engineering', 180000, 10);

INSERT INTO departments (department_id, department_name, budget, location_id)
VALUES (80, 'Finance', 500000, 3);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('Alice', 'Smith', 'alice.smith@example.com', '123-456-7890', 60000, 1),
('Bob', 'Brown', 'bob.brown@example.com', '234-567-8901', 80000, 2),
('Charlie', 'Johnson', 'charlie.johnson@example.com', '345-678-9012', 75000, 3),
('Dana', 'Lee', 'dana.lee@example.com', '456-789-0123', 90000, 1),
('Evan', 'Taylor', 'evan.taylor@example.com', '567-890-1234', 85000, 2),
('Fiona', 'Davis', 'fiona.davis@example.com', '678-901-2345', 95000, 4),
('George', 'Martin', 'george.martin@example.com', '789-012-3456', 70000, 5),
('Hannah', 'Clark', 'hannah.clark@example.com', '890-123-4567', 72000, 6),
('Ivy', 'Walker', 'ivy.walker@example.com', '901-234-5678', 78000, 7),
('Jack', 'Hall', 'jack.hall@example.com', '012-345-6789', 88000, 8),
('Karen', 'Young', 'karen.young@example.com', '123-456-7890', 93000, 9),
('Liam', 'Scott', 'liam.scott@example.com', '234-567-8901', 64000, 10),
('Mia', 'Green', 'mia.green@example.com', '345-678-9012', 91000, 1),
('Noah', 'Adams', 'noah.adams@example.com', '456-789-0123', 94000, 2),
('Olivia', 'Baker', 'olivia.baker@example.com', '567-890-1234', 86000, 3),
('Paul', 'Nelson', 'paul.nelson@example.com', '678-901-2345', 72000, 4),
('Quinn', 'Hill', 'quinn.hill@example.com', '789-012-3456', 67000, 5),
('Rachel', 'Ramirez', 'rachel.ramirez@example.com', '890-123-4567', 83000, 6),
('Steve', 'Carter', 'steve.carter@example.com', '901-234-5678', 78000, 7),
('Tina', 'Morris', 'tina.morris@example.com', '012-345-6789', 74000, 8);

-- Добавляем департаменты без сотрудников
INSERT INTO departments (department_name, budget, location_id) VALUES
('Procurement', 95000, 3),  -- Отдел закупок, без сотрудников
('Quality Assurance', 85000, 6);  -- Отдел качества, без сотрудников

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) 
VALUES ('John', 'Doe', 'john.doe@example.com', '123-456-7890', 75000, 80);
