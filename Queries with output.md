# Query Outputs — University Course Management System

All queries below were run against the sample data in `schema_and_data.sql`.


## Query 1 — CRUD Operations

**1a. CREATE — Insert a new student**

```sql
INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES (13, 'Grace', 'Hopper', 'grace.hopper@email.com', '2001-12-09', '2023-08-01');
```

_(statement executed — no result set)_

**1b. READ — Retrieve all students**

```sql
SELECT * FROM Students ORDER BY StudentID;
```

| StudentID | FirstName | LastName | Email | BirthDate | EnrollmentDate |
|---|---|---|---|---|---|
| 1 | John | Doe | john.doe@email.com | 2000-01-15 | 2022-08-01 |
| 2 | Jane | Smith | jane.smith@email.com | 1999-05-25 | 2021-08-01 |
| 3 | Mark | Twain | mark.twain@email.com | 2001-03-10 | 2023-01-15 |
| 4 | Emily | Clark | emily.clark@email.com | 2000-11-02 | 2019-08-20 |
| 5 | Sara | Connor | sara.connor@email.com | 2002-07-19 | 2024-01-10 |
| 6 | Liam | Brown | liam.brown@email.com | 2001-09-30 | 2020-08-15 |
| 7 | Olivia | Davis | olivia.davis@email.com | 1998-12-05 | 2022-09-01 |
| 8 | Noah | Wilson | noah.wilson@email.com | 2000-06-14 | 2018-08-25 |
| 9 | Ava | Martinez | ava.martinez@email.com | 2003-02-22 | 2023-08-01 |
| 10 | James | Taylor | james.taylor@email.com | 1999-10-08 | 2021-01-12 |
| 11 | Sophia | Anderson | sophia.anderson@email.com | 2002-04-17 | 2024-08-01 |
| 12 | Ethan | Thomas | ethan.thomas@email.com | 2000-08-29 | 2019-01-05 |
| 13 | Grace | Hopper | grace.hopper@email.com | 2001-12-09 | 2023-08-01 |

**1c. UPDATE — Update a student's email**

```sql
UPDATE Students SET Email = 'grace.hopper.updated@email.com' WHERE StudentID = 13;
```

_(statement executed — no result set)_

**1d. Verify the update**

```sql
SELECT StudentID, FirstName, LastName, Email FROM Students WHERE StudentID = 13;
```

| StudentID | FirstName | LastName | Email |
|---|---|---|---|
| 13 | Grace | Hopper | grace.hopper.updated@email.com |

**1e. DELETE — Remove the student**

```sql
DELETE FROM Students WHERE StudentID = 13;
```

_(statement executed — no result set)_

**1f. Verify the deletion**

```sql
SELECT * FROM Students WHERE StudentID = 13;
```

_(0 rows returned)_


## Query 2 — Students who enrolled after 2022

```sql
SELECT *
FROM Students
WHERE EnrollmentDate > '2022-12-31';
```

| StudentID | FirstName | LastName | Email | BirthDate | EnrollmentDate |
|---|---|---|---|---|---|
| 3 | Mark | Twain | mark.twain@email.com | 2001-03-10 | 2023-01-15 |
| 5 | Sara | Connor | sara.connor@email.com | 2002-07-19 | 2024-01-10 |
| 9 | Ava | Martinez | ava.martinez@email.com | 2003-02-22 | 2023-08-01 |
| 11 | Sophia | Anderson | sophia.anderson@email.com | 2002-04-17 | 2024-08-01 |


## Query 3 — Courses offered by Mathematics department (limit 5)

```sql
SELECT c.*
FROM Courses c
JOIN Departments d ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;
```

| CourseID | CourseName | DepartmentID | Credits |
|---|---|---|---|
| 102 | Data Structures | 2 | 4 |
| 104 | Calculus I | 2 | 4 |
| 106 | Linear Algebra | 2 | 3 |
| 107 | Statistics | 2 | 3 |
| 108 | Discrete Math | 2 | 3 |


## Query 4 — Number of students per course (more than 5 students)

```sql
SELECT c.CourseID, c.CourseName, COUNT(e.StudentID) AS NumStudents
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(e.StudentID) > 5;
```

