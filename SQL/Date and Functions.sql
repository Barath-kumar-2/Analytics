-- SQL Functions (String , Number, Date)

show databases;
use mydatabase;
use salesdb;
show tables;

-- Additional
select * from customers;
insert into customers (id, first_name, country, score) values (6, '  Barath kumar   ', 'India',100);
select replace(first_name, ' ','*') from customers;
alter table customers add email varchar(50) unique;
update customers set email ='jos@gmail.com' where customerid = 1;
select * from orders;
select * from employees;

-- STRING Functions
select customerid, concat(firstname,' ', country, '%'), score from customers;
select lower(firstname) from customers;
select upper(firstname) from customers;
select firstname, length(firstname) from customers;
select first_name from customers where first_name not in (select trim(first_name) from customers); -- To find whether name has space or not
select substring(email, 1,3) as part from customers where substring(email,1,3) is not null;
select substring(firstname,2) from customers ;
select left(email,3) from customers;
select right(email,3) from customers;

-- NUMBER Functions
select 3.1412, round(3.1412,2), round(3.1412,1) ;
select -3.14 , abs(-3.14);

-- DATE & TIME functions
select curdate();
select orderid, orderdate, shipdate, creationtime, now() from orders;
select day(orderdate), month(orderdate), year(orderdate), orderdate from orders;
select orderdate, monthname(orderdate), dayname(orderdate), last_day(orderdate) from orders;
select count(*), monthname(orderdate) from orders where month(orderdate) = 2 group by monthname(orderdate); 
select quarter(orderdate), count(*) from orders group by quarter(orderdate);
select creationtime, date_format(creationtime, "%Y-%y-%m-%M-%d-%W-%H-%i-%s PM") from orders;
select date_format(orderdate, "'%y-%M") , count(*) from orders group by date_format(orderdate, "'%y-%M");

-- CAST 
select cast(orderid as signed) from orders;
SELECT CAST(100 AS CHAR);
select cast(50 as decimal);
SELECT CAST('2025-02-27 14:30:00' AS DATETIME);
select cast(creationtime as date) from orders;

-- ADDITION and SUBTRACTION of DATES
select date_add(orderdate,INTERVAL 1 year), orderdate from orders;
select date_add(orderdate,INTERVAL 2 month), orderdate from orders;
select date_add(orderdate,INTERVAL 4 day), orderdate from orders;
select date_sub(orderdate, INTERVAL 3 month), orderdate from orders;
select orderdate, shipdate, datediff(orderdate,shipdate) from orders;
select * from orders where datediff(curdate(),orderdate) <= 30;
select employeeid, birthdate,year(curdate())-year(birthdate) as age from employees where year(curdate())-year(birthdate) > 40;
select month(orderdate), avg(datediff(shipdate,orderdate)) from orders group by month(orderdate);