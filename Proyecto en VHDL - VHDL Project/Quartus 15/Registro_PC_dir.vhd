--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque se encarga de guardar temporalmente y de entregar a la memoria la direccion/posicion que se deseea leer o escribir--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--
library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS								 --
--***********************************************************--

entity Registro_PC_dir is
port(
		data_in	: in std_logic_vector(9 downto 0);
		Enable	: in std_logic;
		Reset		: in std_logic;
		clk 		: in std_logic;
		data_out	: out std_logic_vector(9 downto 0)
	  );
end Entity Registro_PC_dir;              
--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                     		       --
--***********************************************************--

architecture Registro_PC_dirArch of Registro_PC_dir is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN              		       --
--***********************************************************--

component dffe is
port(
	d, clk, clrn, prn, ena: in std_logic;
	q: out std_logic
);
end component dffe;

Signal D, Q: std_logic_vector(9 downto 0);-- Señales 

--***********************************************************--
--DECLARACION LOGICA				  									  --
--***********************************************************--

begin
--Se asigna el valor de la variable de entrada "data_in" a la variable interna "D"
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

--Definicion de las variables que componen el componete DFFE que son los Flip-Flop tipo D--
f1 : dffe Port Map(D(0), clk, (not Reset),'1', Enable, Q (0));
f2 : dffe Port Map(D(1), clk, (not Reset),'1', Enable, Q (1));
f3 : dffe Port Map(D(2), clk, (not Reset),'1', Enable, Q (2));
f4 : dffe Port Map(D(3), clk, (not Reset),'1', Enable, Q (3));
f5 : dffe Port Map(D(4), clk, (not Reset),'1', Enable, Q (4));
f6 : dffe Port Map(D(5), clk, (not Reset),'1', Enable, Q (5));
f7 : dffe Port Map(D(6), clk, (not Reset),'1', Enable, Q (6));
f8 : dffe Port Map(D(7), clk, (not Reset),'1', Enable, Q (7));
f9 : dffe Port Map(D(8), clk, (not Reset),'1', Enable, Q (8));
f10: dffe Port Map(D(9), clk, (not Reset),'1', Enable, Q (9));

--Se asigna la variable interna "Q" (variable de salida de los Flip-Flop) a la variable de salida "data_out" de este bloque--
data_out<=Q;

End  Registro_PC_dirArch;
--***********************************************************--