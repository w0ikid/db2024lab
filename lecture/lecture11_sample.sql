insert into;

update;



begin;
--statements
rollback;
--statements
commit;



begin;
select *
from actor
where actor_id = 150;
update actor
set first_name='New name'
where actor_id = 150;
select *
from actor
where actor_id = 150;
rollback;
select *
from actor
where actor_id = 150;
update actor
set first_name='New name2'
where actor_id = 150;
select *
from actor
where actor_id = 150;
commit;


select *
from actor
where actor_id = 150;
rollback;


begin;
select *
from actor
where actor_id = 152;

update actor
set first_name='New name'
where actor_id = 152;

select *
from actor
where actor_id = 152;

rollback;
select *
from actor
where actor_id = 150;
update actor
set first_name='New name2'
where actor_id = 150;
select *
from actor
where actor_id = 150;
commit;







begin transaction isolation level read uncommitted;
select * from actor where actor_id=180;
select * from actor where actor_id=180;
select * from actor where first_name='asd';
commit;





begin transaction isolation level read committed read only;
select * from actor where actor_id=135;
update actor set first_name='New name' where actor_id=135;
select * from actor where actor_id=135;
commit;



select * from actor where actor_id=135;



begin;
select * from actor where actor_id=134;
update actor set first_name='New name' where actor_id=134;
select * from actor where actor_id=134;
savepoint my_savepoint;
update actor set first_name='New name2' where actor_id=134;
select * from actor where actor_id=134;
rollback to savepoint my_savepoint;
select * from actor where actor_id=134;
release savepoint my_savepoint;
commit;