| CourseID | CourseName | NumStudents |
|---|---|---|
| 101 | Introduction to SQL | 11 |
| 102 | Data Structures | 6 |


## Query 5 — Students enrolled in BOTH Introduction to SQL AND Data Structures

```sql
SELECT s.*
FROM Students s
WHERE s.StudentID IN (
    SELECT e.StudentID FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE c.CourseName = 'Introduction to SQL'
)
AND s.StudentID IN (
    SELECT e.StudentID FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE c.CourseName = 'Data Structures'
);
```

| StudentID | FirstName | LastName | Email | BirthDate | EnrollmentDate |
|---|---|---|---|---|---|
| 1 | John | Doe | john.doe@email.com | 2000-01-15 | 2022-08-01 |
| 2 | Jane | Smith | jane.smith@email.com | 1999-05-25 | 2021-08-01 |
| 3 | Mark | Twain | mark.twain@email.com | 2001-03-10 | 2023-01-15 |
| 4 | Emily | Clark | emily.clark@email.com | 2000-11-02 | 2019-08-20 |
| 5 | Sara | Connor | sara.connor@email.com | 2002-07-19 | 2024-01-10 |
| 6 | Liam | Brown | liam.brown@email.com | 2001-09-30 | 2020-08-15 |


## Query 6 — Students enrolled in EITHER Introduction to SQL OR Data Structures

```sql
SELECT DISTINCT s.*
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures');
```

| StudentID | FirstName | LastName | Email | BirthDate | EnrollmentDate |
|---|---|---|---|---|---|
| 1 | John | Doe | john.doe@email.com | 2000-01-15 | 2022-08-01 |
| 2 | Jane | Smith | jane.smith@email.com | 1999-05-25 | 2021-08-01 |
| 3 | Mark | Twain | mark.twain@email.com | 2001-03-10 | 2023-01-15 |
| 4 | Emily | Clark | emily.clark@email.com | 2000-11-02 | 2019-08-20 |
| 5 | Sara | Connor | sara.connor@email.com | 2002-07-19 | 2024-01-10 |
| 6 | Liam | Brown | liam.brown@email.com | 2001-09-30 | 2020-08-15 |
| 7 | Olivia | Davis | olivia.davis@email.com | 1998-12-05 | 2022-09-01 |
| 8 | Noah | Wilson | noah.wilson@email.com | 2000-06-14 | 2018-08-25 |
| 9 | Ava | Martinez | ava.martinez@email.com | 2003-02-22 | 2023-08-01 |
| 10 | James | Taylor | james.taylor@email.com | 1999-10-08 | 2021-01-12 |
| 11 | Sophia | Anderson | sophia.anderson@email.com | 2002-04-17 | 2024-08-01 |


## Query 7 — Average number of credits for all courses

```sql
SELECT AVG(Credits) AS AvgCredits
FROM Courses;
```

| AvgCredits |
|---|
| 3.375 |


## Query 8 — Maximum salary of instructors in the Computer Science department

```sql
SELECT MAX(i.Salary) AS MaxSalary
FROM Instructors i
JOIN Departments d ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';
```

| MaxSalary |
|---|
| 92000 |


## Query 9 — Number of students enrolled in each department

```sql
SELECT d.DepartmentName, COUNT(DISTINCT e.StudentID) AS NumStudents
FROM Departments d
JOIN Courses c ON d.DepartmentID = c.DepartmentID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY d.DepartmentName;
```

| DepartmentName | NumStudents |
|---|---|
| Computer Science | 11 |
| Mathematics | 8 |


## Query 10 — INNER JOIN: students and their corresponding courses

```sql
SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;
```

