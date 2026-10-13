create database int_task;
use int_task;

create table employees(
employee_id int primary key,
employee_name varchar(80),
department varchar(40),
designation varchar(40),
basic_salary decimal(8,2),
joining_date date,
status varchar(20));

insert into employees values(102,'rohit','IT','developer',30000,'2000-02-12','Inactive'),
(103,'sumit','HR','Manager',80000,'2013-05-02','Active'),
(104,'nilesh','HR','assistant',90000,'2017-03-12','Active'),
(105,'vaishnavi','Finance','cashier',50000,'2013-12-12','Active'),
(106,'lokesh','IT','developer',70000,'2005-02-11','Inctive'),
(107,'saurabh','IT','developer',68000,'2010-05-30','Active'),
(108,'tanuja','HR','assistant',77000,'2017-07-23','Active'),
(109,'hariprasad','IT','developer',40000,'2016-04-22','Active'),
(110,'akshay','FInance','cashier',70000,'2011-01-12','Active'),
(111,'sunil','IT','developer',56000,'2013-03-23','Active');


/* Task 1 – Employee Salary Report Procedure*/
delimiter //
create procedure  GetEmployeeSalaryReport(in department_name varchar(40),minimum_salary decimal(8,2))
begin
select * from employees 
where department=department_name and Basic_salary>=minimum_salary and status='active';
end//
delimiter ;
drop procedure GetEmployeeSalaryReport;
call  GetEmployeeSalaryReport('IT', 50000);


/* Task 2 – Employee Salary Calculation Procedure*/

delimiter //
create procedure CalculateEmployeeSalary(in employees_id int)
begin
with salary as(select basic_salary, (basic_salary*0.20) as HRA, (basic_salary*0.1) as DA, (basic_salary*0.12) as PF from employees where employee_id=employees_id)
select (basic_salary+HRA+DA+PF) as net_salary from salary;  
end//
delimiter ;
drop procedure CalculateEmployeeSalary;
CALL CalculateEmployeeSalary(101);
CALL CalculateEmployeeSalary(102);


/*Task 3 – Salary Grade Procedure*/

delimiter //
create procedure EmployeeSalaryGrade(in emp_id int)
begin
select employee_name,basic_salary,
case when basic_salary<30000 then 'C'
when basic_salary between 30000 and 60000 then 'B'
else 'A'
end as grade from employees;
end //
delimiter ;
drop procedure EmployeeSalaryGrade;
call EmployeeSalaryGrade(101);


/*Bonus Task – Department Summary
Create a procedure named GetDepartmentSummary. It should accept a department name and return:
Total number of employees
Average salary
Highest salary
Lowest salary
Total salary expenditure
*/

delimiter //
create procedure GetDepartmentSummary(in dep_name varchar(50))
begin

select department,count(*) as emp_count, avg(basic_salary) as Average_salary, max(basic_salary) as highest_salary, min(basic_salary)as Lowest_salary,sum(basic_salary) as Total_expend
from employees group by department having department=dep_name;

end//
delimiter ; 
drop procedure GetDepartmentSummary;
call GetDepartmentSummary('IT');
