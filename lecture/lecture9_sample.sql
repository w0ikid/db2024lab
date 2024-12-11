drop view film_view;
create or replace view film_view as
select film_id,
       title,
       language_id,
       rental_duration,
       rental_rate,
       replacement_cost,
       last_update,
       fulltext,
       length
from film
where length > 100;


explain
select *
from film_view;


insert into film_view (film_id, title, language_id, rental_duration,
                       rental_rate, replacement_cost, last_update, fulltext, length)
values (default, 'New title 2', 1, 5, 4, 10, now(), 'asdasd', 110);

select *
from film
order by film_id desc;



create or replace view film_view_child as
select *
from film_view
where rental_duration > 5
with cascaded check option;

insert into film_view_child (film_id, title, language_id, rental_duration,
                             rental_rate, replacement_cost, last_update, fulltext, length)
values (default, 'New title 2', 1, 6, 4, 10, now(), 'asdasd', 110);


drop materialized view film_view_materialized;

create materialized view film_view_materialized as
select film_id,
       title,
       language_id,
       rental_duration,
       rental_rate,
       replacement_cost,
       last_update,
       fulltext,
       length
from film
where length > 100
with no data;

explain
select *
from film_view_materialized;


refresh materialized view concurrently film_view_materialized;

create unique index film_view_materialized_index on film_view_materialized (film_id);



select *
from orders;

explain analyze;
drop materialized view order_mat_view;
create materialized view order_mat_view as
select o.user_id, sum(order_id), avg(order_id), max(order_id), min(order_id)
from orders o
         join users u on o.user_id = u.id
where exists(select * from users where user_id = o.user_id)
group by o.user_id
having count(o.user_id) > 10
with no data;


refresh materialized view concurrently order_mat_view;


create unique index order_mat_view_index on order_mat_view (user_id);



create or replace view film_view as
select film_id,
       title,
       language_id,
       rental_duration,
       rental_rate,
       replacement_cost,
       last_update,
       fulltext,
       length,
       description
from film
where length > 100;


select *
from pg_roles;

drop role new_role7;

create role new_role7 login;

create role new_role7 superuser;

create role new_role7 login createdb;


create database new_db2;



alter role new_role7 login nocreatedb createrole;


grant group_role1 to new_role7; -- createdb
grant group_role2 to new_role7; -- createrole

set role group_role1; -- createdb nocreaterole
set role group_role2; -- nocreatedb createrole


revoke group_role1 from new_role7;



grant select, insert on table film to new_role7;
grant all privileges on table film to new_role7;
grant select on film_view to new_role7;
grant all privileges on database lecture_8 to new_role7;

revoke select, insert on table film from new_role7;

select *
from film;



