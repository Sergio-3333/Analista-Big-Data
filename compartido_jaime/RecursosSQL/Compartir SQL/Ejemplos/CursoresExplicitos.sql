--Ejercicios Cursores Explicitos Jaime Diaz 
--Set serverout put on 	
SET SERVEROUTPUT ON
--1. Desarrollar un programa que visualice el número de empleados junto con su fecha de alta ordenados por fecha.

 --Declaramos nuestro cursor explicito
	declare 
			cursor database is 
			--Seleccionamos los datos que queremos que hayan dentor del cursor
			select fecha_alta as Fecha_alta, count(nroemp) as Num_empleados
			from empleados
			group by fecha_alta
			order by fecha_alta;


	begin 
		--Sacamos los datos, en este caso en formato tabla 
		dbms_output.put_line('F_alta' || '     ' || 'Num_empleados');
		--Con ayuda del for recorremos nuestro puntero y vamos recorriendo los datos
		for i in database loop

			dbms_output.put_line( i.fecha_alta || '      ' || i.Num_empleados);
	END loop;

	

	end ;
/
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--2. Desarrollar un programa que muestre el nombre de los departamentos que tienen exactamente 3 empleados
--ordenados alfabéticamente

--Declaramos el cursor y le introducimos los datos deseados 
	declare
		cursor database2 is 
		select d.nombre as dnombre
		from departamentos d, empleados e
		where d.nrodep=e.nrodep
		group by d.nombre
		having count(e.nroemp)=3
		order by d.nombre;

	begin 
	dbms_output.put_line('Los departamentos son : ');
	--Recorremos el cursor con un for e imprimimos los datos necesarios
	for i in database2 loop

			dbms_output.put_line( i.dnombre);
		END loop;
end ;
/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3. Desarrollar un programa que visualice aquellos departamentos con más coordinadores ordenados
--alfabéticamente
--Declaramos el cursor y le insertamos los datos necesarios
declare
cursor database3 is 
select d.nombre as dname 
from departamentos d,empleados e
where d.nrodep=e.nrodep
group by d.nombre
having count(e.coordinador)=(select max(count (coordinador))
from empleados 
group by nrodep)
order by d.nombre
;
begin 
dbms_output.put_line('Los departamentos con mas coordinadores son : ');
--Recorremos el cursor con un for y sacamos por pantalla los datos que nos pide el enunciado 
for i in database3 loop

		dbms_output.put_line( i.dname);
	END loop;
end ;
/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4. Desarrollar un programa que visualice los pedidos realizados en el año 2019 con un precio total mayor o igual a
--2000 mostrando el número de pedido, la fecha del pedido y el importe de éste ordenado por número de pedidos
--Declaramos el cursor y le insertamos los datos necesarios
	declare
		cursor database4 is 
		select pe.nroped, pe.total_pedido as precio, pe.fecha_pedido 
		from  pedidos pe 
		where  pe.total_pedido>=2000 and to_char(fecha_pedido,'YYYY')=2019
		order by pe.nroped 
	;
	begin
		dbms_output.put_line('Los pedidos realizados en 2019: ');
		--Recorremso el cursor con un for e imprimimos los datos necesarios 
		for i in database4 loop 
			dbms_output.put_line('El pedido '  || i.nroped || ' fue pedido el ' || i.fecha_pedido || ' por un coste total de ' || i.precio );
	end loop;
