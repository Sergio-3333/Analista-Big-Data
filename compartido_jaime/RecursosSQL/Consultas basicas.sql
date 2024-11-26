-- Ejercicio 1
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta)
	values(122,'ismael','hernandez','moya',1950,120,5,(select e.nrodep
from empleados e 
group by e.nrodep
having count(e.nroemp)=(select min(count(e.nroemp))
from empleados e
group by e.nrodep)
),sysdate);






------------------------------------------------------
select * from empleados;
------------------------------------------------------
-- Ejercicio 2
delete from empleados where nroemp
	(select e.nombre, e.salario
from empleados e
where e.salario>(select 2*avg(e.salario)
from empleados e)
);






------------------------------------------------------
select * from empleados;
------------------------------------------------------
-- Ejercicio 3
insert into empleados ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta)
values(123,'jorge','fernandez', 'quiroga',(select e.salario
from empleados e
where e.comision=(select min(comision) from empleados)),
(select e.comision
from empleados e
where e.comision=(select min(comision) from empleados)),
(select nrooficio
from empleados e
where e.comision=(select min(comision) from empleados)),
(select e.nrodep
from empleados e
where e.comision=(select min(comision)
from empleados)),
(select e.fecha_alta
from empleados e
where e.comision=(select min(comision)
from empleados)));

------------------------------------------------------
select * from empleados;
------------------------------------------------------
-- Ejercicio 4
update empleados set salario=(nvl(comision,0)+ salario),comision=null;

------------------------------------------------------
select * from empleados



insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta)
values(1,'pepe','martin', 'martin',1300,1,70,'10/01/2015');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta,coordinador)
values(2,'juan','sanz', 'ortiz',1800,225,1,70,'01/02/2015',1);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta,coordinador)
values(3,'soraya','martinez', 'navarro',1000,110,1,70,'10/03/2015',1);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta)
values(6,'lourdes','mesa', 'martin',2100,225,2,70,'10/06/2015');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta, coordinador)
values(4,'alicia','martinez', 'nuñez',2300,200,2,70,'10/04/2015',6);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta, coordinador)
values(5,'piedad','martin', 'antunez',2500,2,70,'10/05/2015',6);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta)
values(8,'fausto','merino', 'sanz',3100,303, 3,50,'10/08/2015');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta, coordinador)
values(7,'heli','martin', 'gomez',3000,3,50,'10/07/2015',8);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta, coordinador)
values(9,'daniel','sacristan', 'martin',3200,120,3,50,'10/09/2015',8);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta)
values(10,'eugenia','sacristan','martin',400,4,10,'10/10/2015');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta,coordinador)
values(11,'feli','de maria', 'gonzalez',450,220,4,10,'10/10/2016',10);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta,coordinador)
values(12,'eusebio','sacristan','marin',490,175,4,10,'10/10/2016',10);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta)
values(13,'emilano','arranz', 'moreno',500,5,20,'10/11/2016');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta,coordinador)
values(14,'gerardo','sandeogracias','martin',550,5,20,'10/11/2017',13);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta,coordinador)
values(15,'elena','martin', 'gomez',599,5,20,'10/11/2017',13);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta,coordinador)
values(16,'mercedes','gomez', 'estaire',3100,100,5,20,'10/11/2015',13);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta)
values(17,'marina','bravo', 'gomez',2100,100, 5,20,'10/01/2018');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta, coordinador)
values(18,'pepe','martin', 'martin',530,300,5,20,'10/02/2018',17);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta)
values(23,'mikel','ezquerra', 'sanchez',632,6,60,'10/12/2019');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta, coordinador)
values(19,'andres','aranda', 'martino',600,6,60, '10/05/2018',23);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta,coordinador)
values(20,'pablo','alonso', 'marin',678,6,60,'10/06/2019',23);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta,coordinador)
values(21,'victor','navarro', 'marino',679,6,60,'10/08/2016',23);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta,coordinador)
values(22,'enai','navarro', 'crespo',654,6,60,'10/11/2019',23);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta)
values(24,'victor','navarro', 'prieto',890,5,80,'01/01/2020');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta, coordinador)
values(25,'manuel','merino', 'sanchez',880,5,80,'10/02/2016',24);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta)
values(38,'andrea','aragon', 'diaz',1134,4,40,'01/02/2016');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta)
values(39,'juan','perez', 'martin',1800,125,1,90,'01/12/2016');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta,coordinador)
values(26,'eva','moreno', 'marino',900,265,7,90,'10/03/2017',39);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta, coordinador)
values(27,'beatriz','de maria', 'gonzalez',999,7,90,'10/08/2018',39);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta)
values(28,'cristina','rubio', 'quiroga',1110,7,100,'10/08/2019');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta)
values(29,'noah','aberastegui', 'ezquerra',1990,150,2,110,'18/08/2015');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta, coordinador)
values(30,'iker','san segundo', 'weigner',1750,2,110,'20/08/2020',29);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta,coordinador)
values(31,'izaskum','iglesias', 'martin',1134,175,4,10,'20/08/2021',10);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta)
values(32,'soraya','benavent', 'martin',1600,4,10,'10/03/2015');
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta,coordinador)
values(33,'natalia','herrero', 'rojas',1300,150,4,10,'01/05/2016',32);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta, coordinador)
values(34,'sergio','herrera', 'garcia',1550,4,10,'01/08/2017',32);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta, coordinador)
values(35,'alejandro','ruiz', 'lopez',1800,140,4,40,'10/12/2018',38);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta,coordinador)
values(36,'sonia','pastor', 'gil',1100,4,10,'15/07/2018',32);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta, coordinador)
values(37,'raul','macarroni', 'sierra',1134,4,10,'18/11/2019',32);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta,coordinador)
values(40,'daniel','fernandez', 'galindo',1200,125,4,40,'07/08/2019',38);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,nrooficio,nrodep,fecha_alta,coordinador)
values(41,'sergio','lopez', 'amarillo',1350,7,20,'11/11/2020',17);
insert into empleados  ( nroemp,nombre,apellido1,apellido2,salario,comision,nrooficio,nrodep,fecha_alta,coordinador)
values(42,'enzo','garcia', 'sanchez',1575,150,6,110,'21/09/2021',29);
insert into productos values(9,'NUEVO');
------------------------------------------------------
-- Ejercicio 5

