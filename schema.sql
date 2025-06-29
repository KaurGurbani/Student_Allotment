-- Drop tables if they already exist (optional for clean setup)
DROP TABLE IF EXISTS Allotments;
DROP TABLE IF EXISTS UnallottedStudents;
DROP TABLE IF EXISTS StudentPreference;
DROP TABLE IF EXISTS SubjectDetails;
DROP TABLE IF EXISTS StudentDetails;

-- Create StudentDetails table
CREATE TABLE StudentDetails (
    StudentId INT PRIMARY KEY,
    StudentName VARCHAR(100),
    GPA DECIMAL(3, 1),
    Branch VARCHAR(10),
    Section VARCHAR(10)
);

-- Create SubjectDetails table
CREATE TABLE SubjectDetails (
    SubjectId VARCHAR(20) PRIMARY KEY,
    SubjectName VARCHAR(100),
    MaxSeats INT,
    RemainingSeats INT
);

-- Create StudentPreference table
CREATE TABLE StudentPreference (
    StudentId INT,
    SubjectId VARCHAR(20),
    Preference INT CHECK (Preference BETWEEN 1 AND 5),
    PRIMARY KEY (StudentId, Preference),
    FOREIGN KEY (StudentId) REFERENCES StudentDetails(StudentId),
    FOREIGN KEY (SubjectId) REFERENCES SubjectDetails(SubjectId)
);

-- Create Allotments table
CREATE TABLE Allotments (
    StudentId INT,
    SubjectId VARCHAR(20),
    PRIMARY KEY (StudentId),
    FOREIGN KEY (StudentId) REFERENCES StudentDetails(StudentId),
    FOREIGN KEY (SubjectId) REFERENCES SubjectDetails(SubjectId)
);

-- Create UnallottedStudents table
CREATE TABLE UnallottedStudents (
    StudentId INT PRIMARY KEY,
    FOREIGN KEY (StudentId) REFERENCES StudentDetails(StudentId)
);
