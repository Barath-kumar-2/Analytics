-- SQL (CTE)

show databases;
use mydatabase;
use salesdb;
show tables;

-- ADDITIONAL
select * from customers;
select * from orders;


-- STANDALONE CTE
with temp as (
	select *, sum(sales) over(partition by customerid) as total from orders -- CANNOT USE ORDERBY INSIDE CTE
)
select distinct t.total, c.* from temp t right join customers c on t.customerid = c.customerid;

-- Mulitple standalone cte
with temp as (
	select *, sum(sales) over(partition by customerid) as total from orders -- CANNOT USE ORDERBY INSIDE CTE
),
temp2 as (
select customerid, orderid, max(orderdate)  over(partition by customerid) as last from orders
)
select distinct t.total, c.*, temp2.last from temp t right join customers c on t.customerid = c.customerid left join temp2 on temp2.customerid = c.customerid;

-- NESTED CTE
with t1 as (
select distinct customerid, sum(sales) over(partition by customerid) as total from orders)
, t2 as (select distinct customerid, max(orderdate) over(partition by customerid) as last from orders)
, t3 as(
select t1.*, case when total > 100 then "High" when total > 50 then "Medium" else "Low" end as category from t1)
select t1.*, rank() over(order by total desc) as rk, t2.last, t3.category from t1 left join t2 on t1.customerid = t2.customerid left join t3 on t3.customerid = t1.customerid;

-- RECURSIVE CTE

	
