--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque se encarga de guardar el valor a ser procesador por la ALU, ademas funciona como un registro temporal de posicion de memoria  teniendo en cuenta que el modo de direccionamiento es indirecto--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--
library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--

entity Registro_Dato_B is
port(
		data_in		: in std_logic_vector(15 downto 0);
		Enable		: in std_logic;
		Reset			: in std_logic;
		clk 			: in std_logic;
		data_out_02	: out std_logic_vector(9 downto 0);
		data_out		: out std_logic_vector(15 downto 0)
	  );
end Entity Registro_Dato_B;             
 
--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--
architecture Registro_Dato_BArch of Registro_Dato_B is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--

component dffe is
port(
	d, clk, clrn, prn, ena: in std_logic;
	q: out std_logic
);
end component dffe;

Signal D, Q: std_logic_vector(15 downto 0);
Signal Aux1 		: std_logic_vector(9 downto 0);

--***********************************************************--
--DECLARACION LOGICA							   						  --
--***********************************************************--

begin

--La variable interna "D" toma los valores provenientes de la variable "data_in" que esuna variable de entrada en este bloque--
D(0)<=data_in(0);
D(1)<=data_in(1);
D(2)<=data_in(2);
D(3)<=data_in(3);
D(4)<=data_in(4);
D(5)<=data_in(5);
D(6)<=data_in(6);
D(7)<=data_in(7);
D(8)<=data_in(8);
D(9)<=data_in(9);
D(10)<=data_in(10);
D(11)<=data_in(11);
D(12)<=data_in(12);
D(13)<=data_in(13);
D(14)<=data_in(14);
D(15)<=data_in(15);

--Definicion de las variables que componen el componete DFFE que son los Flip-Flop tipo D--
f1 : dffe Port Map(D(0), clk, (not reset),'1', Enable, Q (0));
f2 : dffe Port Map(D(1), clk, (not reset),'1', Enable, Q (1));
f3 : dffe Port Map(D(2), clk, (not reset),'1', Enable, Q (2));
f4 : dffe Port Map(D(3), clk, (not reset),'1', Enable, Q (3));
f5 : dffe Port Map(D(4), clk, (not reset),'1', Enable, Q (4));
f6 : dffe Port Map(D(5), clk, (not reset),'1', Enable, Q (5));
f7 : dffe Port Map(D(6), clk, (not reset),'1', Enable, Q (6));
f8 : dffe Port Map(D(7), clk, (not reset),'1', Enable, Q (7));
f9 : dffe Port Map(D(8), clk, (not reset),'1', Enable, Q (8));
f10: dffe Port Map(D(9), clk, (not reset),'1', Enable, Q (9));
f11: dffe Port Map(D(10), clk, (not reset),'1', Enable, Q (10));
f12: dffe Port Map(D(11), clk, (not reset),'1', Enable, Q (11));
f13: dffe Port Map(D(12), clk, (not reset),'1', Enable, Q (12));
f14: dffe Port Map(D(13), clk, (not reset),'1', Enable, Q (13));
f15: dffe Port Map(D(14), clk, (not reset),'1', Enable, Q (14));
f16: dffe Port Map(D(15), clk, (not reset),'1', Enable, Q (15));

--La variable "Aux1" que es una variable interna de este bloque toma los bits del 9 al 0 de la salida de los Flip-Flops--
Aux1(0)<=Q(0);
Aux1(1)<=Q(1);
Aux1(2)<=Q(2);
Aux1(3)<=Q(3);
Aux1(4)<=Q(4);
Aux1(5)<=Q(5);
Aux1(6)<=Q(6);
Aux1(7)<=Q(7);
Aux1(8)<=Q(8);
Aux1(9)<=Q(9);

--La variable "data_out" que sale de este bloque toma los valores de la variable "Q" para asi enviar posteriormente el Dato B de la segunda entrada de la ALU
data_out<=Q;

--La variable "data_out_02" toma los valores que tiene la variable interna "Aux1", esta variable se usa de forma temporal cuando se desea hacer una lectura de la memoria y el modod de direccionamiento que la instruccion decodifico fue el indirecto--
data_out_02<=Aux1;

End  Registro_Dato_BArch;
--***********************************************************--