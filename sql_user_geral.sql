show databases;

create database meu;

use company;

show tables;

drop table tabela_user;

create table tabela_user(
nome_tabela varchar(255),
id int primary key
);

use information_schema;

show tables;

select * from information_schema.table_constraints;