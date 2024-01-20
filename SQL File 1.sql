-- it is notation to mark comment
use sys; -- login in database

drop database students;

create table students (
	student_id INT PRIMARY KEY, -- integer, Primary key: The values in this column must be unique
    first_name VARCHAR(50), -- string
    last_name VARCHAR(50), -- string
    birth_date DATE, -- LocalDate
    gpa DECIMAL(3, 2), -- double
    is_active BOOLEAN -- boolean
);

select * from students;

-- Insert Approach 1: with column name; You can skip value by this approach 
insert into students (student_id, first_name, last_name, birth_date, gpa, is_active)
	values(1,'John','Wong','2000-12-23',3.23,true);
    
insert into students (student_id, first_name, last_name, birth_date, gpa, is_active)
	values(2,'Michael','Chan','2000-01-17',4.00,true);
    
insert into students (student_id, first_name, last_name, birth_date, gpa, is_active)
	values(3,'Mary','Lee','2001-09-07',3.76,true);
    
insert into students (student_id, first_name, last_name, birth_date, gpa, is_active)
	values(4,'Tommu','Chan','2001-09-07',3.76,true);

insert into students (student_id, first_name, birth_date, gpa, is_active)
	values(5,'Sally','2000-07-07',3.76,true);
    
-- Approach 2: without column name

insert into students values(4,'Peter','Chan','2000-02-23',3,false);

-- Update
update students set gpa = 3.67 WHERE first_name = 'John';

create table students2 (
	student_id INT PRIMARY KEY, -- integer, Primary key: The values in this column must be unique
    first_name VARCHAR(50), -- string
    last_name VARCHAR(50), -- string
    birth_date DATE, -- LocalDate
    gpa DECIMAL(3, 2), -- double
    is_active BOOLEAN -- boolean
);

-- truncate, remove all data from the table
truncate table students2;
-- DISTINCT

insert into students2 (student_id, first_name, last_name, birth_date, gpa, is_active)
		values(1 , 'John', 'Wong', '2000-12-23',3.23, false);
insert into students2 (student_id, first_name, last_name, birth_date, gpa, is_active)
		values(2,'John', 'Lau', '2000-11-23', 2.0,true);
insert into students2 (student_id, first_name, last_name, birth_date, gpa, is_active)
		values(3, 'Mary', 'Lau', '2000-11-23',2.0,true);
select distinct first_name from students2; -- 

-- count() is to count the numer of rows of result set
select count(first_name) from students2; -- 3
select count(student_id) from students2; -- 3
select 1 from students2; -- 3
select count(1) from students2; -- 3
select 10 from students2 where gpa >= 2.0; -- return 3 rows (with a column value 10)
select count(10) from students2 where gpa > 3.0; -- 1
select count(10) from students2 where gpa > 2.0; -- 1

-- alter table add
alter table students2 add column JOIN_DATE date;
-- update -- 1990 Jan 01
update students2 set join_date = '1990-01-01';
select * from students2;

insert into students2 (student_id, first_name, last_name, birth_date, gpa, is_active, join_date)
		values(4, 'Jenny', 'Lau', '2000-11-23',2.0,true,'2000-12-31');
insert into students2 (student_id, first_name, last_name, birth_date, gpa, is_active, join_date)
		values(5, 'Peter', 'Chan', '2000-11-23',2.0,true,'2005-10-20');        

-- between and
select * from students2 where join_date between '2000-12-31' and '2006-12-31'; -- inclusive
select * from students2 where join_date >= '2000-12-31' and join_date <= '2006-12-31'; -- same criteric

-- upper, lower
select upper(first_name) as upper_first_name, last_name, lower(last_name) as LOWER_LAST_NAME from students2;
select upper(s.first_name) as ufn, upper(s.last_name) as uln, s.* from students2 s;

-- Crossover: upper() vs count()
-- upper() cannot be used with count() at the same time,
-- count() is an aggregated function
select upper(first_name), count(first_name) from students2;
select upper(first_name), count(first_name) from students2;

-- avg(), aggregation function
select * from students2;
select avg(gpa) from students2;
select avg(gpa) from students2 where join_date >= '1990-01-01' and join_date <= '2005-10-15';
select avg(gpa) from students2 where join_date >= '2000-01-01' and join_date <= '2005-10-20';
select avg(gpa) as average_gpa, count(1) numer_of_students from students2;

-- min(), max(), aggregation function
select min(gpa) as min_gpa from students2;
select avg(gpa) as average_gpa, count(1) numer_of_students, min(gpa) as min_gpa, max(gpa) as max_gpa from students2;
select max(gpa) as max_gpa from students2;

