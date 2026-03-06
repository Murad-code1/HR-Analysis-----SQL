-- 1) Select all columns from the Employees table 
SELECT * FROM HR.EMPLOYEES;

-- 2) Show employee_id as column 1 and concatenate first_name, last_name, and email as column 2
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME || ' ' || EMAIL AS EMPLOYEE_DATA
FROM HR.EMPLOYEES;

-- 3) Show employee_id and 20% of the sum of 12 months' salary
SELECT EMPLOYEE_ID, SALARY * 12 * 0.2 AS SALARY_20_PERCENT
FROM HR.EMPLOYEES;

-- 4) Show all distinct salary values from Employees table
SELECT DISTINCT SALARY AS UNIQUE_SALARY
FROM HR.EMPLOYEES;

-- 5) Show first_name, last_name, and annual salary
SELECT FIRST_NAME AS Name, LAST_NAME AS Surname, SALARY*12 AS Annual_Salary
FROM HR.EMPLOYEES;

-- 6) Show first_name, last_name, and salary minus commission for each employee
SELECT FIRST_NAME, LAST_NAME, SALARY - (SALARY * NVL(COMMISSION_PCT,0)) AS EMP_INCOME
FROM HR.EMPLOYEES;

-- 7) Select one row with two columns using DUAL: Code -111, Description - 'Computer code'
SELECT -111 AS CODE, 'COMPUTER CODE' AS DESCRIPTION FROM DUAL;

