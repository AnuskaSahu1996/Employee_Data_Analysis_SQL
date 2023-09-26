--Assignment 3 Advanced ASSINGMENT 

CREATE DATABASE EmployeeDetails

USE EmployeeDetails

CREATE TABLE EmployeeInfo
(EmpID INT PRIMARY KEY,
EmpFname VARCHAR(50),
EmpLname VARCHAR(50),
Department VARCHAR(50),
Project VARCHAR(20),
[Address] VARCHAR(100),
DOB DATE,
Gender VARCHAR(30))

INSERT INTO EmployeeInfo(EmpID, EmpFname,EmpLname,Department,Project,[Address],DOB,Gender)

VALUES
		(1,'Sanjay','Meher','HR','P1','Hyderabad(HYD)','01/12/1976','M'),
		(2,'Ananya','Mishra','Admin','P2','Delhi(DEL)','02/05/1968','F'),
		(3,'Rohan', 'Diwan','Account','P3','Mumbai(BOM)','01/01/1980','M'),
		(4,'Sonia','Kulkarni','HR','P1','Hyderabad(HYD)','02/05/1992','F'),
		(5,'Ankit','Kapoor','Admin','P2','Delhi(DEL)','03/07/1994','M')


CREATE TABLE EmployeePosition
(EmpID INT, 
EmpPosition VARCHAR(50),
DateOfJoining DATE,
Salary INT)


INSERT INTO EmployeePosition(EmpID, EmpPosition,DateOfJoining,Salary)

VALUES
		(1,'Manager','01/05/2022',500000),
		(2,'Executive','02/05/2022',75000),
		(3,'Manager','01/05/2022',90000),
		(2,'Lead','02/05/2022',85000),
		(1,'Executive','01/05/2022',300000)

SELECT * FROM EmployeeInfo

--Q1)Write a query to fetch the EmpFname from the EmployeeInfo table in the upper case and use the ALIAS name as EmpName.

SELECT UPPER(EmpFname) AS EmpName FROM EmployeeInfo

--Q2)Write a query to fetch the number of employees working in the department ‘HR’.

SELECT COUNT(Department) AS HR FROM EmployeeInfo 
WHERE Department = 'HR'

--Q3)Write a query to get the current date.

SELECT GETDATE() AS RESULT

--Q4)Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.

SELECT LEFT(EmpLname,4) AS RESULT FROM EmployeeInfo

--Q5)Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.

SELECT LEFT([Address],(CHARINDEX('(',[Address])-1)) AS RESULT FROM EmployeeInfo

--IF WE ONLY WANT THE CHARACTER WHICH PRESENT INSIDE THE BRACKET. 
--SELECT RIGHT([Address],5) FROM EmployeeInfo

--Q6)Write a query to create a new table that consists of data and structure copied from the other table.

SELECT * INTO NEW_TABLE_EmployeeInfo FROM EmployeeInfo

SELECT * FROM NEW_TABLE_EmployeeInfo


--Q7)Write q query to find all the employees whose salary is between 50000 to 100000.

SELECT EmpID FROM EmployeePosition
WHERE Salary >50000 AND Salary <100000

--Q8)Write a query to find the names of employees that begin with ‘S’

SELECT EmpFname FROM EmployeeInfo WHERE EmpFname LIKE 'S%'

--Q9)Write a query to fetch top N records.

SELECT TOP 3 * FROM EmployeeInfo

--Q10)Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space.

SELECT CONCAT(EmpFname,'  ',EmpLname) AS FullName FROM EmployeeInfo

--Q11. Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1975 and are grouped according to gender

SELECT COUNT(DOB) AS COUNTS, Gender FROM EmployeeInfo
WHERE DOB BETWEEN '1970/05/02' AND '1975/12/31'
GROUP BY Gender

--Q12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.

SELECT * FROM EmployeeInfo 
ORDER BY EmpLname DESC,Department ASC

--Q13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.

SELECT * FROM EmployeeInfo
WHERE EmpLname LIKE '____A'

