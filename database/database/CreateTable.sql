CREATE TABLE IF NOT EXISTS products (
  id INT(11) AUTO_INCREMENT,
  name VARCHAR(255),
  price DECIMAL(10, 2),
  PRIMARY KEY (id)
);

-- Chapter 1

-- creating a table in MySQL
create table mytable
(
  id           int unsigned not null AUTO_INCREMENT,
  username     VARCHAR(100) NOT null,
  email        VARCHAR(100) NOT null,

  primary key (id)
);

-- Note 
create table 'table'
(
  'first name' varchar(30)   
);


-- Chapter 3 

create table car(
    car_id int unsigned not null primary key,
    name varchar(20),
    price decimal(8,2)
);

