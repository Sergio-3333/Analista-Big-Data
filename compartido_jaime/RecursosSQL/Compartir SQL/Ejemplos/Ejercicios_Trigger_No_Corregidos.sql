--Diaz Fernandez, Jaime
--1. Realizar un trigger que verifique el salario de los empleados que se inserten de forma que sólo nos deje
--insertarlo si está en el rango establecido en la empresa, es decir, si está por debajo del mínimo o por encima del
--máximo de su oficio, se deshace la transacción y se aborta la operación. En el caso de que el salario del
--empleado esté vacío, el trigger no permitiría su inserción. Si el empleado es el primero o el segundo en su
--oficio, debe permitirse su inserción independientemente del valor del salario (siempre y cuando no sea nulo).
--En el caso de que se intente insertar un empleado con un salario fuera del intervalo, se debe lanzar un error con
--un mensaje de acuerdo al siguiente formato:
		--Creamos el trigger antes de insertar en empleados 
create or replace trigger trigger_1
	before insert
	on empleados
	for each row
	declare 
	--Declaramos el cursor y comparamos los salarios del nuevo oficio 
	cursor salariosyoficios is 
			select max(salario) as mayor_salario, min(salario) as menor_salario, count(nrooficio) as cont
			from empleados
			where nrooficio=:new.nrooficio
			;
	begin 
			--Abrimos el cursor y comparamos el rango del salario
			for i in salariosyoficios loop
					if :new.salario>i.mayor_salario or :new.salario<i.menor_salario and i.cont>2  then 
							raise_application_error(-20002, 'Intentando insertar un empleado con un salario no valido : ' || :new.salario || ' no está entre ' || i.menor_salario || ' y ' || i.mayor_salario);
					end if;
					--Caso donde el salario es nulo
					if nvl(:new.salario,0)=0 then
					raise_application_error(-20002, 'Intentando insertar un empleado con un salario nulo' );
					end if;

			end loop;
	end trigger_1;
	/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--2. Crear un trigger llamado para impedir que se aumente el salario de un empleado en más de un 15%. En el caso
--de que se intente subir un salario por encima del 15% se debe lanzar un error con un mensaje de acuerdo al
--siguiente formato:
create or replace trigger trigger_2
	before update of salario
	on empleados 
	for each row

	begin
			if :new.salario>(:old.salario*0.15+:old.salario) and :old.salario is not null then 
			raise_application_error(-20002, 'Se esta intentando subir el salario del empleado  ' || :old.nroemp || ' en ' || (:new.salario-:old.salario) || ' pero su maximo es : ' || (:old.salario*0.15));
			end if;

	end trigger_2;
	/
	
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3. Crear un trigger que verifique que un nuevo cliente no está ya dado de alta (es decir, que no hay otro cliente
--con el mismo nombre completo). Si ya existe, debe lanzar un mensaje de error con el siguiente formato:
	/*	create table auxiliar_3(
		nombre varchar2(20),
		apellido1 varchar2(20),
		apellido2 varchar2(20)
		);

		declare 
		cursor datos is 
		select nombre,apellido1,apellido2 from clientes;
		begin 
		for i in datos loop
		insert into auxiliar_3 values(i.nombre,i.apellido1,i.apellido2);
			end loop;
		end;
		/


create or replace trigger trigger_3
	after insert 
	on clientes
	for each row 
	declare
		cursor datos is 
			select nombre, apellido1, apellido2 from auxiliar_3;
	begin
	for i in datos loop
			if lower(i.nombre)=lower(:new.nombre) and lower(i.apellido1)=lower(:new.apellido1) and lower(i.apellido2)=lower(:new.apellido2) then 
					raise_application_error(-20003, 'El cliente ' || :new.nombre || ' ' || :new.apellido1 || ' ' || :new.apellido2 || ' ya se encuentra en la base de datos ');
			end if;
	end loop;

	end trigger_3;
	/
	*/

	create or replace trigger trigger_3 
		before insert
		on clientes
		for each row
		declare 
		nrodelcliente clientes.nrocli%type;
		begin 
		select count(nrocli) into nrodelcliente
		from clientes 
		where lower(nombre)=lower(:new.nombre) and lower(apellido1)=lower(:new.apellido1) and lower(apellido2)=lower(:new.apellido2);

			if nrodelcliente is null then 
					raise_application_error(-20003, 'El cliente ' || :new.nombre || ' ' || :new.apellido1 || ' ' || :new.apellido2 || ' ya se encuentra en la base de datos ');
			end if;
		end trigger_3;
		/

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4. Crear un trigger que realice un 5% de descuento en el precio de un pedido al insertarlo si el cliente ya ha
--realizado 5 pedidos antes del recién insertado.
/*Clientes con pedidos no hay ninguno con 5*/
/*
select count(nroped), nrocli
from pedidos
group by nrocli
;
*/
create or replace trigger trigger_4 
	before insert
	on pedidos 
	for each row 

	declare 
	contador number(9):=0;

	begin 
	select count(nroped) into contador 
	from pedidos 
	;

	if contador >=5 then 
	insert into pedidos values(:new.nroped,:new.fecha_pedido,:new.fecha_salida,(:new.total_pedido*0.95),:new.nrocli);
		
		end if;
	end trigger_4;
	/