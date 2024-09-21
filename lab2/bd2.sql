CREATE DATABASE lab2;

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INTEGER,
    population INTEGER
);

INSERT INTO countries (country_name, region_id, population)
VALUES ('Kazakhstan', 1, 20000000);

INSERT INTO countries (country_id, country_name)
VALUES (2, 'China');

INSERT INTO countries (country_name, region_id, population)
VALUES ('Russia', NULL, 150000000);

INSERT INTO countries (country_name, region_id, population)
VALUES 
('USA', 2, 500000000),
('Vietnam', 3, 77788844),
('Ukraine', 5, 5000);

ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries (region_id, population)
VALUES (4, 570667000);

INSERT INTO countries DEFAULT VALUES;

CREATE TABLE countries_new AS
SELECT * FROM countries WHERE 1=0;

INSERT INTO countries_new
SELECT * FROM countries;

UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

SELECT country_name, population * 1.1 AS "New Population"
FROM countries;

DELETE FROM countries
WHERE population < 100000;

DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries);

DELETE FROM countries;
