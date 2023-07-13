INSERT INTO products VALUE(0, 'Curso Front-end especialista', 2500);
INSERT INTO products VALUE(0, 'Curso JS Fullstack', 900);

-- Chapter 1

--SECTION 1
-- Inserting a row into a MySQL table
INSERT INTO mytable (username, email) VALUES ("estevan","estevanmartins03@gmail.com");
-- Updating a row into MYSQL table
update mytable set username = "jacare" where id=1;
-- Selecting rows based on conditions in MySQL
select * from mytable where username = "jacare";
-- Show list of existing databases
show databases;
-- Show tables in an existing database
show tables;
-- Show all the fiels of the table
describe study.mytable; -- desc mytable;

-- Creating user
create user 'estevan'@'localhost' identified by 'regiani2004'; -- only connect on local machine
create user 'estevan'@'%' identified by 'regiani2004'; -- connect from anywhere(except the local machine)

-- Adding privileges
grant select, insert, update on study * to 'estevan'@'localhost';
grant all on *.* to 'estevan'@'localhost' with grant option;

--SECTION 2
--Processlist
select * from information_schema.PROCESSLIST order by info desc, time desc;

select id, user, host, db, command,
time as time_seconds,
round(time / 60,2) as time_minutes,
round(time / 60 / 60,2) as time_hours,
state, info
from information_schema.PROCESSLIST order by info desc, time desc;

--Stored Procedure Searching
select * from information_schema.routines where routine_definition like '%word%';