select * from EmployeeInfo

--Q14. Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.

SELECT * FROM EmployeeInfo WHERE EmpFname NOT LIKE 'S%'

--Q15. Write a query to fetch details of employees with the address as “DELHI(DEL)”.

SELECT * FROM EmployeeInfo WHERE Address = 'DELHI(DEL)'

--Q16. Write a query to fetch all employees who also hold the managerial position.

SELECT EmpID FROM EmployeePosition WHERE EmpID IN(SELECT EmpID FROM EmployeePosition WHERE EmpPosition = 'Manager')

--Q17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order.

SELECT Department, COUNT(Department) AS COUNTOFDepartment FROM EmployeeInfo
GROUP BY Department
ORDER BY Department ASC

--Q18. Write a query to calculate the even and odd records from a table.

SELECT *
FROM (
SELECT *, Row_Number() OVER(ORDER BY (SELECT NULL)) AS RowNumber
--Row_Number() starts with 1
FROM EmployeeInfo
) ROWNUMBEROFEmployeeINFO
WHERE RowNumber % 2 = 1 --Odd

--AND

SELECT *
FROM (
SELECT *, Row_Number() OVER(ORDER BY (SELECT NULL)) AS RowNumber
--Row_Number() starts with 1
FROM EmployeeInfo
) ROWNUMBEROFEmployeeINFO
WHERE RowNumber % 2 = 0 --EVEN

--Q19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table.

SELECT * FROM EmployeeInfo
WHERE EmpID IN (SELECT EmpID FROM EmployeePosition)

--Q20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table.

SELECT TOP 2 SALARY FROM EmployeePosition
ORDER BY Salary DESC

SELECT TOP 2 SALARY FROM EmployeePosition
ORDER BY Salary ASC

--Q21. Write a query to find the Nth highest salary from the table without using TOP/limit keyword.

SELECT Salary
FROM (
SELECT Salary, Row_Number() OVER(ORDER BY Salary DESC) AS RowNumber
--Row_Number() starts with 1
FROM EmployeePosition
) [3rd highest salary]
WHERE RowNumber = 1

--Q22. Write a query to retrieve duplicate records from a table.

SELECT EmpID
FROM EmployeePosition
 GROUP BY EmpID
 HAVING COUNT(*) > 1

 --Q23. Write a query to retrieve the list of employees working in the same department.

 SELECT EI.* 
 FROM EmployeeInfo AS EI
 WHERE EI.Department IN
( SELECT EI1.Department
 FROM EmployeeInfo AS EI1
 WHERE EI.EmpID != EI1.EmpID)

 --Q24. Write a query to retrieve the last 3 records from the EmployeeInfo table.

 select TOP 3* from EmployeeInfo
 ORDER BY EmpID DESC

 --Q25. Write a query to find the third-highest salary from the EmpPosition table.

 SELECT Salary
FROM (
SELECT Salary, Row_Number() OVER(ORDER BY Salary DESC) AS RowNumber
--Row_Number() starts with 1
FROM EmployeePosition
) [3rd highest salary]
WHERE RowNumber = 3

--OR

SELECT TOP 1 Salary FROM 
(SELECT TOP 3 Salary FROM EmployeePosition
ORDER BY Salary DESC) AS SUB
ORDER BY Salary ASC

--Q26. Write a query to display the first and the last record from the EmployeeInfo table.

SELECT TOP 1* FROM EmployeeInfo
ORDER BY EmpID ASC

SELECT TOP 1* FROM EmployeeInfo
ORDER BY EmpID DESC

--Q27. Write a query to add email validation to your database


--Q28. Write a query to retrieve Departments who have less than 2 employees working in it.

 select Department from EmployeeInfo
 group by Department
 having count(Department) < 2

--Q29. Write a query to retrieve EmpPostion along with total salaries paid for each of them

select EmpPosition,Salary from EmployeePosition 

--Q30. Write a query to fetch 50% records from the EmployeeInfo table

SELECT TOP 50 PERCENT*
FROM EmployeeInfo