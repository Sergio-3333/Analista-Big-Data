delete empleados;
delete departamentos;
delete oficios;
delete localidades;
insert into oficios values(1,'analista');
insert into oficios values(2,'programador');
insert into oficios values(3,'publicista');
insert into oficios values(4,'vendedor');
insert into oficios values(5,'contable');
insert into oficios values(6,'productor');
insert into oficios values(7,'administrativo');

--delete localidades;
insert into localidades values(1,'Caceres');
insert into localidades values(2,'Huelva');
insert into localidades values(3,'Bilbao');
insert into localidades values(4,'Vigo');
insert into localidades values(5,'Palencia');
insert into localidades values(6,'Teruel');
insert into localidades values(7,'Cuenca');
insert into localidades values(8,'Lisboa');

--delete departamentos;
insert into departamentos values(10,'almacen', 8);
insert into departamentos values(20,'rrhh', 7);
insert into departamentos values(30,'informatica',8);
insert into departamentos values(40,'publicidad', 2);
insert into departamentos values(50,'produccion',3);
insert into departamentos values(60,'ventas',5);
insert into departamentos values(70,'I+D',3);
insert into departamentos values(80,'financiero',8);
insert into departamentos values(90,'logistica',7);
insert into departamentos values(100,'contabilidad',6);
insert into departamentos values(110,'marketing',4);

--delete empleados;
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


delete linea_pedido;
delete pedidos;
delete clientes;
delete historial_precios;
delete productos;
insert into clientes values(1,'sara','martin','martin','calle olivar 5','madrid',918118888,5000);
insert into clientes values(2,'raquel','martinez','martin','calle juan bravo 3','madrid',916188888,4500);
insert into clientes values(3,'maria','ruiz','soller','calle solana 9','madrid',916468888,2800);
insert into clientes values(4,'fernando','fraile','perez','calle tres casas 4','segovia',921433030,6700);
insert into clientes values(5,'jose antonio','miller','antunez','calle via roma 7','segovia',921523434,1345);
insert into clientes values(6,'rafael','sanchez','sanchez','calle tabanera del monte 4','segovia',921520170,4500);
insert into clientes values(7,'lorena','vazquez','osorio','calle ingeniero martin gil 5','guipuzcoa',943777777,3000);
insert into clientes values(8,'esther','alvarez','Martin','calle gran via 3','guipuzcoa',943777721,3456);
insert into clientes values(9,'sonia','martin','vazquez','calle san sebastian 2','guipuzcoa',943772324,2000);
insert into clientes values(10,'caty','garcia','garcia','calle alcazar 2','toledo',925202323,1234);
insert into clientes values(11,'manuel','sanz','de juan','calle real ','toledo',925434321,2345);
insert into clientes values(12,'sara','aranguren','martin','calle arroyo 3','toledo',925233445,3456);
insert into clientes values(13,'patricia','moreno','martin','calle andujar 5','soria',975232323,4567);
insert into clientes values(14,'conchi','martin','sanz','calle alcala 5','soria',975232321,5678);
insert into clientes values(15,'carmen','gil','mateo','calle madrid 5','soria',975232320,6789);
insert into clientes values(16,'ainhoa','villa','molero','calle sanchidrian 1','avila',920323234,7890);
insert into clientes values(17,'angel','anton','mayoral','calle padilla 7','avila',920323234,1111);
insert into clientes values(18,'jose','bermudez','sacristan','calle pradillo 2','avila',920323234,1232);
insert into clientes values(19,'juan carlos','sanz','sacristan','calle rio pisuerga 2','valladolid',983343435,1000);
insert into clientes values(20,'cesar','iglesias','siguenza','calle portillo','valladolid',983343536,1267);
insert into clientes values(21,'luis','martin','perez','calle reyes cat�licos','valladolid',983353434,5000);

--delete productos;
insert into productos values(1,'tarjeta grafica');
insert into productos values(2,'switch');
insert into productos values(3,'teclado');
insert into productos values(4,'memoria');
insert into productos values(5,'portatil');
insert into productos values(6,'router');
insert into productos values(7,'sobremesa');
insert into productos values(8,'monitor');

