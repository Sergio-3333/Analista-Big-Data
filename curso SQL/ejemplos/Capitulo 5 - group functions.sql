/*
Group functions operate on sets of rows to give one result per group.
*/
/*
------------------------------------------------------------------------------
Function                        Description
------------------------------------------------------------------------------
AVG([DISTINCT|ALL]n)            Average value of n, ignoring null values
COUNT({*|[DISTINCT|ALL]expr})   Number of rows, where expr evaluates to
                                something other than null (count all selected
                                rows using *, including duplicates and rows
                                with nulls)
MAX([DISTINCT|ALL]expr)         Maximum value of expr, ignoring null values
MIN([DISTINCT|ALL]expr)         Minimum value of expr, ignoring null values
STDDEV([DISTINCT|ALL]x)         Standard deviation of n, ignoring null values
SUM([DISTINCT|ALL]n)            Sum values of n, ignoring null values
VARIANCE([DISTINCT|ALL]x)       Variance of n, ignoring null values
------------------------------------------------------------------------------
*/


--SELECT  AVG(salary), 
--        MAX(salary),
--        MIN(salary), 
--        SUM(salary)
--FROM employees
--WHERE job_id LIKE '%REP%';

--You can use MIN and MAX for numeric, character, and date
--data types.

--SELECT MIN(hire_date), MAX(hire_date)
--FROM employees;

/******************/
/* COUNT function */
/******************/
-------------------------------------------------------------------------------
--COUNT(*) returns the number of rows:
-------------------------------------------------------------------------------

--SELECT COUNT(*)
--FROM employees
--WHERE department_id = 50;

-------------------------------------------------------------------------------
--COUNT(expr) returns the number of rows with non-null values for expr:
-------------------------------------------------------------------------------

--SELECT COUNT(commission_pct)
--FROM employees
--WHERE department_id = 80;

-------------------------------------------------------------------------------
--COUNT(DISTINCT expr) returns the number of distinct non-null values of expr.
--  To display the number of distinct department values in the EMPLOYEES table:
-------------------------------------------------------------------------------

--SELECT COUNT(DISTINCT department_id)
--FROM employees;

-------------------------------------------------------------------------------
--Group functions ignore null values in the column:
-------------------------------------------------------------------------------

--SELECT AVG(commission_pct)
--FROM employees;

-------------------------------------------------------------------------------
--The NVL function forces group functions to include null values:
-------------------------------------------------------------------------------

--SELECT AVG(NVL(commission_pct, 0))
--FROM employees;

/*******************/
/* GROUP BY clause */
/*******************/

/*
SELECT column, group_function(column)
FROM table
[WHERE condition]
[GROUP BY group_by_expression]
[ORDER BY column];
*/
-------------------------------------------------------------------------------
--All columns in the SELECT list that are not in group functions
--must be included in the GROUP BY clause.
-------------------------------------------------------------------------------

--SELECT department_id, AVG(salary)
--FROM employees
--GROUP BY department_id ;

-------------------------------------------------------------------------------
--The GROUP BY column does not have to be in the SELECT list.
-------------------------------------------------------------------------------

--SELECT AVG(salary)
--FROM employees
--GROUP BY department_id ;

-------------------------------------------------------------------------------
--Grouping by more than one column:
-------------------------------------------------------------------------------

--SELECT department_id, job_id, SUM(salary)
--FROM employees
--WHERE department_id > 40
--GROUP BY department_id, job_id
--ORDER BY department_id;
-------------------------------------------------------------------------------
--Illegal Queries
--
--Using Group Functions
--  You cannot use the WHERE clause to restrict groups.
--  You use the HAVING clause to restrict groups.
--  You cannot use group functions in the WHERE clause.
-------------------------------------------------------------------------------

Restricting Group Results with the HAVING Clause

When you use the HAVING clause, the Oracle server restricts
groups as follows:
1. Rows are grouped.
2. The group function is applied.
3. Groups matching the HAVING clause are displayed.
-------------------------------------------------------------------------------
/*
    SELECT column, group_function
    FROM table
    [WHERE condition]
    [GROUP BY group_by_expression]
    [HAVING group_condition]
    [ORDER BY column];
*/
-------------------------------------------------------------------------------

--SELECT department_id, MAX(salary)
--FROM employees
--GROUP BY department_id
--HAVING MAX(salary)>10000 ;

--SELECT job_id, SUM(salary) PAYROLL
--FROM employees
--WHERE job_id NOT LIKE '%REP%'
--GROUP BY job_id
--HAVING SUM(salary) > 13000
--ORDER BY SUM(salary);

-------------------------------------------------------------------------------
-- GROUP functions can also be nested
-------------------------------------------------------------------------------

--SELECT MAX(AVG(salary))
--FROM employees
--GROUP BY department_id;

/*
Quiz:

Identify the guidelines for group functions and the GROUP BY clause.

1. You cannot use a column alias in the GROUP BY clause.

2. The GROUP BY column must be in the SELECT clause.

3. By using a WHERE clause, you can exclude rows before
   dividing them into groups.

4. The GROUP BY clause groups rows and ensures order of
   the result set.

5. If you include a group function in a SELECT clause, you
   cannot select individual results as well.
*/