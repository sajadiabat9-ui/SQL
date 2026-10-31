 Create Table AccessCards 
 (
 CardID INT PRIMARY KEY ,
CardNumber VARCHAR(50) NOT NULL UNIQUE ,
employeeid INT  UNIQUE FOREIGN KEY References Employee(EmployeeID)  
 );
 select* from AccessCards

 insert into AccessCards values( 1 , 'Card 101' ,1 ) , (2 , 'Card 102'  ,2  ) , ( 3, 'Card 103' , 3 )

 --m to m
 Create table Project (
  ProjectID INT Primary key ,
  ProjectName VARCHAR(100) NOT NULL
 );
 insert into Project values  (  1 , 'AI & Security Training' ) , ( 2 , 'Cloud Migration')

 select * from Project

 create table EmployeeProject (
 employeeid INT FOREIGN KEY References Employee(EmployeeID)  ,
 projectid INT  FOREIGN KEY References Project (ProjectID)  , 
 AssignedDate DATE ,
) ;
insert into EmployeeProject values (1,1, null),(1,2 ,null),(2,1 ,null ),(3,2 , null);
select* from EmployeeProject 

-- phase 6

select  FullName, Salary ,DepartmentName from Employee inner join Department on Employee.DepartmentID = Department.DepartmentID ;

SELECT DepartmentName,FullName
FROM Department 
LEFT JOIN Employee ON Employee.DepartmentID = Department.DepartmentID;


SELECT FullName, CardNumber
FROM Employee 
INNER JOIN AccessCards ON  AccessCards.employeeid =  Employee.EmployeeID;


-- m-n
SELECT e.FullName, p.ProjectName, ep.AssignedDate
FROM Employee e
INNER JOIN EmployeeProject ep ON e.EmployeeID = ep.employeeid
INNER JOIN Project p ON ep.projectid = p.ProjectID;

--phase 7
-- group by 
SELECT DepartmentID, 
       SUM(Salary) AS TotalSalary, 
       COUNT(EmployeeID) AS EmployeeCount
FROM Employee
GROUP BY DepartmentID;

--having with group by 
SELECT DepartmentID, 
       AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY DepartmentID
HAVING AVG(Salary) > 1000.00;

-- sub
SELECT FullName, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

-- view
CREATE VIEW vw_EmployeeDetails AS
SELECT e.EmployeeID, e.FullName, e.Email, d.DepartmentName
FROM Employee e
INNER JOIN Department d ON e.DepartmentID = d.DepartmentID;

SELECT * FROM vw_EmployeeDetails;

--PROCEDURE
CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DeptID INT
AS
BEGIN
    SELECT *
    FROM Employee
    WHERE DepartmentID = @DeptID;
END;

EXEC sp_GetEmployeesByDepartment @DeptID = 1;

--Triggers

CREATE TABLE EmployeeAudit (
    AuditID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    Action VARCHAR(50),
    ActionDate DATETIME
);
select * from  EmployeeAudit ;



CREATE TRIGGER trg_AfterDeleteEmployee
ON Employee
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeAudit (EmployeeID, Action, ActionDate)
    SELECT EmployeeID, 'Deleted', GETDATE()
    FROM deleted;
END;

INSERT INTO Employee (EmployeeID, FullName, Email, Salary, DepartmentID)
VALUES (999, 'Test Employee', 'test@example.com', 500.00, 1);


DELETE FROM Employee WHERE EmployeeID = 999;


SELECT * FROM EmployeeAudit;

