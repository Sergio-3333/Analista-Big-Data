/******************************************/
/* Conversión implícita de tipos de datos */
/******************************************/

/*

Oracle puede convertir automaticamente 

-----------------------------------------
De                      a
-----------------------------------------
VARCHAR2 or CHAR        NUMBER
VARCHAR2 or CHAR        DATE
NUMBER                  VARCHAR2 or CHAR
DATE                    VARCHAR2 or CHAR
-----------------------------------------

*/

/******************************************/
/* Conversión exlícita de tipos de datos */
/******************************************/

/*
-----------------------------------------------------------------------------------------------
Function                                    Purpose
-----------------------------------------------------------------------------------------------
TO_CHAR(number|date,[ fmt],[nlsparams])     Converts a number or date value to a VARCHAR2 
                                            character string with the format model fmt.
                                            
                                            Number conversion: The nlsparams parameter 
                                            specifies the following characters,
                                            which are returned by number format elements:
                                            • Decimal character
                                            • Group separator
                                            • Local currency symbol
                                            • International currency symbol
                                        
                                            Date conversion: The nlsparams parameter specifies
                                            the language in which the month and day names, 
                                            and abbreviations are returned. 
                                            If this parameter is omitted this function uses 
                                            the default date languages for the session.
                                            
TO_NUMBER(char,[fmt],[nlsparams])
                                            Converts a character string containing digits to a number
                                            in the format specified by the optional format model fmt.
                                            The nlsparams parameter has the same purpose in this
                                            function as in the TO_CHAR function for number
                                            conversion.

TO_DATE(char,[fmt],[nlsparams])
                                            Converts a character string representing a date to a date
                                            value according to the fmt that is specified. 
                                            If fmt is omitted, the format is DD-MON-YY.
                                            The nlsparams parameter has the same purpose in this
                                            function as in the TO_CHAR function for date conversion.                                     
-----------------------------------------------------------------------------------------------
*/

--SELECT employee_id, TO_CHAR(hire_date, 'MM/YY') Month_Hired
--FROM employees
--WHERE last_name = 'Higgins';

/*

Format elements for date conversion

-----------------------------------------------------------------------------------------------------
Element                            Format
-----------------------------------------------------------------------------------------------------
YYYY                                Full year in numbers
YEAR                                Year spelled out (in English)
MM                                  Two-digit value for the month
MONTH                               Full name of the month
MON                                 Three-letter abbreviation of the month
DY                                  Three-letter abbreviation of the day of the week
DAY                                 Full name of the day of the week
DD                                  Numeric day of the month
SCC or CC                           Century; server prefixes B.C. date with -
Years in dates YYYY or SYYYY        Year; server prefixes B.C. date with -
YYY or YY or Y                      Last three, two, or one digit of the year
Y,YYY                               Year with comma in this position
IYYY, IYY, IY, I                    Four-, three-, two-, or one-digit year based on the ISO standard
SYEAR or YEAR                       Year spelled out; server prefixes B.C. date with -
BC or AD                            Indicates B.C. or A.D. year
B.C. or A.D.                        Indicates B.C. or A.D. year using periods
Q                                   Quarter of year
RM                                  Roman numeral month
WW or W                             Week of the year or month
DDD or DD or D                      Day of the year, month, or week
J                                   Julian day; the number of days since December 31, 4713 B.C.
IW                                  Weeks in the year from ISO standard (1 to 53)
AM or PM                            Meridian indicator
A.M. or P.M.                        Meridian indicator with periods
HH or HH12 or HH24                  Hour of day, or hour (1–12), or hour (0–23)
MI                                  Minute (0–59)
SS                                  Second (0–59)
SSSSS                               Seconds past midnight (0–86399)
/ . ,                               Punctuation is reproduced in the result.
“of the”                            Quoted string is reproduced in the result.
TH                                  Ordinal number (for example, DDTH for 4TH)
SP                                  Spelled-out number (for example, DDSP for FOUR)
SPTH or THSP                        Spelled-out ordinal numbers (for example, DDSPTH for FOURTH)
------------------------------------------------------------------------------------------------------
*/

--ALTER SESSION SET NLS_DATE_LANGUAGE='ENGLISH';
--ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-RR';