--delete pedidos;
insert into pedidos values(1,'01/01/18', '01/01/18', 1350,1);
insert into pedidos values(2,'02/02/18', '02/02/18', 3000,1);
insert into pedidos values(3,'03/03/18', '03/03/18', 1226,1);
insert into pedidos values(4,'01/04/18', '01/04/18', 2200,2);
insert into pedidos values(5,'01/05/18', '01/05/18', 1560,2);
insert into pedidos values(6,'01/05/18', '01/05/18', 3200,3);
insert into pedidos values(7,'01/06/18', '01/06/18', 1900,3);
insert into pedidos values(8,'10/06/18', '11/06/18', 3239,3);
insert into pedidos values(9,'01/07/18', '01/07/18', 80,3);
insert into pedidos values(10,'01/08/18', '01/08/18', 700,4);
insert into pedidos values(11,'01/09/18', '01/09/18', 180,4);
insert into pedidos values(12,'01/10/18', '01/10/18', 600,5);
insert into pedidos values(13,'01/11/18', '01/11/18', 120,16);
insert into pedidos values(14,'01/12/18', '01/12/18', 1020,7);
insert into pedidos values(15,'11/12/18', '11/12/18', 1360,7);
insert into pedidos values(16,'01/01/19', '01/01/19', 4350,8);
insert into pedidos values(17,'01/02/19', '01/02/19', 1105,8);
insert into pedidos values(18,'01/05/19', '01/05/19', 1950,8);
insert into pedidos values(19,'01/06/19', '01/06/19', 3160,18);
insert into pedidos values(20,'01/08/19', '01/08/19', 640,18);
insert into pedidos values(21,'01/11/19', '01/11/19', 1800,15);
insert into pedidos values(22,'01/12/19', '01/12/19', 2500,15);
insert into pedidos values(23,'01/01/20', '01/01/20', 3210,11);
insert into pedidos values(24,'01/04/20', '01/04/20', 2500,11);
insert into pedidos values(25,'01/05/20', '01/05/20', 750,10);
insert into pedidos values(26,'01/07/20', '01/07/20', 2500,10);
insert into pedidos values(27,'01/08/20', '01/08/20', 4185,11);
insert into pedidos values(28,'01/09/20', '01/09/20', 1900,20);
insert into pedidos values(29,'01/10/20', '01/10/20', 3785,21);
insert into pedidos values(30,'05/10/21', '05/10/21', 6430,21);

--delete historial_precios;
insert into historial_precios values(1,'01/01/18',400);
insert into historial_precios values(2,'01/01/18',250);
insert into historial_precios values(3,'01/01/18',80);
insert into historial_precios values(4,'01/01/18',100);
insert into historial_precios values(5,'01/01/18',900);
insert into historial_precios values(6,'01/01/18',213);
insert into historial_precios values(7,'01/01/18',700);
insert into historial_precios values(8,'01/01/18',300);
insert into historial_precios values(7,'01/10/18',800);
insert into historial_precios values(4,'01/11/18',120);
insert into historial_precios values(8,'07/11/18',400);
insert into historial_precios values(6,'01/12/18',310);
insert into historial_precios values(1,'01/01/19',450);
insert into historial_precios values(3,'01/01/19',90);
insert into historial_precios values(5,'01/01/19',1105);
insert into historial_precios values(6,'01/01/19',400);
insert into historial_precios values(7,'01/01/19',900);
insert into historial_precios values(8,'01/01/19',500);
insert into historial_precios values(8,'01/11/19',600);
insert into historial_precios values(4,'01/12/19',125);
insert into historial_precios values(1,'01/01/20',500);
insert into historial_precios values(2,'01/01/20',300);
insert into historial_precios values(3,'01/01/20',100);
insert into historial_precios values(8,'01/01/20',700);
insert into historial_precios values(5,'01/02/20',1255);
insert into historial_precios values(4,'01/11/20',170);
insert into historial_precios values(6,'01/11/20',410);
insert into historial_precios values(4,'01/06/21',200);
insert into historial_precios values(5,'01/08/21',1500);
insert into historial_precios values(8,'01/10/21',800);

