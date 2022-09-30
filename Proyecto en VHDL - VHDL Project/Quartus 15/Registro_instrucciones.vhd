--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque se encarga de recibir las instruccione sprovenietes de la memoria y de realizar una organizacion de los bits que entran para asi separarlos en OPCODE, MODO Y DATO/POSICION--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 										 --
--***********************************************************--
library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity Registro_instrucciones is
port(
		data_in	: in std_logic_vector(15 downto 0);
		Enable	: in std_logic;
		Reset		: in std_logic;
		clk 		: in std_logic;
		Opcode	: out std_logic_vector(3 downto 0);
		Modo		: out std_logic_vector(1 downto 0);
		data_out	: out std_logic_vector(9 downto 0)

	  );
end Entity Registro_instrucciones;              

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--

architecture Registro_instruccionesArch of Registro_instrucciones is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--

component dffe is
port(
	d, clk, clrn, prn, ena: in std_logic;
	q: out std_logic
);
end component dffe;

Signal Q : std_logic_vector(15 downto 0);


--***********************************************************--
--DECLARACION LOGICA							   					    --
--***********************************************************--
begin

--La variable de salida "Opcode" correspondiente al codiogo de operacion del sistema toma los valores/salida del registro de instrucciones que estan en las variables "Q" - bits 15, 14, 13, 12 (siendo esta ultuna variable interna de este bloque)
Opcode(3)<=Q(15);
Opcode(2)<=Q(14);
Opcode(1)<=Q(13);
Opcode(0)<=Q(12);

--Se asigna el valor de los bits 11 y 10 a la variable de salida "Modo" los cuales tiene la informacion correspondiente al modod de direccionamiento que la instruccion leyo
Modo(1)<=Q(11);
Modo(0)<=Q(10);

--Se asigna un valor a la variable de salida del bloque "data_out" la cual toma los bits del 9 al 0 de la instruccion leida para luego ser enviados al Program Counter o al Registro_PC_dir--
data_out(9)<=Q(9);
data_out(8)<=Q(8);
data_out(7)<=Q(7);
data_out(6)<=Q(6);
data_out(5)<=Q(5);
data_out(4)<=Q(4);
data_out(3)<=Q(3);
data_out(2)<=Q(2);
data_out(1)<=Q(1);
data_out(0)<=Q(0);

--Definicion de las variables que componen el componete DFFE que son los Flip-Flop tipo D--
f1 : dffe Port Map(data_in(0), clk, (not reset),'1', Enable, Q(0));
f2 : dffe Port Map(data_in(1), clk, (not reset),'1', Enable, Q(1));
f3 : dffe Port Map(data_in(2), clk, (not reset),'1', Enable, Q(2));
f4 : dffe Port Map(data_in(3), clk, (not reset),'1', Enable, Q(3));
f5 : dffe Port Map(data_in(4), clk, (not reset),'1', Enable, Q(4));
f6 : dffe Port Map(data_in(5), clk, (not reset),'1', Enable, Q(5));
f7 : dffe Port Map(data_in(6), clk, (not reset),'1', Enable, Q(6));
f8 : dffe Port Map(data_in(7), clk, (not reset),'1', Enable, Q(7));
f9 : dffe Port Map(data_in(8), clk, (not reset),'1', Enable, Q(8));
f10: dffe Port Map(data_in(9), clk, (not reset),'1', Enable, Q(9));
f11: dffe Port Map(data_in(10), clk, (not reset),'1', Enable, Q(10));
f12: dffe Port Map(data_in(11), clk, (not reset),'1', Enable, Q(11));
f13: dffe Port Map(data_in(12), clk, (not reset),'1', Enable, Q(12));
f14: dffe Port Map(data_in(13), clk, (not reset),'1', Enable, Q(13));
f15: dffe Port Map(data_in(14), clk, (not reset),'1', Enable, Q(14));
f16: dffe Port Map(data_in(15), clk, (not reset),'1', Enable, Q(15));

End  Registro_instruccionesArch;
--***********************************************************--