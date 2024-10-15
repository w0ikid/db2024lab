CREATE DATABASE lab5;

CREATE TABLE customers(
    customer_id integer,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade integer,
    salesman_id integer
);

INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', null, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

SELECT * FROM customers;


CREATE TABLE orders(
    ord_no integer,
    purch_amt DOUBLE PRECISION, /* two decimals*/
    ord_date DATE,
    customer_id integer,
    salesman_id integer
);

INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);


SELECT * FROM orders;


SELECT SUM(purch_amt) FROM orders;


SELECT AVG(purch_amt) FROM orders;


SELECT COUNT(cust_name) FROM customers;


SELECT MIN(purch_amt) FROM orders;


SELECT * FROM CUSTOMERS
WHERE cust_name LIKE '%b';



SELECT * FROM orders WHERE
customer_id IN (SELECT customer_id FROM customers WHERE city = 'New York');



SELECT * FROM customers
WHERE (customer_id IN (SELECT customer_id FROM orders WHERE purch_amt > 10));



SELECT SUM(grade) FROM customers;



SELECT * FROM customers WHERE cust_name IS NOT NULL;


SELECT MAX(grade) FROM customers;