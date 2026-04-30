-- SQL (DDL & DML)

show databases;
use mydatabase;
create table if not exists person(
	id int primary key,
    name varchar(50) not null,
    age int not null,
    phone_number varchar(50) unique
);

-- ALERT COMMANDS
alter table person add email varchar(50) unique; -- Method to add coloumn
alter table person drop email; -- Method to drop coloumn
alter table person change email gmail varchar(60); -- To rename coloumn
alter table person rename to people; -- To rename table
alter table people rename to person;
alter table person modify gmail varchar(50); -- To change the constraint

drop table person; -- To erase the table from db itself
show tables;
select * from person;

-- INSERT INTO 
insert into person (id, name, age, phone_number) values (1, 'BK', 20, '9944456229') , (2,'Barath',20, 9452);

-- DELETING SOME ROWS
delete from person where id = 1;

-- deleting all rows 
truncate table person; -- It will delete only the data

-- UPDATE
update person set age = 19, gmail = 'barath' where  id = 1;