-- SQL JOINS and UNION

show databases;
use mydatabase;
use salesdb;
show tables;

select * from customers where country != 'Germany' or score > 700;
select * from customers where country != 'Germany' and score > 700;

select * from customers where score between 100 and 500;
select * from customers where country in (select country from customers where country != 'USA');
select * from customers where country not in (select country from customers where country != 'USA');  -- in wont work if country has null

-- LIKE operator (To match the Strings)
select * from customers where country like 'U%'; -- Anything starting with U
select * from customers where country like '%A'; -- Anything Ending with A 
select * from customers where country like '%er%'; -- Anything which has in between er
select * from customers where first_name like '___t%'; -- no of _ indicates position

-- SQL Joins (Combining based on coloumns)
select * from customers c inner join orders o on c.id = o.customer_id; -- Inner join
select * from customers c left join orders o on c.id = o.customer_id union -- Left join
select * from customers c right join orders o on c.id = o.customer_id; -- Right join
select * from customers c left join orders o on c.id = o.customer_id where o.customer_id is null union-- Left anti join (only left)
select * from customers c right join orders o on c.id = o.customer_id where c.id is null; -- right anti join (only right)
select * from customers c left join orders o on c.id = o.customer_id where o.customer_id is not null;
select * from customers c cross join orders o;

-- (USE SALESDB)
select c.firstname, o.orderid, p.product, o.sales, p.price, e.firstname from customers c right join orders o on o.customerid = c.customerid left join products p on o.productid = p.productid left join employees e on o.salespersonid = e.employeeid;
select * from employees;
select * from orders;
select * from orders_archive;
select * from products;

-- SQL SET OPERATIONS (Combining 2 tables one after the other)

-- UNION 
select * from customers union select * from orders; -- One table followed by another  table
-- While using union the number of coloumns must be the same and preferably same coloumns for making a union
-- union will remove the duplicate datas 
-- coloumn name will take name from first table 

insert into orders (order_id, customer_id, order_date, sales) values (1005, 7, '2021-09-30',12);
-- We can use order by only once in a query

-- UNION all (Same as Union and also include duplicates)
select firstname,lastname from employees union all
select firstname,lastname from customers;

select firstname, lastname from employees where firstname in (select firstname from customers);
select firstname, lastname from employees e where e.lastname not in (select lastname from customers);
select lastname from customers;
select lastname from employees where lastname  in (select lastname from customers where lastname is not null);

select orderid from orders where orderid not in (
select orderid from orders_archive where orderid is not null) order by orderid asc;


