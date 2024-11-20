/*****************************/
/* Funciones a nivel de fila */
/*****************************/

/* 

Single-Row Functions
These functions operate on single rows only and return one result per row. 
There are different types of single-row functions:

Single-row functions:

  Manipulate data items
  Accept arguments and return one value
  Act on each row that is returned
  Return one result per row
  May modify the data type
  Can be nested
  Accept arguments that can be a column or an expression

function_name [(arg1, arg2,...)]

- Character functions:  Accept character input and can return both character and number values

- Number functions: Accept numeric input and return numeric values

- Date functions: Operate on values of the DATE data type (All date functions return a value of
  the DATE data type except the MONTHS_BETWEEN function, which returns a number.)

- Conversion functions: Convert a value from one data type to another

- General functions:
- NVL
- NVL2
- NULLIF
- COALESCE
- CASE
- DECODE

*/

/***************************/
/* Funciones de caracteres */
/***************************/
/*

-------------------------------------------------------------------------------------------------------------------
Function                                                    Purpose
-------------------------------------------------------------------------------------------------------------------
LOWER(column|expression)                                    Converts alpha character values to lowercase

UPPER(column|expression)                                    Converts alpha character values to uppercase

INITCAP(column|expression)                                  Converts alpha character values to uppercase for the first
                                                            letter of each word; all other letters in lowercase

CONCAT(column1|expression1, column2|expression2)            Concatenates the first character value to the second
                                                            character value; equivalent to concatenation operator (||)

SUBSTR(column|expression,m[,n])                             Returns specified characters from character value starting at
                                                            character position m, n characters long (If m is negative, the
                                                            count starts from the end of the character value. If n is
                                                            omitted, all characters to the end of the string are returned.)

LENGTH(column|expression)                                   Returns the number of characters in the expression

INSTR(column|expression,’string’, [,m], [n] )               Returns the numeric position of a named string.
                                                            Optionally, you can provide a position m to start
                                                            searching, and the occurrence n of the string. m and n
                                                            default to 1, meaning start the search at the beginning
                                                            of the string and report the first occurrence.

LPAD(column|expression, n,'string')                         Returns an expression left-padded to length of n
                                                            characters with a character expression.

RPAD(column|expression, n,'string')                         Returns an expression right-padded to length of n
                                                            characters with a character expression.

TRIM(leading|trailing|both,trim_character FROM trim_source) Enables you to trim leading or trailing characters (or
                                                            both) from a character string. If trim_character or
                                                            trim_source is a character literal, you must enclose it in
                                                            single quotation marks.
                                                            This is a feature that is available in Oracle8i and later
                                                            versions.

REPLACE(text, search_string, replacement_string)            Searches a text expression for a character string and, if
                                                            found, replaces it with a specified replacement string                                                    
-------------------------------------------------------------------------------------------------------------------
*/

/*****************************************************************/
/* Funciones de conversión de caracteres:  LOWER, UPPER, INITCAP */
/*****************************************************************/

--SELECT LOWER('SQL Course'), UPPER('SQL Course'), INITCAP('SQL Course')
--FROM dual;

--SELECT 'The job id for '||UPPER(last_name)||' is '
--        ||LOWER(job_id) AS "EMPLOYEE DETAILS"
--FROM employees;

----------------------------------------------------------
--Display the employee number, name, and department number
--for employee Higgins:
----------------------------------------------------------

--SELECT employee_id, last_name, department_id
--FROM employees
--WHERE last_name = 'higgins';

--SELECT employee_id, last_name, department_id
--FROM employees
--WHERE LOWER(last_name) = 'higgins';

/*****************************************************************************************************/
/* Funciones de manipulación de caracteres: CONCAT, SUBSTR, LENGTH, INSTR, LPAD, RPAD, TRIM, REPLACE */
/*****************************************************************************************************/

--SELECT  CONCAT('Hello', 'World') AS concat,
--        SUBSTR('HelloWorld',1,5) AS substr,
--        LENGTH('HelloWorld') AS length,
--        INSTR('HelloWorld', 'W') AS instr,
--        LPAD(12345, 10, '*') AS lpad,
--        RPAD(12345, 10, '*') AS rpad,
--        REPLACE('JACK and JUE','J','BL') AS replace,
--        TRIM(' ' FROM ' HelloWorld ') AS trim
--FROM dual;


