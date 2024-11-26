--SELECT DEPARTMENT_ID, TRUNC(VARIANCE(SALARY)), TRUNC(STDDEV(SALARY)) 
--FROM EMPLOYEES
--GROUP BY DEPARTMENT_ID;
--
--
--SELECT TRUNC(AVG(SALARY))
--FROM EMPLOYEES;
--

--    decode(columna o expresion , valor_por_el_que_pregunto, valor_en_caso_de_true, valor_en_caso_de_false)

SELECT COUNT(*) total,
    SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2011', 1, 0)) "2011",
    SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2012', 1, 0)) "2012",
    SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2013', 1, 0)) "2013",
    SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2014', 1, 0)) "2014"
FROM employees;

SELECT COUNT(*) total,
    COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'),'2011',1, NULL)) "2011",
    COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'),'2012',1, NULL)) "2012",
    COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'),'2013',1, NULL)) "2013",
    COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'),'2014',1, NULL)) "2014"
FROM employees;

SELECT
    COUNT(*) AS total_employees,
    SUM(CASE WHEN to_char(hire_date, 'yyyy') = '2011' THEN 1 ELSE 0 END) AS hired_in_2011,
    SUM(CASE WHEN to_char(hire_date, 'yyyy')  = '2012' THEN 1 ELSE 0 END) AS hired_in_2012,
    SUM(CASE WHEN to_char(hire_date, 'yyyy')  = '2013' THEN 1 ELSE 0 END) AS hired_in_2013,
    SUM(CASE WHEN to_char(hire_date, 'yyyy')  = '2014' THEN 1 ELSE 0 END) AS hired_in_2014
FROM employees;

SELECT job_id "Job",
        SUM(DECODE(department_id , 20, salary, 0)) "Dept 20",
        SUM(DECODE(department_id , 50, salary, 0)) "Dept 50",
        SUM(DECODE(department_id , 80, salary, 0)) "Dept 80",
        SUM(DECODE(department_id , 90, salary, 0)) "Dept 90",
        SUM(salary) "Total"
FROM employees
GROUP BY job_id;
--
--
--select level, employee_id, 
--       lpad ( '  ', level, '  ' ) || first_name || ' ' || last_name name, manager_id 
--from   employees
--start  with manager_id is null
--connect by prior employee_id = manager_id;
--
---- ASCENDENTE
--select level, employee_id, 
--       lpad ( '  ', level, '  ' ) || first_name || ' ' || last_name name, manager_id 
--from   employees
--start  with employee_id = 107
--connect by prior manager_id = employee_id;
--
--
--
--
--
--
--
--
