--1. Realizar un trigger llamado que permita introducir en una tabla, llamada auditoria, las operaciones de inserción,
--borrado y modificación de los datos que se realicen en la tabla empleados, guardando la fecha en que se
--produjo el evento, el número y nombre del empleado y la operación que se ha realizado. En el caso de
--modificación, como solo se va a modificar el sueldo, guardar también el sueldo antiguo y el sueldo nuevo.
--La tabla auditoria consta de los campos:
--id: campo numérico de longitud 7. Clave primaria
--num_empleado: campo numérico de longitud 7
--fecha: campo fecha
--nombre_emp: campo alfanumérico de longitud 15
--sueldo_ant: campo numérico de longitud 6 con dos decimales
--sueldo_nuevo: campo numérico de longitud 6 con dos decimales
--operación: campo alfanumérico de longitud 13. Sólo puede tener los valores ‘borrado’, ‘insercion’ y
--‘actualizacion’
--Creamos la tabla "auditoria"------------------------------------------------------------------------------------------------
create table auditoria(
	id number(7) default 0,
	num_empleado number(7),
	fecha date,
	nombre_emp varchar2(15),
	sueldo_ant number(6,2),
	sueldo_nuevo number(6,2),
	operacion varchar2(13)
);
alter table auditoria add constraint operacion check (lower(operacion) in ('borrado', 'insercion', 'actualizacion'));
alter table auditoria add constraint pk_id primary key(id);
---------------------------------------------------------------------------------------------------------------------------------
--Creamos el trigger con las 3 opciones insercion, actualizacion o borrado
create or replace trigger trigger_5
	before insert or update or delete
	on empleados
	for each row 
	begin 
		if inserting then 
			insert into auditoria(id, num_empleado,fecha,nombre_emp,sueldo_nuevo,operacion)
			values((select nvl(max(id),0)+1 from auditoria),:new.nroemp,sysdate,:new.nombre,:new.salario,'insercion');
			elsif updating then
		 	insert into auditoria values((select nvl(max(id),0)+1 from auditoria),:new.nroemp,sysdate,:new.nombre,:old.salario,:new.salario,'actualizacion');
		else
			insert into auditoria values((select nvl(max(id),0)+1 from auditoria),:new.nroemp,sysdate,:new.nombre,:old.salario,:new.salario,'borrado');
		end if;
				
	end trigger_5;
	/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--2. Crear un trigger llamado para impedir que, al insertar un empleado, la suma de los salarios de los empleados
--pertenecientes al departamento del empleado insertado supere los 7500 euros. En caso de superarse, el trigger
--debe lanzar un mensaje de error con el siguiente formato
--Creamos el trigger y declaramos un cursor implicito que saque los nombres de los departamentos y la suma de sus salarios
create or replace trigger trigger_6
	before insert
	on empleados
	for each row
	declare
	cursor salarios_y_departamentos is
		select sum(e.salario) as salarios, d.nombre as name
		from empleados e, departamentos d 
		where e.nrodep=:new.nrodep and d.nrodep=e.nrodep
		group by d.nombre
		;

	begin
	for i in salarios_y_departamentos loop
	--Si el nuevo salario a introducir es mayor que (anterior + nuevo ) que 7500 hacemos que nos salte la excepcion
			if :new.salario+i.salarios>7500 then 
			raise_application_error(-20003, 'El salario actual del departamento' || i.name || ' es ' || i.salarios || ' con el nuevo empleado ascenderia a ' || (i.salarios+:new.salario));
			end if; 
		end loop;
	end trigger_6;
	/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3. Crear un trigger llamado que cuando se ingresa un registro en linea_pedido, se debe controlar que el código del
--artículo exista en productos. En caso contrario, el trigger debe lanzar un mensaje de error con el siguiente
--formato:
--Creamos el trigger
create or replace trigger trigger_7
	before insert 
	on linea_pedido
	for each row
	declare
		numerodelproducto productos.nroprod%type;
	begin
	--Declaramos un cursor implicito y comprobamos si el producto existe
		select count(nroprod) into numerodelproducto
		from linea_pedido
		where nroprod=:new.nroprod
		;
		--Comprobamos si la varible es igual a 0, y si es asi sacamos la excepcion
	if numerodelproducto=0 then 
		raise_application_error(-20004,'El producto ' || :new.nroprod || ' no existe ');
	end if;
	end trigger_7;
	/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4. Crear un trigger que se ejecute al insertar o modificar el precio de un producto. Se activa solamente si el precio
--que se ingresa es inferior a 100, en caso de serlo, se ingresa en "ofertas" el código, la fecha del precio y la
--descripción del producto.
--La tabla ofertas consta de los campos:
--nroprod: campo numérico de longitud 7
--fecha_salida: campo fecha
--descripcion: campo alfanumérico de longitud 20
--Creaccion tabla ofertas----------------
create table ofertas(
	nroprod number(7),
	fecha_salida date,
	descripcion varchar2(20)
);
-----------------------------------------
--Creamos el trigger, como condicion debemos de poner si el precio es menor que 100
create or replace trigger trigger_8
	before insert or update
	on historial_precios
	for each row 
	when (new.precio<100)
	declare
		nombres productos.descripcion%type;
	begin 
	--Seleccionamos la descripcion de los productos y las introducimos en la variable "nombres"
		select descripcion into nombres 
		from productos 
		where nroprod=:new.nroprod;
		--Insertamos en la tabla ofertas
	insert into ofertas values (:new.nroprod,sysdate,nombres);
	end trigger_8;
	/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------



