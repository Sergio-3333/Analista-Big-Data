drop table linea_pedido;
drop table historial_precios;
drop table pedidos;
drop table productos;
drop table clientes;
drop table empleados;
drop table departamentos;
drop table localidades;
drop table oficios;

create table oficios (
nrooficio number(7) primary key,
nombre varchar2(15) not null);

create table localidades (
codigop number(8) primary key,
provincia varchar2(20));

create table departamentos (
nrodep number(7) primary key,
nombre varchar2(15) not null,
codigop number(8)references localidades);

create table empleados (
nroemp number(7) primary key,
nombre varchar2(15) not null,
apellido1 varchar2(15) not null,
apellido2 varchar2(15) not null,
salario number(6,2),
comision number(6,2),
nrooficio number(7) references oficios,
nrodep number(7) references departamentos,
fecha_alta date,
coordinador number(7) references empleados(nroemp));

create table clientes (
nrocli number(7) primary key,
nombre varchar2(15) not null,
apellido1 varchar2(15) not null,
apellido2 varchar2(15) not null,
direccion varchar2(50),
provincia varchar2(20),
tf number(9), 
credito number(6,2));

create table productos (
nroprod number (7) primary key,
descripcion varchar2(20));

create table pedidos (
nroped number(7) primary key,
fecha_pedido date,
fecha_salida date,
total_pedido number(11,2),
nrocli number(7)references clientes);

create table historial_precios (
nroprod number(7)references productos,
fecha_insercion date,
precio number(7,2),
constraint pk_precios primary key (nroprod,fecha_insercion));

create table linea_pedido (
nroped number(7)references pedidos,
nro_linea number(3),
nroprod number(7)references productos,
cantidad number(3),
precio number(7,2),
total_linea number(9,2),
constraint pk_linea primary key(nroped,nro_linea));