--SELECT  employee_id, 
--        CONCAT(first_name, last_name) NAME,
--        job_id, 
--        LENGTH (last_name),
--        INSTR(last_name, 'a') "Contains 'a'?"
--FROM employees
--WHERE SUBSTR(job_id, 4) = 'REP'; -- desde indice 4 hasta el final

/***********************/
/* Funciones numéricas */
/***********************/
/*

---------------------------------------------------------------------------------------------
Function                        Purpose
---------------------------------------------------------------------------------------------

ROUND(column|expression, n)     Rounds the column, expression, or value to n decimal
                                places or, if n is omitted, no decimal places (If n is
                                negative, numbers to the left of decimal point are rounded.)
                                
TRUNC(column|expression, n)     Truncates the column, expression, or value to n decimal
                                places or, if n is omitted, n defaults to zero
                                
MOD(m,n)                        Returns the remainder of m divided by n

---------------------------------------------------------------------------------------------

*/

--SELECT  ROUND(45.923, 2), 
--        ROUND(45.923, 0),
--        ROUND(45.923, -1)
--FROM DUAL;

--SELECT  TRUNC(45.923,2), 
--        TRUNC(45.923),
--        TRUNC(45.923,-1)
--FROM DUAL;

--SELECT  last_name, 
--        salary, 
--        MOD(salary, 5000)
--FROM employees
--WHERE job_id = 'SA_REP';

/*****************************/
/* Funciones de fecha y hora */
/*****************************/

--ALTER SESSION SET NLS_DATE_LANGUAGE='ENGLISH';
--ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-RR';

--SELECT SYSDATE FROM DUAL;

/*

The Oracle database stores dates in an internal numeric
format: century, year, month, day, hours, minutes, and
seconds.

  The default date display format is DD-MON-RR.
  
– RR Enables you to store 21st-century dates in the 20th century
  by specifying only the last two digits of the year

– RR Enables you to store 20th-century dates in the
  21st century in the same way
--------------------------------------------------------------------------------------------------------------
                                                    RR format
--------------------------------------------------------------------------------------------------------------
                                                            If the specified two-digit year is:

If two digits of the current year are:                      0  - 49                     50 - 99
--------------------------------------------------------------------------------------------------------------
                                            0  - 49         the return date is in       the return date is in                                            
                                                            the current century         the century before
                                                                                        the current one
                                                                                            
                                            50 - 99         the return date is in       the return date is in
                                                            the century after           the current century
                                                            the current one                                                        
--------------------------------------------------------------------------------------------------------------
*/

--ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-RR';

--SELECT last_name, hire_date
--FROM employees;

--SELECT last_name, hire_date
--FROM employees
--WHERE hire_date < '01-FEB-18';

/***********/
/* SYSDATE */
/***********/

--SELECT sysdate
--FROM dual;

/**************************************/
/* Operaciones aritméticas con fechas */
/**************************************/
/*
--------------------------------------------------------------------------
Operation           Result          Description
--------------------------------------------------------------------------
date + number       Date            Adds a number of days to a date
date – number       Date            Subtracts a number of days from a date
date – date         Number of days  Subtracts one date from another
date + number/24    Date            Adds a number of hours to a date
--------------------------------------------------------------------------
*/

--SELECT last_name, (SYSDATE - hire_date) / 7 AS "Semanas"
--FROM employees
--WHERE department_id = 90;

-- truncando y redondeando los resultados

--SELECT last_name, TRUNC((SYSDATE - hire_date) / 7) AS "Semanas completas"
--FROM employees
--WHERE department_id = 90
--ORDER BY "Semanas completas" DESC;

