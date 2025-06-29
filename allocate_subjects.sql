-- Stored Procedure: AllocateSubjects
-- Author: [Your Name]
-- Description:
--   This procedure allocates elective subjects to students based on their GPA and preferences.
--   The allocation is done in descending order of GPA. Each student is allotted the highest
--   preferred subject with available seats. If none of their preferences have seats left,
--   they are added to the UnallottedStudents table.

DELIMITER $$

CREATE PROCEDURE AllocateSubjects()
BEGIN
    -- Declare control variables
    DECLARE done INT DEFAULT 0;
    DECLARE v_StudentId INT;
    DECLARE v_SubjectId VARCHAR(20);
    DECLARE v_RemainingSeats INT;
    DECLARE pref INT DEFAULT 1;
    DECLARE allocated INT DEFAULT 0;

    -- Cursor to iterate over students in descending GPA order
    DECLARE student_cursor CURSOR FOR
        SELECT StudentId
        FROM StudentDetails
        ORDER BY GPA DESC;

    -- Handler to exit loop when no more rows
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open cursor
    OPEN student_cursor;

    -- Loop through each student
    read_loop: LOOP
        FETCH student_cursor INTO v_StudentId;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Reset tracking variables for each student
        SET pref = 1;
        SET allocated = 0;

        -- Try to allocate subject from preference 1 to 5
        WHILE pref <= 5 DO
            -- Get SubjectId for the current preference
            SELECT SubjectId INTO v_SubjectId
            FROM StudentPreference
            WHERE StudentId = v_StudentId AND Preference = pref;

            -- Get Remaining Seats for the subject
            SELECT RemainingSeats INTO v_RemainingSeats
            FROM SubjectDetails
            WHERE SubjectId = v_SubjectId;

            -- If seats available, allocate and update
            IF v_RemainingSeats > 0 THEN
                -- Insert into Allotments table
                INSERT INTO Allotments(StudentId, SubjectId)
                VALUES (v_StudentId, v_SubjectId);

                -- Decrease seat count
                UPDATE SubjectDetails
                SET RemainingSeats = RemainingSeats - 1
                WHERE SubjectId = v_SubjectId;

                -- Mark as allocated and exit loop
                SET allocated = 1;
                LEAVE WHILE;
            END IF;

            -- Move to next preference
            SET pref = pref + 1;
        END WHILE;

        -- If not allocated to any subject, insert into UnallottedStudents
        IF allocated = 0 THEN
            INSERT INTO UnallottedStudents(StudentId)
            VALUES (v_StudentId);
        END IF;

    END LOOP;

    -- Close cursor after loop
    CLOSE student_cursor;
END$$

DELIMITER ;
