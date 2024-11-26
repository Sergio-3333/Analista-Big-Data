-- Ejercicio 1 
select nombre from empleados order by 1;

--Ejercicio 2
select nrodep, nombre from departamentos 
where nrodep = 50;

--Ejercicio 3
select distinct salario from empleados 
	order by 1;

--Ejercicio 4
select nroemp, nombre, salario from empleados 
where salario > 1875;

--Ejercicio 5
select comision, nombre, salario from empleados 
	order by comision, nombre;

--Ejercicio 6
select nombre, salario, comision from empleados 
where comision is null 
	order by 2,1;

--Ejercicio 7
select nombre, (salario + comision) as salario_total from empleados 
where nrodep = 70;

--Ejercicio 8
select nombre, nrodep from empleados 
where comision is null;

--Ejercicio 9
select nombre,salario,(salario*0.05) as cuantia from empleados 
where lower(nombre)='juan';

--Ejercicio 10
select nombre from empleados 
where lower(nombre) between 'a%' and 'l%' 
	order by 1;

--Ejercicio 11
select nombre,nroemp from empleados where nrodep =20;

--Ejercicio 12
select nroemp, nombre, nrooficio from empleados 
where nrooficio = (select nrooficio from oficios where lower(nombre) = 'contable') order by 1;

--Ejercicio 13
select nroemp, nombre,nrooficio from empleados 
where nrodep=110 and nrooficio=(select nrooficio from oficios where lower(nombre)='programador') order by 2;

--Ejercicio 14
select nombre, apellido1, apellido2 from empleados 
where lower(apellido1) like 'a%' or lower(apellido2) like 'a%';

--Ejercicio 15
select nombre, apellido1, apellido2 from empleados 
where lower(apellido1) like '%d%' or lower(apellido2) like '%d%';

--Ejercicio 16
select nombre from empleados 
where lower(nombre) like 's%' or lower(nombre) like 'd%' or lower(nombre) like 'l%' 
and nrodep in (select nrodep from departamentos where codigop = (select codigop from localidades where lower(provincia) = 'bilbao'));

--Ejercicio 17
 select nombre, nroemp,nrodep from empleados 
 where nrodep=(select nrodep from departamentos where lower(nombre)='rrhh');
 
 --Ejercicio 18
select nombre,nrooficio from oficios 
where nrooficio in(select nrooficio from empleados 
where nrodep in(select nrodep from departamentos where lower(nombre) not in ('ventas','marketing')))order by 1, 2;

--Ejercicio 19
select nombre from departamentos where nrodep not in(select nrodep from empleados);

--Ejercicio 20
select nombre, nrodep from departamentos where nrodep in(select nrodep from empleados where coordinador is not null);

--Ejercicio 21
select nombre,salario,(salario/3) as tercio, comision  from empleados 
where comision < (salario/3);

--Ejercicio 22
select nombre from departamentos where nrodep in(select nrodep from empleados where nrooficio in(select nrooficio from oficios where lower(nombre)='administrativo'));


--Ejercicio 23
select nombre, apellido1, apellido2 from empleados where lower(nombre) like '%ni%' and nrodep=10;

--Ejercicio 24
select nombre from departamentos where nrodep in (select nrodep from empleados where comision is null);

--Ejercicio 25
select nombre from empleados 
	where nrodep in(select nrodep from departamentos 
	where codigop in(select codigop from localidades where lower(provincia)='teruel' or lower(provincia)='vigo'));