--SELECT TO_CHAR(SYSDATE) 
--FROM dual;


--SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS AM') 
--FROM dual;

--SELECT TO_CHAR(SYSDATE, 'DD "of" MONTH') 
--FROM dual;

--SELECT TO_CHAR(SYSDATE, 'ddspth') 
--FROM dual;

--SELECT last_name, TO_CHAR(hire_date, 'DD "of" Month YYYY') AS HIREDATE
--FROM employees;

--SELECT last_name, TO_CHAR(hire_date, 'fmDD "of" fmMonth YYYY') AS HIREDATE
--FROM employees;

--SELECT last_name, TO_CHAR(hire_date, 'fmDdspth "of" Month YYYY fmHH:MI:SS AM') AS HIREDATE
--FROM employees;

/*
Format elements for number conversion
-----------------------------------------------------------------------------------------------------------
Elemento        Format                                                      Example         Result
-----------------------------------------------------------------------------------------------------------
9               Numeric position (number of 9s determine display width)     999999          1234
0               Display leading zeros                                       099999          001234
$               Floating dollar sign                                        $999999         $1234
L               Floating local currency symbol                              L999999         FF1234
D               Returns the decimal character in the specified position. 
                The default is a period (.).                                99D99           99.99
.               Decimal point in position specified                         999999.99       1234.00
G               Returns the group separator in the specified position.
                You can specify multiple group separators.                  9,999           9G999
,               Comma in position specified                                 999,999         1,234
MI              Minus signs to right (negative values)                      999999MI        1234-
PR              Parenthesize negative numbers                               999999PR        <1234>
EEEE            Scientific notation (format must specify four Es)           99.999EEEE      1.234E+03
U               Returns in the specified position the “Euro” 
                (or other) dual currency                                    U9999           €1234
V               Multiply by 10 n times (n = number of 9s after V)           9999V99         123400
S               Returns the negative or positive value                      S9999           -1234 or +1234
B               Display zero values as blank, not 0                         B9999.99        1234.00
-----------------------------------------------------------------------------------------------------------

*/

--SELECT TO_CHAR(salary, '$99,999.00') AS SALARY
--FROM employees;

/**********************************************/
/* Conversión de caracter a fecha con TO_DATE */
/**********************************************/

--Example:
--Display the name and hire date for all employees who started on Sep 28, 2015. There are two spaces
--after the month May and before the number 24 in the following example.

--SELECT last_name, hire_date
--FROM employees
--WHERE hire_date = TO_DATE('Sep 28, 2015', 'Month DD, YYYY');

/*
Example:
To find employees hired before 2015, use the RR date format.
*/

--SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YYYY')
--FROM employees
--WHERE hire_date < TO_DATE('01-Jan-2015','DD-Mon-RR');

/*****************************/
/* TO_CHAR con parámetros nls*/
/*****************************/

--SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YYYY', 'NLS_DATE_LANGUAGE=SPANISH')
--FROM employees;
--
--SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YYYY', 'NLS_DATE_LANGUAGE=RUSSIAN')
--FROM employees;

/*************************************************************/
/*
Nesting Functions:
  
  Single-row functions can be nested to any level.
  
  Nested functions are evaluated from the deepest level to
  the least deep level.
    
    F3(F2(F1(col,arg1),arg2),arg3)
*/
/*************************************************************/

--SELECT  last_name, 
--        SUBSTR(LAST_NAME, 1, 8),
--        CONCAT(SUBSTR(LAST_NAME, 1, 8), '_US'),
--        UPPER(CONCAT(SUBSTR(LAST_NAME, 1, 8), '_US'))
--FROM employees
--WHERE department_id = 60;

/*
Example:
    Display the date of the next Friday that is six months from the hire date. 
    The resulting date should appear as Friday, August 13th, 2024. 
    Order the results by hire date.
*/

--SELECT TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 'FRIDAY'),'fmDay, Month ddth, YYYY') AS "Next 6 Months Review"
--FROM employees
--ORDER BY hire_date;