end ;
/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--5. De la tabla clientes sacar:
-- Cuántos clientes tienen 3 o más pedidos;
-- Qué cliente es el que menos pedidos tiene visualizando su nombre, dirección y crédito limite; si hay más
--de uno se visualizan todos ordenados por el número de cliente.
--Además, de aquellos clientes sin pedidos aumentar su crédito limite un 5 %, siempre que no supere 3000. A
--continuación, sacar el nombre completo y el crédito de todos los clientes, ordenados por orden alfabético del
--apellido.
--Declaramos los cursores
declare
    --Clientes con menos pedidos
    cursor datos is
        select p.nrocli, c.nombre, c.direccion, c.credito  
        from clientes c, pedidos p  
        where c.nrocli=p.nrocli
        group by p.nrocli, c.nombre, c.direccion, c.credito  
        having count(p.nroped)=(select min(count(nroped))
                                from pedidos
                                group by nroped)
        order by p.nrocli
        ;
    --CLientes sin pedidos
    cursor datos1 is 
        select c.nrocli, c.nombre, c.apellido1,c.apellido2, c.credito  
        from clientes c full outer join pedidos p  
        on c.nrocli=p.nrocli
        where c.credito<3000
        group by c.nrocli, c.nombre,c.apellido1,c.apellido2, c.credito  
        having count(p.nroped)=0 
        order by 3,4
        ;
        
    dat datos%rowtype;
    dat1 datos1%rowtype;
    databsebs pedidos.nrocli%type;
begin
        --Declaramos un cursor implicito
        select count(sum(nrocli)) as cli_mas3 into databsebs
            from pedidos p  
            group by p.nrocli
            having count(p.nroped)>=3
            ;
        --Imprimimos por pantalla los datos del cursor implicito 
        dbms_output.put_line('Los clientes con 3 o mas pedidos son '||databsebs);
    --Ahora recorremos el primer cursor con un for
    for i in datos loop
    	--Imprimimos por pantalla los datos 
            dbms_output.put_line('El cliente ' ||i.nrocli || ' de nombre '||i.nombre|| ' tiene credito de '||i.credito
            ||' y vive en calle '||i.direccion );
    end loop;
    
    --Ahora sacamos por pantalla los clientes actualizados(EL CREDITO)
    dbms_output.put_line('Los clientes actualizados son: ');
    for j in datos1 loop
        update clientes set credito=(j.credito*1.05) where (nrocli=j.nrocli);
                dbms_output.put_line('El cliente ' ||j.nrocli || ' de nombre '||j.nombre||' '|| j.apellido1 ||' '|| j.apellido2|| ' con credito de '
                ||j.credito ||' se actualiza a '|| j.credito*1.05);
    end loop;
end;
/





--------------------------------------------------------------------------------------------------------------------------------------------------------------
--6.A partir de la tabla historial de pedidos sacar el valor medio de los productos, indicando aquellos que superan
--1,88 veces esa media. Averiguar el producto de mayor precio, indicando el nombre y la fecha de inserción
--ordenando por número de producto. Realizarlo con un único cursor.
--Declaramos el cursor 
declare
    cursor database10 is
    --Seleccionamos todos los campos 
        select hp.precio, pd.descripcion, hp.fecha_insercion, pd.nroprod, round(avg(h2.precio),2) as precio2
        from historial_precios hp, productos pd, historial_precios h2, productos p2
        where hp.nroprod = pd.nroprod 
            and h2.nroprod = p2.nroprod 
            and hp.precio in (	select max(precio)
                				from historial_precios)
                				and hp.precio > (
                    								select avg(precio)*1.88
                    								from historial_precios)
        group by hp.precio, pd.descripcion, hp.fecha_insercion, pd.nroprod
        order by pd.nroprod;

begin
--Recorremos los datos del cursor con un for
--Esta vez lo haremos por fila y no con la i como normalmente lo hacemos 
    for fila in database10 loop
    --Imprimimos los datos por pantalla
        dbms_output.put_line('El '||fila.descripcion||' insertado el '||fila.fecha_insercion||' es de mayor precio, con un importe de '|| fila.precio);
        dbms_output.put_line('La media de los precios son ' || fila.precio2) ;
        dbms_output.put_line('Los productos con 1.88 mas de la media: Nroprod ' || fila.nroprod || ' con nombre '|| fila.descripcion);
end loop;

end;
/




------------------------------------------------------------------------------------------------------------------------------------------------------------------------