--delete linea_pedido;
insert into linea_pedido values( 1,1,1,2,400,800);
insert into linea_pedido values( 1,2,2,1,250,250);
insert into linea_pedido values( 1,3,4,3,100,300);
insert into linea_pedido values( 2,1,1,3,400,1200);
insert into linea_pedido values( 2,2,5,2,900,1800);
insert into linea_pedido values( 3,1,6,2,213,426);
insert into linea_pedido values( 3,2,1,2,400,800);
insert into linea_pedido values( 4,1,1,4,400,1600);
insert into linea_pedido values( 4,2,8,2,300,600);
insert into linea_pedido values( 5,1,7,2,700,1400);
insert into linea_pedido values( 5,2,3,2,80,160);
insert into linea_pedido values( 6,1,5,2,900,1800);
insert into linea_pedido values( 6,2,7,2,700,1400);
insert into linea_pedido values( 7,1,8,2,300,600);
insert into linea_pedido values( 7,2,1,2,400,800);
insert into linea_pedido values( 7,3,2,2,250,500);
insert into linea_pedido values( 8,1,1,2,400,800);
insert into linea_pedido values( 8,2,6,3,213,639);
insert into linea_pedido values( 8,3,5,2,900,1800);
insert into linea_pedido values( 9,1,3,1,80,80);
insert into linea_pedido values( 10,1,7,1,700,700);
insert into linea_pedido values( 11,1,4,1,100,100);
insert into linea_pedido values( 11,2,3,1,80,80);
insert into linea_pedido values( 12,1,4,6,100,600);
insert into linea_pedido values( 13,1,3,4,80,120);
insert into linea_pedido values( 14,1,1,1,400,400);
insert into linea_pedido values( 14,2,6,2,310,620);
insert into linea_pedido values( 15,1,8,3,400,1200);
insert into linea_pedido values( 15,2,3,2,80,160);
insert into linea_pedido values( 16,1,2,3,250,750);
insert into linea_pedido values( 16,2,7,4,900,3600);
insert into linea_pedido values( 17,1,5,1,1105,1105);
insert into linea_pedido values( 18,1,8,3,500,1500);
insert into linea_pedido values( 18,2,3,5,90,450);
insert into linea_pedido values( 19,1,3,4,90,360);
insert into linea_pedido values( 19,2,2,4,250,1000);
insert into linea_pedido values( 19,3,1,5,450,1800);
insert into linea_pedido values( 20,1,4,2,120,240);
insert into linea_pedido values( 20,2,6,1,400,400);
insert into linea_pedido values( 21,1,8,3,600,1800);
insert into linea_pedido values( 22,1,6,4,400,1600);
insert into linea_pedido values( 22,2,3,3,300,900);
insert into linea_pedido values( 23,1,2,3,300,900);
insert into linea_pedido values( 23,2,5,2,1105,2210);
insert into linea_pedido values( 23,3,3,1,100,100);
insert into linea_pedido values( 24,1,2,2,300,600);
insert into linea_pedido values( 24,2,1,3,500,1500);
insert into linea_pedido values( 24,3,6,1,400,400);
insert into linea_pedido values( 25,1,4,6,125,750);
insert into linea_pedido values( 26,1,7,2,900,1800);
insert into linea_pedido values( 26,2,8,1,700,700);
insert into linea_pedido values( 27,1,3,4,100,400);
insert into linea_pedido values( 27,2,5,3,1255,3785);
insert into linea_pedido values( 28,1,6,4,400,1600);
insert into linea_pedido values( 28,2,3,3,100,300);
insert into linea_pedido values( 29,1,4,5,125,575);
insert into linea_pedido values( 29,2,5,2,1255,2510);
insert into linea_pedido values( 29,3,8,1,700,700);
insert into linea_pedido values( 30,1,8,2,800,1600);
insert into linea_pedido values( 30,2,6,3,410,1230);
insert into linea_pedido values( 30,3,4,3,200,600);
insert into linea_pedido values( 30,4,5,2,1500,3000);