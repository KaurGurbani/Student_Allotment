-- Insert subject details
INSERT INTO SubjectDetails (SubjectId, SubjectName, MaxSeats, RemainingSeats) VALUES
('PO1491', 'Basics of Political Science', 60, 2),
('PO1492', 'Basics of Accounting', 120, 119),
('PO1493', 'Basics of Financial Markets', 90, 90),
('PO1494', 'Eco philosophy', 60, 50),
('PO1495', 'Automotive Trends', 60, 60);

-- Insert student details
INSERT INTO StudentDetails (StudentId, StudentName, GPA, Branch, Section) VALUES
(159103036, 'Mohit Agarwal', 8.9, 'CCE', 'A'),
(159103037, 'Rohit Agarwal', 5.2, 'CCE', 'A'),
(159103038, 'Shohit Garg', 7.1, 'CCE', 'B'),
(159103039, 'Mrinal Malhotra', 7.9, 'CCE', 'A'),
(159103040, 'Mehreet Singh', 5.6, 'CCE', 'A'),
(159103041, 'Arjun Tehlan', 9.2, 'CCE', 'B');

-- Insert student preferences
-- Preferences for Mohit
INSERT INTO StudentPreference VALUES
(159103036, 'PO1491', 1),
(159103036, 'PO1492', 2),
(159103036, 'PO1493', 3),
(159103036, 'PO1494', 4),
(159103036, 'PO1495', 5);

-- Preferences for remaining students (example)
INSERT INTO StudentPreference VALUES
(159103037, 'PO1493', 1),
(159103037, 'PO1491', 2),
(159103037, 'PO1492', 3),
(159103037, 'PO1494', 4),
(159103037, 'PO1495', 5),

(159103038, 'PO1492', 1),
(159103038, 'PO1491', 2),
(159103038, 'PO1493', 3),
(159103038, 'PO1494', 4),
(159103038, 'PO1495', 5),

(159103039, 'PO1492', 1),
(159103039, 'PO1491', 2),
(159103039, 'PO1493', 3),
(159103039, 'PO1494', 4),
(159103039, 'PO1495', 5),

(159103040, 'PO1494', 1),
(159103040, 'PO1495', 2),
(159103040, 'PO1492', 3),
(159103040, 'PO1493', 4),
(159103040, 'PO1491', 5),

(159103041, 'PO1491', 1),
(159103041, 'PO1492', 2),
(159103041, 'PO1493', 3),
(159103041, 'PO1494', 4),
(159103041, 'PO1495', 5);
