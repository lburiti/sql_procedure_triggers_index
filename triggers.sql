use company;
show tables;
desc employee;
select * from employee;


-- before insert statement
# setando gerentes por departamento

delimiter \\
create trigger superssn_check before insert on company.employee
for each row
	begin
		case new.Dno
			when 1 then set new.Super_ssn = '333445555';
            when 2 then set new.Super_ssn = null;
            when 3 then set new.Super_ssn = null;
            when 4 then set new.Super_ssn = '123456789';
            when 5 then set new.Super_ssn = '987654321';
         end case;   
    end \\
delimiter ;

-- drop trigger salary_check;
show triggers from company;

select * from employee;
insert into employee (Fname, Minit, Lname, Ssn, Bdata, Addres, sex, Salary, Super_ssn, Dno)
    values('João', 'B', 'Smith', '123456759', '1965-01-09', '731-Fondren-Houston-TX', 'M', '32000.00', NULL, '5');

-- after insert statement
# verificar se algum valor nulo que não foi passado alter
# adiciona uma mensagem para o usuário.

create table user_messages(
id int auto_increment primary key,
message varchar(100),
ssn char(9),
constraint fk_ssn_messages foreign key (ssn) references employee(Ssn)
);

drop trigger null_value_check;
delimiter \\
create trigger null_value_check after insert on employee
for each row
	if (new.Addres is null) then
		-- select 'Upadte your adress, please!' as Message;
        insert into user_messages(message, ssn) values(concat('Update your addres, please!!', new.Fname), new.Ssn);
	else
		insert into user_messages (message, ssn) values(concat('Error', new.Fname), new.Ssn);
	end if;
\\
delimiter ;

show triggers from company;

insert into employee (Fname, Minit, Lname, Ssn, Bdata, Addres, sex, Salary, Super_ssn, Dno)
    values('Fulana', 'B', 'Smith', '713489824', '1965-01-09', null, 'F', '35000.00', '123456789', '5');

select * from employee;
select * from user_messages;


create database triggersdb;

use triggersdb;


create table account(
id int primary key,
acct_num int not null,
amount decimal(10,2)
);

create trigger check_amount before insert on account
for each row set @sum = @sum+new.amount;

show triggers from triggersdb;

set @sum  = 0;
insert into account(id, acct_num, amount) 
		values(1, 137, 14.98),
			  (2, 141, 1937.50),
              (3, 97, -100.00);
select * from account;
drop trigger check_amount;

delimiter //
create trigger upd_check before update on account
	for each row
	begin
		if new.amount < 0 then
			set new.amount = 0;
		elseif new.amount > 100 then
			set new.amount = 100;
		end if;
	end//

delimiter ;

show triggers from triggersdb;

update account set amount = -50 where id=3;

select * from account

-- before update statement
# atribuindo aumento de salário para um departamento específico = 1


-- before delete statement
# salvando em outra tabela os employees demitidos.
