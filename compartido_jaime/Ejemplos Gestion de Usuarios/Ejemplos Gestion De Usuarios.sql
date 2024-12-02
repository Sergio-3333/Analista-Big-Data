--1. Cree un usuario "urano", con contraseña "urano" y 100M de espacio en "system".
create user urano identified by urano quota 100m on system;
--2. Cree un usuario "neptuno", con contraseña "neptuno" y espacio en "system".
create user neptuno identified by neptuno quota unlimited on system;
--3. Crear el usuario "nombre+el número de letras de tu nombre" y con 
--contraseña "nombre+el número de letras de
--tu nombre" y espacio en "system".
create user jaime5 identified by jaime5 quota unlimited on system;
--4. Consulte el diccionario "dba_users" y analice la información que nos muestra
--Deben aparecer los tres usuarios creados anteriormente.
select * from dba_users;
--5. Consulte el diccionario "dba_sys_privs"
-- para encontrar los privilegios concedidos a nuestros tres usuarios.
select * from dba_sys_privs;
--6. Conceda a "urano" permiso para conectarse.
grant create session to urano;
--7. Conceda a "neptuno" permiso para conectarse.
grant create session to neptuno;
--8. Consulte el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a nuestros 3 usuarios.
select  * from dba_sys_privs where lower(grantee)='urano';
select  * from dba_sys_privs where lower(grantee)='neptuno';
select  * from dba_sys_privs where lower(grantee)='jaime5';
--9. Abra una nueva conexión para "urano". Se debe abrir una nueva solapa (nueva conexión) con el nombre del
--usuario (urano).
conn urano
--10. En la conexión de "urano" consulte sus privilegios.
select * from user_sys_privs;
--11. Obtenga el nombre del usuario conectado.
select user from dual;
--12. Vuelva a la conexión "system" (la otra solapa) y compruebe el usuario actual.
conn as sysdba
select user from dual;
--13. Intente abrir una nueva conexión para el usuario inexistente.
conn inexitente
--14. Intente abrir una nueva conexión para el usuario "neptuno" colocando una contraseña incorrecta.
conn neptuno
Enter password:
ERROR:
ORA-01017: invalid username/password; logon denied
--15. Abra una nueva conexión para "neptuno" colocando los datos correctos. Se debe abrir una nueva solapa (nueva
--conexión) con el nombre del usuario (neptuno).
conn neptuno
Enter password:
Connected.

--16. Intentemos abrir una nueva conexión para el usuario "nombre+el número de letras de tu nombre ".
conn jaime5
Enter password:
ERROR:
ORA-01045: user JAIME5 lacks CREATE SESSION privilege; logon denied

--17. Conceda a "nombre+el número de letras de tu nombre permiso de conexión.
grant create session to jaime5;
--18. Consulte el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a "nombre+el número de letras
--de tu nombre".
select  * from dba_sys_privs where lower(grantee)='jaime5';
--19. Abra una nueva conexión para "nombre+el número de letras de tu nombre". Se debe abrir una nueva conexión
--con el nombre del usuario.
 conn jaime5
Enter password:
Connected.
--20. Consulte el diccionario "user_sys_privs".
 select * from user_sys_privs;
--21. Compruebe que está en la sesión de "nombre+el número de letras de tu nombre".

USERNAME                       PRIVILEGE                                ADM
------------------------------ ---------------------------------------- ---
JAIME5                         CREATE SESSION                           NO
--22. Para realizar los siguientes apartados, crear primero la siguiente base de datos:
create tablespace fernandez datafile 'fernandez.ora' size 10m;
default storage (initial 10k next 10k pctincrease 25);
create table jaime (codigo number(2) not null primary key, nombre varchar2(15), apellido varchar2(30))
tablespace fernandez;
create table diecinueve19 (codigo number(2) not null primary key, cod_usuario number(2), nombre
varchar2(15)) tablespace fernandez;
insert into jaime values (1, 'juan', 'fernandez');
insert into jaime values (2, 'ana', 'perez');
insert into diecinueve19 values (1, 2, 'mayor');
insert into diecinueve19 values (2, 1, 'menor');
--Conceder los privilegios insert, update, delete y select para la tabla ‘edad+numero’ a neptuno.
grant insert,update,delete,select on diecinueve19 to neptuno;
--23. Conceder todos los privilegios para la tabla “nombre” a urano incluyendo que pueda conceder estos privilegios
--a otros usuarios.
 grant all privileges on jaime to urano with grant option;
