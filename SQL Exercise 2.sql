create database org;
show databases;
use org;

create table worker (
	worker_id integer not null primary key auto_increment,
    first_name char(25),
    last_name char(25),
    salary numeric(15),
    joining_date datetime,
    department char(25)
);

insert into worker
(first_name, last_name, salary, joining_date, department) values
('Monika', 'Arora',100000 ,'21-01-20 09:00:00','HR'),
('Niharika', 'Verma', 80000,'21-06-11 09:00:00','Admin'),
('Vishal', 'Singhal', 300000,'21-02-20 09:00:00','HR'),
('Mohan', 'Sarah', 300000,'12-03-19 09:00:00','Admin'),
('Amitabh', 'Singh',500000 ,'21-02-20 09:00:00','Admin'),
('Vivek', 'Bhati', 490000,'21-06-11 09:00:00','Admin'),
('Vipul', 'Diwan', 200000,'21-06-11 09:00:00','Account'),
('Satish', 'Kumar', 75000,'21-01-20 09:00:00','Account'),
('Geetika', 'Chauhan', 90000,'21-04-11 09:00:00','Admin');

create table bonus (
	worker_ref_id integer,
    bonus_amount numeric(10),
    bonus_date datetime,
    foreign key (worker_ref_id) references worker(worker_id)
);

-- Task 1
insert into bonus 
(worker_ref_id, bonus_amount, bonus_date) values
(6, 32000, '21-11-02 09:00:00'),
(6, 20000, '22-11-02 09:00:00'),
(5, 21000, '21-11-02 09:00:00'),
(9, 30000, '21-11-02 09:00:00'),
(8, 4500, '22-11-02 09:00:00');


-- Task 2
with highest_salary as (
	select w.salary
    from worker w        
    order by w.salary desc
    limit 1
)

select max(w.salary)
from worker w
where w.salary < (select hs.salary from highest_salary hs);

-- Task 3

with highest_salary2 as (
	select w.salary
    from worker w        
    order by w.salary desc
    limit 1
)
select concat(w.first_name, ' ', w.last_name) as 'employee name'
from worker w
where w.salary = (select hs.salary from highest_salary2 hs);

-- Task 4
with samesalary as (select w.salary
from worker w
group by w.salary
having count(1) > 1
)

select concat(w.first_name, ' ', w.last_name) as 'employee name', w.salary
from worker w
where w.salary in (select ss.salary from samesalary ss);

-- Task 5
select concat(w.first_name, ' ', w.last_name) as 'employee name', w.salary, b.bonus_amount, b.bonus_date
from worker w 
left join bonus b on w.worker_id = b.worker_ref_id
where b.bonus_date between '2021-01-01 00:00:00' and '2021-12-31 23:59:59'
or b.bonus_date is null
;

-- Task 6
Truncate table worker;
-- Because the column "worker_id" is a foreign key of table bonus,
-- the data in table worker cannot be deleted as long as the bonus table contain data with the foreign key.

-- Task 7
drop table worker;
-- Because the column "worker_id" is a foreign key of table bonus,
-- the table worker cannot be dropped as long as the bonus table contain data with the foreign key.