-- 8) Concatenate first_name with last_name in a sentence format
SELECT FIRST_NAME || '''s last name is ' || LAST_NAME AS EMPLOYEE_INFO
FROM HR.EMPLOYEES;

-- 9) Example of a projection: select specific columns only
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY
FROM HR.EMPLOYEES;

-- 10) Show all unique job codes from Employees table
SELECT DISTINCT JOB_ID FROM HR.EMPLOYEES;

-- 11) Create a database named Uni and use it
CREATE DATABASE Uni;
USE Uni;

-- 12) Create a table named Students
CREATE TABLE Students(
    ID_number INT PRIMARY KEY,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(23),
    Score INT,
    Birth_Date DATE
);

-- 13) Select all data from Students table
SELECT * FROM Students;

-- 14) Insert 5 records into Students table
INSERT INTO Students VALUES(1,'Murad','Rzayev',100,'2007-02-04');
INSERT INTO Students VALUES(2,'Leman','Samirova',20,'2025-02-02');
INSERT INTO Students VALUES(3,'Saril','Ferzay',70,'1999-09-04');
INSERT INTO Students VALUES(4,'Abdul','ibharem',59,'2004-04-04');
INSERT INTO Students VALUES(5,'Mahir','Abbasov',0,'2005-10-09');

-- 15) Add an Email column to the Students table
ALTER TABLE Students ADD Email VARCHAR(30);

-- 16) Create a table named University
CREATE TABLE University(
    ID INT PRIMARY KEY,
    Name VARCHAR(30),
    Faculty VARCHAR(50),
    Student_Count INT
);

-- 17) Select all data from University table
SELECT * FROM University;

-- 18) Insert 5 records into University table
INSERT INTO University VALUES(1,'BMU','Information and Computer Sciences',400);
INSERT INTO University VALUES(2,'BDU','Information and Computer Sciences',325);
INSERT INTO University VALUES(3,'AZTU','Information and Computer Sciences',530);
INSERT INTO University VALUES(4,'ATU','Information and Computer Sciences',400);
INSERT INTO University VALUES(5,'UNEC','Information and Computer Sciences',400);

-- 19) Drop the Students table
DROP TABLE Students;

-- 20) Show employees whose manager_id is NULL
SELECT * FROM employees WHERE manager_id IS NULL;

-- 21) Find employees whose salary is between 3000 and 8000
SELECT * FROM employees WHERE salary BETWEEN 3000 AND 8000;

-- 22) Show employees whose department_id is not 50 or 80
SELECT * FROM employees WHERE department_id NOT BETWEEN 50 AND 80;

-- 23) Show top 10 highest-paid employees
SELECT * FROM employees ORDER BY salary DESC OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- 24) Sort employees by hire_date in ascending order (oldest first)
SELECT * FROM employees ORDER BY hire_date ASC;

-- 25) Show employees whose name starts with 'S' and salary > 6000, sorted by salary descending
SELECT * FROM employees WHERE salary > 6000 AND first_name LIKE 'S%' ORDER BY salary DESC;

-- 26) Find employees whose first name is exactly 5 letters long
SELECT * FROM employees WHERE first_name LIKE '_____';

-- 27) Sort employees first by department_id, then by salary
SELECT * FROM employees ORDER BY department_id, salary;

-- 28) Show all employees working in "HR" or "Marketing" departments
SELECT * FROM employees WHERE department_id='HR' OR department_id='Marketing';

-- 29) Show name, last name, and salary of employees in "IT" department with salary less than 5000
SELECT first_name, last_name, salary FROM employees WHERE department_id='IT' AND salary<5000;

-- 30) Display a sentence for each employee: "Ali employee's salary: 5000"
SELECT CONCAT(first_name, ' employee''s salary: ', salary) AS EMP_SALARY FROM employees;

-- 31) Show employees in "IT" or "Finance" departments with salary between 3000 and 7000
SELECT first_name, last_name FROM employees 
WHERE (department_id='IT' OR department_id='Finance') AND salary BETWEEN 3000 AND 7000;

-- 32) Show first name and last name of employees whose first name is longer than 5 letters
SELECT first_name, last_name FROM employees WHERE LEN(first_name)>5;

-- 33) Show only first 3 letters of employees' last name
SELECT SUBSTRING(last_name,1,3) AS SHORT_LAST_NAME FROM employees;

-- 34) Concatenate first and last names with a space and name the column "Full_Name"
SELECT CONCAT(first_name, ' ', last_name) AS Full_Name FROM employees;

-- 35) Find employees whose second letter of first name is 'a' or 'e'
SELECT * FROM employees WHERE SUBSTRING(first_name,2,1) IN ('a','e');

-- 36) Show employees whose salary is greater than the average salary
SELECT employee_id, first_name, last_name, department_id
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 37) Show departments whose average salary is greater than 6000
SELECT department_id, AVG(salary) AS AVG_SALARY FROM employees
GROUP BY department_id
HAVING AVG(salary) > 6000;

-- 38) Count employees per job_id
SELECT job_id, COUNT(*) AS EMP_COUNT FROM employees GROUP BY job_id;

-- 39) Show departments with more than 3 employees
SELECT department_id, COUNT(*) AS EMP_COUNT FROM employees GROUP BY department_id HAVING COUNT(*)>3;

-- 40) Find minimum and maximum salary
SELECT MIN(salary) AS MIN_SALARY, MAX(salary) AS MAX_SALARY FROM employees;

-- 41) Show employees working in departments located in 'United Kingdom' or 'Germany'
SELECT E.first_name, E.last_name, D.department_name, C.country_name
FROM employees E
INNER JOIN departments D ON E.department_id = D.department_id
INNER JOIN locations L ON D.location_id = L.location_id
INNER JOIN countries C ON L.country_id = C.country_id
WHERE C.country_name IN ('United Kingdom','Germany');

-- 42) Show job title, employee count, total salary, average salary per job; only jobs with average salary > 5000 and order descending
SELECT 
    J.job_title AS JOB_TITLE, 
    COUNT(E.employee_id) AS EMP_COUNT, 
    SUM(E.salary) AS TOTAL_SALARY, 
    AVG(E.salary) AS AVG_SALARY
FROM employees E
INNER JOIN jobs J ON E.job_id = J.job_id
GROUP BY J.job_title
HAVING AVG(E.salary) > 5000
ORDER BY AVG(E.salary) DESC;

-- 43) Categorize employees based on hire date and count number in each category
SELECT 
    CASE 
        WHEN hire_date < '2005-01-01' THEN 'Veteran'
        WHEN hire_date BETWEEN '2005-01-01' AND '2010-12-31' THEN 'Experienced'
        ELSE 'New'
    END AS EMP_STATUS,
    COUNT(*) AS EMP_COUNT
FROM employees
GROUP BY 
    CASE 
        WHEN hire_date < '2005-01-01' THEN 'Veteran'
        WHEN hire_date BETWEEN '2005-01-01' AND '2010-12-31' THEN 'Experienced'
        ELSE 'New'
    END;