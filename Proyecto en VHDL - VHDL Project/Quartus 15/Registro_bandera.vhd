--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque se encarga de almacenar las banderas provenientes de la ALU para luego enviarlas a control y ser usadas como condiciones para diferentes estados--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************-- 

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--

entity Registro_bandera is
port(
		Enable	: in std_logic;
		Reset		: in std_logic;
		clk 		: in std_logic;
		Overflow	: in std_logic;
		Zero		: in std_logic;
		Negativo	: in std_logic;
		Carry_out: in std_logic;
		data_out	: out std_logic_vector(3 downto 0)
	  );
end Entity Registro_bandera;              

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--

architecture Registro_banderaArch of Registro_bandera is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--

component dffe is
port(
	d, clk, clrn, prn, ena: in std_logic;
	q: out std_logic
);
end component dffe;

signal D, Q : std_logic_vector (3 downto 0);

--***********************************************************--
--DECLARACION LOGICA							   						  --
--***********************************************************--

begin

--La variable interna "D" toma el valor de cada una de las variables correspondientes a las banderas que salen de la ALU 
D(0)<= Overflow;
D(1)<= Zero;
D(2)<= Negativo;
D(3)<= Carry_out;

--Definicion de las variables que componen el componete DFFE que son los Flip-Flop tipo D--
f1 : dffe Port Map(D(0), clk, (not reset),'1', Enable, Q(0));
f2 : dffe Port Map(D(1), clk, (not reset),'1', Enable, Q(1));
f3 : dffe Port Map(D(2), clk, (not reset),'1', Enable, Q(2));
f4 : dffe Port Map(D(3), clk, (not reset),'1', Enable, Q(3));

--La variable de salida "Data_out" toma el valor de la variable interna "Q"--
Data_out<=Q;

End  Registro_banderaArch;
--***********************************************************--