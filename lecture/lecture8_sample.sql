create database lecture_8;


CREATE TABLE users
(
    id          serial PRIMARY KEY,
    username    VARCHAR(255) NOT NULL,
    email       VARCHAR(255) NOT NULL,
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DO
$$
    DECLARE
        i INTEGER := 0;
    BEGIN
        WHILE i < 1000000
            LOOP
                INSERT INTO users (username, email)
                VALUES (md5(random()::text || clock_timestamp()::text),
                        md5(random()::text || clock_timestamp()::text) || '@example.com');
                i := i + 1;
            END LOOP;
    END
$$;



CREATE TABLE orders
(
    order_id     serial PRIMARY KEY,
    user_id      INT REFERENCES users (id),
    product_name VARCHAR(255) NOT NULL,
    order_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DO
$$
    DECLARE
        j INTEGER := 0;
    BEGIN
        WHILE j < 5000000
            LOOP
                INSERT INTO orders (user_id, product_name)
                VALUES (floor(random() * 1000000 + 1)::INT, 'Product-' || md5(random()::text));
                j := j + 1;
            END LOOP;
    END
$$;



explain analyze
select *
from rental
where customer_id < 5;


create index rental_customer_id_index on rental (customer_id);



explain analyze
select *
from users
where username = '85d9e5815b29370abe25d1a24eedf968';

create index users_username_index on users (username);
create index users_username_index_hash on users using hash (username);


explain analyze
select *
from orders
where user_id > 5;

create index orders_user_id_index on orders (user_id);
drop index orders_user_id_index;



explain analyze
select *
from orders
where user_id = 324995
  and product_name = 'Product-c055587c61b173b35d2b47d6b6613089';


create index orders_index on orders (user_id, product_name);


explain analyze
select *
from users
order by username desc nulls last;


create index users_username_desc_index on users (username desc nulls last);


drop index users_username_desc_index;
create unique index users_username_desc_index on users (username desc nulls last);


select *
from users;

delete
from users
where username = '6c7f2c3292cb084d2d84604a77f12943'
  and email = '6c7f2c3292cb084d2d84604a77f12943@example.com';

insert into users (username, email)
values ('6c7f2c3292cb084d2d84604a77f12943', '6c7f2c3292cb084d2d84604a77f12943@example.com');



explain analyze
select *
from orders
where lower(product_name) = 'product-c055587c61b173b35d2b47d6b6613089';


create index orders_exp_index on orders (lower(product_name));


create index orders_partial_index on orders (product_name) where user_id < 1000;

explain analyze
select *
from orders
where user_id < 1000
  and product_name = 'Product-dde50c67d275ce371f34ed2ec856c12e';

