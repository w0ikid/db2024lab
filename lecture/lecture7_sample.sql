select *
from film;
select *
from language;


select *
from film
         cross join language;

select *
from film,
     language;

select *
from film
         inner join language on true;



select *
from film f
         join language l on f.language_id = l.language_id
    and f.last_update = l.last_update;


select *
from film f
         join language l using (language_id, last_update);

select *
from film
         natural join language;



select *
from country;
select *
from city;


select *
from city c
         left join country cc on c.country_id = cc.country_id;


select *
from city c
         left join country cc using (country_id);



select *
from city c
         right join country cc on c.country_id = cc.country_id;


select *
from city c
         full join country cc on c.country_id = cc.country_id;



select *
from film f
         inner join language l on f.language_id = l.language_id and length < 100;

select *
from film f
         inner join language l on f.language_id = l.language_id
where length < 100;


select *
from film f
         left join language l on f.language_id = l.language_id and length < 100;


select *
from film f
         left join language l on f.language_id = l.language_id
where length < 100;