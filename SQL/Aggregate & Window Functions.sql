-- SQL (Aggregate Functions and Window functions)

show databases;
use mydatabase;
use salesdb;
show tables;

-- Additional 
select * from orders;
select * from employees;
select * from orders_archive;
select * from customers;
select productid, sum(sales) from orders group by productid;

-- USE Group by for simple aggregate functions and for complex use window functions
select count(*), sum(sales), avg(sales), max(sales), min(sales) from orders; -- Aggregate functions

-- WINDOW functions
select *, sum(sales) over() from orders;
select *, sum(sales) over(partition by productid) from orders;
select *, sum(sales) over(partition by productid, orderstatus) from orders;
select *, rank() over(order by sales desc) from orders;

select orderid, sum(sales) over(order by orderid asc range between 1 preceding and 1 following) from orders;
select orderid, sum(sales) over(order by orderid asc range between unbounded preceding and 0 following) from orders; -- to get running total

select *, sum(sales) over(partition by orderstatus) from orders where productid = 101 or productid = 102;
select customerid, total, rk from (select *, dense_rank() over(order by total desc)  as rk from (select customerid, sum(sales) over(partition by customerid) as total from orders order by total desc) as t1) as t2 group by customerid, total, rk;

select count(orderid) from orders_archive group by orderid, productid, customerid, salespersonid;
select *, sum(sales) over(), sum(sales) over(partition by productid) from orders;

select orderid, sum(sales) over(order by orderid rows between unbounded preceding and 0 following) from orders;
select orderid, sum(sales) over(order by orderid) from orders; -- RUNNING TOTAL
select  distinct productid , sum(sales) over(partition by productid)/ sum(sales) over() from orders; -- DISTINCT removes duplicate rows 

select *, avg(sales) over(), avg(sales) over(partition by productid) from orders;
select *, avg(ifnull(score,0)) over() from customers;
select * from orders where sales > (select avg(sales) from orders);

SELECT * , MAX(SALES) OVER(), MIN(SALES) OVER(), MAX(SALES) OVER(PARTITION BY PRODUCTID), MIN(SALES) OVER(PARTITION BY PRODUCTID) FROM ORDERS;
select * from employees where salary = (select min(salary) from employees);

select orderid, sales- min(sales) over(),max(sales) over() - sales from orders;

-- RUNNING Totals from beginning to now -- ROLLING Totals from fixed time to now (like last 30 days)
select orderid, productid, sales, avg(sales) over(partition by productid order by orderid) from orders;

-- ROWNUMBER/rank/dense_rank/ntile/ CUME_DIST
select *, row_number() over(order by sales desc) , rank() over(order by sales desc), dense_rank() over(order by sales desc)from orders; -- UNIQUE NUMBER FOR EACH ROWS DOESNOT HANDLE TIES

select orderid, productid,sales, rk from (select orderid, productid, row_number() over(partition by productid order by sales desc) as rk , sales from orders) as t where rk = 1;
select distinct customerid, rk from (select customerid, total, dense_rank()  over(order by total asc) as rk from (select customerid, sum(sales) over(partition by customerid) as total from orders) as t) as t1 where rk <= 2;

select orderid, sales, ntile(4) over(order by sales desc) as nt from orders; -- IT will divide into buckets for segmenting data
select orderid, sales, nt, case when nt = 1 then 'High' when nt = 2 then 'Medium' when nt = 3 then 'Low' else 'extreme' end as 'group' from (select orderid, sales, ntile(4) over(order by sales desc) as nt from orders) as t;

select orderid, sales, (cume_dist() over(order by sales desc))*100 from orders; -- If there is a tie, then last occurence is considered
select orderid, sales, (percent_rank() over(order by sales desc))*100 from orders; -- If there is a tie, then first occurence is considered

select orderid, sales from (select orderid, sales, (cume_dist() over(order by sales desc))* 100 as p from orders) as t where p <= 40 order by p desc;

-- LEAD/ LAG
select orderid, sales, lead(sales,1,0) over(order by creationtime asc), creationtime from orders;
select orderid, sales, lag(sales,1,0) over(order by creationtime asc), creationtime from orders;

select month(orderdate), count(*) from orders group by month(orderdate); 
select distinct month(orderdate) as m , sum(sales) over(partition by month(orderdate)) as sales from orders; 

-- MOM performance
select m, sales, lag(sales,1,0) over(ORDER BY m) as prev, ((-lag(sales,1,0) over(ORDER BY m) +sales)/sales) * 100 as mom from (select distinct month(orderdate) as m , sum(sales) over(partition by month(orderdate)) as sales from orders) as t; 

-- CUSTOMER retension analysis (avg retension)
select distinct customerid, cast(avg(diff) over(partition by customerid) as signed)  as 'avg' from (select customerid, orderdate, datediff(orderdate,lag(orderdate,1,0) over(partition by customerid order by orderdate)) as diff from orders) as t where diff is not null; -- TO find average days
select customerid, diff, row_number() over(partition by customerid order by diff) as rn from (select customerid, orderdate, datediff(orderdate,lag(orderdate,1,0) over(partition by customerid order by orderdate)) as diff from orders) as t where diff is not null;

-- FINDING MEDIAN
select *, cume_dist() over(partition by customerid order by diff) from (select customerid, diff, row_number() over(partition by customerid order by diff) as rn from (select customerid, orderdate, datediff(orderdate,lag(orderdate,1,0) over(partition by customerid order by orderdate)) as diff from orders) as t where diff is not null) as t1;
