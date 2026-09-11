# University Course Management System — Final Project

## Overview
This project implements a relational database for a University Course
Management System and demonstrates a broad range of SQL operations:
CRUD, filtering, sorting, aggregation, joins, subqueries, string/date
functions, window functions, and CASE expressions.

## Files

| File | Contents |
|---|---|
| `schema_and_data.sql` | `CREATE TABLE` statements for all 5 tables plus `INSERT` statements with sample data. Run this first to set up the database. |
| `queries_with_output.md` | All 16 required queries, each shown with the exact result it produces against the sample data. |

## Schema

Five tables, matching the project spec:

- **Departments** (`DepartmentID`, `DepartmentName`)
- **Students** (`StudentID`, `FirstName`, `LastName`, `Email`, `BirthDate`, `EnrollmentDate`)
- **Instructors** (`InstructorID`, `FirstName`, `LastName`, `Email`, `DepartmentID`, `Salary`)
- **Courses** (`CourseID`, `CourseName`, `DepartmentID`, `Credits`)
- **Enrollments** (`EnrollmentID`, `StudentID`, `CourseID`, `EnrollmentDate`)

**Note:** A `Salary` column was added to `Instructors`. It wasn't in the
original field list, but Query 8 ("Find the maximum salary of instructors
in the Computer Science department") requires it.

Sample data includes 12 students, 4 instructors, 8 courses (3 Computer
Science, 5 Mathematics), and 22 enrollments — sized so filters like
"more than 5 students" and "more than 10 students" actually return
results.

## How to run

1. Load `schema_and_data.sql` into your database engine (MySQL, PostgreSQL, or SQLite) to create the tables and populate them.
2. Run any query from `queries_with_output.md` against that database — the file shows you what output to expect.

## Dialect notes

Most queries are standard SQL and run unchanged anywhere. Three queries
use MySQL/PostgreSQL-specific functions; SQLite equivalents are noted
in comments next to them:

| Query | MySQL/PostgreSQL | SQLite equivalent |
|---|---|---|
| 13 — Extract year | `EXTRACT(YEAR FROM EnrollmentDate)` | `STRFTIME('%Y', EnrollmentDate)` |
| 14 — Concatenate names | `CONCAT(FirstName, ' ', LastName)` | `FirstName \|\| ' ' \|\| LastName` |
| 16 — Senior/Junior label | `DATE_SUB(CURDATE(), INTERVAL 4 YEAR)` | `DATE('now', '-4 years')` |

All 16 query outputs in `queries_with_output.md` were generated using
the SQLite equivalents above, tested against the sample data.

## Query list

1. CRUD operations on all tables
2. Students who enrolled after 2022
3. Courses offered by Mathematics, limited to 5
4. Number of students per course (more than 5)
5. Students enrolled in both Introduction to SQL and Data Structures
6. Students enrolled in either Introduction to SQL or Data Structures
7. Average number of credits across all courses
8. Maximum salary of Computer Science instructors
9. Number of students enrolled per department
10. INNER JOIN — students and their courses
11. LEFT JOIN — all students and their courses, if any
12. Subquery — students in courses with more than 10 students
13. Extract year from EnrollmentDate
14. Concatenate instructor first and last name
15. Running total of students enrolled in courses
16. Label students Senior/Junior by enrollment date
