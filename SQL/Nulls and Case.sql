-- SQL (NULLS & CASE)

show databases;
use mydatabase;
use salesdb;
show tables;

-- Additional
select * from customers;
select * from orders;
select * from products;
select * from employees;
select billaddress from orders;

-- NULL 
SELECT orderid, ifnull(shipaddress, 'n/a') FROM ORDERS;
select orderid, (billaddress), shipaddress, coalesce(billaddress, shipaddress, 'n/a') from orders;
select billaddress, quantity, nullif(quantity,1) from orders; 
select * from customers where score is null;

select avg(score), avg(nullif(score,0)), avg(ifnull(score,0)) from customers; -- (Aggregate functinos will not work properly with NULL)
select customerid, concat(firstname,ifnull(lastname,'')) as name, (ifnull(score,0)+10) as updatedscore from customers;

-- Arithmetic operation with null results in null
select score from customers order by score desc; -- By default null is assigned the lowest value
select score, case when score is null then 1 else 0 end as flag from customers order by flag asc, score asc;

select o.orderid, (o.sales/o.quantity)* p.price as q from orders o inner join products p on o.productid = p.productid group by orderid order by orderid asc  ;
select c.customerid, c.firstname from customers c left join orders o on c.customerid = o.customerid where o.orderid is null;

-- CASE Statements
select case when sales > 50 then 'High' when sales > 20 then 'Medium' else 'Low' end as Category, sum(sales) from orders group by case when sales > 50 then 'High' when sales > 20 then 'Medium' else 'Low' end order by sum(sales) desc;
-- All values in the case statement must be of same data type

select *, case when gender = 'M' then 'MALE' else 'FEMALE' end as gender from employees;
select customerid,  sum(case when sales > 30 then 1 else 0 end) as sum from orders  group by customerid order by customerid;
