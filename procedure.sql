use company;
select * from employee;
select * from departament;

delimiter \\
create procedure procedure_test()
begin


end \\
delimiter ;

drop procedure info_employee;
delimiter \\
create procedure info_employee()
begin
	select * from employee inner join departament on Ssn = Mgr_ssn;
end \\
delimiter ;

-- criar view para reduzir retrabalho.
call info_employee;


drop procedure insert_into_employee_proc;
delimiter %
create procedure insert_into_employee_proc(
	in Fname_p varchar(15),
    in Minit_p char(1),
    in Lname_p varchar(15),
    in Ssn_p char(9),
    in Bdata_p date,
    in Addres_p varchar(30),
    in sex_p char(1),
    in Salary_p decimal(10,2),
    in Super_ssn_p char(9),
    in Dno_p int
)
begin
	-- insert into employee (Fname, Minit, Lname, Ssn, Bdata, Addres, sex, Salary, Super_ssn, Dno)
    insert into employee (Fname, Minit, Lname, Ssn, Bdata, Addres, sex, Salary, Super_ssn, Dno)
    -- values('Maria', 'B', 'Smith', '123456824', '1965-08-09', '731-Fondren-Houston-TX', 'F', '35000.00', '123456789', '5');
    values(Fname_p, Minit_p, Lname_p, Ssn_p, Bdata_p, Addres_p, sex_p, Salary_p, Super_ssn_p, Dno_p);
    
    -- retorna o registro persistido na procedure
    select 'Inserção bem sucedida' as message;
    select * from employee where Ssn = Ssn_p;
    
end %
delimiter ;

desc employee;

call insert_into_employee_proc('Amanda', 'B', 'Teixeira', '123769824', '1990-08-09', '731-Fondren-Houston-TX', 'F', '40000.00', '123456789', '1');

select * from employee;

create database teste_proc;
use teste_proc;

drop table user;
create table user(
	id int auto_increment primary key,
    nome varchar(20) not null unique,
    email varchar(30) not null unique,
    senha varchar(60) not null,
    data_cadastro datetime
);

desc user;

drop procedure procedure_insert;
delimiter \\
create procedure procedure_insert(
	in nome_p varchar(20),
    in email_p varchar(30),
    in senha_p varchar(60)    
)
begin
	if(length(senha_p) < 10 and length(senha_p) > 7) then
    insert into user (nome, email, senha, data_cadastro) values(nome_p, email_p, md5(senha_p), now());
    select * from user;
    select 'Inserção bem sucedida' as message;
	else
		select 'Forneça outra senha' as Message_error;
    end if;

end \\
delimiter ;

call procedure_insert('Juliana', 'juliana@email.com', '123456789');
call procedure_insert('luciano', 'luciano@email.com', '1234');

select length(md5('123456789')) as senha;
