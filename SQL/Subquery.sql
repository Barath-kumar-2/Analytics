-- SQL (Subqueries) 

show databases;
use mydatabase;
use salesdb;
show tables;

-- ADDITIONAL
select * from products where price > (select avg(price) from products);
select * from customers;
select * from customers where score is not null order by score desc;
select p.productid, p.product, p.price, count(*) from products p inner join orders o where p.productid = o.productid group by p.productid, p.product, p.price;
select * from products;
select * from orders;
select customerid, sum(sales) as total from orders group by customerid;
select *, rank() over(order by total desc) from (select customerid, sum(sales) as total from orders group by customerid) as t;

-- SUB QUERY IN SELECT 
select productid, product, price, (select count(*) from products) as total from products;

-- SUB QUERY IN JOINS
select c.*, ifnull(t1.ck,0) as total from customers c left join (
select customerid, count(orderid) as ck from orders group by customerid) t1 on c.customerid = t1.customerid;

-- SUB QUERY IN WHERE
select price from products where price > (select avg(price) from products);
select * from orders where customerid in (select customerid from customers where country != 'Germany');
select * from employees where gender = 'F' and salary > (select min(salary) from employees where gender = 'M');
select * from employees where gender = 'F' and salary > (select max(salary) from employees where gender = 'M');

-- CORRELATED AND NON CORRELATED SUBQUERY
select c.*, ifnull(t.count,0) as count from customers c left join (
select customerid, count(orderid) as count from orders group by customerid) as t on c.customerid = t.customerid order by customerid;

	
