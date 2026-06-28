--Total Employees
Select  count(id) as total_employees
from HR_Project.dbo.HR_Data


--Employee Status Count
SELECT employee_status , Count(Employee_status) AS status_count
FROM HR_Project.dbo.HR_data
GROUP BY Employee_status
ORDER BY Status_count


--Gender Distribution
SELECT gender,count(id) AS total_employees
FROM HR_Project.dbo.HR_Data
GROUP BY gender
ORDER BY total_employees


--Department Employee Metric
SELECT department,
Count(id) AS total_employees,
SUM(CASE
	WHEN employee_status= 'Active' THEN 1 ELSE 0
	END) AS Active_employees,
SUM(CASE
	WHEN employee_status='Terminated' THEN 1 ELSE 0
	END) AS terminated_employees,
SUM(CASE
	WHEN employee_status='Contract' THEN 1 ELSE 0
	END) AS contract_employees
FROM HR_project.dbo.HR_Data
GROUP BY department
ORDER BY Total_employees


--Job Title Employee Metric
SELECT Jobtitle,
count(id) AS total_employees,
SUM(CASE
	WHEN employee_status='Active' THEN 1 ELSE 0
	END) AS active_employees,
SUM(CASE
	WHEN employee_status='Terminated' THEN 1 ELSE 0
	END) AS terminated_employees,
SUM(CASE
	WHEN employee_status='Contract' THEN 1 ELSE 0
	END) AS contract_employees
From HR_Project.dbo.HR_Data
GROUP BY jobtitle
ORDER BY total_employees DESC


--Employee by State
SELECT location_state,
count(id) AS total_employees,
SUM(CASE
	WHEN employee_status='Active' THEN 1 ELSE 0
	END) AS active_employees,
SUM(CASE
	WHEN employee_status='Terminated' THEN 1 ELSE 0
	END) AS terminated_employees,
SUM(CASE
	WHEN employee_status='Contract' THEN 1 ELSE 0
	END) AS contract_employees
From HR_Project.dbo.HR_Data
GROUP BY location_state
ORDER BY total_employees


--Retention Rate
SELECT
COUNT(CASE WHEN employee_status='Active' then 1 END)*100.0
/COUNT(id)
AS retention_rate
FROM HR_Project.dbo.HR_data


--Service Years
SELECT CONCAT( first_name,' ',last_name) AS Full_Name,
DATEDIFF(YEAR,hire_date,
ISNULL(term_date,GETDATE()))
AS service_years
FROM HR_Project.dbo.HR_Data 


--Longest Serving Employees (Window Function)
SELECT *
FROM(
SELECT concat(first_name,' ', last_name) AS full_name,employee_status,hire_date,
DATEDIFF(YEAR,hire_date,GETDATE()) AS ServiceYears,
RANK() OVER (ORDER BY hire_date) AS ServiceRank

FROM HR_Project.dbo.HR_Data)
A
WHERE ServiceRank <= 20

;


/* --Department Summary (CTE) */
WITH Department_Summary AS(
SELECT department,count(id) AS total_employees,
AVG(DATEDIFF(YEAR,hire_date,GETDATE())) AS AvgYearsWorked
FROM HR_Project.dbo.HR_Data
GROUP BY department
)
SELECT * 
FROM Department_Summary
;


--Final Report(Department Rank)
WITH Department_Summary1 AS(
SELECT department,count(id) AS total_employees,
AVG(DATEDIFF(YEAR,hire_date,GETDATE())) AS AvgYearsWorked
FROM HR_Project.dbo.HR_Data
GROUP BY department
)
SELECT department,total_employees,
AvgYearsWorked,
RANK() OVER(ORDER BY total_employees DESC)
AS Department_Rank
FROM Department_Summary1