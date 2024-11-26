--1) Visualizar el salario medio, mínimo y máximo del colectivo de trabajadores cuyos trabajos estén asignados al departamento 10
select distinct  max (nvl(salario,0)), min (nvl(salario,0) ,round (avg (salario),2) from empleados
where nrodep = 10;

--2) Visualizar el nombre de los empleados, del oficio, de la provincia de los departamentos donde trabajan empleados de oficio productor
select e.nombre,o.nombre,l.provincia,d.nombre
from empleados e, oficios o, localidades l, departamentos d
where lower (o.nombre) = ('productor') and o.nrooficio= e.nrooficio and l.codigop= d.codigop and d.nrodep=e.nrodep
;
--3) Seleccionar el nombre del empleado, del oficio y el salario de los empleados que trabajan en Cuenca
select e.nombre , o.nombre, l.provincia, salario, d.nombre
from empleados e, oficios o , localidades l,departamentos d
where lower(l.provincia)=('cuenca') and o.nrooficio=e.nrooficio and l.codigop=d.codigop and d.nrodep=e.nrodep
;

--4) Visualizar los nombres de los departamentos y la cantidad de empleados de los departamentos con más de 5 empleados.

select d.nombre,  count (e.nroemp)
from departamentos d, empleados e
where d.nrodep=e.nrodep
group by d.nombre
having count(e.nroemp)>5;
--5) Mostrar el nombre del empleado, salario y nombre del departamento de los empleados que tengan el mismo oficio que Marina Bravo Gómez.

select e.nombre, salario , d.nombre , o.nrooficio, l.provincia
from empleados e , departamentos d, oficios o , localidades l 
where o.nrooficio  in (select nrooficio
from empleados
where lower(nombre)= ('marina') and lower(apellido1)=('bravo') and lower(apellido2)=('gomez')
 and o.nrooficio=e.nrooficio and l.codigop=d.codigop and d.nrodep=e.nrodep
) 
;
--6) Mostrar el nombre del empleado, salario y nombre del departamento de los empleados que tengan el mismo oficio que Mikel Ezquerra Sánchez y que no tengan comisión.

select e.nombre, salario , d.nombre , o.nrooficio, l.provincia, comision
from empleados e , departamentos d, oficios o , localidades l 
where o.nrooficio  in (select nrooficio
from empleados
where lower(nombre)= ('mikel') and lower(apellido1)=('ezquerra') and lower(apellido2)=('sanchez')
)
 and o.nrooficio=e.nrooficio and l.codigop=d.codigop and d.nrodep=e.nrodep and comision= null
;

--7) Averiguar cuantos empleados trabajan en Palencia.
select count(nroemp) as empleado_en_palencia
from empleados
where nrodep=(select nrodep
from departamentos
where codigop=(select codigop
from localidades
where lower(provincia)=('palencia')))
;
--8) Averiguar cuántos empleados tiene el departamento rrhh y a cuánto ascienden sus comisiones

select count(nroemp) as numero_de_empleados , sum( nvl(comision,0)) as suma_de_comision
from empleados e, departamentos d
where lower(d.nombre)=('rrhh') and e.nrodep=d.nrodep
;


--9) Mostrar los nombres los departamentos que tengan más de 3 personas trabajando en la misma profesión.
select d.nombre,  o.nombre as nombre_oficios, count (e.nroemp) as numero_de_empleados
from departamentos d, empleados e, oficios o  
where e.nrodep=d.nrodep and e.nrooficio=o.nrooficio
group by d.nombre, o.nombre
having count(nroemp)>3;

--10) Mostrar el nombre de los oficios y la suma salarial de estos.
select o.nombre as nombre_oficios, sum(e.salario) as suma_del_salario
from oficios o, empleados e 
where e.nrooficio=o.nrooficio
group by o.nombre
;

--11) Visualizar el salario medio de cada departamento junto con el número y el nombre del departamento.
select d.nombre as nombre_del_departamento, d.nrodep as numero_departamento, avg ( nvl(e.salario,0)) as media_de_salario
from departamentos d, empleados e 
where d.nrodep=e.nrodep
group by d.nombre, d.nrodep
;

--12) Averiguar cuántas comisiones diferentes hay y su valor medio
select  count( distinct e.comision) as numero_de_comisones, avg( distinct e.comision) as media_de_comisiones
from empleados e;
.
--13) Para los departamentos en los que hay algún empleado cuyo salario sea menor que 1000 euros al mes hallar el número de empleados y la suma de sus salarios, comisiones.
select count(nroemp) as numero_de_empleados, sum( nvl (salario,0)) as suma_del_salario , sum( nvl(comision,0))
from empleados e , departamentos d
where salario<(1000) and e.nrodep=d.nrodep
group by e.nrodep
;

--14) Mostrar el código y las provincias donde existen departamentos.
select l.codigop, l.provincia as nombre_provincias
from localidades l, departamentos d
where d.codigop=l.codigop
group by l.codigop, l.provincia
having count(nrodep)>0
;

--15) Mostrar el código y el nombre de las provincias donde está el departamento con menor código de departamento.
select l.codigop, l.provincia
from localidades l, departamentos d 
where l.codigop in d.codigop 
and d.nrodep = (
	select min(nrodep) 
	from departamentos
)
order by l.codigop;


--16) Mostrar el menor código de departamento para cada provincia.
select l.provincia, d.nrodep, 
from localidades l, departamentos d 
where d.nrodep = (
	select min(nrodep) 
	from departamentos
)
order by l.codigop; 


-- 17) Obtener el código y nombre de provincia donde tenemos dos o más departamentos.
select l.codigop, l.provincia as nombre_provincias
from localidades l, departamentos d 
where d.codigop=l.codigop
group by l.codigop, l.provincia
having count(nrodep)>=2
;
