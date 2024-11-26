create or replace view frecuencias_oficios
as 
select o.nombre,count(e.nroemp) as numero_de_empleados
from oficios o left join empleados e 
on e.nrooficio=o.nrooficio
group by o.nombre
;
create or replace trigger vistas_1
	instead of insert or update 
	on frecuencias_oficios
	for each row 

	begin 
	if updating then
	update oficios set nombre=:new.nombre where nombre=:old.nombre;
	end if; 
	if inserting then
	insert into oficios values 
							((select max(nrooficio)+1
								from oficios),:new.nombre);
	end if;


	end vistas_1;
	/



----------------------------------------------------------------------------------------------------------------------------------------
--1. Crear una vista que muestre a los empleados del departamento 30 mostrando su número de empleado (con
--nombre de campo "codigo"), nombre, apellido1, apellido2, oficio (el número, no el nombre) y salario (en ese
--orden y con esos nombres de campos). Construir un trigger que permita insertar nuevos empleados en esa vista
create or replace view vista_1
	as 
	select nroemp as codigo,nombre,apellido1,apellido2,salario,nrooficio
	from empleados
	where nrodep=30
	;

create or replace trigger trigger_vistas_1
	instead of insert
	on vistas_1
	for each row 

	begin 
	insert into empleados ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep)
		values(:new.codigo,:new.nombre,:new.apellido1,:new.apellido2,:new.salario,:new.nrooficio,30);


	end trigger_vistas_1;
	/
---------------------------------------------------------------------------------------------------------------------------------------------
--2.Crear una vista que muestre nombre de producto ("nombre"), precio actual de éste ("precio_actual") y la fecha
--en la que se introdujo el precio actual ("fecha") (en ese orden y con esos nombres de campos). Implementar un
--trigger que permita realizar las siguientes operaciones sobre la vista:
-- Insertar nuevo producto. Si la fecha con la que se inserta es nula, el precio debe tener la fecha actual.
-- Eliminar producto, siempre que no haya sido vendido nunca. Si se ha vendido, y por tanto no se puede
--borrar, debe mostrarse el siguiente mensaje de error:
-- Modificar el precio de dicho producto.
create or replace view vista_2
	as
	select p.descripcion as nombre,h.precio as precio_actual,h.fecha_insercion as fecha 
	from historial_precios h, productos p 
	where p.nroprod=h.nroprod and fecha_insercion = (select max(h2.fecha_insercion)
													from historial_precios h2
													where h2.nroprod = h.nroprod
													group by h2.nroprod)
;
create or replace trigger trigger_vistas_2
	instead of insert or delete or update
	on vista_2
	for each row 
	declare 
	cursor c1 is 
		select distinct nvl(p.nroprod,0) as ey
		from linea_pedido l left join productos p 
		on p.nroprod=l.nroprod 
		where l.nroped is not  null and p.nroprod=(select nroprod 
													from productos 
													where lower(descripcion)=lower(:old.nombre))
		;
	cursor c2 is 
	select max(nroprod)+1 as hola from productos;
	
	begin
	
		if updating then 
			update historial_precios set precio=:new.precio_actual where nroprod =(select nroprod 
																					from productos 
																					where lower(descripcion)=lower(:new.nombre));
		end if;

		for i in c2 loop
				if inserting then 
					if :new.fecha is null then 
						insert into productos values(i.hola,:new.nombre);
						insert into historial_precios values(i.hola,sysdate,:new.precio_actual);
					else
						insert into productos values(i.hola,:new.nombre);
						insert into historial_precios values(i.hola,:new.fecha,:new.precio_actual);
					end if;
				end if;
		end loop;
	

		for i in c1 loop 
			if deleting then 
					 if i.ey is not null then 
						 raise_application_error(-20003, 'El producto ' || i.ey || ' ' || (:old.nombre) || ' porque ya ha sido vendido');
					end if;
				end if;
		end loop;

