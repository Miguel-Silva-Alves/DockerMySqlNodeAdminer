INSERT INTO products VALUE(0, 'Curso Front-end especialista', 2500);
INSERT INTO products VALUE(0, 'Curso JS Fullstack', 900);

-- Chapter 1 // GETTING STARTED WITH MYSQL

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
create user 'estevan_s'@'%' identified by 'regiani2004'; -- connect from anywhere(except the local machine)

-- Adding privileges
grant select, insert, update on study.* to 'estevan'@'localhost';
grant all on *.* to 'estevan'@'localhost' with grant option; 

--SECTION 2
--Processlist

-- Essa consulta pode ser útil para identificar processos em execução, monitorar consultas 
-- em andamento e analisar o desempenho do servidor de banco de dados.
select * from information_schema.PROCESSLIST order by info desc, time desc;

select id, user, host, db, command,
time as time_seconds,
round(time / 60,2) as time_minutes,
round(time / 60 / 60,2) as time_hours,
state, info
from information_schema.PROCESSLIST order by info desc, time desc;

--Stored Procedure Searching
select * from information_schema.routines where routine_definition like '%word%';


-- CHAPTER // 2 DATA TYPES (only theoretical)


-- CHAPTER 3 // SELECT

insert into car values (1,'Audi A1', '20000');
insert into car values (2,'Audi A1', '15000');
insert into car values (3,'Audi A2', '40000');
insert into car values (4,'Audi A2', '40000');

-- DISTINCT
select distinct name, price from car; -- the diference is betweens line not columns 

-- ALL COLUMNS(*)
select * from car;

-- BY COLUMN
select name from car;

-- WITH LIKE (%)
insert into stack(username) values ('Corinthians'),('Coringão'),('Timão'),('Time do povo');

select * from stack where username like '%C%';-- 'C' in anywhere 
select * from stack where username like 'C%';-- begins with 'o'
select * from stack where username like '%o';-- end with 'o'
select * from stack where username like 'Tim_o';-- with anyone letter between m and o

-- CASE OR IF
insert into students values ('Estevan',67);
insert into students values ('Danilo',28);
insert into students values ('Miguel',35);
insert into students values ('Regiani',92);

select st.name, st.percentage,
        case when st.percentage >= 35 then 'Pass' else 'Fail' end as 'Remark'
        from students as st;

select st.name,st.percentage,
        if(st.percentage >= 35, 'Pass', 'Fail') as 'Remark'
        from students as st;

-- AS
select username as val from stack; -- is the same thing that bellow
select username val from stack;

-- LIMIT CLAUSE
select * from students order by percentage limit 3;
select * from students order by percentage limit 2,1 -- two numbers: offset,count 

-- BETWEEN
select * from car_id where id >=2 and id<=5;-- is like the bellow
select * from car where car_id between 2 and 5;

--NOT BETWEEN
select * from car where car_id not between 2 and 5;

-- WHERE
select * from car where name = 'Audi A2' and price = 40000;

-- LIKE
select name from car where name like 'Audi A_';

-- DATE RANGE
/*
select ... where dt >= '2017-02-01'
                and dt < '2017-02-01' + interval 1 month
*/ 


-- CHAPTER 4 // BACKTICKS
/*doesn't work
select name from student group by 'group'; -- works for don't happens mess between group */


-- CHAPTER 5 // NULL
/*select ...
        from a
        left join b on ...
        where b.id is NULL;
*/

-- CHAPTER 6 // LIMIT AND OFFSET

select * from car order by car_id asc limit 2;
select * from car order by car_id asc limit 2,3; -- first number is offset, second is the limit
select * from car order by car_id asc limit 2 offset 3;

-- CHAPTER 7 // CREATING DATABASES

-- DATABASE, USERS, AND GRANTS
create database if not exists study;
drop database if exists study;

select @@character_set_database as cset,@@collation_database as col; -- default CHARACTER SET and Collation

create user 'Miguel123'@'%' identified by 'senha';
CREATE USER 'Miguel157'@'%' IDENTIFIED BY 'senha';

SELECT user, host, authentication_string FROM mysql.user WHERE user IN ('Miguel123', 'Miguel157');

grant all on study.* to 'Miguel123'@'%';
grant select on study.* to 'Miguel157'@'%';

show grants for 'Miguel123'@'%';

-- CHAPTER 8 // USING VARIABLES

-- SETTING VARIABLES
set @var_string = 'my_var';
set @var_num = 2; -- set @var_num = '2';
set @var_date = '2004-04-26';

select @var_num = 2; -- retorna se é verdadeiro ou falso com 0 ou 1
select @var_num := 2; -- atribui o valor da variavel novamente com o valor informado

set @start_date = '2012/12/12';
set @end_datte = '2013/02/13';

set @start_yearmonth = (select extract(year_month from @start_date));
set @end_yearmonth = (select extract(year_month from @end_date));

-- put the partitions into a variable
select group_concat(partition_name) from information_schema.partitions p
        where table_name = 'partitioned_table'
        and substring_index(partition_name,'P',-1) between @start_yearmonth and @end_yearmonth
        into @partitions;


-- put the query in a variable. I need to do this, because mysql
--did not recognize my variable as a variable in that position. I need
--to contact the value of the variable together with the rest of the
--query and then execute it as a stmt
set @query = concat('create table part_of_partitioned_table (primary key(id))
        select partitioned_table.*
        from partitioned_table partition(', @partitions, ')
        join users u using(user_id)
        where date(partitioned_table.date) between ', @start_date, 'and', @end_date);

-- prepare the statement from @query
prepare stmt from @query;--don't works

-- i tried execute this commands bellow because the command above don't worked
SET @partitions = COALESCE(@partitions, ''); -- Define um valor padrão se @partitions for nulo
SET @start_date = COALESCE(@start_date, ''); -- Define um valor padrão se @start_date for nulo
SET @end_date = COALESCE(@end_date, '');

-- Remover espaços em branco extras, se necessário
SET @partitions = TRIM(@partitions);
SET @start_date = TRIM(@start_date);
SET @end_date = TRIM(@end_date);

--drop table
drop table if exists tech.part_of_partitioned_table;
--create table using statement
execute stmt;

create table team_person as select 'A' team, 'John' person
        union all select 'B' team, 'Isabela' person
        union all select 'A' team, 'Haroldo' person
        union all select 'A' team, 'Daniel' person
        union all select 'B' team, 'Danilo' person
        union all select 'B' team, 'Gabriel' person;

-- don't works
select @row_no := @row_no+1 as row_number, team, person
        from team_person, (select @row_no := 0) t;
-- don't works too
set @row_no := 0;
select @row_no := @row_no + 1 as row_number, team, person
from team_person;


-- CHAPTER 9 // COMMENTS
-- WORKS(--, #,/* */)


-- CHAPTER 10 // INSERT





















