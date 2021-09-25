-- 1. Drop column picture from staff.
alter table sakila.staff
drop column picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
-- Update the database accordingly.
select * from sakila.customer where first_name = 'Tammy';
select * from sakila.staff;
insert into sakila.staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
values (3,'Tammy','Sanders',79,'TAMMY.SANDERS@sakilacustomer.org',2,1,'Tammy',null,SYSDATETIME());


-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. 
select * from sakila.rental;
-- You can query those pieces of information. 
-- For eg., you would notice that you need customer_id information as well. 
-- To get that you can use the following query:
 select customer_id from sakila.customer
 		where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- 		Use similar method to get inventory_id, film_id, and staff_id.
 select film_id from sakila.film
 		where title = "Academy Dinosaur";
 select inventory_id from sakila.inventory
 		where film_id = 1;
        select * from sakila.inventory;
        select * from sakila.staff;
 select store_id from sakila.staff
 		where first_name = 'Mike';
insert into sakila.rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
values (current_timestamp, 1, 130, null, 1, current_timestamp);
select * from sakila.rental where customer_id = 130;


-- 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

-- 		 Check if there are any non-active users
select * from sakila.customer where active <>1;
select customer_id, email, current_timestamp as deleted_date from sakila.customer where active <>1 ;

-- 		 Create a table backup table as suggested
drop table if exists deleted_users;

create table sakila.deleted_users(
customer_id int(11) unique not null,
email varchar(100) default null,
deleted_date datetime
);

-- 		 Insert the non active users in the table backup table
insert into sakila.deleted_users
select customer_id, email, current_timestamp as deleted_date from sakila.customer
where active <> 1;

select * from sakila.deleted_users;

-- 		 Delete the non active users from the table customer
create table sakila.customer_test like sakila.customer;
insert into sakila.customer_test select * from sakila.customer;
select * from sakila.customer_test;
delete from sakila.customer_test where active <>1;
select * from sakila.customer_test where active <>1;