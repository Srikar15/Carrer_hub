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

18. SELECT 
    JobTitle, 
    CompanyID, 
    JobLocation, 
    Salary
FROM Jobs
WHERE JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%';



-- Insert into Companies
INSERT INTO Companies (CompanyName, Location) 
VALUES ('Tech Solutions', 'New York'), 
       ('Innovatech', 'San Francisco');

-- Insert into Jobs
INSERT INTO Jobs (CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType) 
VALUES (1, 'Software Engineer', 'Develop and maintain software applications.', 'New York', 90000.00, 'Full-Time'), 
       (2, 'Data Analyst', 'Analyze data to drive business insights.', 'San Francisco', 75000.00, 'Full-Time');

-- Insert into Applicants
INSERT INTO Applicants (FirstName, LastName, Email, Phone, Resume) 
VALUES ('Alice', 'Johnson', 'alice.johnson@email.com', '123-456-7890', 'Resume of Alice'), 
       ('Bob', 'Smith', 'bob.smith@email.com', '987-654-3210', 'Resume of Bob');

-- Insert into Applications
INSERT INTO Applications (JobID, ApplicantID, CoverLetter) 
VALUES (1, 1, 'I am excited to apply for the Software Engineer position at Tech Solutions.'), 
       (2, 2, 'I am interested in the Data Analyst role at Innovatech.');
