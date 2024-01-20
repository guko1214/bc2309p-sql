create database bootcamp_exercise1;

use bootcamp_exercise1;

create table regions (
	region_id INT PRIMARY KEY,
    region_name VARCHAR(25)
);

create table countries (
	country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR(40),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id) 
);

create table locations (
	location_id INT PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12),
    country_id CHAR(2),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

create table departments (
	department_id INT PRIMARY KEY,
    department_name VARCHAR(30),
    manager_id INT,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

create table jobs (
	job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(35),
    min_salary DECIMAL(12,2),
    max_salary DECIMAL(12,2)
);

create table job_history (	
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT es PRIMARY KEY (employee_id, start_date)    
);

create table employees (
	employee_id INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(25),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(12,2),
    commission_pct DECIMAL(5,2),
    manager_id INT,
    department_id INT,
    FOREIGN KEY (employee_id) REFERENCES job_history(employee_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


truncate table regions;
truncate table countries;
truncate table locations;

select * from regions;
select * from countries;
select * from locations;

select * from employees;

insert into regions(region_id, region_name) values(1, 'europe');
insert into regions(region_id, region_name) values(2, 'north america');
insert into regions(region_id, region_name) values(3, 'asia');

insert into countries(country_id, country_name, region_id) values('DE', 'Germany',1);
insert into countries(country_id, country_name, region_id) values('IT', 'Italy',1);
insert into countries(country_id, country_name, region_id) values('JP', 'Japan',3);
insert into countries(country_id, country_name, region_id) values('US', 'United State',2);

insert into locations(location_id, street_address, postal_code, city, state_province, country_id)
			values(1000, '1297 Via Cola di Rie', 989,'Roma', null,'IT');
insert into locations(location_id, street_address, postal_code, city, state_province, country_id)
			values(1100, '93091 Calle della Te', 10934,'Venice', null,'IT');
insert into locations(location_id, street_address, postal_code, city, state_province, country_id)
			values(1200, '2017 Shinjuku-ku', 1689,'Tokyo', 'Tokyo','JP');
insert into locations(location_id, street_address, postal_code, city, state_province, country_id)
			values(1400, '2014 Jabberwocky Rd',26192 ,'Southlake', 'Texas','US');            

insert into departments(department_id, department_name, manager_id, location_id)
			values(10, 'Adminstration',200,1100);
insert into departments(department_id, department_name, manager_id, location_id)
			values(20, 'Marketing',201,1200);
insert into departments(department_id, department_name, manager_id, location_id)
			values(30, 'Purchasing',202,1400);
insert into departments(department_id, department_name, manager_id, location_id)
			values(40, 'Information Technology',203,1400);
            
insert into jobs(job_id, job_title, min_salary, max_salary)
			values('IT_PROG','iT Programmer', 17000, 20000);
insert into jobs(job_id, job_title, min_salary, max_salary)
			values('MK_REP', 'Marketing Representative',9000,17000);
insert into jobs(job_id, job_title, min_salary, max_salary)
			values('ST_CLERK', 'Store Clerk',16000,24000);
insert into jobs(job_id, job_title, min_salary, max_salary)
			values('AD_AST', 'Administrative Assistant',15000,20000);
insert into jobs(job_id, job_title, min_salary, max_salary)
			values('MAGR', 'Manager',28000,40000);

insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(100,'1989-09-21','1993-10-27','MK_REP',20);            
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(101,'1993-01-13','1998-07-24','IT_PROG',40);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(100,'1993-10-28','1997-03-15','ST_CLERK',30);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(102,'1996-02-17','1999-12-19','AD_AST',10);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(103,'1998-03-24','1999-12-31','MK_REP',20);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(104,'2000-01-20',null,'IT_PROG',40);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(105,'2000-08-28',null,'ST_CLERK',30);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(106,'2001-02-11',null,'AD_AST',10);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(107,'2001-03-24',null,'MK_REP',20);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(200,'2003-01-20',null,'MAGR',40);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(201,'2003-01-28',null,'MAGR',30);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(202,'2003-03-11',null,'MAGR',10);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
			values(203,'2003-03-12',null,'MAGR',20);

insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
			values(104,'Steven','King','SKING','515-1234567','2000-01-20','IT_PROG',20000,0.00,203,40);
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
			values(105,'Neena','Kochhar','NKOCHHAR','515-1234568','2000-08-28','ST_CLERK',24000,0.00,202,30);
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
			values(106,'Lex','De Haan','LEDHAAN','515-1234569','2001-02-11','AD_AST',20000,0.00,200,10);
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
			values(107,'Alexander','Hunold','AHUNOLD','590-4234567','2001-03-24','MK_REP',17000,5.00,201,20);
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
			values(200,'John','Wall','JOHNWAL','590-4238977','2003-01-20','MAGR',32000,0.00,200,10);
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
			values(201,'Austin','Rivers','AUSTRIV','590-4232967','2003-01-28','MAGR',40000,5.00,201,20);
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
			values(202,'Jerry','West','JERRYWEST','590-4239972','2003-03-11','MAGR',28000,0.00,202,30);
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
			values(203,'Kelvin','Davis','KELVDAV','590-4237975','2003-03-12','MAGR',30000,0.00,203,40);
            
-- 3. Write a query to find the location_id, street_address, city, state_province, country_name of locations
select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from locations l, countries c
where l.country_id = c.country_id;

-- 4. Write a query to find the first_name, last_name, department_id, of all the employees
 select e.first_name, e.last_name, e.department_id
 from employees e;
 
-- 5. Write a query to find the first_name, last_name, job_id, department ID of the employees who work in japan
select e.first_name, e.last_name, e.job_id, e.department_id
from employees e
inner join departments d on e.department_id = d.department_id
inner join locations l on d.location_id = l.location_id
inner join countries c on l.country_id = c.country_id
where c.country_name = 'Japan';

-- 6 Write a query to find the employee id, last_name along with their manager_id and last name.
select e.employee_id, concat(e.last_name, e.manager_id), e.last_name
from employees e;

-- 7. Write a query to find the first_name, last_name, and hire date of the employees who was hired after employee 'Lex De Haan'.
select e.first_name, e.last_name, e.hire_date
from employees e
where e.hire_date > (select e.hire_date from employees e where concat(e.first_name, ' ', last_name) = 'Lex De Haan' limit 1);

-- 8. Write a query to get the department name and number of employees of each the department. 
select d.department_name, count(1)
from employees e, departments d
where e.department_id = d.department_id
group by d.department_name;

-- 9. Write a query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department ID 30.
select jh.employee_id, j.job_title, datediff(jh.end_date , jh.start_date)
from job_history jh, jobs j
where jh.job_id = j.job_id
and jh.department_id = 30;

-- 10. Write a query to display all departmemt name, manager name, city and country name
select d.department_name, concat(e.first_name, ' ', e.last_name) as 'manager name', l.city, c.country_name
from employees e
inner join departments d on e.employee_id = d.manager_id
inner join locations l on d.location_id = l.location_id
inner join countries c on l.country_id = c.country_id;

-- 11. Write a query to display the average salary of each department
select d.department_name, avg(e.salary) as 'average salary'
from employees e, departments d
where e.department_id = d.department_id
group by d.department_name

-- 12. Now, we try to perform normalization on table 'jobs'.

-- a. How do you re-design the table 'jobs'? and adding table 'job_grades'?

-- Remove min_salary and max_salary from 'jobs'
-- add grade_level to 'jobs' as foreign key reference to 'job_grades'