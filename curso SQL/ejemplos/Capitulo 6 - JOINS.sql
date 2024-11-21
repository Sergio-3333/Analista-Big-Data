/*
Types of Joins:

Joins that are compliant with the standard ANSI SQL standard include the following:

  Natural joins:
    – NATURAL JOIN clause
    – USING clause
    – ON clause
  OUTER joins:
    – LEFT OUTER JOIN
    – RIGHT OUTER JOIN
    – FULL OUTER JOIN
  Cross joins
*/
/*
SELECT table1.column, table2.column
FROM table1
[NATURAL JOIN table2] |
[JOIN table2 USING (column_name)] |
[JOIN table2
ON (table1.column_name = table2.column_name)]|
[LEFT|RIGHT|FULL OUTER JOIN table2
ON (table1.column_name = table2.column_name)]|
[CROSS JOIN table2];
*/

/*****************/
/* Natural JOINS */
/*****************/
/*
Creating Natural Joins
  The NATURAL JOIN clause is based on all columns in the
  two tables that have the same name.
  
  It selects rows from the two tables that have equal values
  in all matched columns.
  
  If the columns having the same names have different data
  types, an error is returned.
*/

--SELECT  department_id, 
--        department_name,
--        location_id, 
--        city
--FROM departments
--NATURAL JOIN locations ;

--SELECT  department_id, 
--        department_name,
--        location_id, 
--        city
--FROM departments
--NATURAL JOIN locations
--WHERE department_id IN (20, 50);

/****************/
/* USING clause */
/****************/
/*
Creating Joins with the USING Clause:

  If several columns have the same names but the data
  types do not match, use the USING clause to specify the
  columns for the equijoin.
  
  Use the USING clause to match only one column when
  more than one column matches.
  
  The NATURAL JOIN and USING clauses are mutually
  exclusive.
*/

--SELECT  employee_id, 
--        last_name,
--        location_id, 
--        department_id
--FROM employees 
--JOIN departments
--USING (department_id);

/*************/
/* ON clause */
/*************/
/*
Creating Joins with the ON Clause:

  The join condition for the natural join is basically an
  equijoin of all columns with the same name.
  
  Use the ON clause to specify arbitrary conditions or specify
  columns to join.
  
  The join condition is separated from other search
  conditions.
  
  The ON clause makes code easy to understand.
*/

--SELECT  e.employee_id, 
--        e.last_name, 
--        e.department_id,
--        d.department_id, 
--        d.location_id
--FROM employees e 
--JOIN departments d
--ON (e.department_id = d.department_id);

--SELECT  employee_id, city, 
--        department_name
--FROM employees e
--JOIN departments d
--ON d.department_id = e.department_id
--JOIN locations l
--ON d.location_id = l.location_id;

-------------------------------------------------------------------------------
--Applying Additional Conditions to a Join

--    Use the AND clause or the WHERE clause to apply additional
--    conditions:
-------------------------------------------------------------------------------

--SELECT  e.employee_id, 
--        e.last_name, 
--        e.department_id,
--        d.department_id, 
--        d.location_id
--FROM employees e 
--JOIN departments d
--ON (e.department_id = d.department_id)
--AND e.manager_id = 149 ;

---------------------------------------
--equivalente
---------------------------------------

--SELECT e.employee_id, e.last_name, e.department_id,
--d.department_id, d.location_id
--FROM employees e JOIN departments d
--ON (e.department_id = d.department_id)
--WHERE e.manager_id = 149 ;

/**************/
/* SELF joins */
/**************/

--SELECT  worker.last_name  || ' works for ' || manager.last_name 
--FROM employees worker 
--JOIN employees manager
--ON (worker.manager_id = manager.employee_id);

/******************/
/* NON EQUI joins */
/******************/

--SELECT  e.last_name, 
--        e.salary, 
--        j.grade_level
--FROM employees e 
--JOIN job_grades j
--ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;


/*
INNER Versus OUTER Joins:

  In SQL, the join of two tables returning only matched
  rows is called an INNER join.
  
  A join between two tables that returns the results of the
  INNER join as well as the unmatched rows from the left (or right) 
  table is called a left (or right) OUTER join.
  
  A join between two tables that returns the results of an
  INNER join as well as the results of a left and right join is a
  full OUTER join.
*/

/*******************/
/* LEFT OUTER JOIN */
/*******************/

--SELECT  e.last_name, 
--        e.department_id, 
--        d.department_name
--FROM employees e 
--LEFT OUTER JOIN departments d
--ON (e.department_id = d.department_id) ;

/********************/
/* RIGHT OUTER JOIN */
/********************/

--SELECT  e.last_name, 
--        e.department_id, 
--        d.department_name
--FROM employees e 
--RIGHT OUTER JOIN departments d
--ON (e.department_id = d.department_id) ;

/*******************/
/* FULL OUTER JOIN */
/*******************/

--SELECT  e.last_name, 
--        e.department_id, 
--        d.department_name
--FROM employees e 
--FULL OUTER JOIN departments d
--ON (e.department_id = d.department_id) ;

/*
Cartesian Products:

  A Cartesian product is formed when:
  
    – A join condition is omitted
    – A join condition is invalid
    – All rows in the first table are joined to all rows in the second table
  
  To avoid a Cartesian product, always include a valid join condition.
  
  Creating Cross Joins
  The CROSS JOIN clause produces the cross-product of
  two tables.
  
  This is also called a Cartesian product between the two
  tables.
*/

--SELECT  last_name, 
--        department_name
--FROM employees
--CROSS JOIN departments;