-- Find the first_name and last_name of the person who has min. gpa
-- select first_name, last_name from students2 order by gpa limit 1;
insert into students2 (student_id, first_name, last_name, birth_date, gpa, is_active, join_date)
		values(6, 'Sally', 'Chan', '2000-11-23',1.5,true,'2005-10-20');    
select first_name, last_name from students2 where gpa = (select min(gpa) from students2); -- return Sally

-- length(), concat()
select length(first_name) as lenght_of_first_name
, first_name
, concat(first_name, ' ', last_name) as full_name
, length(concat(first_name, ' ', last_name)) as length_full_name
 from students2;
 
 -- instr() [1...n], notfound: 0
 -- java: indexOf() [0...n], notfound: -1
 -- Mysql: by default ignore case
 select s.first_name
 ,instr(s.first_name, 'J') -- 1st occurence index of the 'J'
 ,instr(s.first_name, 'a') -- 1st occurence index of the 'J'
 ,instr(s.first_name, 'j') -- 1st occurence index of the 'J'
 , instr(s.first_name,'Jenny') > 0 as is_jenny
 from students2 s;
 
 -- non-aggregated functions can be used in select clause and where clause
 select * from students2 where length(first_name) < 5;
 select * from students2 where concat(first_name, ' ', last_name) = 'John Wong';
 -- We can re-calculate the value of the result set
 select gpa * 1.1 from students2 where concat(first_name, ' ', last_name) = 'John Wong';
 
 -- LIKE %
 select * from students where concat(first_name, ' ', last_name) like '%Wong'; -- Any character(s) is allowed to match the pattern

-- update students2 set last_name = 'aaabbbsss' 
 insert into students2 (student_id, first_name, last_name, birth_date, gpa, is_active, join_date)
		values(7, 'abcabc', 'aaabbbsss', '2000-11-23',1.5,true,'2005-10-20');
insert into students2 (student_id, first_name, last_name, birth_date, gpa, is_active, join_date)
		values(8, 'abcdefabc', 'aaasss', '2000-11-23',2.0,true,'2005-10-20');
insert into students2 (student_id, first_name, last_name, birth_date, gpa, is_active, join_date)
 values (9, 'abcdefabc', 'faaasssf', '2000-11-23', 2.0, true, '2005-10-20');
 
select * from students2 where last_name like 'aaa%sss';
select * from students2 where last_name like '%aaasss';
select * from students2 where last_name like '%aaa%sss%';

-- not equals: <> or != 
select * from students2 where last_name <> 'Wong'; -- perferable <>, more product support
select * from students2 where last_name != 'Wong'; -- not all sql product support !=, not recommond
select * from students2 where NOT last_name = 'Wong'; -- not recommond

-- 'is null' or 'is not null' in where clause
insert into students2 (student_id, first_name, last_name, birth_date, gpa, is_active, join_date)
 values (10, 'Eric', 'Chan', null, 2.0, true, '2005-10-20');
 
select * from students2 where birth_date is null;
select * from students2 where birth_date is not null;

-- distinct multiple column
select s.*  from students2 s;
select distinct join_date, birth_date from students2 s;

-- Modify column definition
alter table students2 modify column first_name varchar(100);
-- alter table students2 modify column first_name varchar(4); -- NOT OK, existing records with value > 4
alter table students2 add dummy datetime;
alter table students2 drop column dummy;

-- update students2 -- not support +=
-- set gpa += 0.5;

create table books (
	id integer not null,
    name varchar(100),
    color varchar(10),
    price decimal(7,2) -- 99999.99 is max value you can store
);

select * from books;

truncate table books;

-- 1, 'ABC', 'RED', 10.0
-- 2, 'BCD', 'RED', 20.5
-- 3, 'AAA', 'YELLOW', 40.9
-- 4, 'DDD', 'BLUE', 5.3
insert into books(id, name, color, price)
	values(1,'ABC', 'RED',10.0);
insert into books(id, name, color, price)
	values(2, 'BCD', 'RED',20.5);
insert into books(id, name, color, price) values(3,'AAA','YELLOW',40.9);
insert into books(id, name, color, price) values(4, 'DDD', 'BLUE', 5.3);
insert into books(id, name, color, price) values(5, 'EEE', 'BLACK',89.4);

-- GROUP BY
-- 1. The number of record in the result set based on how many group was formed final
-- 2. When you use "group by", you can only select the "group" as the column(s) as well as aggregated function
select color, count(1) from books group by color;
select color, count(1), avg(price), max(price), avg(id) from books group by color;

-- Aggrated fuinctions: sum(), avg(), max(), min(), count()
select avg(price), sum(price) / count(1) from books;

