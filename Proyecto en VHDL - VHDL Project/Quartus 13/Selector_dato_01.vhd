--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque se encraga de realizar una seleccion entre la salida de la Memoria, salida del Registro de Instruccion y la salida de la ALU, para luego enviar una de estas tres opciones al Registro Datos--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity Selector_dato_01 is 
port(		
		Selector							: in  std_logic_vector(1 downto 0);
		Dato_OUT_Memoria				: in std_logic_vector(15 downto 0);
		Dato_OUT_ALU					: in std_logic_vector(15 downto 0);
		Dato_OUT_Reg_Inst				: in std_logic_vector(9 downto 0);
		Salida_Sel_dato_01			: out std_logic_vector(15 downto 0)
);
end entity Selector_dato_01; 

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--
architecture Selector_dato_01Arch of Selector_dato_01 is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--
signal Sel_ALU: std_logic;
signal Sel_Memoria: std_logic;
signal Sel_Reg_Inst: std_logic;
signal Salida:std_logic_vector(15 downto 0);

--***********************************************************--
--DECLARACION LOGICA							   						  --
--***********************************************************--

Begin
--Acontinuacion, se realiza la logica combinatoria para asi seleccionar una de las tres posibles variables que ingresan a este bloque selector
 
--Cuando Selector_dato_OUT es 00 la salida de este selector es el dato de salida de la memoria
--Cuando Selector_dato_OUT es 10 la salida de este selector es el dato de salida de la ALU
--Cuando Selector_dato_OUT es 01 la salida de este selector son los últimos 10 bits del registro de instrucciones

Sel_Memoria<=((not(Selector(0))) and (not (Selector(1))));
Sel_ALU<=((not(Selector(0))) and (Selector(1)));
Sel_Reg_Inst<=((Selector(0)) and (not (Selector(1))));

--La variable "Salida" recibe la logica combinatoria realizada para asi seleccionar los datos/variables deseadas
Salida(0)<=((Dato_OUT_Memoria(0) and Sel_Memoria) or ((Dato_OUT_ALU(0) and Sel_ALU)) or ((Dato_OUT_Reg_Inst(0) and Sel_Reg_Inst)));
Salida(1)<=((Dato_OUT_Memoria(1) and Sel_Memoria) or ((Dato_OUT_ALU(1) and Sel_ALU)) or ((Dato_OUT_Reg_Inst(1) and Sel_Reg_Inst)));
Salida(2)<=((Dato_OUT_Memoria(2) and Sel_Memoria) or ((Dato_OUT_ALU(2) and Sel_ALU)) or ((Dato_OUT_Reg_Inst(2) and Sel_Reg_Inst)));
Salida(3)<=((Dato_OUT_Memoria(3) and Sel_Memoria) or ((Dato_OUT_ALU(3) and Sel_ALU)) or ((Dato_OUT_Reg_Inst(3) and Sel_Reg_Inst)));
Salida(4)<=((Dato_OUT_Memoria(4) and Sel_Memoria) or ((Dato_OUT_ALU(4) and Sel_ALU)) or ((Dato_OUT_Reg_Inst(4) and Sel_Reg_Inst)));
Salida(5)<=((Dato_OUT_Memoria(5) and Sel_Memoria) or ((Dato_OUT_ALU(5) and Sel_ALU)) or ((Dato_OUT_Reg_Inst(5) and Sel_Reg_Inst)));
Salida(6)<=((Dato_OUT_Memoria(6) and Sel_Memoria) or ((Dato_OUT_ALU(6) and Sel_ALU)) or ((Dato_OUT_Reg_Inst(6) and Sel_Reg_Inst)));
Salida(7)<=((Dato_OUT_Memoria(7) and Sel_Memoria) or ((Dato_OUT_ALU(7) and Sel_ALU)) or ((Dato_OUT_Reg_Inst(7) and Sel_Reg_Inst)));
Salida(8)<=((Dato_OUT_Memoria(8) and Sel_Memoria) or ((Dato_OUT_ALU(8) and Sel_ALU)) or ((Dato_OUT_Reg_Inst(8) and Sel_Reg_Inst)));
Salida(9)<=((Dato_OUT_Memoria(9) and Sel_Memoria) or ((Dato_OUT_ALU(9) and Sel_ALU)) or ((Dato_OUT_Reg_Inst(9) and Sel_Reg_Inst)));
Salida(10)<=(((Dato_OUT_Memoria(10) and Sel_Memoria) or ((Dato_OUT_ALU(10) and Sel_ALU))));
Salida(11)<=(((Dato_OUT_Memoria(11) and Sel_Memoria) or ((Dato_OUT_ALU(11) and Sel_ALU))));
Salida(12)<=(((Dato_OUT_Memoria(12) and Sel_Memoria) or ((Dato_OUT_ALU(12) and Sel_ALU))));
Salida(13)<=(((Dato_OUT_Memoria(13) and Sel_Memoria) or ((Dato_OUT_ALU(13) and Sel_ALU))));
Salida(14)<=(((Dato_OUT_Memoria(14) and Sel_Memoria) or ((Dato_OUT_ALU(14) and Sel_ALU))));
Salida(15)<=(((Dato_OUT_Memoria(15) and Sel_Memoria) or ((Dato_OUT_ALU(15) and Sel_ALU))));

--La variable "Salida_Sel_dato_01" toma la variable interna "Salida"
Salida_Sel_dato_01<=Salida;

end Selector_dato_01Arch;
--***********************************************************--