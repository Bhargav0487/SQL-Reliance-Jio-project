show databases;

create database RelianceJio;

use RelianceJio;

create table Employee (
Emp_ID int(10),
First_Name varchar(10),
Last_Name varchar(10),
Dept_code int (3));

select * from employee;

insert into Employee (Emp_ID, First_Name, Last_Name, Dept_Code)
values
(248132604,"Shivam", "Deo",76),
(815242165,"Parijat", "Shankar",43),
(416122768,"rahul", "Srivastava", 66),
(960828909,"Kumar","Swamy",47),
(440361783,"Shankh","Khurana",23),
(851591490,"Swapnil", "Mehta", 43),
(668957687,"Arvind", "Chattejee",23),
(585068105,"Jalpesh", "Modi",33),
(379882096,"Kavita", "Yadav", 23),
(718929853,"Syed", "Zaheer", 66),
(873840890,"Sanjay", "Shukla",76),
(941877566,"Ragini", "Malhotra",33),
(998809976,"Javed","Khan", 23),
(669391133, "Vikram","Singh",43),
(861199021,"Ajay","Kumar",23),
(980140890,"Pankaj","Verma",43),
(750603819,"Roshan","Singh",47),
(558885983,"Sunaina","Yadav",76),
(392214056,"Bhavna","Sharma",66),
(164880802,"Pooja","Kumari",47);

select * from employee;


create table Department(
Dept_Code int (10),
Dept_Name varchar(25),
Dept_Budget int (12));

insert into Department (Dept_Code,Dept_Name,Dept_Budget)
values
(23,"Sales and Marketing",50000000),
(66,"Information Technology",100000000),
(43,"Customer Service",30000000),
(33, "Human Resources",20000000),
(76, "Finance and Accounting",40000000),
(47,"Operations",60000000);

select * from department;
#Questions:


#What are the unique Last_Names from the Employee Table?
SELECT DISTINCT Last_Name FROM Employee;

#What is the total number of employees in the company?
SELECT COUNT(Emp_ID) FROM Employee;

#What is the total budget for the company?
SELECT SUM(Dept_Budget) FROM Department;

#What is the department code and budget for the "Operations" department?
SELECT Dept_Code, Dept_Budget FROM Department WHERE Dept_Name = 'Operations';

#What is the total budget for the "Information Technology" and "Finance and Accounting" departments?
SELECT SUM(Dept_Budget) FROM Department 
WHERE Dept_Name IN ('Information Technology', 'Finance and Accounting');

#Who are the employees working in the "Sales and Marketing" department?
SELECT Employee.First_Name, Employee.Last_Name FROM Employee 
inner JOIN Department ON Employee.Dept_Code = Department.Dept_Code 
WHERE Department.Dept_Name = 'Sales and Marketing';

#What is the name of the employee with Emp_ID 718929853?
SELECT First_Name, Last_Name FROM Employee WHERE Emp_ID = 718929853;

#What is the budget for the "Customer Service" department?
SELECT Dept_Budget FROM Department WHERE Dept_Name = 'Customer Service';

#What is the total budget for all departments except "Operations"?
SELECT SUM(Dept_Budget) FROM Department WHERE Dept_Name <> 'Operations';    # for except use <>. 

#What is the Emp_ID, First_Name and department_code of the employee with the last name "Shukla"?
SELECT Emp_ID, First_Name, Dept_Code FROM Employee WHERE Last_Name = 'Shukla';

#What is the average budget for the departments with Dept_Code 23 and 43?
SELECT AVG(Dept_Budget) FROM Department WHERE Dept_Code IN (23, 43);

#How many employees are there whose first name starts with the letter "S"?
SELECT COUNT(*) FROM Employee WHERE First_Name LIKE 'S%';

#List the name of Employees whose First_name starts with "S".
SELECT First_Name, Last_Name FROM Employee WHERE First_Name LIKE 'S%';

#List the name of Employees whose First_name starts with "S" and ends with "A".
SELECT First_Name, Last_Name FROM Employee WHERE First_Name LIKE 'S%a';

#Fetch Top 3 records of all the Departments in descending order based on the budget of the department.
SELECT * FROM Department ORDER BY Dept_Budget DESC LIMIT 3;

#Fetch data of all employees from the employee table whose dept_code is an odd number
SELECT * FROM Employee WHERE Dept_Code % 2 <> 0;  # except 0 we find odd number.

#Create a clone of the table employee with a name Clone_table and having two columns, one with full name and the other with the department code with an alias D_Code
CREATE TABLE Clone_Table AS 
SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name, Dept_Code AS D_Code 
FROM Employee;
show tables;
#Delete employee details of "Ajay Kumar" from Clone_Table
DELETE FROM Clone_Table WHERE Full_Name = 'Ajay Kumar';
select * from Clone_Table;

#The name of the employee "rahul Srivasatava" has a lower case 'r', make changes in the clone table so that the full_name is written as "Rahul Srivastava"
UPDATE Clone_Table SET Full_Name = 'Rahul Srivastava' WHERE Full_Name = 'rahul Srivastava';
select * from Clone_Table;

#Convert Full_name from clone table into uppercase.
SELECT UPPER(Full_Name) FROM Clone_Table;

#Fetch second to fifth record from the department table based on the Highest Budget.
SELECT * FROM Department ORDER BY Dept_Budget DESC LIMIT 4 OFFSET 1;

#The employee with the name "Jalpesh Modi" has decided to move into another department, delete the D_code value corresponding to "Jalpesh_Modi" from the clone_table
UPDATE Clone_Table SET D_Code = NULL WHERE Full_Name = 'Jalpesh Modi';
select * from Clone_Table;

#Change the name of the column D_Code to Department_code in clone table.
ALTER TABLE Clone_Table RENAME COLUMN D_Code TO Department_code;
select * from Clone_Table;

#Since no mathematical operation will be performed on emp_id in employee table, convert its data type from int to varchar
ALTER TABLE Employee 
MODIFY Emp_ID VARCHAR(20);
select * from Clone_Table;

#The Company has decided to increase the budget of all the department by 10% , make changes accordingly to fetch old and new budget
SELECT Dept_Name, Dept_Budget AS Old_Budget, (Dept_Budget * 1.10) AS New_Budget 
FROM Department;

#What is the name of the department with the lowest budget?
SELECT Dept_Name FROM Department ORDER BY Dept_Budget ASC LIMIT 1;

#Who are the employees working in the departments with budgets greater than 40,000,000?
SELECT Employee.First_Name, Employee.Last_Name 
FROM Employee
inner JOIN Department ON Employee.Dept_Code = Department.Dept_Code
WHERE Department.Dept_Budget > 40000000;

#What is the name of the department with the second highest budget?
SELECT Dept_Name FROM Department ORDER BY Dept_Budget DESC LIMIT 1 OFFSET 1;  #second highest using 1 offset 1.

#How many employees are there in each department?
SELECT Department.Dept_Name, COUNT(Employee.Emp_ID) 
FROM Department
LEFT JOIN Employee ON Department.Dept_Code = Employee.Dept_Code
GROUP BY Department.Dept_Name;

#Create view for "Sales and Marketing"
CREATE VIEW Sales_Marketing_Employees AS
SELECT Employee.* FROM Employee
inner JOIN Department ON Employee.Dept_Code = Department.Dept_Code
WHERE Department.Dept_Name = 'Sales and Marketing';
select * from employee;
select * from department;


