CREATE DATABASE Employee

USE Employee

CREATE TABLE EmployeeDetails
(EmpId int PRIMARY KEY,
FullName VARCHAR(100),
ManagerId int,
DateOfJoining DATE,
City VARCHAR(100))

DROP TABLE EmployeeSalary

SELECT * FROM EmployeeSalary

INSERT INTO EmployeeDetails(EmpId,FullName,ManagerId,DateOfJoining,City)
VALUES
		(121,'John Snow',321,'01/31/2019','Toronto'),
		(321,'Walter White',986,'01/30/2020','California'),
		(421,'Kuldeep Rana',876,'11/27/2021','New Delhi')

CREATE TABLE EmployeeSalary

(EmpId INT PRIMARY KEY,
FOREIGN KEY (EmpId)  REFERENCES EmployeeDetails (EmpId),
Project VARCHAR(20),
Salary int,
Variable int)

INSERT INTO EmployeeSalary(EmpId,Project,Salary,Variable)
VALUES
		(121,'P1',8000,500),
		(321,'P2',10000,1000),
		(421,'P1',12000,0)

--Q1)SQL Query to fetch records that are present in one table but not in another table.

SELECT * 
FROM EmployeeSalary
RIGHT JOIN
EmployeeDetails
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId

--Q2)SQL query to fetch all the employees who are not working on any project.

SELECT Project
FROM EmployeeSalary
RIGHT JOIN
EmployeeDetails
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId
WHERE Project IS NULL

--Q3)SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.

SELECT FullName
FROM EmployeeDetails
INNER JOIN
EmployeeSalary
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId
WHERE YEAR(DateOfJoining) = 2020

--Q4)Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.

SELECT FullName,Salary
FROM EmployeeDetails
INNER JOIN
EmployeeSalary
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId

--Q5)Write an SQL query to fetch a project-wise count of employees.

SELECT Project, COUNT(Project) AS projectwisecount
FROM EmployeeSalary
INNER JOIN
EmployeeDetails
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId
GROUP BY Project

--Q6)Fetch employee names and salaries even if the salary value is not present for the employee.

SELECT FullName,Salary
FROM EmployeeDetails
INNER JOIN
EmployeeSalary
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId

--Q7)Write an SQL query to fetch all the Employees who are also managers.

SELECT * 
FROM EmployeeDetails
WHERE EmpId IN (SELECT ManagerId FROM EmployeeDetails)

--Q8)Write an SQL query to fetch duplicate records from EmployeeDetails.

SELECT EmpId,FullName,ManagerId
FROM EmployeeDetails
 GROUP BY EmpId,FullName,ManagerId
 HAVING COUNT(*) > 1

--Q9)Write an SQL query to fetch only odd rows from the table.

SELECT *
FROM (
SELECT *, Row_Number() OVER(ORDER BY (SELECT NULL)) AS RowNumber
--Row_Number() starts with 1
FROM EmployeeDetails
) ROWNUMBEROFEmployeeDetails
WHERE RowNumber % 2 = 1 --Odd

--Q10)Write a query to find the 3rd highest salary from a table without top or limit keyword.

SELECT Salary
FROM (
SELECT Salary, Row_Number() OVER(ORDER BY Salary DESC) AS RowNumber
--Row_Number() starts with 1
FROM EmployeeSalary
) [3rd highest salary]
WHERE RowNumber = 3

--ASSINGMENT nos - 2
--Ques.1. Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’.

SELECT FullName from EmployeeDetails
WHERE ManagerId = 986

--Ques.2. Write an SQL query to fetch the different projects available from the EmployeeSalary table.

SELECT DISTINCT Project FROM EmployeeSalary

--Ques.3. Write an SQL query to fetch the count of employees working in project ‘P1’.

SELECT COUNT(EmpId) AS [COUNT OF EMPLOYEES] FROM EmployeeSalary WHERE Project = 'P1'

--Ques.4. Write an SQL query to find the maximum, minimum, and average salary of the employees.

SELECT MAX(Salary) AS MAXI, MIN(Salary) AS MINI, AVG(Salary) as Avarage FROM EmployeeSalary

--Ques.5. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.

SELECT EmpId FROM EmployeeSalary WHERE Salary >9000 AND Salary <15000

--Ques.6. Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.

SELECT EmpId,FullName FROM EmployeeDetails WHERE City = 'Toronto' AND ManagerId = 321

--Ques.7. Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321.

SELECT EmpId,FullName FROM EmployeeDetails WHERE City = 'California' OR ManagerId = 321

--Ques.8. Write an SQL query to fetch all those employees who work on Projects other than P1.

SELECT * FROM EmployeeSalary WHERE Project != 'P1'

--Ques.9. Write an SQL query to display the total salary of each employee adding the Salary with Variable value.

SELECT EmpId, (Salary + Variable) as Total_Salary FROM EmployeeSalary

