--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque se encarga de realizar las operaciones logicas y aritmeticas del procesador--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--
library IEEE;
use IEEE.std_logic_1164.all;

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity ALU is 
port(
		A									: in std_logic_vector(15 downto 0);
		B									: in std_logic_vector(15 downto 0);
		OP									: in std_logic_vector(3 downto 0);
		Overflow							: out std_logic;
		Zero								: out std_logic;
		Negativo 						: out std_logic;
		Carry_out						: out std_logic;
		Salida							: out std_logic_vector(15 downto 0)
);
end entity ALU; 

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
architecture ALUArch of ALU is

--***********************************************************--
--DEFINICIÓN DE CADA BLOQUE 			  		                   --
--***********************************************************--
component Alu_sumador is
port(
	Carr_in								: in std_logic;
	A										: in std_logic_vector(15 downto 0);
	Bcomp									: in std_logic_vector(15 downto 0);
	Salida								: out std_logic_vector(15 downto 0);
	Carry_out							: out std_logic_vector(15 downto 0);
	Overflow								: out std_logic
);
end component;

component Alu_Comparador is 
port(
	OP										: in std_logic_vector(3 downto 0);
	Salida								: in std_logic_vector(15 downto 0);
	Carry_out							: in std_logic_vector(15 downto 0);
	Negativo								: out std_logic;
	Zero									: out std_logic
);
end component;

component Alu_Complemento is
port(
	OP										: in std_logic_vector(3 downto 0);
	B										: in std_logic_vector(15 downto 0);
	SUM_uno								: out std_logic;
	Bcomp									: out std_logic_vector(15 downto 0)
);
end component;

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--
--Señales de Carry de entrada
signal Carry_in_sumador_signal 	: std_logic;

--Entradas del sumador 
signal A_signal						: std_logic_vector(15 downto 0);
signal B_comp_signal					: std_logic_vector(15 downto 0);

--Entradas del complemento
signal B_signal						: std_logic_vector(15 downto 0);

--Salidas del sumador
signal Salida_suma_signal			: std_logic_vector(15 downto 0);
signal Carry_out_sumador_signal	: std_logic_vector(15 downto 0);

--Salidas del Comparador
signal Overflow_signal				: std_logic;
signal Zero_signal					: std_logic;
signal Negativo_signal				: std_logic;

--***********************************************************--
--CONEXIÓN DE ENTRADAS Y SALIDAS
--***********************************************************--
begin

A_signal<=A;
B_signal<=B;


Alu_Complemento_portmap: Alu_Complemento port map(OP,B_signal,Carry_in_sumador_signal,B_comp_signal);
Alu_Comparador_portmap: Alu_Comparador port map(OP,Salida_suma_signal,Carry_out_sumador_signal,Negativo_signal,Zero_signal);
Alu_sumador_portmap: Alu_sumador port map(Carry_in_sumador_signal,A_signal,B_comp_signal,Salida_suma_signal,Carry_out_sumador_signal,Overflow_signal);

--***********************************************************--
--ASIGNACIÓN DE VARIABLES A LA SALIDA
--***********************************************************--
Overflow<=Overflow_signal;
Zero<=Zero_signal;
Negativo<=Negativo_signal;
Carry_out<=Carry_out_sumador_signal(15);
Salida<=Salida_suma_signal;

end ALUArch;