--24. Queremos que un usuario llamado polar (crearlo), con contraseña polar, sólo pueda hacer insert en las columnas
--(codigo, nombre), update en las columnas (código, nombre) y references en la columna (cod_usuario) y select
--en todas de la tabla edad+numero de apellido2.
create user polar identified by polar;
grant insert(codigo,nombre),update(codigo,nombre),references(cod_usuario),select on diecinueve19 to polar;
--25. Revocar el privilegio references a polar.
revoke references on diecinueve19 from polar;
--26. Crear un rol para los científicos llamado ‘estrella’ con contraseña ‘estrella’.
create role estrella identified by estrella;
--27. Conceder los privilegios de sistema create session, create table, create view, create any index, create sequence,
--create type al rol estrella creado anteriormente.
grant create session,create table,create view,create any index,create sequence,create type to estrella;
--28. Conceder los privilegios de objeto insert, update, delete, select sobre la tabla edad+numero al rol estrella.
grant insert,update,delete,select on diecinueve19 to estrella;
--29. Conceder el rol estrella al usuario polar.
grant estrella to polar;
--30. Conceder el rol estrella al usuario neptuno.
grant estrella to neptuno;
--31. Crear un perfil estrellita con los límites de recursos siguientes: máximo de 5 sesiones de BD concurrentes abiertas,
--CPU por sesión ilimitada, CPU por petición de BD 30 segundos, tiempo de conexión activa ilimitado, estar
--inactivo durante un tiempo máximo de 30 minutos, lecturas lógicas por sesión ilimitadas y lecturas lógicas por
--petición 1000.
create profile estrellita limit
	sessions_per_user 5
	cpu_per_session unlimited
	cpu_per_call 30
	idle_time 30 
	connect_time unlimited
	logical_reads_per_session unlimited
	logical_reads_per_call 1000
	; 
--32. Modificar el perfil anterior ajustando los límites de la contraseña a: bloquear la cuenta tras tres intentos
--consecutivos sin éxito, si se bloquea la cuenta mantener ésta bloqueada durante todo un día, tiempo de vida para
--la contraseña de 30 días más un periodo de gracia de cinco días, el perfil de usuario no puede volver a usar una
--contraseña antigua.
alter profile estrellita limit
	failed_login_attempts 3
	password_life_time 30
	password_reuse_max unlimited
	password_lock_time 1
	password_grace_time 5
	;	
--33. Hacer que caduque la contraseña de polar.
alter user polar identified by polar password expire;
--34. Asignar a "nombre+el número de letras de tu nombre” el perfil estrellita.
alter user jaime5 profile estrellita;
--35. Deshabilitar la administración de contraseñas para el perfil predeterminado de la bbdd.

--36. Mostrar información (status de la cuenta, tablespace por defecto, tablespace temporal y perfil) acerca de los
--usuarios nombre+apellido y polar. Pista: tabla dba_users.
select account_status,default_tablespace,temporary_tablespace,profile from dba_users where lower(username)='jaime5' or lower(username)='polar'; 
--37. Mostrar información sobre los roles de la base de datos.
 select * from dba_roles;
--38. Mostrar información acerca de las cuotas de espacio de tablas.
select * from dba_ts_quotas;
--39. Mostrar información acerca del perfil estrellita.
select * from dba_profiles where lower(profile)='estrellita';
--40. Asignar el perfil a urano.
alter user urano profile estrellita;