/***************************************/
/* Funciones de manipulación de fechas */
/***************************************/
/*
---------------------------------------------------------------------------------------------------------------
Function                                Description
---------------------------------------------------------------------------------------------------------------
MONTHS_BETWEEN(date1, date2):           Finds the number of months between date1 and date2. 
                                        The result can be positive or negative. 
                                        
                                        If date1 is later than date2, the result is positive; 
                                        if date1 is earlier than date2, the result is negative. 
                                        
                                        The noninteger part of the result represents a portion of the month.
                                        
ADD_MONTHS(date, n):                    Adds n number of calendar months to date. The value of n must
                                        be an integer and can be negative.

NEXT_DAY(date, 'char'):                 Finds the date of the next specified day of the week
                                        ('char') following date. 
                                        
                                        The value of char may be a number representing a day or a
                                        character string.

LAST_DAY(date):                         Finds the date of the last day of the month that contains date
                                        The above list is a subset of the available date functions. 

---------------------------------------------------------------------------------------------------------------                                        
ROUND and TRUNC number functions can also be used to manipulate the date values as shown below:
---------------------------------------------------------------------------------------------------------------

ROUND(date[,'fmt']):                    Returns date rounded to the unit that is specified by the format
                                        model fmt. 
                                        If the format model fmt is omitted, date is rounded to the nearest day.

TRUNC(date[, 'fmt']):                   Returns date with the time portion of the day truncated to the
                                        unit that is specified by the format model fmt. 
                                        
                                        If the format model fmt is omitted, date is truncated to the nearest day.
---------------------------------------------------------------------------------------------------------------
*/


--SELECT  MONTHS_BETWEEN('01-SEP-95','11-JAN-94'),
--        ADD_MONTHS('31-JAN-96', 1),
--        NEXT_DAY('01-SEP-95','FRIDAY'),
--        LAST_DAY('01-FEB-96')
--FROM dual;

--SELECT  ROUND(SYSDATE,'MONTH'),
--        ROUND(SYSDATE ,'YEAR'),
--        TRUNC(SYSDATE ,'MONTH'),
--        TRUNC(SYSDATE ,'YEAR')
--FROM dual;

--SELECT  employee_id, 
--        hire_date,
--        ROUND(hire_date, 'MONTH'), 
--        TRUNC(hire_date, 'MONTH')
--FROM employees
--WHERE hire_date LIKE '%17';

/************************************/
/* Ejemplo de función personalizada */
/************************************/

--CREATE OR REPLACE FUNCTION invertir_cadena(cadena IN VARCHAR2) 
--RETURN VARCHAR2 IS
--    cadena_invertida VARCHAR2(4000);
--BEGIN
--    FOR letra IN REVERSE 1..LENGTH(cadena) LOOP
--        cadena_invertida := cadena_invertida || SUBSTR(cadena, letra, 1);
--    END LOOP;
--    RETURN cadena_invertida;
--END;
--/

--SELECT invertir_cadena(first_name) 
--FROM employees;

/********/
/* QUIZ */
/********/

--select length(concat(first_name,last_name)) 
--from employees;

/*

¿Cuáles de las siguientes afirmaciones son correctas acerca de las funciones a nivel de fila?

1. Manipulan elementos de datos.
2. Aceptan argumentos y devuelven un valor por cada argumento.
3. Actúan en cada fila devuelta.
4. Devuelven un resultado por cada conjunto de filas.
5. No pueden modificar el tipo de dato.
6. Pueden anidarse.
7. Aceptan argumentos que pueden ser columnas o expresiones.

*/
-------------------------------------------------------------------------------------------------------
-- Fecha de renovacion de contrato (siguiente Lunes transcurridos 6 meses de la fecha de contratación)
-------------------------------------------------------------------------------------------------------
--SELECT  hire_date, 
--        NEXT_DAY(ADD_MONTHS(hire_date, 6), 'MONDAY') AS "Fecha de renovación del contrato"
--FROM employees;

-- CALCULAR SALARIO ANUAL DE TODOS LOS EMPLEADOS CONTANDO TAMBIÉN SU POSIBLE COMISIÓN

--SELECT  EMPLOYEE_ID,
--        JOB_ID,
--        SALARY, 
--        COMMISSION_PCT, 
--        (SALARY * (1 + (NVL(COMMISSION_PCT, 0) / 100))) * 12 AS SALARIO_ANUAL 
--FROM EMPLOYEES;


