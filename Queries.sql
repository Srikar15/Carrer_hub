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



5. Write an SQL query to count the number of applications received for each job listing in the 
"Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all 
jobs, even if they have no applications.

SELECT  j.JobTitle,
    COUNT(a.ApplicationID) AS ApplicationCount
FROM   Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
GROUP BY j.JobTitle;


6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary 
range. Allow parameters for the minimum and maximum salary values. Display the job title, 
company name, location, and salary for each matching job.

SELECT JobTitle, CompanyName, JobLocation,Salary
FROM Jobs j
INNER JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary between 1000 and 92000;

7. Write an SQL query that retrieves the job application history for a specific applicant. Allow a 
parameter for the ApplicantID, and return a result set with the job titles, company names, and 
application dates for all the jobs the applicant has applied to.


SELECT a.ApplicantID,j.JobTitle,  c.CompanyName, a.ApplicationDate
FROM Applications a
INNER JOIN Jobs j ON a.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = 5;



8.Create an SQL query that calculates and displays the average salary offered by all companies for 
job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero.

SELECT AVG(Salary) AS AverageSalary
FROM Jobs
WHERE Salary > 0;


9. Write an SQL query to identify the company that has posted the most job listings. Display the 
company name along with the count of job listings they have posted. Handle ties if multiple 
companies have the same maximum count.

SELECT Top(1)with ties c.CompanyName, 
    COUNT(j.JobID) AS JobCount
FROM Companies c
INNER JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyID, c.CompanyName
ORDER BY JobCount DESC;

10. Find the applicants who have applied for positions in companies located in 'CityX' and have at 
least 3 years of experience.


SELECT ApllicantsId FROM  Applicants a
JOIN  Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN  Companies c ON j.CompanyID = c.CompanyID
WHERE c.Location = 'CityX' AND a.Experience >= 3;


11. Retrieve a list of distinct job titles with salaries between $60,000 and $80,000.

SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000;

12. Find the jobs that have not received any applications.

SELECT JobTitle
FROM Jobs where JobId NOT IN (Select JobID from Applicants);

13. Retrieve a list of job applicants along with the companies they have applied to and the positions 
they have applied for.

SELECT  a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM  Applications ap
JOIN  Applicants a ON ap.ApplicantID = a.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID;

14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not 
received any applications.

SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
FROM  Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY  c.CompanyName;


15. List all applicants along with the companies and positions they have applied for, including those 
who have not applied.

SELECT  a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM   Applicants a
LEFT JOIN  Applications ap ON a.ApplicantID = ap.ApplicantID
LEFT JOIN  Jobs j ON ap.JobID = j.JobID
LEFT JOIN  Companies c ON j.CompanyID = c.CompanyID;


16. Find companies that have posted jobs with a salary higher than the average salary of all jobs.

SELECT  CompanyName
FROM Companies c
INNER JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Jobs
);

17. Display a list of applicants with their names and a concatenated string of their city and state.

SELECT  FirstName, LastName, City + ', ' + State AS CityState
FROM  Applicants;


18. Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'

SELECT * FROM Jobs
WHERE JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%';

19. Retrieve a list of applicants and the jobs they have applied for, including those who have not 
applied and jobs without applicants.

SELECT a.FirstName, a.LastName, j.JobTitle
FROM Applicants a
LEFT JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
LEFT JOIN Jobs j ON ap.JobID = j.JobID


20. List all combinations of applicants and companies where the company is in a specific city and the 
applicant has more than 2 years of experience. For example: city=Chennai

SELECT  a.FirstName, a.LastName, c.CompanyName
FROM  Applicants a
JOIN  Jobs j ON j.CompanyID IN (SELECT CompanyID FROM Companies WHERE Location = 'Chennai')
JOIN  Companies c ON j.CompanyID = c.CompanyID
WHERE a.Experience > 2;
