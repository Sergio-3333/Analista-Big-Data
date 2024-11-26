/*
Data Manipulation Language


A DML statement is executed when you:

    – Add new rows to a table
    – Modify existing rows in a table
    – Remove existing rows from a table

A transaction consists of a collection of DML statements that form a logical unit of work.

*/
/***************************/
/* INSERT Statement Syntax */
/***************************/
/*
Add new rows to a table by using the INSERT statement:
With this syntax, only one row is inserted at a time.

    INSERT INTO table [(column [, column...])]
    VALUES (value [, value...]);

You can add new rows to a table by issuing the INSERT statement.

In the syntax:
    - table is the name of the table
    - column is the name of the column in the table to populate
    - value is the corresponding value for the column

Note: This statement with the VALUES clause adds only one row at a time to a table.

*/

--INSERT INTO departments(department_id, department_name, manager_id, location_id)
--VALUES (70, 'Public Relations', 100, 1700);

----------------------------------------------------------------
-- Inserting Rows with Null Values
----------------------------------------------------------------
/*
Implicit method: Omit the column from the column list.
*/

--INSERT INTO departments (department_id,
--department_name)
--VALUES (30, 'Purchasing');

/*
Explicit method: Specify the NULL keyword in the VALUES clause.
*/

--INSERT INTO departments
--VALUES (100, 'Finance', NULL, NULL);

----------------------------------------------------------------
-- Inserting Special Values
----------------------------------------------------------------
/*
The SYSDATE function records the current date and time.
*/

--INSERT INTO employees ( employee_id, 
--                        first_name, 
--                        last_name, 
--                        email, 
--                        phone_number, 
--                        hire_date, 
--                        job_id, 
--                        salary, 
--                        commission_pct, 
--                        manager_id,
--                        department_id)
--VALUES (113, 'Louis', 'Popp', 'LPOPP', '515.124.4567', SYSDATE, 'AC_ACCOUNT', 6900, NULL, 205, 110);

----------------------------------------------------------------
-- Inserting Specific Date and Time Values
----------------------------------------------------------------

--INSERT INTO employees
--VALUES (114, 'Den', 'Raphealy', 'DRAPHEAL', '515.127.4561', TO_DATE('FEB 3, 1999', 'MON DD, YYYY'), 'SA_REP', 11000, 0.2, 100, 60);

/***************************/
/* UPDATE Statement Syntax */
/***************************/
/*
Modify existing values in a table with the UPDATE statement:

    UPDATE table
    SET column = value [, column = value, ...]
    [WHERE condition];
    
Update more than one row at a time (if required).

*/
----------------------------------------------------------------
-- Updating Rows in a Table
----------------------------------------------------------------
/*
Values for a specific row or rows are modified if you specify the WHERE clause:
*/

--UPDATE employees
--SET department_id = 50
--WHERE employee_id = 113;

/*
Values for all the rows in the table are modified if you omit
the WHERE clause:
*/

--UPDATE copy_emp
--SET department_id = 110;

----------------------------------------------------------------
-- Updating Two Columns with a Subquery
----------------------------------------------------------------

/*
Update employee 113’s job and salary to match those of employee 205.
*/

--UPDATE employees
--SET job_id =   (SELECT job_id
--                FROM employees
--                WHERE employee_id = 205),
--    salary =   (SELECT salary
--                FROM employees
--                WHERE employee_id = 205)
--WHERE employee_id = 113;

----------------------------------------------------------------
-- Updating Rows Based on Another Table
----------------------------------------------------------------
/*
Use the subqueries in the UPDATE statements to update row
values in a table based on values from another table:
*/

--UPDATE copy_emp
--SET department_id = (SELECT department_id
--                     FROM employees
--                     WHERE employee_id = 100)
--WHERE job_id =      (SELECT job_id
--                     FROM employees
--                     WHERE employee_id = 200);

/***************************/
/* DELETE Statement Syntax */
/***************************/

/*
You can remove existing rows from a table by using the DELETE statement:

    DELETE [FROM] table
    [WHERE condition];
*/

----------------------------------------------------------------
-- Deleting Rows from a Table
----------------------------------------------------------------
/*
Specific rows are deleted if you specify the WHERE clause:
*/

--DELETE FROM departments
--WHERE department_name = ‘Finance';

/*
All rows in the table are deleted if you omit the WHERE clause:
*/

--DELETE FROM copy_emp;

----------------------------------------------------------------
-- Deleting Rows Based on Another Table
----------------------------------------------------------------
/*
Use the subqueries in the DELETE statements to remove rows
from a table based on values from another table:
*/

--DELETE FROM employees
--WHERE department_id =  (SELECT department_id
--                        FROM departments
--                        WHERE department_name LIKE '%Public%');

