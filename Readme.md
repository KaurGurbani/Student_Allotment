## Student Subject Allotment System

## Overview

This project implements a subject allotment system for students based on GPA and subject preferences using two approaches:

1. Stored Procedure (preferred for logic-heavy control)
2. DML Triggers (used for demonstrating AFTER/INSTEAD OF trigger concepts)


## Files

| File                        | Description                                    |
|-----------------------------|---------------------------------------------- -|
| `schema.sql`               | Table creation for all required tables         |
| `sample_data.sql`          | Sample data for testing                         |
| `allocate_subjects_procedure.sql` | Stored procedure to automate allotment     |
| `triggers_solution.sql`    | AFTER INSERT and AFTER UPDATE triggers         |

---

## How to Use

1. Create schema 
   Run schema.sql in your MySQL environment.

2. Insert sample data  
   Run sample_data.sql.

3. Run Stored Procedure  
   
   CALL AllocateSubjects();

4. Using Triggers (optional)
   Run triggers_solution.sql to enable **DML-based** behavior.