-- WHERE -> GROUP BY
select color, count(1) from books where color in ('RED','BLUE') group by color;

-- WHERE -> GROUP BY -> HAVING
-- HAVING: after the grouping, you add another criteria to filter out some of the group
select color, avg(price) 
from books
where color in ('RED','BLEU')
group by color
having count(1) >= 2;

-- Find the color of the book, where color group of the book with average price > 10.0
-- After grouping, you can filter the records inside the group
-- You can only filter out the whole group(s)
select color, avg(price), count(1)
from books
group by color
having avg(price) > 10.0;

-- JOIN (CUSTOMER1, ORDER1, ITEM1)and

create table customer1 (
	id integer primary key,
    c_name varchar(50) not null,
    email varchar(40),
    phone varchar(20)
);

create table order1 (
	id integer primary key,
    order_date datetime not null,
	delivery_address varchar(100),
    order_amount decimal(10,2),
    customer_id integer,
    foreign key (customer_id) references customer1(id) 
    -- Constriant: ensure the customer_id (order1) exists in customer1 table's id
);

create table item1 (
	id integer primary key,
    item_desc varchar(100) not null,
    item_unit_price decimal(10,2),
    item_quantity integer not null,
    item_amount decimal(10,2),
    order_id integer,
    foreign key (order_id) references order1(id)
    -- ensure the order_id (item1) exists in order1 table's id
);

drop table customer1;
drop table order1;
drop table item1;

-- 2 Customer
-- 2 orders per customer
-- 2 item per orders

insert into customer1(id, c_name, email, phone) values(1, 'John Wall', 'johnwall039@jmail.com','98740983');
insert into customer1(id, c_name, email, phone) values(2, 'Mary Lee', 'marylee@yhmail.com','63759091');

insert into order1(id, order_date, delivery_address, order_amount, customer_id) 
	values(1, '2023-12-04 10:34:09','Flat E, 3/F, 10 Fish Road, Tuen Mun, New Territories, Hong Kong',162.35 ,1);
insert into order1(id, order_date, delivery_address, order_amount, customer_id)     
    values(2, '2023-12-05 11:49:36','Flat B, 16/F, 10 Farmer Road, Tusen Wan, New Territories, Hong Kong', 365.68,2);
insert into order1(id, order_date, delivery_address, order_amount, customer_id)     
    values(3, '2023-12-20 17:28:05','Flat B, 16/F, 10 Farmer Road, Tusen Wan, New Territories, Hong Kong', 214.98,2); 
insert into order1(id, order_date, delivery_address, order_amount, customer_id)     
    values(4, '2023-12-23 21:09:36','Flat E, 3/F, 10 Fish Road, Tuen Mun, New Territories, Hong Kong',226.26 ,1);
    
insert into item1(id, item_desc, item_unit_price, item_quantity, item_amount, order_id)
	-- values(1,'apple',5.99,10, 59.9, 1);
    values(1,'apple',5.99,10, null, 1);
insert into item1(id, item_desc, item_unit_price, item_quantity, item_amount, order_id)
	-- values(2,'milk',20.49,5, 102.45, 1);
    values(2,'milk',20.49,5, null, 1);
insert into item1(id, item_desc, item_unit_price, item_quantity, item_amount, order_id)
	-- values(3,'apple',5.99,20, 119.8, 2);
    values(3,'apple',5.99,20, null, 2);
insert into item1(id, item_desc, item_unit_price, item_quantity, item_amount, order_id)
	-- values(4,'milk',20.49,12, 245.88, 2);
    values(4,'milk',20.49,12, null, 2);
    
insert into item1(id, item_desc, item_unit_price, item_quantity, item_amount, order_id)
	-- values(5,'pork',30.68,3, 92.04, 3);
	values(5,'pork',30.68,3, null, 3);
insert into item1(id, item_desc, item_unit_price, item_quantity, item_amount, order_id)
	-- values(6,'milk',20.49,6, 122.94, 3);    
    values(6,'milk',20.49,6, null, 3);    
insert into item1(id, item_desc, item_unit_price, item_quantity, item_amount, order_id)
	-- values(7,'beef',60.99,2, 121.98, 4);
    values(7,'beef',60.99,2, null, 4);
insert into item1(id, item_desc, item_unit_price, item_quantity, item_amount, order_id)
	-- values(8,'orange',8.69,12, 104.28, 4);
    values(8,'orange',8.69,12, null, 4);
    
truncate table item1;    
drop table item1;
truncate table order1;
drop table order1;
truncate table customer1;
drop table customer1;

