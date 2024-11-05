create database lecture_6;


drop table products;
create table products
(
    id    serial,
    name  varchar(200),
    price integer check ( price > 0 ) default 100
);


insert into products (name, price)
VALUES ('Coke', 100);
insert into products (name, price)
VALUES ('Coke', 0);
insert into products (name, price)
VALUES ('Pepsi', 100);

select *
from products;

select *
from pg_constraint;


drop table products;
create table products
(
    id    serial,
    name  varchar(200) check ( char_length(name) > 3 ),
    price integer check ( price > 0 ) default 100
);


insert into products (name, price)
VALUES ('Coke', 100);
insert into products (name, price)
VALUES ('asd', 100);


drop table products;
create table products
(
    id             serial,
    name           varchar(200) check ( char_length(name) > 3 ),
    price          integer check ( price > 0 ) default 100,
    discount_price integer,
    check (price > discount_price)
);


insert into products (name, price, discount_price)
VALUES ('Coke', 100, 100);

insert into products (name, price, discount_price)
VALUES ('Coke', 100, 90);



drop table products;
create table products
(
    id             serial,
    name           varchar(200) not null,
    price          integer,
    discount_price integer
);



select *
from pg_constraint;



drop table products;
create table products
(
    id             serial,
    name           varchar(200) not null unique,
    price          integer unique,
    discount_price integer
);



insert into products (name, price, discount_price)
VALUES ('Coke', 100, 90);

insert into products (name, price, discount_price)
VALUES ('Coke2', 100, 90);



drop table products;
create table products
(
    id             serial,
    name           varchar(200) not null,
    price          integer,
    discount_price integer,
    unique (name, price)
);


insert into products (name, price, discount_price)
VALUES ('Coke', 100, 90);

insert into products (name, price, discount_price)
VALUES ('Coke', 101, 90);

insert into products (name, price, discount_price)
VALUES ('Coke', 100, 90);

insert into products (name, price, discount_price)
VALUES ('Coke2', 100, 90);

select *
from products;



drop table products;
create table products
(
    id             serial,
    name           varchar(200) not null,
    price          integer,
    discount_price integer,
    primary key (name, price)
);



select *
from pg_constraint;



drop table products;
create table products
(
    id    serial primary key,
    name  varchar(200) not null,
    price integer
);

create table orders
(
    id         serial primary key,
    product_id integer references products (id),
    quantity   integer
);


insert into products (name, price)
VALUES ('Coke', 100),
       ('Pepsi', 150),
       ('Fanta', 200);


select *
from products;

insert into orders (product_id, quantity)
values (1, 10),
       (2, 5),
       (3, 7);

insert into orders (product_id, quantity)
values (null, 10);

select *
from orders;

select *
from pg_constraint;



create table category
(
    id        serial primary key,
    name      varchar,
    parent_id integer references category (id)
);