update empleados set salario=(salario-(salario*0.05))
	where nrodep=(select e.nrodep
from empleados e 
group by e.nrodep
having count(e.nroemp)=(select max(count(e.nroemp))
from empleados e
group by e.nrodep)
);

------------------------------------------------------
select * from empleados;
------------------------------------------------------
-- Ejercicio 6
update empleados set nrodep =(select e.nrodep
from empleados e, oficios o 
where lower(o.nombre)=('analista') and e.nrooficio=o.nrooficio 
group by e.nrodep, o.nombre
having count(*)=(select max(count(*))
from empleados e , oficios o
where lower(o.nombre)=('analista') and e.nrooficio=o.nrooficio
group by e.nrodep, o.nombre))
where lower(apellido1)=('fernandez') and lower(apellido2)=('quiroga');

------------------------------------------------------
select * from empleados;
------------------------------------------------------
-- Ejercicio 7
update empleados set salario=(select salario
							from empleados
							where lower(nombre)=('jorge') and lower(apellido1)=('fernandez') and lower(apellido2)=('quiroga')) 
							where nrodep=(select nrodep
											from departamentos 
												where lower(nombre)=('financiero')); 


------------------------------------------------------
select * from empleados;
------------------------------------------------------
-- Ejercicio 8
insert into productos(nroprod,descripcion)
 values((select max(nroprod)+1
 	from productos),'raton');

------------------------------------------------------
select * from productos;
------------------------------------------------------
-- Ejercicio 9
delete from clientes c
		where c.nrocli in(select c.nrocli 
		from clientes c left join pedidos p 
		on c.nrocli=p.nrocli
		where p.nroped is null);
	
--clientes sin pedidos
select c.nrocli 
from clientes c left join pedidos p 
on c.nrocli=p.nrocli
where p.nroped is null;





------------------------------------------------------
select * from clientes;
------------------------------------------------------
-- Ejercicio 10

---Producto menos vendido 
/*select nroprod, count(cantidad)
from linea_pedido
group by nroprod
having count(cantidad)=(select min(count(cantidad))
from linea_pedido
group by nroprod);*/
delete from productos where nroprod=(select nroprod
from linea_pedido
group by nroprod
having count(cantidad)=(select min(count(cantidad))
from linea_pedido
group by nroprod));

/*Este es el error que sale
ERROR at line 1:
ORA-02292: integrity constraint (ADMIN.SYS_C007999) violated - child record
found*/
-- Ejercicio 11
delete from departamentos d 
		where d.nrodep in (select e.nrodep
		from empleados e
		group by e.nrodep 
		having count(e.nroemp) <3);

--departamentos con menos de 3 empleados
select e.nrodep
from empleados e
group by e.nrodep 
having count(e.nroemp) <3;
/*Incompleto*/





------------------------------------------------------
select * from departamentos;
------------------------------------------------------
-- Ejercicio 12
delete from productos where nroprod=(select p.nroprod
from productos p
left join linea_pedido l 
on p.nroprod=l.nroprod
where l.nroprod is null);





------------------------------------------------------
select * from productos;
------------------------------------------------------