| StudentID | FirstName | LastName | CourseName |
|---|---|---|---|
| 1 | John | Doe | Introduction to SQL |
| 1 | John | Doe | Data Structures |
| 2 | Jane | Smith | Introduction to SQL |
| 2 | Jane | Smith | Data Structures |
| 3 | Mark | Twain | Introduction to SQL |
| 3 | Mark | Twain | Data Structures |
| 4 | Emily | Clark | Introduction to SQL |
| 4 | Emily | Clark | Data Structures |
| 5 | Sara | Connor | Introduction to SQL |
| 5 | Sara | Connor | Data Structures |
| 6 | Liam | Brown | Introduction to SQL |
| 6 | Liam | Brown | Data Structures |
| 7 | Olivia | Davis | Introduction to SQL |
| 7 | Olivia | Davis | Database Design |
| 8 | Noah | Wilson | Introduction to SQL |
| 8 | Noah | Wilson | Database Design |
| 9 | Ava | Martinez | Introduction to SQL |
| 9 | Ava | Martinez | Calculus I |
| 10 | James | Taylor | Introduction to SQL |
| 10 | James | Taylor | Programming Basics |
| 11 | Sophia | Anderson | Introduction to SQL |
| 12 | Ethan | Thomas | Linear Algebra |


## Query 11 — LEFT JOIN: all students and their corresponding courses, if any

```sql
SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;
```

| StudentID | FirstName | LastName | CourseName |
|---|---|---|---|
| 1 | John | Doe | Introduction to SQL |
| 1 | John | Doe | Data Structures |
| 2 | Jane | Smith | Introduction to SQL |
| 2 | Jane | Smith | Data Structures |
| 3 | Mark | Twain | Introduction to SQL |
| 3 | Mark | Twain | Data Structures |
| 4 | Emily | Clark | Introduction to SQL |
| 4 | Emily | Clark | Data Structures |
| 5 | Sara | Connor | Introduction to SQL |
| 5 | Sara | Connor | Data Structures |
| 6 | Liam | Brown | Introduction to SQL |
| 6 | Liam | Brown | Data Structures |
| 7 | Olivia | Davis | Introduction to SQL |
| 7 | Olivia | Davis | Database Design |
| 8 | Noah | Wilson | Introduction to SQL |
| 8 | Noah | Wilson | Database Design |
| 9 | Ava | Martinez | Introduction to SQL |
| 9 | Ava | Martinez | Calculus I |
| 10 | James | Taylor | Introduction to SQL |
| 10 | James | Taylor | Programming Basics |
| 11 | Sophia | Anderson | Introduction to SQL |
| 12 | Ethan | Thomas | Linear Algebra |


## Query 12 — Subquery: students enrolled in courses that have more than 10 students

```sql
SELECT *
FROM Students
WHERE StudentID IN (
    SELECT e.StudentID
    FROM Enrollments e
    WHERE e.CourseID IN (
        SELECT CourseID
        FROM Enrollments
        GROUP BY CourseID
        HAVING COUNT(StudentID) > 10
    )
);
```

| StudentID | FirstName | LastName | Email | BirthDate | EnrollmentDate |
|---|---|---|---|---|---|
| 1 | John | Doe | john.doe@email.com | 2000-01-15 | 2022-08-01 |
| 2 | Jane | Smith | jane.smith@email.com | 1999-05-25 | 2021-08-01 |
| 3 | Mark | Twain | mark.twain@email.com | 2001-03-10 | 2023-01-15 |
| 4 | Emily | Clark | emily.clark@email.com | 2000-11-02 | 2019-08-20 |
| 5 | Sara | Connor | sara.connor@email.com | 2002-07-19 | 2024-01-10 |
| 6 | Liam | Brown | liam.brown@email.com | 2001-09-30 | 2020-08-15 |
| 7 | Olivia | Davis | olivia.davis@email.com | 1998-12-05 | 2022-09-01 |
| 8 | Noah | Wilson | noah.wilson@email.com | 2000-06-14 | 2018-08-25 |
| 9 | Ava | Martinez | ava.martinez@email.com | 2003-02-22 | 2023-08-01 |
| 10 | James | Taylor | james.taylor@email.com | 1999-10-08 | 2021-01-12 |
| 11 | Sophia | Anderson | sophia.anderson@email.com | 2002-04-17 | 2024-08-01 |


## Query 13 — Extract the year from the EnrollmentDate of students

```sql
SELECT StudentID, FirstName, LastName,
       EXTRACT(YEAR FROM EnrollmentDate) AS EnrollmentYear
FROM Students;
```

