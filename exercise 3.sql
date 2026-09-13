create catalog if not exists employee;
show catalogs;

create schema if not exists employee.table;
show schemas;


create table if not exists employee.table.employee
 (employee_id int,
  employees_name string,
 department string,
 salary int
 );

insert into employee.table.employee values 
(111,'John','IT',25000),
(112,'sarah','IT',30000),
(113,'Peter','sales',2000),
(114,'Mary','sales',22000),
(115,'David','sales',18000),
(116,'Thabo','HR',28000),
(117,'Lerato','HR',32000);
select * 
from employee.table.employee;

---1.calculate the number of employees in by department---
select department,
   count(employee_id)as total_employee
from employee.table.employee
group by department;
---2.calculate the total salary by department---
select department
