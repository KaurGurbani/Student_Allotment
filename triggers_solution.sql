-- Trigger: Automatically allot subject if seats available after preference is inserted

DELIMITER $$

CREATE TRIGGER trg_allocate_subject
AFTER INSERT ON StudentPreference
FOR EACH ROW
BEGIN
    DECLARE v_RemainingSeats INT;

    SELECT RemainingSeats INTO v_RemainingSeats
    FROM SubjectDetails
    WHERE SubjectId = NEW.SubjectId;

    IF v_RemainingSeats > 0 THEN
        INSERT INTO Allotments(StudentId, SubjectId)
        VALUES (NEW.StudentId, NEW.SubjectId);

        UPDATE SubjectDetails
        SET RemainingSeats = RemainingSeats - 1
        WHERE SubjectId = NEW.SubjectId;
    END IF;
END$$

-- Trigger: Log students as unallotted if subject is full

CREATE TRIGGER trg_log_unallotted
AFTER INSERT ON StudentPreference
FOR EACH ROW
BEGIN
    DECLARE v_RemainingSeats INT;

    SELECT RemainingSeats INTO v_RemainingSeats
    FROM SubjectDetails
    WHERE SubjectId = NEW.SubjectId;

    IF v_RemainingSeats <= 0 THEN
        INSERT IGNORE INTO UnallottedStudents(StudentId)
        VALUES (NEW.StudentId);
    END IF;
END$$

-- Trigger: Log changes in RemainingSeats for audit trail

CREATE TABLE IF NOT EXISTS SeatLogs (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    SubjectId VARCHAR(20),
    OldSeats INT,
    NewSeats INT,
    ChangedOn DATETIME
);

CREATE TRIGGER trg_log_seat_update
AFTER UPDATE ON SubjectDetails
FOR EACH ROW
BEGIN
    IF NEW.RemainingSeats <> OLD.RemainingSeats THEN
        INSERT INTO SeatLogs (SubjectId, OldSeats, NewSeats, ChangedOn)
        VALUES (NEW.SubjectId, OLD.RemainingSeats, NEW.RemainingSeats, NOW());
    END IF;
END$$

DELIMITER ;
