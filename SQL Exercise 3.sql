-- Question 1a

create database bootcamp_exercise3;

use bootcamp_exercise3;

create table city(
	id int auto_increment,
    name varchar(128) not null,
    constraint pk_city primary key (id)
);

create table customer(
	id int auto_increment,
    customer_name varchar(255) not null,
    city_id int not null,
    customer_address varchar(255) not null,
    contact_person varchar(255),
    email varchar(128) not null,
    phone varchar(128) not null,
    constraint pk_customer primary key (id),
    constraint fk_customer foreign key(city_id) references city(id)
);

create table product(
	id int auto_increment,
    sku varchar(32) not null,
    product_name varchar(128) not null,
    product_description text not null,
    current_price decimal(8,2) not null,
    quantity_in_stock int not null,
    constraint pk_product primary key (id)    
);


create table invoice(
	id int auto_increment,
    invoice_number varchar(255) not null,
    customer_id int not null,
    user_account_id int not null,
    total_price decimal(8,2) not null,
    time_issued datetime,
    time_due datetime,
    time_paid datetime,
    time_canceled datetime,
    time_refunded datetime,
    constraint pk_invoice primary key (id),
    constraint fk_invoice foreign key (customer_id) references customer(id)
);

create table invoice_item(
	id int auto_increment,
    invoice_id int not null,
    product_id int not null,
    quantity int not null,
    price decimal(8,2) not null,
    line_total_price decimal(8,2) not null,
    constraint pk_invoice_item primary key (id),
    constraint fk_invoice_item1 foreign key (invoice_id) references invoice(id),
    constraint fk_invoice_item2 foreign key (product_id) references product(id)
);

-- Question 1b

delete from city;
insert into city
(name) values
('City1'),
('City2'),
('City3'),
('City4');

delete from customer;
insert into customer
(id, customer_name, city_id, customer_address, contact_person, email, phone) values
(1,'Drogerie Wien',1,'Deckergasse 15A','Emil Steinbach','abc@gmail.com',123455678),
(2,'John',4,'Deckergasse 1A','9upper','abck@gmail.com',12345567),
(3,'Mary',3,'Deckergasse 18A','9upper','abcd@gamil.com',123456789);


delete from product;
insert into product 
(id, sku, product_name, product_description, current_price, quantity_in_stock) values
(1, '330120', '9UP PRODUCT', 'COMPLETELY 9UP', 60,122),
(2,'330121','9UPPER PRODUCT', 'COMPLETELY 9UPPER', 50,50),
(3, '330122','9UPPER PRODUCTS','SUPER 9UPPER',40,600),
(4, '330123','9UPPER PRODUCTSS','SUPER COMPLETELY 9UPPER',30, 500);
 
delete from invoice;
insert into invoice values
(1, 123456780,2,41,1423,NULL, NULL,null, null,null),
(2,123456780 ,3,42,1400,NULL, NULL,null, null,null),
(3, 123456780,2,43,17000,NULL, NULL,null, null,null);

delete from invoice_item;
insert into invoice_item values
(1,1,1,40,23,920),
(2,1,2,4,20,80),
(3,1,3,4,10,40),
(4,1,2,4,30,120);

-- Question 1c

select 'customer', c.id, c.customer_name
from customer c
left join invoice i on c.id = i.customer_id
where i.id is null
union 
select 'product',p.id ,p.product_name
from product p
left join invoice_item it on p.id = it.product_id
where it.id is null;

-- Question 2

create table employee (
	id integer not null auto_increment primary key,
    employee_name varchar(30) not null,
    salary numeric(8,2),
    phone numeric(15),
    email varchar(50),
    dept_id integer not null
);

create table department (
	id integer not null auto_increment primary key,
    dept_code varchar(3) not null,
    dept_name varchar(200) not null
);

delete from employee;
insert into employee values(1,'JOHN',20000,90234567,'JOHN@GMAIL.COM',1);
insert into employee values(2,'MARY',10000,90234561,'MARY@GMAIL.COM',1);
insert into employee values(3,'STEVE',30000,90234562,'STEVE@GMAIL.COM',3);
insert into employee values(4,'SUNNY',40000,90234563,'SUNNY@GMAIL.COM',4);

delete from department;
insert into department values(1,'HR','HUMAN RESOURCES');
insert into department values(2,'9UP','9UP DEPARTMENT');
insert into department values(3,'SA','SALES DEPARTMENT');
insert into department values(4,'IT','INFORMATION TECHNOLOGY DEPARTMENT');

-- 2a) find the number of employees in each department

select d.dept_code, count(e.id)
from department d
left join employee e on d.id = e.dept_id
group by d.dept_code
order by count(e.id) desc, d.dept_code;

-- 2b) is your SQL in 2a still working after inserting the following data? If not, why?
-- Please insert the following data into department

delete from department where id = 5;
insert into department values (5,'IT', 'INFORMATION TECHNOLOGY DEPARTMENT');

-- It is not working. 
-- The department code is indistinguishable between department with id 4 and 5.
-- Since d.dept_code is used in group by, the employees is count is counted together in one row
-- instead of counted separately in two row