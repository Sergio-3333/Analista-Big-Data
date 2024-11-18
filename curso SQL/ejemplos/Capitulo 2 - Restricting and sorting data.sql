/*****************************************/
/* Limitando filas con la cláusula WHERE */
/*****************************************/

/*******************/
/* Sintáxis básica */
/*******************/

/*

SELECT *|{[DISTINCT] column|expression [alias],...}
FROM table
[WHERE condition(s)];

*/

--SELECT employee_id, last_name, job_id, department_id
--FROM employees
--WHERE department_id = 90 ;














--SELECT last_name, job_id, department_id
--FROM employees
--WHERE last_name = 'Whalen';

--ALTER SESSION SET NLS_DATE_LANGUAGE='ENGLISH';
--ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-RR';

--SELECT last_name
--FROM employees
--WHERE hire_date = '17-JUN-13';

--SELECT HIRE_DATE FROM EMPLOYEES;


/*****************************/
/* Operadores de comparación */
/*****************************/
/*
---------------------------------------------------------------------------------
 Operador               Significado
---------------------------------------------------------------------------------
    =                   Igual a
    >                   Mayor que
    <                   Menor que
    >=                  Mayor o igual que
    <=                  Menor o igual que
    <>                  Distinto de
    !=                  Distinto de
    BETWEEN ... AND ... Entre dos valores (inclusive)
    IN(lista)           Correspondencia con cualquiera de los valores de la lista
    LIKE                Correspondencia con un patrón de caracteres
    IS NULL             Correspondencia con un valor nulo (NULL)
---------------------------------------------------------------------------------
*/

--SELECT last_name, salary
--FROM employees
--WHERE salary <= 3000 ;

--SELECT last_name, salary
--FROM employees
--WHERE salary BETWEEN 2500 AND 3500 ;


--SELECT employee_id, last_name, salary, manager_id
--FROM employees
--WHERE manager_id IN (100, 101, 201) ;

---------------------------------------------
-- % --> 0 ó n caracteres.
-- _ --> 1 único caracter.

--SELECT first_name
--FROM employees
--WHERE first_name LIKE 'S%';

--SELECT last_name
--FROM employees
--WHERE last_name LIKE '_o%';

--SELECT last_name
--FROM employees
--WHERE last_name LIKE '%r__';

--SELECT last_name, manager_id
--FROM employees
--WHERE manager_id IS NULL;


/**********************/
/* Operadores lógicos */
/**********************/
/*
---------------------------------------------------------------------------------
 Operador               Significado
---------------------------------------------------------------------------------
    AND                 devuelve TRUE si ambas condiciones se evalúan a TRUE
    OR                  devuelve TRUE si alguna de las condiciones se evalúa a TRUE
    NOT                 negación de la condición
---------------------------------------------------------------------------------
*/

--SELECT employee_id, last_name, job_id, salary
--FROM employees
--WHERE salary >= 10000
--AND job_id LIKE '%MAN%' ;

--SELECT employee_id, last_name, job_id, salary
--FROM employees
--WHERE salary >= 10000
--OR job_id LIKE '%MAN%' ;

--SELECT last_name, job_id
--FROM employees
--WHERE job_id NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP') ;

/***************************************/
/* Reglas de precedencia de operadores */
/***************************************/
/*
---------------------------------------------------------------------------------
 Operador               Significado
---------------------------------------------------------------------------------
    1                   operadores aritméticos
    2                   operador de concatenación
    3                   operadores de comparación excepto "distinto de"
    4                   IS [NOT] NULL, LIKE, [NOT] IN
    5                   [NOT] BETWEEN
    6                   distinto de
    7                   condición lógica NOT
    8                   condición lógica AND
    9                   condición lógica OR
---------------------------------------------------------------------------------
*/


--SELECT last_name, job_id, salary
--FROM employees
--WHERE job_id = 'SA_REP'
--OR (job_id = 'AD_PRES'
--AND salary > 15000);

--SELECT last_name, job_id, salary
--FROM employees
--WHERE (job_id = 'SA_REP'
--OR job_id = 'AD_PRES')
--AND salary > 15000;

/*****************************************************/
/* Ordenación de resultados con la cláusula ORDER BY */
/*****************************************************/

/*******************/
/* Sintáxis básica */
/*******************/

/*

SELECT *|{[DISTINCT] column|expression [alias],...}
FROM table
[WHERE condition(s)]
[ORDER BY {column, expr, alias} [ASC|DESC]]

*/

--SELECT last_name, job_id, department_id, hire_date
--FROM employees
--ORDER BY hire_date;

--SELECT last_name, job_id, department_id, hire_date
--FROM employees
--ORDER BY hire_date DESC ;

--SELECT employee_id, last_name, salary*12 AS annsal
--FROM employees
--ORDER BY annsal DESC;

--SELECT last_name, job_id, department_id, hire_date
--FROM employees
--ORDER BY 3;

--SELECT  department_id, 
--        job_id, 
--        first_name || ' ' || last_name AS fullname,  
--        salary
--FROM employees
--ORDER BY department_id ASC, job_id DESC, salary DESC ;

--SELECT last_name, department_id, salary
--FROM employees
--ORDER BY department_id, salary DESC;

/****************************/
/* Variables de sustitución */
/****************************/
/*

Use substitution variables to:
– Temporarily store values with single-ampersand (&) and
double-ampersand (&&) substitution

  Use substitution variables to supplement the following:
– WHERE conditions
– ORDER BY clauses
– Column expressions
– Table names
– Entire SELECT statements

*/

--SELECT employee_id, last_name, salary, department_id
--FROM employees
--WHERE employee_id = &employee_num ;

--SELECT last_name, department_id, salary*12
--FROM employees
--WHERE job_id = '&job_title' ;


--SELECT employee_id, last_name, job_id,&column_name
--FROM employees
--WHERE &condition
--ORDER BY &order_column ;


--SELECT employee_id, last_name, job_id, &&column_name
--FROM employees
--ORDER BY &column_name ;

--UNDEFINE column_name



--DEFINE column_name = hire_date
--
--SET VERIFY ON
--DEFINE employee_num = 200

--SELECT employee_id, last_name, salary, department_id
--FROM employees
--WHERE employee_id = &employee_num ;

--UNDEFINE employee_num

DEFINE
--
--UNDEFINE COLUMNA
--
--SELECT first_name, last_name, &&columna 
--FROM employees
--WHERE &columna = '&valor';
--
--DEFINE COLUMNA = SALARY
--DEFINE COLUMNA
--
--SELECT &COLUMNA FROM EMPLOYEES;
--
----SELECT first_name, last_name, &columna 
----FROM employees
----WHERE &CONDICION;
--
--


/********/
/* quiz */
/********/

/*

¿Cuáles de los siguientes son operadores válidos en la cláusula WHERE?

1. >=
2. IS NULL
3. !=
4. IS LIKE
5. IN BETWEEN
6. <>

*/

--