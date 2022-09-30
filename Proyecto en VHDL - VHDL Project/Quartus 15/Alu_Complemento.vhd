--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--
library IEEE;
use IEEE.std_logic_1164.all;

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity Alu_Complemento is 
port(		
		OP							: in std_logic_vector(3 downto 0);
		B							: in std_logic_vector(15 downto 0);
		SUM_uno					: out std_logic;
		Bcomp						: out std_logic_vector(15 downto 0)
);
end entity Alu_Complemento; 

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--
architecture Alu_ComplementoArch of Alu_Complemento is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--
signal Sop : std_logic;

--***********************************************************--
--DECLARACION LOGICA							   						  --
--***********************************************************--
Begin

--La variable interna "Sop" toma el valor de la variable de entrada "Op" para asi decidir si se realiza el complemento del numero 2 de entrada a la ALU o no
Sop<= (((not OP(3)) and OP(2) and (not OP(1)) and OP(0)) or (not (OP(3)) and (not OP(2)) and (OP(1)) and (not OP(0))));


--Logica combinatoria para realizar el complemento--
Bcomp(0) <= (((not Sop)  and B(0)) or (Sop  and (not B(0))));
Bcomp(1) <= (((not Sop)  and B(1)) or (Sop  and (not B(1))));
Bcomp(2) <= (((not Sop)  and B(2)) or (Sop  and (not B(2))));
Bcomp(3) <= (((not Sop)  and B(3)) or (Sop  and (not B(3))));
Bcomp(4) <= (((not Sop)  and B(4)) or (Sop  and (not B(4))));
Bcomp(5) <= (((not Sop)  and B(5)) or (Sop  and (not B(5))));
Bcomp(6) <= (((not Sop)  and B(6)) or (Sop  and (not B(6))));
Bcomp(7) <= (((not Sop)  and B(7)) or (Sop  and (not B(7))));
Bcomp(8) <= (((not Sop)  and B(8)) or (Sop  and (not B(8))));
Bcomp(9) <= (((not Sop)  and B(9)) or (Sop  and (not B(9))));
Bcomp(10) <= (((not Sop)  and B(10)) or (Sop  and (not B(10))));
Bcomp(11) <= (((not Sop)  and B(11)) or (Sop  and (not B(11))));
Bcomp(12) <= (((not Sop)  and B(12)) or (Sop  and (not B(12))));
Bcomp(13) <= (((not Sop)  and B(13)) or (Sop  and (not B(13))));
Bcomp(14) <= (((not Sop)  and B(14)) or (Sop  and (not B(14))));
Bcomp(15) <= (((not Sop)  and B(15)) or (Sop  and (not B(15))));

SUM_uno<=(Sop);

end Alu_ComplementoArch;
--***********************************************************--