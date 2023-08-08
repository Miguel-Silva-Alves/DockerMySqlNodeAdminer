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

create table stack(
    id int AUTO_INCREMENT primary key,
    username varchar(100) not null
);

create table students(
    name varchar(20),
    percentage int
);


-- Chapter 10
create table iodku(
    id int AUTO_INCREMENT not null,
    name varchar(30) not null,
    misc int not null,
    primary key(id),
    unique(name)
) engine = InnoDB;

-- Chapter 11
create table people(
    id int primary key,
    name varchar(100) not null,
    gender char(1) not null
);

create table pets( 
    id int auto_increment primary key,
    ownerId int not null,
    name varchar(100) not null,
    color varchar(100) not null
);

