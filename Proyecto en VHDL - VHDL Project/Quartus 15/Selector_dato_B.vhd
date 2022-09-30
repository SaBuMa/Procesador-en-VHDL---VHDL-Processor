--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este selector se encarga de escoger entre los valores provenientes del Registro de Instruccions o de la Memoria para luego enviar uno al Registro dato B

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity Selector_dato_B is 
port(		
		Selector					: in 	std_logic;
		Dato_OUT_Memoria		: in std_logic_vector(15 downto 0);
		Dato_OUT_Reg_Inst		: in std_logic_vector(9 downto 0);
		Salida_Sel_dato_B		: out std_logic_vector(15 downto 0)
);
end entity Selector_dato_B;

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--
architecture Selector_dato_BArch of Selector_dato_B is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--
signal Salida:std_logic_vector(15 downto 0);

--***********************************************************--
--DECLARACION LOGICA							   						  --
--***********************************************************--
Begin

--Acontinuacion, se realiza la logica combinatoria para asi seleccionar una de las dos posibles variables que ingresan a este bloque selector
--Cuando Selector_dato_IN es 0 la salida de este selector es el dato de salida de la memoria
--Cuando Selector_dato_IN es 1 la salida de este selector es el dato de salida del registro de instrucciones

Salida(0)<=((Dato_OUT_Memoria(0) and (not (Selector))) or (Dato_OUT_Reg_Inst(0) and Selector));
Salida(1)<=((Dato_OUT_Memoria(1) and (not (Selector))) or (Dato_OUT_Reg_Inst(1) and Selector));
Salida(2)<=((Dato_OUT_Memoria(2) and (not (Selector))) or (Dato_OUT_Reg_Inst(2) and Selector));
Salida(3)<=((Dato_OUT_Memoria(3) and (not (Selector))) or (Dato_OUT_Reg_Inst(3) and Selector));
Salida(4)<=((Dato_OUT_Memoria(4) and (not (Selector))) or (Dato_OUT_Reg_Inst(4) and Selector));
Salida(5)<=((Dato_OUT_Memoria(5) and (not (Selector))) or (Dato_OUT_Reg_Inst(5) and Selector));
Salida(6)<=((Dato_OUT_Memoria(6) and (not (Selector))) or (Dato_OUT_Reg_Inst(6) and Selector));
Salida(7)<=((Dato_OUT_Memoria(7) and (not (Selector))) or (Dato_OUT_Reg_Inst(7) and Selector));
Salida(8)<=((Dato_OUT_Memoria(8) and (not (Selector))) or (Dato_OUT_Reg_Inst(8) and Selector));
Salida(9)<=((Dato_OUT_Memoria(9) and (not (Selector))) or (Dato_OUT_Reg_Inst(9) and Selector));
Salida(10)<=((Dato_OUT_Memoria(10) and (not (Selector))));
Salida(11)<=((Dato_OUT_Memoria(11) and (not (Selector))));
Salida(12)<=((Dato_OUT_Memoria(12) and (not (Selector))));
Salida(13)<=((Dato_OUT_Memoria(13) and (not (Selector))));
Salida(14)<=((Dato_OUT_Memoria(14) and (not (Selector))));
Salida(15)<=((Dato_OUT_Memoria(15) and (not (Selector))));

--La variable "Salida_Sel_dato_B" toma la variable interna "Salida"
Salida_Sel_dato_B<=Salida;

end Selector_dato_BArch;
--***********************************************************--