end trigger_vistas_2;
/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3. A partir de una vista que muestre los nombres de los departamentos ("nombre_dep"), el nombre de la provincia
--donde está ("nombre_prov") y cuántos empleados pertenecen a ese departamento ("n_empleados"), construir
--un trigger que permita cambiar la localidad de un departamento siempre y cuando éste tenga menos de 5
--empleados y la localidad ya exista.
--Si la localidad no existe, el trigger debe lanzar el siguiente error:
--Si el departamento tiene 5 empleados o más, el trigger debe lanzar el siguiente error:
create or replace view vista_3
	as 
	select d.nombre as nombre_dep,l.provincia as nombre_prov,count(e.nroemp) as n_empleados 
	from departamentos d, empleados e, localidades l 
	where d.nrodep=e.nrodep and d.codigop=l.codigop
	group by d.nombre,l.provincia
	;
create or replace trigger trigger_vistas_3
	instead of update 
	on vista_3
	for each row 

	declare 
	code localidades.codigop%type;
		
	begin
	select count(codigop) into code from localidades where lower(provincia)=:new.nombre_prov
		;
	if code=0 then 
	 	raise_application_error(-20003, 'La localidad ' || :new.nombre_prov || ' no existe en la base de datos');	
	end if;
	if :old.n_empleados>=5 then 
		 	 raise_application_error(-20003, 'El departamento ' || :old.nombre_dep || ' tiene ' || :old.n_empleados || ' empleados');
	else 
		update localidades set provincia=:new.nombre_prov where codigop=(select codigop
																		from departamentos
																		where nrodep=(select nrodep
																			from departamentos
																			where lower(nombre)=:old.nombre_dep));
	end if;

	end trigger_vistas_3;
	/
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4. A partir de una vista que muestre los datos de los empleados (nroemp, nombre, apellidos y nombre de oficio)
--ordenados por el nombre del oficio, crear un trigger que permita modificar el oficio del empleado. Si el oficio
--no existe, ha de ser creado.
create  or replace view vista_4
	as 
	select e.nombre,e.apellido1,e.apellido2,o.nombre as oficio,e.nroemp
	from empleados e, oficios o 
	where e.nrooficio=o.nrooficio
	;
create or replace trigger trigger_vistas_4
	instead of update 
	on vista_4
	for each row
	declare 
	job oficios.nrooficio%type; 
	begin 
		select count(nrooficio) into job from oficios where lower(nombre)=lower(:new.oficio);

		if job=0 then 
			insert into oficios values((select max(nrooficio) +1
				from oficios),:new.oficio);
		else 
		update empleados set nrooficio=(select nrooficio
										from oficios 
										where lower(nombre)=lower(:new.oficio)) where nroemp=:old.nroemp;
		end if;
		




	end trigger_vistas_4;
	/
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--5. Crear una vista que muestre el nombre completo (nombre y apellidos en un campo llamado "nombre"), el
--número de departamento ("nrodep") y la comisión ("comision") de aquellos empleados cuya comisión sea
--menor que el 5% de su sueldo (o nula). A partir de ella, construir un trigger que permita modificar la comisión
--de estos empleados. Recuerda que los empleados deben seguir perteneciendo a esta vista. En caso de que la
--comisión sea demasiado alta y el empleado deba dejar de pertenecer a la vista, debe lanzarse el siguiente error:
create or replace view vista_5
	as 
	 select (e.nombre || ' ' || e.apellido1 || ' ' || e.apellido2) as nombre,e.nrodep,nvl(e.comision,0) as comision
	 from empleados e
	 where e.comision<(nvl(e.salario,0)*0.05) or e.comision is null
	;
create or replace trigger trigger_vistas_5
	instead of update
	on vista_5
	for each row
	declare
		salary empleados.salario%type;
	begin 
	select (nvl(salario,0)*0.05) into salary from empleados where concat(concat(concat(concat(nombre, ' '), apellido1), ' '), apellido2) = :new.nombre;
		if :new.comision>salary then 
			raise_application_error(-20003, 'El empleado ' || :old.nombre || ' no puede tener una comision mayor que ' || salary );
		end if;	
	end trigger_vistas_5;
	/