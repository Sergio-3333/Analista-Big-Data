--Crear un procedimiento llamado CREAR_DEPARTAMENTO que permita insertar nuevos
--departamentos según las siguientes especificaciones: se pasará al procedimiento el nombre del
--departamento y el nombre de la localidad. El procedimiento insertará la fila nueva asignando como
--número de departamento la decena siguiente al número mayor de la tabla. Se verificará que no existe un
--departamento con ese nombre en esa localidad. Si la localidad no está en la tabla se insertará con el
--código siguiente al mayor código presente en la tabla. Indicación: se pueden utilizar dos cursores
SET SERVEROUTPUT on
create or replace PROCEDURE CREAR_DEPARTAMENTO
(nom_dep departamentos.nombre%type, nom_local localidades.provincia%type)
as 
-- creamos un cursor para guardar los datos de los departamentos
	cursor datosD is 
	select * 
	from departamentos
	order by nrodep;
-- creamos un cursor para guardar la informacion de la localidades
	cursor datosL is 
	select * 
	from localidades 
	order by codigop;
--creamos las variables
	existeL boolean := false;
	existe boolean := false;
	dataL datosL%rowtype;
	dataD datosD%rowtype;
	maxDep departamentos.nrodep%type;
	maxLoc localidades.codigop%type;

--Creamos las excepciones
	dep_existe exception;
	begin 
--abrimos el cursor
		open datosD;
		fetch datosD into dataD;
-- recorremos el cursor con un while ya que si el departamento existe dejara de recorrerlo para mas tarde saltar una excepcion	
		WHILE( datosD%found and existe = false)loop
-- ya que esta ordenado por nro de departamento el ultimo en introducirse sera el mayor
			maxDep := dataD.nrodep;
			if(lower(nom_dep) = lower(dataD.nombre)) then
				existe := true;
			end if;
			fetch datosD into dataD;
		end loop;
		close datosD;
-- si el departamento existe lanzamos una excepcion ya que no se podra insertar
		if (existe = true) then
			raise dep_existe;
		end if;
-- ya que si no salta la excepcion el departamento no existe sumamos 10 al maximo numero de departamento		
		maxDep := maxDep + 10;
		open datosL;
		fetch datosL into dataL;
-- recorremos el cursor con un while ya que si existe la localidad parara de recorrerlo
		WHILE(datosL%found and existeL = false)loop
-- ya que esta ordenado por codigo de localidad el ultimo que se introduzca sera mayor
			maxLoc := dataL.codigop;
			if(lower(nom_local) = lower(dataL.provincia)) then
				existeL := true;
			end if;
			fetch datosL into dataL;
		end loop;
		close datosL;
		-- si la localidad no existe sumamos 1 al codigo de localidad para insertarla
		if (existeL = false) then 
			maxLoc := maxLoc + 1;
		-- una vez sumado 1 al codigo insertamos la nueva localidad
			insert into localidades (codigop, provincia) values (maxLoc, nom_local);
		end if;
		-- una vez comprobado que existe la nueva localidad insertamos el nuevo departamento
		insert into departamentos (nrodep, nombre, codigop) values (maxDep, nom_dep, maxLoc);
exception
	when dep_existe then
				RAISE_APPLICATION_ERROR(-20001, 'Error el departamento ya existe');
	when OTHERS then
	dbms_output.put_line('ERROR ' || SQLERRM);
		if(datosD%isopen) then 
			close datosD;
		end if;
		if(datosL%isopen) then 
			close datosD;
		end if;
	end CREAR_DEPARTAMENTO;
	/