--Ques.10. Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters.

SELECT FullName FROM EmployeeDetails WHERE FullName LIKE '__hn%'

--ASSINGMENT nos - 3

--Ques.1 Write an SQL query to fetch all the EmpIds which are present in either of the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’.

SELECT [dbo].[EmployeeDetails].[EmpId] FROM EmployeeDetails 
LEFT JOIN
EmployeeSalary
ON EmployeeDetails.EmpId = EmployeeSalary.EmpId

--Ques.2 Write an SQL query to fetch common records between two tables.

SELECT * FROM EmployeeDetails 
INNER JOIN
EmployeeSalary
ON EmployeeDetails.EmpId = EmployeeSalary.EmpId

--Ques.3. Write an SQL query to fetch records that are present in one table but not in another table.

SELECT * FROM EmployeeDetails 
RIGHT JOIN
EmployeeSalary
ON EmployeeDetails.EmpId = EmployeeSalary.EmpId

--Ques.4. Write an SQL query to fetch the EmpIds that are present in both the tables –  ‘EmployeeDetails’ and ‘EmployeeSalary.

SELECT [dbo].[EmployeeDetails].[EmpId] FROM EmployeeDetails 
FULL OUTER JOIN
EmployeeSalary
ON EmployeeDetails.EmpId = EmployeeSalary.EmpId

--Ques.5. Write an SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary.

SELECT [dbo].[EmployeeDetails].[EmpId] 
FROM EmployeeSalary
FULL OUTER JOIN
EmployeeDetails
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId

--Ques.6. Write an SQL query to fetch the employee’s full names and replace the space

SELECT [FullName], REPLACE([FullName],' ',',') AS REPLACED FROM [EmployeeDetails]

--Ques.7. Write an SQL query to fetch the position of a given character(s) in a field.

SELECT CHARINDEX('S',[FullName]) AS SEARCH FROM [EmployeeDetails]

--Ques.8. Write an SQL query to display both the EmpId and ManagerId together.

SELECT CONCAT (EmpId, ' ', ManagerId) as Names FROM [EmployeeDetails]

--OR

SELECT EmpId,ManagerId  FROM [EmployeeDetails]

--Ques.9. Write a query to fetch only the first name(string before space) from the FullName column of the EmployeeDetails table.

SELECT LEFT([FullName], (charindex(' ',[FullName])-1)) AS first_name FROM [EmployeeDetails]

--Ques.10. Write an SQL query to uppercase the name of the employee and lowercase the city values.

SELECT UPPER([FullName]) AS UPPERS, LOWER([City]) AS LOWERS FROM [EmployeeDetails]

--ASSINGMENT nos - 4
--Ques.1. Write an SQL query to find the count of the total occurrences of a particular character – ‘n’ in the FullName field.

SELECT  COUNT(CHARINDEX('n',[FullName])) AS COUNTOFFULLNAME FROM [EmployeeDetails]

--OR

SELECT 
		LEN(FullName) - LEN(REPLACE(FullName,'n', '')) AS COUNTOF_N
FROM EmployeeDetails;

--Ques.2. Write an SQL query to update the employee names by removing leading and trailing spaces.

UPDATE [dbo].[EmployeeDetails] SET FullName = TRIM(FullName)

--Ques.3. Fetch all the employees who are not working on any project.

SELECT [dbo].[EmployeeDetails].EmpId
FROM EmployeeSalary
inner join
EmployeeDetails
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId
WHERE Project IS NULL

--Ques.4. Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and less than or equal to 10000.

SELECT [FullName] FROM EmployeeSalary
inner join
EmployeeDetails
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId
WHERE Salary >= 5000 AND Salary <= 10000

--Ques.5. Write an SQL query to find the current date-time.

SELECT GETDATE() AS currentdatetime

--Ques.6. Write an SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2020.

SELECT FullName
FROM EmployeeDetails
INNER JOIN
EmployeeSalary
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId
WHERE YEAR(DateOfJoining) = 2020

--Ques.7. Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table.

SELECT *
FROM EmployeeDetails
INNER JOIN
EmployeeSalary
ON EmployeeSalary.EmpId = EmployeeDetails.EmpId

--Ques.8. Write an SQL query to fetch the project-wise count of employees sorted by project’s count in descending order.

SELECT [Project],COUNT(*) AS PROJECTCOUNT FROM [dbo].[EmployeeSalary]
GROUP BY [Project]
ORDER BY PROJECTCOUNT DESC

--Ques.9. Write a query to fetch employee names and salary records. Display the employee details even if the salary record is not present for the employee.


SELECT [FullName],[Salary] FROM [dbo].[EmployeeDetails]
FULL OUTER JOIN
[dbo].[EmployeeSalary]
ON [dbo].[EmployeeDetails].EmpId = [dbo].[EmployeeSalary].EmpId

--Ques.10. Write an SQL query to join 3 tables.