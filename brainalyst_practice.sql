create database practice;
-- 1. Write a SQL query to find those employees whose salary is higher than 9000. Return 
-- first name, last name and department number and salary
select * from employee_hr_data;
select first_name,last_name,department_id from employee_hr_data where salary >9000;
-- 2 Write a SQL query to identify employees who do not have a department number. Return 
-- employee_id, first_name, last_name, email, phone_number, hire_date, job_id, 
-- salary,commission_pct, manager_id and department_id
select  employee_id,first_name,last_name,email, phone_number, hire_date, job_id,salary,commission_pct, manager_id , department_id
 from employee_hr_data where department_id =' ';
--  3. Write a SQL query to find those employees whose first name does not contain the letter 
-- ‘T’. Sort the result-set in ascending order by department ID. Return full name (first and 
-- last name together), hire_date, salary and department_id.
select concat(first_name,last_name) as full_name,hire_date,salary,department_id from employee_hr_data where first_name not like '%T%' order by department_id;
-- 4. Write a SQL query to find those employees who earn between 9000 and 12000 (Begin 
-- and end values are included.) and get some commission. Return all fields
select * from employee_hr_data where salary >=9000 and salary <=12000 and commission_pct>0 ;
-- 5. Write a SQL query to find those employees who do not earn any commission. Return full 
-- name (first and last name), and salary
select * from employee_hr_data;
select concat(trim(first_name),trim(last_name)) as full_name ,salary from employee_hr_data where COMMISSION_PCT=0;
-- 6. Write a SQL query to find those employees who work under a manager. Return full name 
-- (first and last name), salary, and manager ID
select concat(first_name,last_name) as full_name,salary , manager_id from employee_hr_data where manager_id !=0;
-- 7. Write a SQL query to find employees whose first names contain the letters F, T, or M. 
-- Sort the result-set in descending order by salary. Return all fields
select * from employee_hr_data where FIRST_NAME like '%F%' or FIRST_NAME like'%T%' or FIRST_NAME like'%M%' order by salary desc;
-- 8. Write a SQL query to find those employees who earn above 12000 or the seventh 
-- character in their phone number is 3. Sort the result-set in descending order by first 
-- name. Return full name (first name and last name), hire date, commission percentage, 
-- email, and telephone separated by '-', and salary
select concat(first_name,last_name) as full_name,hire_date,commission_pct,email,salary,PHONE_NUMBER from employee_hr_data where SALARY>12000 or PHONE_NUMBER like '%_______3%' order by first_name desc;
-- 9. Write a SQL query to find those employees whose first name contains a character 's' in 
-- the third position. Return first name, last name and department id.
select first_name,last_name,department_id from employee_hr_data where first_name like '%s%';
-- 10. Write a SQL query to find those employees who worked more than two jobs in the past. 
-- Return employee id
select count(distinct(job_id)), employee_id from `practice`.`employee_hr_data` group by employee_id;
-- 11. Write a SQL query to count the number of employees, the sum of all salary, and 
-- difference between the highest salary and lowest salaries by each job id. Return job_id, 
-- count, sum, salary_difference
select job_id,count(employee_id) as emp , sum(salary) as sal, max(salary) - min(salary) as diff from employee_hr_data group by job_id ;
-- 12. Write a SQL query to find each job ids where two or more employees worked for more 
-- than 300 days. Return job id
SELECT 
    job_id
FROM 
    employee_hr_data
GROUP BY 
    job_id
HAVING 
    COUNT(CASE WHEN DATEDIFF(CURDATE(), hire_date) > 300 THEN 1 END) >= 2;
-- 13. Write a SQL query to count the number of employees worked under each manager. 
-- Return manager ID and number of employees
select manager_id,count(employee_id) as countemp from employee_hr_data group by MANAGER_ID;
-- 14. Write a SQL query to calculate the average salary of employees who receive a 
-- commission percentage for each department. Return department id, average salary.
select department_id,avg(salary) from employee_hr_data where commission_pct !=0 group by department_id ;
-- 15. Write a SQL query to find the departments where more than ten employees receive 
-- commissions. Return department id
select department_id from employee_hr_data where COMMISSION_PCT !=0 group by department_id having count(*)>10;
-- 16. Write a SQL query to find those job titles where maximum salary falls between 10000 
-- and 15000 (Begin and end values are included.). Return job_title, max_salarymin_salary
select job_id, max(salary),min(salary) from employee_hr_data group by job_id having max(salary) between 10000 and 15000;
-- 17. Write a SQL query to find details of those jobs where the minimum salary exceeds 9000. 
-- Return all the fields of jobs
select job_id , min(salary) from employee_hr_data group by job_id having min(salary)>9000;
-- 18. Write a SQL query to find those employees who work in the same department as ‘Clara’. 
-- Exclude all those records where first name is ‘Clara’. Return first name, last name and 
-- hire date.

