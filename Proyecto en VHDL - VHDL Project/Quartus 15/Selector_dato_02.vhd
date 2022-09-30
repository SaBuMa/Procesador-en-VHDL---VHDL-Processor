--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este selector se encarga de escoger entre los datos provenietes del Registro Datos y del Program Counter y luego enviar uno como entrada a la Memoria

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity Selector_dato_02 is 
port(		
		Selector					: in 	std_logic;
		Dato_OUT_Reg_Datos	: in std_logic_vector(15 downto 0);
		Dato_OUT_PC				: in std_logic_vector(9 downto 0);
		Salida_Sel_dato_02	: out std_logic_vector(15 downto 0)
);
end entity Selector_dato_02;

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--
architecture Selector_dato_02Arch of Selector_dato_02 is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--
signal Salida:std_logic_vector(15 downto 0);

--***********************************************************--
--DECLARACION LOGICA							   						  --
--***********************************************************--
Begin

--Acontinuacion, se realiza la logica combinatoria para asi seleccionar una de las dos posibles variables que ingresan a este bloque selector
--Cuando Selector_dato_IN es 0 la salida de este selector es el dato de salida del registro de datos
--Cuando Selector_dato_IN es 1 la salida de este selector es el dato de salida del PC

Salida(0)<=((Dato_OUT_Reg_Datos(0) and (not (Selector))) or (Dato_OUT_PC(0) and Selector));
Salida(1)<=((Dato_OUT_Reg_Datos(1) and (not (Selector))) or (Dato_OUT_PC(1) and Selector));
Salida(2)<=((Dato_OUT_Reg_Datos(2) and (not (Selector))) or (Dato_OUT_PC(2) and Selector));
Salida(3)<=((Dato_OUT_Reg_Datos(3) and (not (Selector))) or (Dato_OUT_PC(3) and Selector));
Salida(4)<=((Dato_OUT_Reg_Datos(4) and (not (Selector))) or (Dato_OUT_PC(4) and Selector));
Salida(5)<=((Dato_OUT_Reg_Datos(5) and (not (Selector))) or (Dato_OUT_PC(5) and Selector));
Salida(6)<=((Dato_OUT_Reg_Datos(6) and (not (Selector))) or (Dato_OUT_PC(6) and Selector));
Salida(7)<=((Dato_OUT_Reg_Datos(7) and (not (Selector))) or (Dato_OUT_PC(7) and Selector));
Salida(8)<=((Dato_OUT_Reg_Datos(8) and (not (Selector))) or (Dato_OUT_PC(8) and Selector));
Salida(9)<=((Dato_OUT_Reg_Datos(9) and (not (Selector))) or (Dato_OUT_PC(9) and Selector));
Salida(10)<=((Dato_OUT_Reg_Datos(10) and (not (Selector))));
Salida(11)<=((Dato_OUT_Reg_Datos(11) and (not (Selector))));
Salida(12)<=((Dato_OUT_Reg_Datos(12) and (not (Selector))));
Salida(13)<=((Dato_OUT_Reg_Datos(13) and (not (Selector))));
Salida(14)<=((Dato_OUT_Reg_Datos(14) and (not (Selector))));
Salida(15)<=((Dato_OUT_Reg_Datos(15) and (not (Selector))));

--La variable "Salida_Sel_dato_02" toma la variable interna "Salida"
Salida_Sel_dato_02<=Salida;

end Selector_dato_02Arch;
--***********************************************************--