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

-- for to realistic i don't understand very well what this line do
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

-- on duplicate key update
insert into car(car_id, name, price)
        values (5, 'scort', 120000)
        on duplicate key update
        name = 'scortinho',
        price = values(price);

-- ignoring existing rows
insert ignore into car (car_id, name) values
        (2,'Ferrari'),
        (6,'Jacaré'),
        (7,'Fusquinha'); 

-- if exists will create a invisible id for the incorect
--insert and update the right data
insert into iodku (name, misc)
        values('Jacareterrivel',157)
        on duplicate key update 
        id = last_insert_id(id),
        misc = values(misc);

--inserting data from another table
insert into iodku(name, misc)
        select car.name, car.price
        from car
        where car.price <> 20000 and car.price <> 40000
        order by car.price;



-- CHAPTER 11 // DELETE
insert people(id, name, gender) 
        values(1,'Katy','f'),
              (2,'Joao','m'),
              (3,'Paul','m'),
              (4,'Estevan','m');

insert pets(ownerId,name,color) values
                (1,'Rover','beige'),
                (2,'Bubbles','purple'),
                (3,'Spot','black and white'),
                (1,'Rover2','white');

-- Remove only pets
DELETE p2 FROM pets p2
        WHERE p2.ownerId in (
                        SELECT p1.id FROM people p1
                                WHERE p1.name = 'Paul');

-- Is the same thing that the example above
DELETE p2 FROM people p1
        JOIN pets p2 ON p2.ownerId = p1.id
                WHERE p1.name = 'Paul';

-- Remove pets and the people
DELETE p1, p2 FROM people p1 
        JOIN pets p2 ON p2.ownerId = p1.id
                WHERE p1.name = 'Paul';

-- ON DELETE CASCADE make that the soon lines burned after the father delete
ALTER TABLE pets ADD CONSTRAINT `fk_pets_2_people` FOREIGN KEY (ownerId) references people(id) ON
DELETE CASCADE;

-- This will delete all the data and reset AUTO_INCREMENT index.
TRUNCATE people;

-- Delete only one because i set a limit range of 1
DELETE FROM car WHERE name = 'Audi A1' LIMIT 1;


-- CHAPTER 12 // UPDATE

--basic update
UPDATE car SET name='luke' WHERE car_id=1;

-- bulk update
UPDATE people
        SET name =
                (CASE id WHEN 1 THEN 'Karl'
                        WHEN 2 THEN 'Tom'
                        WHEN 3 THEN 'Mary'
                END)
                WHERE id IN (1,2,3);

-- I don't create a table but i put here for rememenber when necessary
/*

Syntax for the MySQL UPDATE with ORDER BY and LIMIT is,
UPDATE [ LOW_PRIORITY ] [ IGNORE ] tableName
        SET column1 = expression1,
            column2 = expression2,
...
                [WHERE conditions]
                        [ORDER BY expression [ ASC | DESC ]]
                                [LIMIT row_count];

-- multiple table update example but this too don't have example
UPDATE products, salesOrders
        SET salesOrders.Quantity = salesOrders.Quantity - 5,
        products.availableStock = products.availableStock + 5
                WHERE products.productId = salesOrders.productId
                        AND salesOrders.orderId = 100 AND salesOrders.productId = 20;




-- CHAPTER 13 // ORDER BY

-- for default
SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY ... LIMIT ... OFFSET ...;
( SELECT ... ) UNION ( SELECT ... ) ORDER BY ... -- for ordering the result of the UNION.

Returns the result in the specified order of ids.
SELECT * FROM some_table WHERE id IN (118, 17, 113, 23, 72)
        ORDER BY FIELD(id, 118, 17, 113, 23, 72);

*/

-- CHAPTER 14 // GROUP BY
SELECT ownerId, GROUP_CONCAT(name ORDER BY name desc SEPERATOR ' ') AS pets_name
FROM pets
GROUP BY ownerId; -- ERROR 1064 (42000)

-- Number of orders for each customer.
/*
SELECT customer, COUNT(*) as orders
        FROM orders
                GROUP BY customer
                ORDER BY customer;
*/

-- CHAPTER 15 //ERROR 1055




















