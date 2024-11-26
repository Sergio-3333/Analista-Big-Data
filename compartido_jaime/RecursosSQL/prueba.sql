/*Crear una sentencia sql que saque todos los empleados que no tengan comision y que ademas trabajen en un departamento 
cuyo numero de empleados sea mayor a 2 y que ademas su salario sea mayor a la media de los salarios de su departamento.*/
SELECT e.*
FROM employees e
    JOIN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(*) > 2
) d ON e.department_id = d.department_id
WHERE e.commission_pct IS NULL
    AND e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

