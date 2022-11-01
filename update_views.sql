show databases;
use company;
show tables;

select * from employees_salary_27000_view;

-- alter table employees_salary_27000_view;

update employees_salary_27000_view
set Dept_number = 1
where Salary = 32000.00;

update employees_salary_27000_view
set Dept_number = 5
where Name = 'JohnBSmith';

select * from employees_salary_27000_view;

select * from employees_dependent_view;

update employees_dependent_view
set Dependent = 'Abner'
where Departament = 4;

update employees_dependent_view
set Dependent = 'John' and Name = 'Abner Father'
where Departament = 4;