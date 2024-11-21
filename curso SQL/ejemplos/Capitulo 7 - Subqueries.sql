/*

Subquery Syntax
  The subquery (inner query) executes before the main query.

query (outer query).
  The result of the subquery is used by the main query.

    SELECT select_list
    FROM table
    WHERE expr operator
                        (SELECT select_list
                        FROM table);

*/

-- Seleccionar apellidos y salarios de empleados cuyo salarios ea mayor que el de Abel

--SELECT last_name, salary
--FROM employees
--WHERE salary > (SELECT salary
--                FROM employees
--                WHERE last_name = 'Abel');

/*
Types of Subqueries
  
  - Single-row subqueries: 
        Queries that return only one row from the inner SELECT statement
  
  - Multiple-row subqueries: 
        Queries that return more than one row from the inner SELECT statement
*/

/*************************/
/* Single row subqueries */
/*************************/
/*
Single-Row Subqueries
  
  Return only one row
  
  Use single-row comparison operators
-------------------------------------------
Operator        Meaning
-------------------------------------------
    >=          Greater than or equal to
    <           Less than
    <=          Less than or equal to
    =           Equal to
    <>          Not equal to
    >           Greater than
-------------------------------------------
*/

--SELECT last_name, job_id
--FROM employees
--WHERE job_id = (SELECT job_id
--                FROM employees
--                WHERE employee_id = 141);

--SELECT last_name, job_id, salary
--FROM employees
--WHERE job_id = (SELECT job_id
--                FROM employees
--                WHERE first_name = 'Jonathon')
--                
--AND salary >   (SELECT salary
--                FROM employees
--                WHERE first_name = 'Jonathon');

----------------------------------------------------
-- Using group functions in subqueries
----------------------------------------------------

--SELECT last_name, job_id, salary
--FROM employees
--WHERE salary = (SELECT MIN(salary)
--                FROM employees);

----------------------------------------------------
-- The HAVING Clause with Subqueries
----------------------------------------------------
/*

The Oracle server executes the subqueries first.
    
    The Oracle server returns results into the HAVING clause
    of the main query.

*/

--SELECT department_id, MIN(salary)
--FROM employees
--GROUP BY department_id
--HAVING MIN(salary) >   (SELECT MIN(salary)
--                        FROM employees
--                        WHERE department_id = 50);

/***************************/
/* Multiple row subqueries */
/***************************/
/*
  Return more than one row
  
  Use multiple-row comparison operators
----------------------------------------
Operator        Meaning
----------------------------------------
    IN          Equal to any member in the list

    ANY         Must be preceded by =, !=, >, <, <=, >=.
    
                Compares a value to each value in a list or
                returned by a query. Evaluates to FALSE if the
                query returns no rows

    ALL         Must be preceded by =, !=, >, <, <=, >=.
    
                Compares a value to every value in a list or
                returned by a query. Evaluates to TRUE if the
                query returns no rows.
----------------------------------------

*/

--SELECT last_name, salary, department_id
--FROM employees
--WHERE salary IN (SELECT MIN(salary)
--                 FROM employees
--                 GROUP BY department_id);

--SELECT employee_id, last_name, job_id, salary
--FROM employees
--WHERE salary < ANY
--                    (SELECT salary
--                    FROM employees
--                    WHERE job_id = 'IT_PROG')
--                    AND job_id <> 'IT_PROG';

--SELECT employee_id, last_name, job_id, salary
--FROM employees
--WHERE salary < ALL
--                    (SELECT salary
--                    FROM employees
--                    WHERE job_id = 'IT_PROG')
--                    AND job_id <> 'IT_PROG';

/*****************************/                    
/* Null Values in a Subquery */
/*****************************/

--SELECT emp.last_name
--FROM employees emp
--WHERE emp.employee_id NOT IN
--                            (SELECT manager_id
--                            FROM employees);