/*****************************/
/* TRUNCATE Statement Syntax */
/*****************************/
/*
Removes all rows from a table, leaving the table empty and the table structure intact

Is a data definition language (DDL) statement rather than a DML statement; cannot easily be undone

- Syntax:

    TRUNCATE TABLE table_name;

- Example:

    TRUNCATE TABLE copy_emp;
*/

/*************************/
/* Database Transactions */
/*************************/
/*
A database transaction consists of one of the following:
    
    - DML statements that constitute one consistent change to the data
    
    - One DDL statement
    
    - One data control language (DCL) statement
*/

-----------------------------------------------------------------
-- Database Transactions: Start and End
-----------------------------------------------------------------
/*
Begin when the first DML SQL statement is executed.

End with one of the following events:

    - A COMMIT or ROLLBACK statement is issued.
    - A DDL or DCL statement executes (automatic commit).
    - The user exits SQL Developer or SQL*Plus.
    - The system crashes.
*/
-----------------------------------------------------------------
-- Advantages of COMMIT and ROLLBACK Statements
-----------------------------------------------------------------
/*
With COMMIT and ROLLBACK statements, you can:

    - Ensure data consistency

    - Preview data changes before making changes permanent

    - Group logically-related operations
--------------------------------------------------------------------------------------------------
Statement                       Description
--------------------------------------------------------------------------------------------------
COMMIT                          Ends the current transaction by making all pending data
                                changes permanent
SAVEPOINT name                  Marks a savepoint within the current transaction
                                ROLLBACK 
ROLLBACK                        ends the current transaction by discarding all
                                pending data changes.
ROLLBACK TO SAVEPOINT name      ROLLBACK TO SAVEPOINT rolls back the current
                                transaction to the specified savepoint, thereby discarding any
                                changes and/or savepoints that were created after the
                                savepoint to which you are rolling back. If you omit the TO
                                SAVEPOINT clause, the ROLLBACK statement rolls back the
                                entire transaction. Because savepoints are logical, there is no
                                way to list the savepoints that you have created.
--------------------------------------------------------------------------------------------------
*/
SELECT * FROM HR.DEPARTMENTS;
-- State of the Data Before COMMIT or ROLLBACK
---------------------------------------------------------------
/*
    - The previous state of the data can be recovered.
    
    - The current user can review the results of the DML 
      operations by using the SELECT statement.
    
    - Other users cannot view the results of the DML statements
      issued by the current user.
    
    - The affected rows are locked; other users cannot change
      the data in the affected rows.
*/
---------------------------------------------------------------
-- State of the Data After COMMIT
---------------------------------------------------------------
/*
    - Data changes are saved in the database.

    - The previous state of the data is overwritten.

    - All users can view the results.

    - Locks on the affected rows are released; those rows are
      available for other users to manipulate.

    - All savepoints are erased
*/
---------------------------------------------------------------
-- State of the Data After ROLLBACK
---------------------------------------------------------------
/*
Discard all pending changes by using the ROLLBACK statement:

- Data changes are undone.
- Previous state of the data is restored.
- Locks on the affected rows are released.

*/

---------------------------------------------------------------
-- Statement-Level Rollback
---------------------------------------------------------------
/*
    - If a single DML statement fails during execution, only that
      statement is rolled back.
    
    - The Oracle server implements an implicit savepoint.
    
    - All other changes are retained.
    
    - The user should terminate transactions explicitly by
      executing a COMMIT or ROLLBACK statement.
*/
---------------------------------------------------------------
-- Read Consistency
---------------------------------------------------------------
/*
    - Read consistency guarantees a consistent view of the data
      at all times.

    - Changes made by one user do not conflict with the
      changes made by another user.

    - Read consistency ensures that, on the same data:

        - Readers do not wait for writers

        - Writers do not wait for readers

        - Writers wait for writers
*/
---------------------------------------------------------------
-- FOR UPDATE Clause in a SELECT Statement
---------------------------------------------------------------
/*
Locks the rows in the EMPLOYEES table where job_id is SA_REP.

SELECT employee_id, salary, commission_pct, job_id
FROM employees
WHERE job_id = 'SA_REP'
FOR UPDATE
ORDER BY employee_id;

Lock is released only when you issue a ROLLBACK or a COMMIT.

If the SELECT statement attempts to lock a row that is
locked by another user, then the database waits until the
row is available, and then returns the results of the
SELECT statement.

*/

/* PRUEBAS */

--GRANT SELECT ON DEPARTMENTS TO OE;

--INSERT INTO DEPARTMENTS 
--VALUES (280, 'NUEVO DEPT1', NULL, NULL);

--COMMIT;

--SELECT * FROM DEPARTMENTS;

--DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 280;

--COMMIT;


