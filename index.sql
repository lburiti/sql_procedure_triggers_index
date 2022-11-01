create database if not exists customer_managment;
use customer_managment;

drop table customer;
create table if not exists customer(
id_customer int auto_increment primary key,
customer_name varchar(25),
email varchar(40) not null,
cpf char(11),
credit_card char(13),
contact char(9),
address varchar(60)
);

show tables;
show index from customer;

-- drop index;

alter table customer_managment.customer add index index_email(email);

select * from customer_managment.customer;

desc customer_managment.customer;

insert into customer(customer_name, email, cpf, credit_card, contact, address)
			values('Luciano Carvalho', 'lburiti@uol.com.br', '82491682168', '5456478965412', '999794579', 'Rua G1, Qd 05 Lt 15, Goiania-GO');

select * from customer_managment.customer;

create table customer_v2(
customer_id smallint unsigned not null auto_increment,
store_id tinyint unsigned not null,
first_name varchar(45) not null,
last_name varchar(45) not null,
email varchar(50) default null,
address_id smallint unsigned not null,
active boolean not null default true,
create_date datetime not null,
last_update timestamp default current_timestamp,
primary key(customer_id),
key idx_fk_store_id (store_id),
key idx_fk_address_id (address_id),
key idx_fk_last_name (last_name)
);

desc customer_v2;

show index from customer_v2;

alter table customer_managment.customer_v2 add index active_customers_index(active);
create index ind on customer_managment.customer_v2 (active) using hash; -- não acontece: SGBD converte para Btree

-- drop table exemplo;
create table exemplo(
id int primary key auto_increment,
nome varchar(60),
ativo boolean default true,
email varchar(50)
) engine = MEMORY;

create index idx_hash_ativo on exemplo(ativo) using hash;
create index idx_btree_id on exemplo(id) using Btree;
show tables;

show index from exemplo;