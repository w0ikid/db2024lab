create database lecture_1
    owner user2
    tablespace name_of_tablespace;


drop database lecture_1;
create database lecture_1
    allow_connections true
    connection limit -1;


create tablespace space1
    location '/Users/aibekkuralbayev/Desktop/data';


drop database if exists lecture_1;

create database lecture_1
    tablespace space1;


drop table users;
create table users
(
    id   integer primary key,
    name varchar(100)
)
    tablespace space1;

insert into users (id, name)
values (1, 'Bob');

select *
from users;
select *
from users_copy;

drop table users_copy;
create table users_copy
(
    like users including all
);



create table users_child
(
    age     integer,
    address varchar(200)
)
    inherits (users);


select *
from users;
select *
from users_child;

insert into users (id, name)
values (2, 'John');

insert into users_child (id, name, age, address)
values (3, 'Jack', 20, 'some address');

update users
set name='Jack2'
where id = 3;



alter table users
    add column phone varchar(100) default '123';

alter table users
    drop column phone;

select *
from users;

select *
from users_child;


alter table users
    alter column phone set data type varchar(20);



alter table users
    alter column phone set data type varchar(20);


drop table users restrict;
drop table users cascade;



create table users_child2
(
    phone varchar(20)
)
    inherits (users_child);


select *
from users_child2;