update item1 set item_amount = item_unit_price * item_quantity;
select * from customer1;
select * from order1;
select * from item1;

-- join (Inner join)
-- customer - 2 rows
-- order - 4 rows
select c.*, o.* from customer1 c , order1 o; -- 8 rows (4, 2)

-- Approach 1 (inner join)
select c.*, o.*
from customer1 c, order1 o
where c.id = o.customer_id;

-- select c.*, o.*, i.*
select c.id, c.c_name, c.phone, c.email, o.delivery_address, o.order_amount, i.item_desc, i.item_amount
from customer1 c, order1 o, item1 i
where c.id = o.customer_id
and o.id = i.order_id;
-- Approach 2 (inner join)
select c.*, o.*
from customer1 c
inner join order1 o on c.id = o.customer_id;

select c.id, c.c_name, c.phone, c.email, o.delivery_address, o.order_amount, i.item_desc, i.item_amount
from customer1 c 
	inner join order1 o on c.id = o.customer_id
	inner join item1 i on o.id = i.order_id;
    
-- Left Join
insert into customer1(id, c_name, email, phone) 
values(3, 'Jenny Kwan', 'jk01@gmail.com','42310');

-- Find all customers with his order histories, including those who has no orders
-- For those who has no order, you can just leave the order / item data as null
select c.*, o.*
from customer1 c 
	left join order1 o on c.id = o.customer_id;
    
-- select c.*, o.*, i.*
select c.id, c.c_name, c.phone, c.email, o.delivery_address, o.order_amount, i.item_desc, i.item_amount
from customer1 c 
	left join order1 o on c.id = o.customer_id
	left join item1 i on o.id = i.order_id;
    
select c.id, c.c_name, c.phone, c.email, o.delivery_address, o.order_amount, i.item_desc, i.item_amount
from customer1 c, order1 o, item1 i
where (c.id = o.customer_id)
	and o.id = i.order_id;

-- Right Join
select c.*, o.*
from order1 o right join customer1 c on c.id = o.customer_id;


-- Select all customer's, order's, item's data with or without order(s)
-- Approach 1: (
select c.id, c.c_name, c.phone, c.email, o.delivery_address, o.order_amount, i.item_desc, i.item_amount
from customer1 c 
	left join order1 o on c.id = o.customer_id
	left join item1 i on o.id = i.order_id;

-- Approach 2: Sub-query -> Sub-table
select *
from customer1 c left join 
(select o.id, o.customer_id
from order1 o, item1 i
where o.id = i.order_id) as order_item_table
on c.id = order_item_table.customer_id;

-- Approach 3: Common Table Expression (CTE) - Recommended approach
With
	order_item_table as (select o.id as order_id, o.customer_id, o.delivery_address, o.order_amount 
						 from order1 o, item1 i
                         where o.id = i.order_id)

select c.*, oi.*
from customer1 c left join order_item_table oi on c.id = oi.customer_id;


create database bootcamp_exercise1;
use bootcamp_exercise1;

--  Find the name of the customers, who has orders
select *
from customer1 c
where exists (select 1 from order1 d where d.customer_id = c.id);

select *
from customer1 c
where not exists (select 1 from order1 d where d.customer_id = c.id);

-- Find then name of the customer(s), who has 3 or above orders
insert into order1(id, order_date, delivery_address, order_amount, customer_id)     
    values(5, now(),'888888',1000.2 ,2);
select c.c_name, c.id
from customer1 c
-- where exists (select count(1) from order1 d where d.customer_id = c.id group by d.customer_id having count(1) >= 3);
where exists (select count(1) from order1 d where d.customer_id = c.id having count(1) >= 3);

select c.c_name, count(1) as no_of_orders
from customer1 c left join order1 o on c.id = o.customer_id
group by c.id, c.c_name
having count(1) >= 3;

with 
	order_counts as (select o.customer_id, count(1) as no_of_orders
					 from order1 o
					 group by o.customer_id),
                     
	order_item as (select *
					from item1 i
					)
select c.c_name
from customer1 c
where exists (select 1 from order_counts oc where oc.customer_id = c.id and oc.no_of_orders >= 3)
;


CREATE VIEW customr_details
as
select c.id, concat(c_name, ' ', email) as c_info
from customer1 c;

select * from customr_details; -- cannot insert, update delete on a view
-- so, when we insert, update, delete on customer1, the result should reflect in the view as well.

-- update customer_details set 


select * from customr_details; -- cannot insert, update delete on a view
-- so, when we insert, update, delete on customer1, the result should reflect in the view as well.

select * 
from customer1 c
where not exists (select 1 from order1 o where o.customer_id = c.id);