create or replace procedure PROCEDIMIENTO_5
	is 
	cursor cursor_empleados is 
		select e.nombre as e_name,e.apellido1,e.salario,o.nombre AS oficio,d.nombre as name_dept,e.nroemp,e.coordinador
		from empleados e, departamentos d, oficios o 
		where d.nrodep=e.nrodep and e.nrooficio=o.nrooficio
;

	v_emp cursor_empleados%rowtype;
	name_dept departamentos.nombre%type:='.';
	cont_emple NUMBER(4):=0;
	sum_sal NUMBER(9):=0;
	contadorcoordinadores number(9):=0;
	media_sal number(10):=0;


begin 
OPEN cursor_empleados;
	FETCH cursor_empleados INTO v_emp;
WHILE cursor_empleados%FOUND LOOP

	if v_emp.coordinador is null then
		contadorcoordinadores:=contadorcoordinadores+1;
	end if;

	if name_dept != v_emp.name_dept THEN
	
		dbms_output.put_line('El departamento ' || name_dept || ' tiene ' || cont_emple || ' empleados ' || 'con un salario medio de ' || media_sal );	

		name_dept := v_emp.name_dept;
		cont_emple:=0;
		sum_sal:=0;

	end if;

	dbms_output.put_line('Num' || v_emp.nroemp || ' con  nombre ' || v_emp.e_name || ' ' || v_emp.apellido1 || ' salario : ' || v_emp.salario || ' oficio : ' || v_emp.oficio  );
	cont_emple := cont_emple + 1;
	sum_sal:=sum_sal + v_emp.salario;
 	media_sal:=sum_sal/cont_emple;
	FETCH cursor_empleados INTO v_emp;

	end LOOP;
CLOSE cursor_empleados;

	if cont_emple > 0 THEN
		dbms_output.put_line('El departamento ' || name_dept || ' tiene ' || cont_emple || ' empleados ' || 'con un salario medio de ' || sum_sal/cont_emple );
		name_dept := v_emp.name_dept;
		cont_emple:=0;
		sum_sal:=0;

end if;

dbms_output.put_line('En total hay  ' || contadorcoordinadores|| ' coordinadores');

end PROCEDIMIENTO_5;
/