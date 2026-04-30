-- SQL QUERY (Basics)

-- Using the Databases
show databases; -- It will show all the databases
use mydatabase; -- If i have to use a specific database
use salesdb; 
show tables; -- It will show all the tables in the database 

-- SELECT QUERY (Working on mydatabase)
select * from orders;
select * from customers;
select first_name as name, country, score from customers;

-- WHERE CLAUSE (used before aggregation) and ORDER BY 
select * from customers where country = 'Germany' order by id asc;
select * from customers where score != 0 order by score desc;

-- NESTED ORDER BY
select * from customers order by country asc, score desc; -- (First country is done, then score is done)

-- GROUP BY -- Every column in SELECT must either: Be inside GROUP BY OR Be inside an aggregate function
select country, count(*) from customers group by country;
select country, sum(score) as total from customers group by country; 
select country, sum(score) as total, count(*) from customers group by country;
select country, first_name, count(*) from customers group by country, first_name; -- NESTED GROUP BY
-- Nested aggregate function is not possible

-- HAVING CLAUSE (used after aggregation)
select country from customers group by country having sum(score) > 800;
select country, round(avg(score),0) as avg from customers where score != 0 group by country having avg(score) > 430;

-- DISTINCT (Removing Duplicates), LIMIT and OFFSET
select distinct country from customers;
select * from customers order by score desc limit 3;
select * from customers limit 3 offset 1;

-- ORDER OF CODING (SELECT DISTINCT col_names FROM table_name WHERE condition GROUP BY col_names HAVING ORDER BY col_names LIMIT OFFSET
-- ORDER OF EXECUTION (FROM WHERE GROUP BY HAVING SELECT ORDER BY OFFSET LIMIT)
