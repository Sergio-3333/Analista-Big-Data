/*1. (5 puntos) Escribir un procedimiento llamado ACTUALIZAR_SALARIOS que suba el sueldo de todos los empleados que ganen menos que el salario medio de su oficio. La subida será de un porcentaje de la diferencia entre el salario del empleado y la media de su oficio. El porcentaje se pasará por parámetro al procedimiento. Si el parámetro es un número negativo, el procedimiento lanzará una excepción y la capturará, mostrando el siguiente mensaje:
"El porcentaje de subida no puede ser negativo".*/
create or replace procedure ACTUALIZAR_SALARIOS(porcentaje number)
is 
--Cursor que saque a los empleados que cobran menos que la media de su oficio
cursor empleados_menores_a_oficio is 
	select e.nombre,e.salario,e.nrooficio
	from empleados e 
	where e.salario<(select avg(salario)
					from empleados 
					where nrooficio=e.nrooficio) 
	for update of e.salario;
--Cursor que saque la media de los oficio 
cursor media_oficios_empleados is 
select nrooficio,avg(salario) as media
from empleados 
where nrooficio in (select e1.nrooficio
				from empleados e1
				where salario<(select avg(salario)
				from empleados e
				where e.nrooficio=e1.nrooficio))
				group by nrooficio
				;
--Nueva excepcion que se producira si el porcentaje es negativo 
porc_neg exception;
begin 
--Comprobacion excepcion
	if porcentaje<0 then 
		raise porc_neg;
	end if;
	--Abrimos los dos cursores
	for i in empleados_menores_a_oficio loop 
	for j in media_oficios_empleados loop
	--Actualizamos a los empleados
		update empleados set salario=(porcentaje/100)*(j.media-i.salario)+ i.salario
		where current of empleados_menores_a_oficio;
	end loop;
	end loop;
--Gestionamos la excepcion
exception
	when porc_neg then 
	dbms_output.put_line('El porcentaje de subida no puede ser negativo');
	when others then 
	dbms_output.put_line('Error desconocido ' || SQLERRM);
end ACTUALIZAR_SALARIOS;
/				 

/*2. (5 puntos) Crear una función llamada OFICIOS_SALARIOS que devuelva el número de oficios que existen con un salario medio superior al del departamento donde haya más empleados con ese oficio (si hay más de uno, tomar el departamento con código más bajo). Mostrar por pantalla un informe que muestre, por orden de número de oficio, el nombre del oficio, nombre del departamento en el que hay más empleados de ese oficio y la media de salario de ese departamento, de acuerdo al siguiente formato:
Oficio: XXXX. Departamento: YYYY. Media del departamento: ZZZZ,ZZ*/
create or replace function OFICIOS_SALARIOS
return number 
is 
/*
cursor no_funciona is 
select avg(e.salario),d.nombre,o.nombre
from oficios o,empleados e,departamentos d 
where e.nrooficio=o.nrooficio and d.nrodep=e.nrodep and d.nombre in (select nombre
																	from departamentos 
																	where nrodep in (select nrodep 
																					from empleados 
																					group by nrodep
																					having count(nroemp)=(select max(count(nroemp))
																									from empleados 
																									where nrooficio in(select nrooficio
																									from oficios 
																									where lower(nombre)= lower (o.nombre))
																									group by nroemp)))
group by d.nombre,o.nombre
;*/
/*
cursor no_funciona1 is 
select distinct count(e.nroemp),d.nombre,e.nrooficio
from empleados e, departamentos d,oficios o 
where e.nrodep=d.nrodep and o.nrooficio=e.nrooficio
group by d.nombre,e.nrooficio
having count(e.nroemp)=(select max(count(nroemp))
						from empleados 
						where nrooficio=e.nrooficio
						group by nroemp)
;
*/
--Cursor 1 media  de oficios
cursor no_funciona2 is 
select o.nombre,avg(e.salario) as salo
from oficios o,empleados e  
where e.nrooficio=o.nrooficio
group by o.nombre
;
--Cursor 2 media departametnos
cursor no_funciona3 is 
select d.nombre,avg(e.salario) as sald
from departamentos d,empleados e 
where e.nrodep=d.nrodep
group by d.nombre
;
contador number(9):=0;
begin 
	--Abrimos los dos cursores 
	for i in no_funciona2 loop
		for j in no_funciona3 loop
		--Comparamos las medias si se cumple la condicion lo sacamos por pantalla y le summamos uno al contador
		if (i.salo>j.sald) then 
			dbms_output.put_line('Oficio' || i.nombre || ' Departamento ' || j.nombre || ' Media del departamento' || j.sald);
			contador:=contador+1;
		end if;
		
		end loop;
	end loop;
	--Devolvemos el valor del contador 
	return contador;

exception
	when others then 
	dbms_output.put_line('Error desconocido ' || SQLERRM);
	
end OFICIOS_SALARIOS;
/