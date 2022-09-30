--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque se encarga de realizar la suma entre dos numeros por medio de un FULL ADDER

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity Alu_sumador is 
port(		
		Carr_in					: in std_logic;
		A							: in std_logic_vector(15 downto 0);
		Bcomp						: in std_logic_vector(15 downto 0);
		Salida					: out std_logic_vector(15 downto 0);
		Carry_out				: out std_logic_vector(15 downto 0);
		Overflow					: out std_logic
);
end entity Alu_sumador; 

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--
architecture Alu_sumadorArch of Alu_sumador is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--
signal carr_out : std_logic_vector(15 downto 0);

--***********************************************************--
--DECLARACION LOGICA							   						  --
--***********************************************************--
Begin

-- Ac otnuacion, se presenta la logica combinatoria para realizar un FULL ADDER entre el dato A y el dato B que entran a la ALU
Salida(0) <= Carr_in xor (A(0) xor Bcomp(0));
Carr_out(0) <= ((Carr_in and (A(0) xor Bcomp(0))) or (A(0) and Bcomp(0)));

Salida(1) <= Carr_out(0) xor (A(1) xor Bcomp(1));
Carr_out(1) <= ((Carr_out(0) and (A(1) xor Bcomp(1))) or (A(1) and Bcomp(1)));

Salida(2) <= Carr_out(1) xor (A(2) xor Bcomp(2));
Carr_out(2) <= ((Carr_out(1) and (A(2) xor Bcomp(2))) or (A(2) and Bcomp(2)));

Salida(3) <= Carr_out(2) xor (A(3) xor Bcomp(3));
Carr_out(3) <= ((Carr_out(2) and (A(3) xor Bcomp(3))) or (A(3) and Bcomp(3)));

Salida(4) <= Carr_out(3) xor (A(4) xor Bcomp(4));
Carr_out(4) <= ((Carr_out(3) and (A(4) xor Bcomp(4))) or (A(4) and Bcomp(4)));

Salida(5) <= Carr_out(4) xor (A(5) xor Bcomp(5));
Carr_out(5) <= ((Carr_out(4) and (A(5) xor Bcomp(5))) or (A(5) and Bcomp(5)));

Salida(6) <= Carr_out(5) xor (A(6) xor Bcomp(6));
Carr_out(6) <= ((Carr_out(5) and (A(6) xor Bcomp(6))) or (A(6) and Bcomp(6)));

Salida(7) <= Carr_out(6) xor (A(7) xor Bcomp(7));
Carr_out(7) <= ((Carr_out(6) and (A(7) xor Bcomp(7))) or (A(7) and Bcomp(7)));

Salida(8) <= Carr_out(7) xor (A(8) xor Bcomp(8));
Carr_out(8) <= ((Carr_out(7) and (A(8) xor Bcomp(8))) or (A(8) and Bcomp(8)));

Salida(9) <= Carr_out(8) xor (A(9) xor Bcomp(9));
Carr_out(9) <= ((Carr_out(8) and (A(9) xor Bcomp(9))) or (A(9) and Bcomp(9)));

Salida(10) <= Carr_out(9) xor (A(10) xor Bcomp(10));
Carr_out(10) <= ((Carr_out(9) and (A(10) xor Bcomp(10))) or (A(10) and Bcomp(10)));

Salida(11) <= Carr_out(10) xor (A(11) xor Bcomp(11));
Carr_out(11) <= ((Carr_out(10) and (A(11) xor Bcomp(11))) or (A(11) and Bcomp(11)));

Salida(12) <= Carr_out(11) xor (A(12) xor Bcomp(12));
Carr_out(12) <= ((Carr_out(11) and (A(12) xor Bcomp(12))) or (A(12) and Bcomp(12)));

Salida(13) <= Carr_out(12) xor (A(13) xor Bcomp(13));
Carr_out(13) <= ((Carr_out(12) and (A(13) xor Bcomp(13))) or (A(13) and Bcomp(13)));

Salida(14) <= Carr_out(13) xor (A(14) xor Bcomp(14));
Carr_out(14) <= ((Carr_out(13) and (A(14) xor Bcomp(14))) or (A(14) and Bcomp(14)));

Salida(15) <= Carr_out(14) xor (A(15) xor Bcomp(15));
Carr_out(15) <= ((Carr_out(14) and (A(15) xor Bcomp(15))) or (A(15) and Bcomp(15)));

Overflow<=(Carr_out(14) xor Carr_out(15));

Carry_out<=Carr_out;

end Alu_sumadorArch;
--***********************************************************--