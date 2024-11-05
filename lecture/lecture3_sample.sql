create table users
(
    id   serial,
    name varchar(200)
);


insert into users (name)
values ('bob');

select *
from users;


alter sequence users_id_seq increment by 3;
alter sequence users_id_seq restart with 100;



create table table1
(
    col1 varchar(5),
    col2 char(5)
);

insert into table1 (col1, col2)
VALUES ('abc', 'abc');

select *
from table1;

select octet_length(col1), octet_length(col2)
from table1;



create table decimal_test
(
    value decimal(5, 2)
);


insert into decimal_test (value)
values (999.99);



-- one line comment --
/*
 multi
 line
 comment
 */


create table "Table2"
(
    id integer
);

select *
from "Table2";


create table products
(
    id     serial primary key,
    name   varchar(200),
    price  integer,
    weight integer
);

alter table products
    alter column price set default 0;

insert into products (name, price, weight)
values ('Coke', 30.1::integer, 10);

insert into products (id, name, price, weight)
values (default, 'Coke', default, 10);

select *
from products;


insert into products default
values;


insert into products
values (default, 'Pepsi', 10);


insert into products as p (name, price, weight)
select name, price, weight
from products
where id = 1;



select *
from products;


update products
set weight=0
where weight is null;


update products
set weight=0,
    price=10,
    name  = 'asd'
where weight is null;



update products
set (weight, price, name) = (0, 10, 'asd')
where weight is null;


update products
set price=price * 1.1
where id = 8;


update products
set (price, weight) = (select max(price), 5 from products)
where price = 0;



create table category
(
    id   serial primary key,
    name varchar(200)
);

insert into category (name)
values ('Products'),
       ('Electronics'),
       ('Clothes');


select *
from category;


alter table products
    add column category_id integer references category;

select *
from products;

select *
from category;

1 1
1 2
1 3
2 1
2 2
2 3

update products
set category_id=1
where id < 4;
update products
set category_id=2
where id between 4 and 8;


update products
set price=price * 1.1
where category_id = (select id from category where name = 'Electronics');


update products p
set price=price * 1.1
from category c
where c.name = 'Electronics'
  and p.category_id = c.id;



select *
from products;

delete
from products
where price = 11;


delete
from products p
    using category c
where c.name = 'Electronics'
  and p.category_id = c.id
returning *;


select *
from products;

update products p
set price=price * 1.1
from category c
where c.name = 'Products'
  and p.category_id = c.id
returning p.id, p.name, price as new_price;