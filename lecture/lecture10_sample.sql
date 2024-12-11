select count(), nullif();


create database lecture11;

create function inc(a integer) returns integer as
$$
BEGIN
    return a + 1;
END;
$$
    language plpgsql;

select inc(inc(5));


create or replace function get_sum(in a numeric, b numeric) returns numeric as
$$
BEGIN
    return a + b;
END;
$$
    language plpgsql;

select get_sum(5, 6);

select *
from get_sum(5, 6);



create or replace function hi_lo(a numeric, b numeric, c numeric, out hi numeric, out lo numeric)
as
$$
BEGIN
    hi := greatest(a, b, c);
    lo := least(a, b, c);
END;
$$
    language plpgsql;



select *
from hi_lo(10, 1, 5);

select hi_lo(10, 1, 5);



create function square(inout a numeric)
as
$$
BEGIN
    a = a * a;
END;
$$
    language plpgsql;


select *
from square(square(5));



create function sum_avg(variadic list numeric[], out total numeric, out average numeric)
as
$$
BEGIN
    select into total sum(unnest) from unnest(list);
    select into average avg(unnest) from unnest(list);
END;
$$
    language plpgsql;



select *
from sum_avg(5, 6, 1, 8, 9, 10, 12, 20);

create or replace function sum_avg(variadic list numeric[], out total numeric, out average numeric)
as
$$
BEGIN
    select into total sum(list[i]) from generate_subscripts(list, 1) g(i);
    select into average avg(list[i]) from generate_subscripts(list, 1) g(i);
END;
$$
    language plpgsql;

select *
from sum_avg(5, 6, 1, 8, 9, 10, 12, 20);


select sum(unnest)
from unnest(array [4, 5, 6, 10]);


select *
from generate_subscripts(array [4, 5, 6, 10], 1) g(i);


CREATE OR REPLACE FUNCTION get_rental_duration(p_customer_id INTEGER)
    RETURNS INTEGER AS
$$
DECLARE
    rental_duration INTEGER;
BEGIN
    -- get the rate based on film_id
    SELECT INTO rental_duration SUM(EXTRACT(DAY FROM return_date -
                                                     rental_date))
    FROM rental
    WHERE customer_id = p_customer_id;
    RETURN rental_duration;
END;
$$
    LANGUAGE plpgsql;


select *
from get_rental_duration(100);


CREATE OR REPLACE FUNCTION get_rental_duration(p_customer_id INTEGER, p_from_date date default '2005-07-01')
    RETURNS INTEGER AS
$$
DECLARE
    rental_duration INTEGER;
BEGIN
    -- get the rate based on film_id
    SELECT INTO rental_duration SUM(EXTRACT(DAY FROM return_date -
                                                     rental_date))
    FROM rental
    WHERE customer_id = p_customer_id
      and rental_date >= p_from_date;
    RETURN rental_duration;
END;
$$
    LANGUAGE plpgsql;


drop function get_rental_duration(a integer);

select *
from get_rental_duration(100);



CREATE OR REPLACE FUNCTION get_film(p_pattern VARCHAR)
    RETURNS TABLE
            (
                film_title        VARCHAR,
                film_release_year INT
            )
AS
$$
BEGIN
    RETURN QUERY SELECT title,
                        cast(release_year as integer)
                 FROM film
                 WHERE title ILIKE p_pattern;
END;
$$
    LANGUAGE 'plpgsql';


select *
from get_film('A%a');

select get_film('A%a');



DO
$$
    <<outer_block>>
        DECLARE
        counter integer = 0;
        cnt     integer = 10;
    BEGIN
        counter = counter + 1;
        raise notice 'The value of counter is %', counter;
        <<inner_block>>
            declare
            counter integer = 5;
        begin
            counter = counter + 5;
            raise notice 'The value of inner block counter is %', counter;
            raise notice 'The value of outer block counter is %', outer_block.counter;
            raise notice 'The value of outer block cnt is %', cnt;
        end inner_block;

        raise notice 'The value of counter is %', counter;

    END outer_block;
$$;



create table actors_history
(
    actor_id       integer references actor,
    old_first_name varchar(500),
    new_first_name varchar(500),
    changed_at     timestamp
);



create function actors_fname_change()
    returns trigger
as
$$
BEGIN
    if old.first_name <> new.first_name then
        insert into actors_history (actor_id, old_first_name, new_first_name, changed_at)
        values (old.actor_id, old.first_name, new.first_name, now());
    end if;
    return new;
END;
$$
    language plpgsql;


create trigger actors_trigger
    before update
    on actor
    for each row
execute procedure actors_fname_change();



select *
from actor
where actor_id = 10;


update actor
set first_name = 'JOHN'
where actor_id in (10, 11, 12, 13);

update actor
set last_name = 'NewLast'
where actor_id in (10);

select * from actors_history;
