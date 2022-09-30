--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque se encarga de realizar la comparacion de los resultados obtenidos de la ALU y asi determinar las banderas de esta--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity Alu_Comparador is 
port(		
		OP							: in std_logic_vector(3 downto 0);
		Salida					: in std_logic_vector(15 downto 0);
		Carry_out				: in std_logic_vector(15 downto 0);
		Negativo					: out std_logic;
		Zero						: out std_logic
);
end entity Alu_Comparador; 

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--
architecture Alu_ComparadorArch of Alu_Comparador is

signal Negativo_signal : std_logic;
signal Zero_signal : std_logic;

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--
Begin

--La variable Zero_signal toma el negado valor de la variable de entrada "Salida" 
Zero_signal<=(not(Salida(0) or Salida(1) or Salida(2) or Salida(3) or Salida(4) or Salida(5) or Salida(6) or Salida(7) or Salida(8) or Salida(9) or Salida(10) or Salida(11) or Salida(12) or Salida(13) or Salida(14) or Salida(15)));

--La variable "Negativo_signal" toma el valor negado de la variable "Zero_signal" y el valor negado del bit 15 de la señal de entrada "Salida"
Negativo_signal<=(not(Zero_signal) and (not (Salida(15))));

Zero<=Zero_signal;

--Si el número B es menor que A la señal Negativo será 1 siempre que el OPCODE sea de comparación
Negativo<=(Negativo_signal and (not (OP(3)) and (OP(2)) and not(OP(1)) and OP(0)));

end Alu_ComparadorArch;
--***********************************************************--