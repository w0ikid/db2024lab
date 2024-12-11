CREATE DATABASE lab10;

CREATE TABLE Books (
    book_id INTEGER PRIMARY KEY,
    title VARCHAR,
    author VARCHAR,
    price DECIMAL,
    quantity INTEGER
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES Books,
    customer_id INTEGER,
    order_date DATE DEFAULT CURRENT_DATE,
    quantity INTEGER
);

CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR,
    email VARCHAR
);

INSERT INTO Books VALUES
    (1, 'Database 101', 'A. Smith', 40.00, 10),
    (2, 'Learn SQL', 'B.Johnson', 35.00, 15),
    (3, 'Advanced DB', 'C.Lee', 50.00, 5);

INSERT INTO Customers VALUES
    (101, 'John Doe', 'johndoe@example.com'),
    (102, 'Jane Doe', 'janedoe@example.com');

-- 1
BEGIN;

DO $$
BEGIN
    IF (SELECT quantity FROM Books WHERE book_id = 1) < 2 THEN
        RAISE EXCEPTION 'Недостаточно книг на складе';
    END IF;
END
$$;

INSERT INTO Orders (book_id, customer_id, quantity)
VALUES (1, 101, 2);

UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;

SELECT * FROM Orders WHERE book_id = 1;
SELECT * FROM Books WHERE book_id = 1;

BEGIN;

DO $$
BEGIN
    IF (SELECT quantity FROM Books WHERE book_id = 3) < 10 THEN
        RAISE EXCEPTION 'Нет достаточного количества книг в наличии';
    END IF;
END
$$;

INSERT INTO Orders (book_id, customer_id, quantity)
VALUES (3, 102, 10);

UPDATE Books
SET quantity = quantity - 10
WHERE book_id = 3;

COMMIT;

-- 2
SELECT * FROM Books WHERE book_id = 3;

-- 3
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
    UPDATE Books
    SET price = 24.50
    WHERE book_id = 3;
COMMIT;

-- 
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SELECT price FROM Books WHERE book_id = 3;
    
    SELECT price FROM Books WHERE book_id = 3;
COMMIT;

-- 4
BEGIN;
    UPDATE Customers
    SET email = 'doni@kbtu.kz'
    WHERE customer_id = 101;
COMMIT;

-- проверка обновления
SELECT email FROM Customers WHERE customer_id = 101;