| StudentID | FirstName | LastName | EnrollmentYear |
|---|---|---|---|
| 1 | John | Doe | 2022 |
| 2 | Jane | Smith | 2021 |
| 3 | Mark | Twain | 2023 |
| 4 | Emily | Clark | 2019 |
| 5 | Sara | Connor | 2024 |
| 6 | Liam | Brown | 2020 |
| 7 | Olivia | Davis | 2022 |
| 8 | Noah | Wilson | 2018 |
| 9 | Ava | Martinez | 2023 |
| 10 | James | Taylor | 2021 |
| 11 | Sophia | Anderson | 2024 |
| 12 | Ethan | Thomas | 2019 |


## Query 14 — Concatenate the instructor's first and last name

```sql
SELECT InstructorID,
       CONCAT(FirstName, ' ', LastName) AS FullName
FROM Instructors;
```

| InstructorID | FullName |
|---|---|
| 1 | Alice Johnson |
| 2 | Bob Lee |
| 3 | Carla Nguyen |
| 4 | David Kim |


## Query 15 — Running total of students enrolled in courses

```sql
SELECT EnrollmentID, StudentID, CourseID, EnrollmentDate,
       SUM(1) OVER (ORDER BY EnrollmentDate, EnrollmentID) AS RunningTotal
FROM Enrollments;
```

| EnrollmentID | StudentID | CourseID | EnrollmentDate | RunningTotal |
|---|---|---|---|---|
| 8 | 8 | 101 | 2018-08-25 | 1 |
| 19 | 8 | 103 | 2018-08-25 | 2 |
| 22 | 12 | 106 | 2019-01-05 | 3 |
| 4 | 4 | 101 | 2019-08-20 | 4 |
| 15 | 4 | 102 | 2019-08-20 | 5 |
| 6 | 6 | 101 | 2020-08-15 | 6 |
| 17 | 6 | 102 | 2020-08-15 | 7 |
| 10 | 10 | 101 | 2021-01-12 | 8 |
| 21 | 10 | 105 | 2021-01-12 | 9 |
| 2 | 2 | 101 | 2021-08-01 | 10 |
| 13 | 2 | 102 | 2021-08-01 | 11 |
| 1 | 1 | 101 | 2022-08-01 | 12 |
| 12 | 1 | 102 | 2022-08-01 | 13 |
| 7 | 7 | 101 | 2022-09-01 | 14 |
| 18 | 7 | 103 | 2022-09-01 | 15 |
| 3 | 3 | 101 | 2023-01-15 | 16 |
| 14 | 3 | 102 | 2023-01-15 | 17 |
| 9 | 9 | 101 | 2023-08-01 | 18 |
| 20 | 9 | 104 | 2023-08-01 | 19 |
| 5 | 5 | 101 | 2024-01-10 | 20 |
| 16 | 5 | 102 | 2024-01-10 | 21 |
| 11 | 11 | 101 | 2024-08-01 | 22 |


## Query 16 — Label students as 'Senior' or 'Junior'

```sql
SELECT StudentID, FirstName, LastName, EnrollmentDate,
       CASE
           WHEN EnrollmentDate <= DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
                THEN 'Senior'
           ELSE 'Junior'
       END AS StudentLevel
FROM Students;
```

| StudentID | FirstName | LastName | EnrollmentDate | StudentLevel |
|---|---|---|---|---|
| 1 | John | Doe | 2022-08-01 | Senior |
| 2 | Jane | Smith | 2021-08-01 | Senior |
| 3 | Mark | Twain | 2023-01-15 | Junior |
| 4 | Emily | Clark | 2019-08-20 | Senior |
| 5 | Sara | Connor | 2024-01-10 | Junior |
| 6 | Liam | Brown | 2020-08-15 | Senior |
| 7 | Olivia | Davis | 2022-09-01 | Senior |
| 8 | Noah | Wilson | 2018-08-25 | Senior |
| 9 | Ava | Martinez | 2023-08-01 | Junior |
| 10 | James | Taylor | 2021-01-12 | Senior |
| 11 | Sophia | Anderson | 2024-08-01 | Junior |
| 12 | Ethan | Thomas | 2019-01-05 | Senior |
