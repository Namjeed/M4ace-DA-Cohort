Select * from EmployeeDemographics

create index ix_name
on employeedemographics(FirstName, Lastname)

drop index EmployeeDemographics.ix_name