5.SELECT 
    j.JobTitle, 
    COUNT(a.ApplicationID) AS ApplicationCount
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
GROUP BY j.JobTitle;

6. SELECT 
    j.JobTitle, 
    c.CompanyName, 
    j.JobLocation, 
    j.Salary
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN @MinSalary AND @MaxSalary;

7. SELECT 
    j.JobTitle, 
    c.CompanyName, 
    a.ApplicationDate
FROM Applications a
JOIN Jobs j ON a.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = @ApplicantID
ORDER BY a.ApplicationDate DESC;

8. SELECT 
    AVG(Salary) AS AverageSalary
FROM Jobs
WHERE Salary > 0;

9. SELECT 
    c.CompanyName, 
    COUNT(j.JobID) AS JobCount
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyID, c.CompanyName
ORDER BY JobCount DESC
LIMIT 1;

10. SELECT 
    a.FirstName, 
    a.LastName, 
    a.Email, 
    a.Phone
FROM Applicants a
JOIN Applications app ON a.ApplicantID = app.ApplicantID
JOIN Jobs j ON app.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE c.Location = 'CityX' 
AND a.Experience >= 3;

11. SELECT DISTINCT 
    JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000;

12. SELECT 
    j.JobTitle, 
    c.CompanyName
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
LEFT JOIN Applications a ON j.JobID = a.JobID
WHERE a.ApplicationID IS NULL;

16. SELECT DISTINCT 
    c.CompanyName
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.Salary > (
    SELECT AVG(Salary)
    FROM Jobs
);
