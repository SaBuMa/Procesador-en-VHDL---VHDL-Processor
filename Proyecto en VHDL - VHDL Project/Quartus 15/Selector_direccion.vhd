--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este selector se encarga de escoger una entre cuatro variables que le ingresan para ser enviada al Registro_PC_dir--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--

library IEEE;
use IEEE.std_logic_1164.all;

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--

entity Selector_direccion is 
port(		
		Selector						: in  std_logic_vector(1 downto 0);
		Dato_OUT_SP					: in std_logic_vector(9 downto 0);
		Dato_OUT_PC					: in std_logic_vector(9 downto 0);
		Dato_OUT_Reg_Inst			: in std_logic_vector(9 downto 0);
		Dato_OUT_Reg_Dato_B_02	: in std_logic_vector(9 downto 0);
		Salida_sel_direccion		: out std_logic_vector(9 downto 0)
);
end entity Selector_direccion; 

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--

architecture Selector_direccionArch of Selector_direccion is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--

signal Sel_SP			: std_logic;
signal Sel_PC			: std_logic;
signal Sel_Reg_Inst	: std_logic;
signal Sel_Dato_B 	: std_logic;
signal Salida:std_logic_vector(9 downto 0);

--***********************************************************--
--DECLARACION LOGICA							   						  --
--***********************************************************--

Begin

--Acontinuacion, se realiza la logica combinatoria para asi seleccionar una de las cuatro posibles variables que ingresan a este bloque selector

--Cuando Selector_direccion es 00 la salida de este selector es el dato de salida del "Registro de Instrucciones"
--Cuando Selector_direccion es 01 la salida de este selector es el dato de salida del "Stack Pointer"
--Cuando Selector_direccion es 10 la salida de este selector es el dato de salida del "Program Counter"
--Cuando Selector_direccion es 11 la salida de este selector es el dato de salida del "Registro Dato B"

Sel_Reg_Inst<=((not(Selector(0))) and (not (Selector(1))));
Sel_PC<=((not(Selector(0))) and (Selector(1)));
Sel_SP<=((Selector(0)) and (not (Selector(1))));
Sel_Dato_B<=(Selector(0) and Selector(1));

--Logica combinatoria para selecionar uno de los 4 datos teneindo en cuenta que valor de seleccion se tiene--
Salida(0)<=((Dato_OUT_Reg_Inst(0) and Sel_Reg_Inst) or ((Dato_OUT_PC(0) and Sel_PC)) or ((Dato_OUT_SP(0) and Sel_SP)) or ((Dato_OUT_Reg_Dato_B_02(0) and Sel_Dato_B)));
Salida(1)<=((Dato_OUT_Reg_Inst(1) and Sel_Reg_Inst) or ((Dato_OUT_PC(1) and Sel_PC)) or ((Dato_OUT_SP(1) and Sel_SP)) or ((Dato_OUT_Reg_Dato_B_02(1) and Sel_Dato_B)));
Salida(2)<=((Dato_OUT_Reg_Inst(2) and Sel_Reg_Inst) or ((Dato_OUT_PC(2) and Sel_PC)) or ((Dato_OUT_SP(2) and Sel_SP)) or ((Dato_OUT_Reg_Dato_B_02(2) and Sel_Dato_B)));
Salida(3)<=((Dato_OUT_Reg_Inst(3) and Sel_Reg_Inst) or ((Dato_OUT_PC(3) and Sel_PC)) or ((Dato_OUT_SP(3) and Sel_SP)) or ((Dato_OUT_Reg_Dato_B_02(3) and Sel_Dato_B)));
Salida(4)<=((Dato_OUT_Reg_Inst(4) and Sel_Reg_Inst) or ((Dato_OUT_PC(4) and Sel_PC)) or ((Dato_OUT_SP(4) and Sel_SP)) or ((Dato_OUT_Reg_Dato_B_02(4) and Sel_Dato_B)));
Salida(5)<=((Dato_OUT_Reg_Inst(5) and Sel_Reg_Inst) or ((Dato_OUT_PC(5) and Sel_PC)) or ((Dato_OUT_SP(5) and Sel_SP)) or ((Dato_OUT_Reg_Dato_B_02(5) and Sel_Dato_B)));
Salida(6)<=((Dato_OUT_Reg_Inst(6) and Sel_Reg_Inst) or ((Dato_OUT_PC(6) and Sel_PC)) or ((Dato_OUT_SP(6) and Sel_SP)) or ((Dato_OUT_Reg_Dato_B_02(6) and Sel_Dato_B)));
Salida(7)<=((Dato_OUT_Reg_Inst(7) and Sel_Reg_Inst) or ((Dato_OUT_PC(7) and Sel_PC)) or ((Dato_OUT_SP(7) and Sel_SP)) or ((Dato_OUT_Reg_Dato_B_02(7) and Sel_Dato_B)));
Salida(8)<=((Dato_OUT_Reg_Inst(8) and Sel_Reg_Inst) or ((Dato_OUT_PC(8) and Sel_PC)) or ((Dato_OUT_SP(8) and Sel_SP)) or ((Dato_OUT_Reg_Dato_B_02(8) and Sel_Dato_B)));
Salida(9)<=((Dato_OUT_Reg_Inst(9) and Sel_Reg_Inst) or ((Dato_OUT_PC(9) and Sel_PC)) or ((Dato_OUT_SP(9) and Sel_SP)) or ((Dato_OUT_Reg_Dato_B_02(9) and Sel_Dato_B)));

--Se asigna a la variable de salida "Salida_sel_direccion" la variable interna "Salida" la cual depnediendo del valor de la seleccion contiene el dato a ser enviado al Registro_PC_dir
Salida_sel_direccion<=Salida;

end Selector_direccionArch;
--***********************************************************--