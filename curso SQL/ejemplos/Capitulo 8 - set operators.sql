/*

Set Operators

Set operators combine the results of two or more component queries into one result. Queries
containing set operators are called compound queries.

-----------------------------------------------------------------------------
Operator    Returns
-----------------------------------------------------------------------------
UNION       Rows from both queries after eliminating duplications
UNION ALL   Rows from both queries, including all duplications
INTERSECT   Rows that are common to both queries
MINUS       Rows in the first query that are not present in the second query
-----------------------------------------------------------------------------

    - All set operators have equal precedence. If a SQL statement contains multiple set operators, the
    Oracle server evaluates them from left (top) to right (bottom)—if no parentheses explicitly specify
    another order. 

    - You should use parentheses to specify the order of evaluation explicitly in queries that
    use the INTERSECT operator with other set operators.
    
    - The expressions in the SELECT lists must match in number.
    
    - The data type of each column in the second query must
    match the data type of its corresponding column in the first query.
        
    - Parentheses can be used to alter the sequence of execution.
      
    - ORDER BY clause can appear only at the very end of the statement.
    
    - Duplicate rows are automatically eliminated except in UNION ALL.
    
    - Column names from the first query appear in the result.  
*/

/*********/
/* UNION */
/*********/

/* 
Display the current and previous job details of all employees.
*/

--SELECT employee_id, job_id
--FROM employees
--UNION
--SELECT employee_id, job_id
--FROM job_history
--ORDER BY employee_id;

/*************/
/* UNION ALL */
/*************/

/* 
Display the current and previous departments of all employees.

176 - SA_REP

*/

--SELECT employee_id, job_id
--FROM employees
--UNION ALL
--SELECT employee_id, job_id
--FROM job_history
--ORDER BY employee_id;

/*************/
/* INTERSECT */
/*************/
/*

Display the employee IDs and job IDs of those employees who
currently have a job title that is the same as their previous one
(that is, they changed jobs but have now gone back to doing
the same job they did previously).

*/

--SELECT employee_id, job_id
--FROM employees
--INTERSECT
--SELECT employee_id, job_id
--FROM job_history
--ORDER BY employee_id;

/*********/
/* MINUS */
/*********/

/*
Display the employee IDs of those employees who have not
changed their jobs even once.
*/

--SELECT employee_id
--FROM employees
--MINUS
--SELECT employee_id
--FROM job_history
--ORDER BY employee_id;

/*
Matching the SELECT Statements

    - Using the UNION operator, display the location ID,
    department name, and the state where it is located.
  
    - You must match the data type (using the TO_CHAR
    function or any other conversion functions) when columns
    do not exist in one or the other table.

*/

/*
Using the UNION operator, display the employee ID, job ID, and
salary of all employees.
*/

--SELECT employee_id, job_id,salary
--FROM employees
--UNION
--SELECT employee_id, job_id,0
--FROM job_history
--ORDER BY employee_id;


