/*********************/
/* General functions */
/*********************/
/*
--The following functions work with any data type and pertain to using nulls:
---------------------------------------------------------------------------------------
Function    Description
---------------------------------------------------------------------------------------
NVL         Converts a null value to an actual value

NVL2        If expr1 is not null, NVL2 returns expr2. If expr1 is null, NVL2
            returns expr3. 
            The argument expr1 can have any data type.

NULLIF      Compares two expressions and returns null if they are equal; 
            returns the first expression if they are not equal

COALESCE    Returns the first non-null expression in the expression list
---------------------------------------------------------------------------------------
*/

/*******/
/* NVL */
/*******/

--SELECT  last_name, 
--        salary, 
--        NVL(commission_pct, 0),
--        (salary*12) + (salary * 12 * NVL(commission_pct, 0)) AN_SAL
--FROM employees;

/********/
/* NVL2 */
/********/

--SELECT  last_name, 
--        salary, 
--        commission_pct,
--        NVL2(commission_pct, 'SAL + COMM', 'SAL') AS income
--FROM employees 
--WHERE department_id IN (50, 80);

/**********/
/* NULLIF */
/**********/

--SELECT  first_name, 
--        LENGTH(first_name) "expr1",
--        last_name, 
--        LENGTH(last_name) "expr2",
--        NULLIF(LENGTH(first_name), LENGTH(last_name)) result
--FROM employees;

/************/
/* COALESCE */
/************/

--SELECT  last_name, 
--        employee_id,
--        COALESCE(TO_CHAR(commission_pct), TO_CHAR(manager_id), 'No commission and no manager')
--FROM employees;
/*
Example:
    For the employees who do not get any commission, your organization wants to give a salary
    increment of $2,000 and for employees who get commission, the query should compute the new
    salary that is equal to the existing salary added to the commission amount.
*/

--SELECT  last_name, 
--        salary, 
--        commission_pct,
--        COALESCE((salary+(commission_pct*salary)), salary+2000, salary) "NewSalary"
--FROM employees;

/***************************/
/* Conditional Expressions */
/***************************/

/*
  Provide the use of the IF-THEN-ELSE logic within a SQL statement
  Use two methods:
    – CASE expression
    – DECODE function
*/

/********************/
/* CASE expressions */
/********************/
/*
    CASE expr WHEN comparison_expr1 THEN return_expr1
             [WHEN comparison_expr2 THEN return_expr2
              WHEN comparison_exprn THEN return_exprn
    ELSE else_expr]
    END
*/

--SELECT  last_name, 
--        job_id, 
--        salary,
--        CASE job_id WHEN 'IT_PROG'  THEN 1.10 * salary
--                    WHEN 'ST_CLERK' THEN 1.15 * salary
--                    WHEN 'SA_REP' THEN 1.20 * salary
--                    ELSE salary 
--        END AS "REVISED_SALARY"
--FROM employees;


/*******************************************************************/
/* CASE without an expression allows to check different conditions */
/*******************************************************************/

--SELECT 
--    employee_id,
--    CASE 
--        WHEN salary > 5000 THEN 'High'
--        WHEN salary BETWEEN 3000 AND 5000 THEN 'Medium'
--        ELSE 'Low'
--    END AS salary_category
--FROM employees;

/*******************/
/* DECODE function */
/*******************/
/*

Facilitates conditional inquiries by doing the work of a CASE
expression or an IF-THEN-ELSE statement:

    DECODE(col|expression, search1, result1
                        [, search2, result2,...,]
                        [, default])
*/

--SELECT  last_name, 
--        job_id, 
--        salary,
--        DECODE(job_id, 'IT_PROG', 1.10 * salary,
--                       'ST_CLERK', 1.15 * salary,
--                       'SA_REP', 1.20 * salary,
--                        salary) AS REVISED_SALARY
--FROM employees;

/*
Example:
    Display the applicable tax rate for each employee in department 80:
*/

--SELECT last_name, salary,
--DECODE (TRUNC(salary/2000, 0), 0, 0.00,
--                               1, 0.09,
--                               2, 0.20,
--                               3, 0.30,
--                               4, 0.40,
--                               5, 0.42,
--                               6, 0.44,
--                               0.45) AS TAX_RATE
--FROM employees
--WHERE department_id = 80;

/*
Quiz:

The TO_NUMBER function converts either character strings or
date values to a number in the format specified by the optional
format model.
    1. True
    2. False
*/


