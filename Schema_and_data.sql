-- ============================================================
-- University Course Management System - Schema & Sample Data
-- ============================================================
-- Note: A Salary column was added to Instructors (not listed in
-- the original field list) because Query #8 requires it.
-- ============================================================

-- ============================================================
-- SCHEMA (DDL)
-- ============================================================

DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Instructors;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments (
    DepartmentID   INTEGER PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Students (
    StudentID       INTEGER PRIMARY KEY,
    FirstName       VARCHAR(50) NOT NULL,
    LastName        VARCHAR(50) NOT NULL,
    Email           VARCHAR(100) UNIQUE,
    BirthDate       DATE,
    EnrollmentDate  DATE
);

CREATE TABLE Instructors (
    InstructorID   INTEGER PRIMARY KEY,
    FirstName      VARCHAR(50) NOT NULL,
    LastName       VARCHAR(50) NOT NULL,
    Email          VARCHAR(100) UNIQUE,
    DepartmentID   INTEGER,
    Salary         DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Courses (
    CourseID       INTEGER PRIMARY KEY,
    CourseName     VARCHAR(100) NOT NULL,
    DepartmentID   INTEGER,
    Credits        INTEGER,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Enrollments (
    EnrollmentID    INTEGER PRIMARY KEY,
    StudentID       INTEGER,
    CourseID        INTEGER,
    EnrollmentDate  DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID)  REFERENCES Courses(CourseID)
);

-- ============================================================
-- SAMPLE DATA (DML)
-- ============================================================

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID, Salary) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 85000.00),
(2, 'Bob',   'Lee',     'bob.lee@univ.com',       2, 78000.00),
(3, 'Carla', 'Nguyen',  'carla.nguyen@univ.com',  1, 92000.00),
(4, 'David', 'Kim',     'david.kim@univ.com',     2, 74000.00);

INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures',     2, 4),
(103, 'Database Design',     1, 3),
(104, 'Calculus I',          2, 4),
(105, 'Programming Basics',  1, 4),
(106, 'Linear Algebra',      2, 3),
(107, 'Statistics',          2, 3),
(108, 'Discrete Math',       2, 3);

INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES
(1,  'John',    'Doe',      'john.doe@email.com',      '2000-01-15', '2022-08-01'),
(2,  'Jane',    'Smith',    'jane.smith@email.com',    '1999-05-25', '2021-08-01'),
(3,  'Mark',    'Twain',    'mark.twain@email.com',    '2001-03-10', '2023-01-15'),
(4,  'Emily',   'Clark',    'emily.clark@email.com',   '2000-11-02', '2019-08-20'),
(5,  'Sara',    'Connor',   'sara.connor@email.com',   '2002-07-19', '2024-01-10'),
(6,  'Liam',    'Brown',    'liam.brown@email.com',    '2001-09-30', '2020-08-15'),
(7,  'Olivia',  'Davis',    'olivia.davis@email.com',  '1998-12-05', '2022-09-01'),
(8,  'Noah',    'Wilson',   'noah.wilson@email.com',   '2000-06-14', '2018-08-25'),
(9,  'Ava',     'Martinez', 'ava.martinez@email.com',  '2003-02-22', '2023-08-01'),
(10, 'James',   'Taylor',   'james.taylor@email.com',  '1999-10-08', '2021-01-12'),
(11, 'Sophia',  'Anderson', 'sophia.anderson@email.com','2002-04-17','2024-08-01'),
(12, 'Ethan',   'Thomas',   'ethan.thomas@email.com',  '2000-08-29', '2019-01-05');

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1,  1,  101, '2022-08-01'),
(2,  2,  101, '2021-08-01'),
(3,  3,  101, '2023-01-15'),
(4,  4,  101, '2019-08-20'),
(5,  5,  101, '2024-01-10'),
(6,  6,  101, '2020-08-15'),
(7,  7,  101, '2022-09-01'),
(8,  8,  101, '2018-08-25'),
(9,  9,  101, '2023-08-01'),
(10, 10, 101, '2021-01-12'),
(11, 11, 101, '2024-08-01'),
(12, 1,  102, '2022-08-01'),
(13, 2,  102, '2021-08-01'),
(14, 3,  102, '2023-01-15'),
(15, 4,  102, '2019-08-20'),
(16, 5,  102, '2024-01-10'),
(17, 6,  102, '2020-08-15'),
(18, 7,  103, '2022-09-01'),
(19, 8,  103, '2018-08-25'),
(20, 9,  104, '2023-08-01'),
(21, 10, 105, '2021-01-12'),
(22, 12, 106, '2019-01-05');
