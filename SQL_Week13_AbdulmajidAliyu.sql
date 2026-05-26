SELECT *
FROM EmployeeDemographics
WHERE Age <=30 AND Gender Like '%Male%'

SELECT AGE, COUNT(Age) AS COUNTAGE
FROM EmployeeDemographics
WHERE Age>28
GROUP BY Age
ORDER BY COUNTAGE