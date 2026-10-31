-- Task 2.1: Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
select*from Departments

-- Task 2.2: Students Table (1:N with Departments)
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    GPA DECIMAL(3,2),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID)
);


-- Task 2.3: StudentProfiles Table (1:1 Relation with Students)
CREATE TABLE StudentProfiles (
    ProfileID INT PRIMARY KEY,
    StudentID INT UNIQUE FOREIGN KEY REFERENCES Students(StudentID),
    Address VARCHAR(200),
    EmergencyPhone VARCHAR(20)
);

-- Task 2.4: Courses Table (1:N with Departments)
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT,
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID)
);

-- Task 2.5: StudentCourses Table (M:N Junction Table)
CREATE TABLE StudentCourses (
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
    EnrollmentDate DATE DEFAULT GETDATE(),
    PRIMARY KEY (StudentID, CourseID)
);
select*from StudentCourses 




ALTER TABLE Students
ADD Age INT;
select*from  Students


DROP TABLE TempInstructors;
--select*from TempInstructors; -- error




--stage 2

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'Computer Science'),
       (2, 'Software Engineering'),
       (3, 'Business Administration');

       select*from Departments ;
INSERT INTO Students (StudentID, FullName, Email, GPA, DepartmentID, Age)
VALUES (101, 'Ali Smadi', 'ali@coursehub.com', 3.80, 1, 22),
       (102, 'Omar Ahmad', 'omar@coursehub.com', 2.90, 1, 21),
       (103, 'Laila Hassan', 'laila@coursehub.com', 3.50, 2, 23),
       (104, 'Tariq Zaid', 'tariq@coursehub.com', 2.10, 3, 20);
       select*from Students

INSERT INTO StudentProfiles (ProfileID, StudentID, Address, EmergencyPhone)
VALUES (1, 101, 'Amman, Jordan', '0791111111'),
       (2, 102, 'Irbid, Jordan', '0792222222'),
       (3, 103, 'Zarqa, Jordan', '0793333333');


INSERT INTO Courses (CourseID, CourseName, Credits, DepartmentID)
VALUES (201, 'Database Systems', 3, 1),
       (202, 'Web Development', 3, 1),
       (203, 'Software Architecture', 3, 2);


INSERT INTO StudentCourses (StudentID, CourseID)
VALUES (101, 201),
       (101, 202),
       (102, 201),
       (103, 203);

       select*from StudentCourses
UPDATE Students
SET GPA = 2.50
WHERE StudentID = 104;

select*from Students
DELETE FROM Students
WHERE StudentID = 104; 


--stage4

SELECT s.FullName, s.GPA, d.DepartmentName
FROM Students s
INNER JOIN Departments d ON s.DepartmentID = d.DepartmentID;


SELECT d.DepartmentName, s.FullName
FROM Departments d
LEFT JOIN Students s ON d.DepartmentID = s.DepartmentID;


SELECT s.FullName, p.Address, p.EmergencyPhone
FROM Students s
INNER JOIN StudentProfiles p ON s.StudentID = p.StudentID;

SELECT s.FullName, c.CourseName, sc.EnrollmentDate
FROM Students s
INNER JOIN StudentCourses sc ON s.StudentID = sc.StudentID
INNER JOIN Courses c ON sc.CourseID = c.CourseID;




--stage5
SELECT 
    COUNT(StudentID) AS TotalStudents,
    AVG(GPA) AS AverageGPA,
    MAX(GPA) AS HighestGPA,
    MIN(GPA) AS LowestGPA
FROM Students;

-- group by dept
SELECT DepartmentID, AVG(GPA) AS AverageGPA, COUNT(StudentID) AS TotalStudents
FROM Students
GROUP BY DepartmentID;

--  HAVING 
SELECT DepartmentID, AVG(GPA) AS AverageGPA
FROM Students
GROUP BY DepartmentID
HAVING AVG(GPA) > 3.00;


SELECT DepartmentID, COUNT(StudentID) AS TotalStudents
FROM Students
WHERE GPA >= 2.50
GROUP BY DepartmentID
HAVING COUNT(StudentID) > 1;


--noncluster 
CREATE NONCLUSTERED INDEX IX_Students_Email 
ON Students(Email);
EXEC sp_helpindex 'Students';--showing


--subquiry 
SELECT StudentID, FullName, GPA
FROM Students
WHERE GPA > (SELECT AVG(GPA) FROM Students);

--view 
CREATE VIEW vw_StudentAcademicDetails AS
SELECT s.StudentID, s.FullName, s.GPA, d.DepartmentName
FROM Students s
INNER JOIN Departments d ON s.DepartmentID = d.DepartmentID;
select*from vw_StudentAcademicDetails


--procedure
CREATE PROCEDURE sp_GetStudentsByDepartment
    @DeptID INT
AS
BEGIN
    SELECT *
    FROM Students
    WHERE DepartmentID = @DeptID;
END;
EXEC sp_GetStudentsByDepartment @DeptID = 1;