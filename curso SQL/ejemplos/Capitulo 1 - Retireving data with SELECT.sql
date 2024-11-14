/*************************/
/* Descripción de tablas */
/*************************/

--DESCRIBE departments

--DESC employees

/******************************************/
/* Sintáxis básica de la sentencia SELECT */
/******************************************/
/*

SELECT *|{[DISTINCT] column|expression [alias],...}
FROM table;

*/


--SELECT * FROM departments;


--SELECT department_id, location_id FROM departments;

/**************************/
/* Operadores aritméticos */
/**************************/

--SELECT last_name, salary, salary + 300
--FROM employees;

/*****************************/
/* Precedencia de operadores */
/*****************************/

--SELECT last_name, salary, 12*salary+100
--FROM employees;

--SELECT last_name, salary, 12*(salary+100)
--FROM employees;

/*****************/
/* Valores nulos */
/*****************/

--SELECT last_name, job_id, salary, commission_pct
--FROM employees;

--SELECT last_name, 12*salary*commission_pct
--FROM employees;

/*********************/
/* Alias de columnas */
/*********************/

--SELECT last_name AS name, commission_pct comm
--FROM employees;

--SELECT last_name "Name" , salary*12 "Annual Salary"
--FROM employees;

/*****************************/
/* Operador de concatenación */
/*****************************/

--SELECT last_name||job_id AS "Employees"
--FROM employees;

--SELECT last_name ||' is a '||job_id
--AS "Employee Details"
--FROM employees;

--SELECT department_name || ' Department''s Manager Id: ' || manager_id AS "Department and Manager"
--FROM departments;

--SELECT department_name || q'[ Department's Manager Id: ]' || manager_id AS "Department and Manager"
--FROM departments;

/************************/
/* Registros duplicados */
/************************/

--SELECT department_id
--FROM employees;

--SELECT DISTINCT department_id
--FROM employees;

/********/
/* Quiz */
/********/
/*

Identifica las sentencias SELECT que se ejecutan correctamente.

1.

SELECT first_name, last_name, job_id, salary*12 AS Yearly Sal
FROM employees;

2.

SELECT first_name, last_name, job_id, salary*12 "yearly sal"
FROM employees;

3.

SELECT first_name, last_name, job_id, salary AS "yearly sal"
FROM employees;

4.

SELECT first_name + last_name AS name, job_Id, salary*12 AS "yearly sal"
FROM employees;

*/