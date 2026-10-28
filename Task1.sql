--phase 1

create table TemporaryStaff ( 
StaffID INT primary key ,
StaffName VARCHAR(50) ,
HireDate DATE

) ;

--phase2 
create table Department ( 
DepartmentID INT PRIMARY KEY ,
DepartmentName VARCHAR(50) NOT NULL UNIQUE 
);

create table Employee (
EmployeeID INT PRIMARY KEY ,
FullName VARCHAR(100) NOT NULL ,
Email varchar (100) UNIQUE ,
Salary  DECIMAL(10,2) ,
DepartmentID INT
);


 ALTER TABLE Employee add PhoneNumber VARCHAR(20) ;


 drop table TemporaryStaff ; 


 --phase 3
 insert into  Department values (
  1, 'IT'
 
 );
 insert into  Department values (
 2, 'HR' 
 
 );
insert into  Department values (
 3, 'Finance'
 
 );


 insert into Employee values  (1 , 'Ahmad Ali' , 'ahmad@techworld.com', 1200.00 , 1 , '0791111111'
 )
  insert into Employee values  ( 2 , 'Sara Hassan' , 'sara@techworld.com' ,  950.00 , 2 , '0792222222'
 )
  insert into Employee values  ( 3 , 'Zaid Omar' , 'zaid@techworld.com' , 1500.00 , 1 , '0793333333'
 )
  insert into Employee values  ( 4 , 'Mona Khaled' ,'mona@techworld.com', 800.00 , 3 , '0794444444'
 )


 update Employee set salary = 1350.00 where EmployeeID = 4 ;


 delete from Employee where EmployeeID = 4 ;

 select * from Employee ; 
 select FullName , Salary from Employee ; 

 SELECT SUM(Salary) AS TotalSalaries FROM Employee;
 SELECT AVG(Salary) AS  AverageSalary FROM Employee;
 SELECT MAX(Salary) AS HighestSalary, MIN(Salary) AS LowestSalary FROM Employee;
 SELECT COUNT(*) AS TotalEmployees FROM Employee;