set @a = (select department_id from employee_hr_data where first_name like '%Clara%');
select @a;
select first_name , last_name ,hire_date from employee_hr_data where department_id = @a;
-- 19. Write a SQL query to find those employees who earn more than the average salary and 
-- work in the same department as an employee whose first name contains the letter 'J'. 
-- Return employee ID, first name and salary
WITH cte AS (
    SELECT department_id 
    FROM employee_hr_data 
    WHERE first_name LIKE '%J%'
),
cte1 AS (
    SELECT department_id ,employee_id, first_name, salary
    FROM employee_hr_data
    WHERE salary > (SELECT AVG(salary) FROM employee_hr_data)
)
select employee_id, first_name, salary from cte1 join cte on cte1.department_id = cte.department_id;
-- 20. Write a query to display the employee id, name ( first name and last name ) and the job 
-- id column with a modified title SALESMAN for those employees whose job title is 
-- ST_MAN and DEVELOPER for whose job title is IT_PROG

SELECT 
    employee_id,
    CONCAT(first_name, ' ', last_name) AS name,
    CASE 
        WHEN trim(job_id) = 'ST_MAN' THEN 'SALESMAN'
        WHEN trim(job_id) = 'IT_PROG' THEN 'DEVELOPER'
        ELSE job_id -- Keeps the original job_id if it doesn't match the specified values
    END AS job_title
FROM 
    employee_hr_data;
    -- joins 
-- 1. Write a SQL query to find the first name, last name, department, city, and state 
-- province for each employee
select * from location_hr_data;
select first_name,last_name,d.department_name,city,STATE_PROVINCE from employee_hr_data e join department_hr_data d on e.DEPARTMENT_ID = d.department_id 
join location_hr_data l on l.LOCATION_ID = d.LOCATION_ID ;
-- 2. Write a SQL query to find the first name, last name, salary, and job grade for all 
-- employees
select * from employee_hr_data;
select  first name, last name, salary, grade_level from employee_hr_data e join job_grades_hr_data j on e;

-- 3. Write a SQL query to find all those employees who work in department ID 80 or 40. 
-- Return first name, last name, department number and department name
select first_name,last_name,d.department_id,department_name from employee_hr_data e join department_hr_data d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 4. Write a SQL query to find those employees whose first name contains the letter ‘z’. 
-- Return first name, last name, department, city, and state province
select first_name,last_name,d.department_name,city,STATE_PROVINCE from employee_hr_data e join department_hr_data d on e.DEPARTMENT_ID = d.department_id 
join location_hr_data l on l.LOCATION_ID = d.LOCATION_ID where first_name like '%Z%' ;

-- 5. Write a SQL query to find all employees who joined on 1st January 1993 and left on 
-- or before 31 August 1997. Return job title, department name, employee name, and 
-- joining date of the job
SELECT 
    j.job_id,
    d.department_name,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    j.start_date
FROM 
    employee_hr_data e
JOIN 
    job_history_hr_data j ON e.employee_id = j.employee_id
JOIN 
    department_hr_data d ON j.department_id = d.department_id;
-- 6. Write a SQL query to calculate the difference between the maximum salary of the job 
-- and the employee's salary. Return job title, employee name, and salary difference.
select (j.max_salary - e.salary) as salary_difference, j.job_Id ,  CONCAT(e.first_name, ' ', e.last_name) AS full_name   from jobs_hr_data j join employee_hr_data e  on e.JOB_ID = j.JOB_ID;
-- 7. Write a SQL query to find the department name and the full name (first and last 
-- name) of the manager
-- department_hr_data
select distinct(concat(e.first_name , e.last_name)),department_name from employee_hr_data e join employee_hr_data e1 on e.EMPLOYEE_ID = e1.MANAGER_ID join department_hr_data d on d.DEPARTMENT_ID = e.DEPARTMENT_ID ;
-- 8. Write a SQL query to find the department name, full name (first and last name) of the 
-- manager and their city
select distinct(concat(e.first_name , e.last_name)),department_name,city from employee_hr_data e join employee_hr_data e1 on e.EMPLOYEE_ID = e1.MANAGER_ID join department_hr_data d on d.DEPARTMENT_ID = e.DEPARTMENT_ID join location_hr_data l on l.location_id = d.location_id ;
-- 9. Write a SQL query to find out the full name (first and last name) of the employee with 
-- an ID and the name of the country where he/she is currently employed
select concat(e.first_name , e.last_name),e.employee_id,country_name from employee_hr_data e join department_hr_data d on e.department_id = d.department_id 
join location_hr_data l on l.location_id = d.location_id join countries_hr_data c on l.country_id = c.COUNTRY_ID;