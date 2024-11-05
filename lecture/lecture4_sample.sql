select 1;

select 1 + 1;

select 'Hello world';


select *
from actor;

select upper(title)
from film;

select actor_id, first_name, 1 + 1, 1 + 2
from actor;


select film_id, title, length + 10 as "Length_Plus_Ten"
from film f;



select distinct on (title) *
from film;


select distinct on (first_name, last_name) *
from actor;


select all *
from actor;
select *
from actor;


select *
from film
where length > 100
   or rental_duration < 5;



select rental_duration, max(length), sum(length)
from film
group by rental_duration;

select rental_duration, rental_rate, max(length), sum(length)
from film
group by rental_duration, rental_rate;

select sum(length)
from film
where rental_duration = 4;



select rental_duration,
       rental_rate,
       max(length),
       sum(length),
       avg(length),
       min(length),
       count(*)
from film
-- where length < 160
group by rental_duration, rental_rate
having sum(length) > 7500;



select *
from film
where length > 100
union
select *
from film
where length < 160;


select *
from film
where length > 100
   or length < 160;


select *
from film
where length > 100
intersect all
select *
from film
where length < 160;

select *
from film
where length > 100
  and length < 160;



select *
from film
where length > 100
except all
select *
from film
where length < 160;

select *
from film
where length > 100
  and not length < 160;


select *
from film
order by length asc;


select *
from film
order by length asc, rental_duration desc, release_year;


select *
from address
order by address2 asc nulls first;



select *
from film
order by film_id
limit 20 offset 60;


select distinct on (length) *
from film
order by length desc
limit 1 offset 2;


select *
from film
where length =
      (select distinct on (length) length
       from film
       order by length desc
       limit 1 offset 2);


select max(length)
from film;




















