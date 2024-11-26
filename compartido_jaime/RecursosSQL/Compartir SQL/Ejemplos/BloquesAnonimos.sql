/*Server out*/
set serveroutput on;
--1. Realizar un bloque anónimo PL que introduzca un número entero e indique si el número es positivo, negativo o cero y si es par o impar.

	accept variable_teclado prompt 'Introduzca un numero ';
	declare
		numeroteclado number(5);
	begin 
		numeroteclado :=&variable_teclado;
		--Comprobacion numero positivo o negativo

			if (numeroteclado>0) then
				dbms_output.put_line('El numero introducido es positivo ');
			elsif (numeroteclado=0) then
				dbms_output.put_line('El numero introducido es 0');
			else  
				dbms_output.put_line('El numero introducido es negativo');
			end if;
		--Comprobacion numero par o impar

			 if (mod(numeroteclado,2)=0) then
			 	dbms_output.put_line('El numero introducido es par ');
			else 
			 	dbms_output.put_line('El numero introducido es impar');
			 	end if;
	end ;
	/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--2. Realizar un bloque anónimo PL que sume los primeros 40 números naturales (utilizar loop)
--Declaramos variables
declare
	suma number(5):=0;
	nume number(5):=0;
	begin
	loop
		nume:=nume+1;
		suma:=suma+nume;
		exit when nume=40;
	end loop;
	dbms_output.put_line('la suma es '|| suma);
end ;
/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3. Realizar un bloque anónimo PL que visualice los primeros 35 números naturales, la suma de los pares, el
--producto de los impares y la cantidad de ambos. (utilizar while)
	declare 
		sumpar number(38):=0;
		prodimpar number(38):=1;
		c_par number(38):=0;
		c_impar number(38):=0;
		num number(38):=0;

	begin
	 	--Comprobamos si el numero es par o impar
	 	while (num<36) loop

	 	if (mod(num,2)=0) then
	 	c_par:=c_par+1;
	 	sumpar:=sumpar+num;

	 	else 
	 	c_impar:=c_impar+1;
	 	prodimpar:=prodimpar*num;


	 	end if;
	 	num:=num+1;
	 	end loop;

	 	--Imprimimos por pantalla
	 	dbms_output.put_line('La suma de los pares es ' || sumpar);
	 	dbms_output.put_line('El producto de los impares es ' || prodimpar);
	 	dbms_output.put_line('El numero de numeros pares es ' || c_par);
	 	dbms_output.put_line('El numero de numeros impares es ' || c_impar);

end ;
/
--4. Realizar un bloque anónimo PL que, al introducir dos números por teclado, imprima los números naturales que
--hay entre ambos números empezando por el más pequeño, contar cuantos hay en total, cuántos de ellos son
--pares, y calcular la suma de los impares. (utilizar for)
	--Declaramos las variables teclado
accept vtec1 prompt "Introducza un numero "
accept vtec2 prompt "Introducza otro numero "
--Declaramos variables
declare
	num1 number(30) :=0;
	num2 number(30) :=0;
	cont number(30) :=0;
	par number(30) :=0;
	sumimpar number(30) :=0;
	i number(15) :=0;
--Empezamos el programa y le pedimos dos numeros al usuario
begin 
	num1 :=&vtec1;
	num2 :=&vtec2;
	--Comprobar que número es mayor
		if(num1<num2) then 
			for i in num1..num2 loop
				dbms_output.put_line(i);
				cont := cont + 1;
					if mod(i,2)=0 then
					par := par + 1;
				else
					sumimpar := sumimpar + i;
				end if;
		end loop;
	--Sacamos por teclado el contador el numero de pares y la suma de los impares
		dbms_output.put_line('Contador: '||cont);
		dbms_output.put_line('Hay '||par||' num pares');
		dbms_output.put_line('La suma de impares es: '||sumimpar);
	else 
		for i in num2..num1 loop
			dbms_output.put_line(i);
			cont := cont + 1;
				if mod(i,2)=0 then
					par := par + 1;
				else
					sumimpar := sumimpar + i;
				end if;
		end loop;
		--Sacamos por teclado el contador el numero de pares y la suma de los impares
		dbms_output.put_line('Contador: '||cont);
		dbms_output.put_line('Hay '||par||' numeros pares');
		dbms_output.put_line('La suma de los numeros impares es: '||sumimpar);
	end if;
end;
/
------------------------------------------------------------------------------------------------------------------------------------------------------------
--5. Realizar un bloque anónimo PL que imprima el mayor y el menor de una serie de cinco números que vamos
--introduciendo por teclado.
accept variable_teclado1 prompt "Introducza el primer numero  "
accept variable_teclado2 prompt "Introducza el segundo numero "
accept variable_teclado3 prompt "Introducza el tercer numero "
accept variable_teclado4 prompt "Introducza el cuarto numero "
accept variable_teclado5 prompt "Introducza el quinto numero "

	declare
		num1 number(10);
		num2 number(10);
		num3 number(10);
		num4 number(10);
		num5 number(10);
		


	begin
		--Leemos las variables
		num1 :=&variable_teclado1;
		num2 :=&variable_teclado2;
		num3 :=&variable_teclado3;
		num4 :=&variable_teclado4;
		num5 :=&variable_teclado5;

		--Con las funciones "greatest" y "least " sacamos cual es el número mas grande y cual es el mas pequeño 
		dbms_output.put_line ('El numero mas grandes es ' || greatest(num1,num2,num3,num4,num5));
		
		dbms_output.put_line('El menor numero es  ' ||   least(num1,num2,num3,num4,num5));


		

end ;
/
----------------------------------------------------------------------------------------------------------------------------------------------------------------
--6. Realizar un bloque anónimo PL que calcule y muestre la suma de los diez primeros números entre 1 y 1000 que
--sean divisibles por uno dado.
accept teclado prompt "Introduzca un numero: "

declare

	num number(4);
	suma number(4) := 0;
	i number(4) := 1;
	cont number(2) := 0;

begin
	num :=&teclado;
	for i in 1..1000 loop
		if (cont <10) then
			if (mod(i,num) = 0) then
				cont := cont + 1;
				suma := suma + i;
			end if;
		end if;
	end loop;
dbms_output.put_line(suma);
end;
/
-----------------------------------------------------------------------------------------------------------------------------------------------
--7. Realizar un bloque anónimo PL que dada una fecha muestre la frase “El día DD de 'nombre del mes' del año
--YYYY es muy importante’.
accept variable_teclado12 prompt "Introduzca la fecha: YYYY-MM-DD"

	declare
		fecha date;

	begin
		fecha:=to_date('&variable_teclado12','YYYY-MM-DD');
		dbms_output.put_line('El dia' || (to_char(fecha,'DD')) || 'del mes' ||(to_char(fecha,'MM')) ||'del anyyo' || (to_char(fecha,'YYYY')) || 'es muy importante');
	end ;
	/

-----------------------------
--8. Realizar un bloque anónimo PL que dada una fecha nos diga que día de la semana es.
accept teclado1 prompt "Introduzca la fecha (DD-MM-AAAA): "
declare

fecha date;

begin 

fecha :=to_date('&teclado1', 'DD-MM-YYYY');

dbms_output.put_line(TO_CHAR(fecha, 'DY'));

end;
/




