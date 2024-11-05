select *
from film
where not ((length > 100
    and rental_duration < 5)
    or (length < 50 and rental_duration > 7));


select *
from film
where language_id <> 1;



select *
from film
where length between 50 and 100;

select *
from film
where length >= 50
  and length <= 100;


select *
from film
where length not between 50 and 100;

select *
from film
where length < 50
   or length > 100;


select *
from film
where length between symmetric 100 and 50;


select *
from film
where original_language_id = null;

select *
from film
where film.length is not distinct from 50;


select *
from film
where film.original_language_id is null;


select num_nonnulls(1, 2, null, 5, null),
       num_nulls(1, 2, null, 5, null);


select num_nonnulls(title, length, original_language_id),
       num_nulls(title, length, original_language_id)
from film;



select ceil(4.35),
       floor(4.35),
       round(4.35, 1),
       trunc(4.1234, 2);



select setseed(0.5);
select random();



select 'The film: ' || title || ' was released in ' || release_year
from film;



select bit_length('Hello world'),
       char_length('Hello world'),
       octet_length('Hello world');


select *
from test;

select char_length(value2), octet_length(value2)
from test;



select title,
       overlay(title placing 'asd' from 3 for 5),
       position('LAND' in title),
       substring(title from 3 for 5),
       substr(title, 3, 5),
       trim(both 'ABC' from title)
from film;


select format('The film: %s was released in %s', title, release_year)
from film;


select *
from actor
where first_name like '_A%A_';
select *
from actor
where first_name like '%B%';



select to_char(4.1234, '999D9999S');

select to_date('05 12 2020', 'Day Month YYYY');


select length,
       case
           when length < 60 then 'Short film'
           when length between 60 and 100 then 'Medium film'
           else 'Long film'
           end
from film;


select rental_duration,
       case rental_duration
           when 3 then 'Short'
           when 4 then 'Medium'
           else 'Long'
           end
from film;



select coalesce(null, 1, 2, 3, null);


select coalesce(description, short_desc, title, 'No description')
from film;

select nullif(1, 2);

select nullif(coalesce(description, short_desc, title, 'No description'), 'No description')
from film;



select greatest(1, 4, 5, 10, 1),
       least(1, 4, 5, 10, 1),
       max(),
       min()
;

select length,
       rental_duration * 20,
       rental_rate * 20,
       greatest(length, rental_duration * 20, rental_rate * 20),
       least(length, rental_duration * 20, rental_rate * 20)
from film;



select max(length), min(length)
from film;



create table test
(
    asd int[]
);



select t.num
from unnest(array [[1, 2 ,3, 10], [1, 2 ,3, 10]], array ['asd', 'qwe', '123']) AS t(num, word);



select max(length),
       min(length),
       sum(length),
       count(*),
       avg(length),
       array_agg(title),
       json_agg(title),
       string_agg(title, ';')
from film
GROUP BY length;



select *
from film_actor;

select *
from actor a
where exists(select fa.actor_id
             from film_actor fa
             where a.actor_id = fa.actor_id
             group by fa.actor_id
             having count(*) >= 30);



select *
from actor
where actor_id not in (select actor_id
                       from film_actor
                       group by actor_id
                       having count(*) >= 30);



select *
from actor
where actor_id < some (select actor_id
                       from film_actor
                       group by actor_id
                       having count(*) >= 30);



select *
from actor
where actor_id < all (select actor_id
                      from film_actor
                      group by actor_id
                      having count(*) >= 30);



select *
from film
where length <= all (select length from film);







