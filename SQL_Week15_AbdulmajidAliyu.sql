select *
from EmployeeSalary

Select EmployeeID, salary, (select avg(salary) from EmployeeSalary) as AvgSalary
From EmployeeSalary

Select EmployeeID, Salary, Jobtitle
From EmployeeSalary
where EmployeeID in(
	Select EmployeeID
	From EmployeeDemographics Where age >30)
