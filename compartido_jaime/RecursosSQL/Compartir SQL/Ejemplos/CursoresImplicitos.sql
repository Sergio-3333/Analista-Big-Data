set serveroutput on 
-- 1
declare 

	nroempleado empleados.nroemp%type;
	nombre empleados.nombre%type;
	apell1 empleados.apellido1%type;
	apell2 empleados.apellido2%type;
	nrodepartamento empleados.nrodep%type;
	nrodeoficio empleados.nrooficio%type;
	salario empleados.salario%type;
	comision empleados.comision%type;


begin

	
	select e.nroemp,e.nombre,e.apellido1,e.apellido2,e.nrodep,e.nrooficio,e.salario,e.comision  into nroempleado,nombre,apell1,apell2,nrodepartamento,nrodeoficio,salario,comision
	from empleados e 
	inner join oficios o
	on e.nrooficio=o.nrooficio
	where lower(o.nombre)='publicista' and lower(e.nombre) like '%d%'; 

	dbms_output.put_line('Los datos de empleado '||nroempleado|| ' son: '||nombre||' '||apell1||' '||apell2||' que trabaja en el deparamento '||nrodepartamento||' como '||nrodeoficio||' y cobra '||salario||' con comision de '||comision);
end;
/

-- 2

declare 
	empleadoMasNuevo empleados%rowtype;
begin 
	select * into empleadoMasNuevo
 	from empleados 
	where fecha_alta=( select max(fecha_alta)
						from empleados);

	dbms_output.put_line('Los datos de empleado '|| empleadoMasNuevo.nroemp || ' son: '||empleadoMasNuevo.nombre||' '||empleadoMasNuevo.apellido1 ||' '||empleadoMasNuevo.apellido1||' que trabaja en el deparamento '||empleadoMasNuevo.nrodep||' como '||empleadoMasNuevo.nrooficio||' y cobra '||empleadoMasNuevo.salario ||' con comision de '||empleadoMasNuevo.comision);

end;
/

-- 3

declare
	dnombre departamentos.nombre%type;

begin
	select d.nombre into dnombre
	from departamentos d
	inner join empleados e 
	on d.nrodep=e.nrodep 
	group by d.nombre
	having count(e.nroemp)=(select max(count(nroemp))
							from empleados
							group by nombre);

	dbms_output.put_line('El departamento con mas empleados es '||dnombre);

end;
/

-- 4

declare 
	clienteMasPedidos clientes%rowtype;
begin 
	select c.nrocli,nombre,apellido1,apellido2,direccion,provincia,tf,credito into clienteMasPedidos
	from clientes c
	inner join pedidos p 
	on c.nrocli=p.nrocli
	where p.nroped=(select max(count(p.nroped))
					from pedidos p
					group by p.nrocli);
	dbms_output.put_line('Los datos de cliente '||clienteMasPedidos.nrocli||' son:  '||clienteMasPedidos.nombre ||' '||clienteMasPedidos.apellido1 || clienteMasPedidos.apellido2||' con dirección '||clienteMasPedidos.direccion||'('||clienteMasPedidos.provincia||')'||', teléfono '||clienteMasPedidos.tf ||' y	crédito '|| clienteMasPedidos.credito);

end;
/
-- 5

declare 
	menosVendidos productos%rowtype;
	
begin

	select prod.nroprod,prod.descripcion into menosVendidos
	from productos prod
	inner join linea_pedido l 
	on prod.nroprod=l.nroprod
	group by prod.descripcion,prod.nroprod
	having count(l.nroped)=(select min(count(nroped))
								from linea_pedido 
								group by nroprod);

	dbms_output.put_line('El producto '|| menosVendidos.nroprod ||' con nombre: ' || menosVendidos.descripcion);
end;
/


-- 6

declare
	masVendido productos.descripcion%type;

begin

	select prod.descripcion  into masVendido
	from productos prod
	inner join linea_pedido l 
	on prod.nroprod=l.nroprod
	group by prod.descripcion
	having sum(l.cantidad)=(select max(sum(cantidad))
								from linea_pedido
								group by nroprod);

	dbms_output.put_line('El producto más vendido es: '||masVendido);
end;
/


