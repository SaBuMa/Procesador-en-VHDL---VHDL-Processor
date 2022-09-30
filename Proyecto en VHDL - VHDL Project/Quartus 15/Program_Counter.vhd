--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque se encarga de llevar un registro de la posicion de memoria que se esta leyendo, ademas tiene la  habilidad de ser cargado por un nuevo valor para asi iniciar a contar desde una posicion de memoria escogida por el programa-- 

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity Program_Counter is
port(
        clk						: in std_logic;
		  Enable_PC				: in std_logic;
		  Enable_cargar_PC	: in std_logic;
		  NUM						:  in std_logic_vector(9 downto 0);
        SALIDA					: out std_logic_vector(9 downto 0)
);
end entity Program_Counter;

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--

architecture Program_CounterArch of Program_Counter is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--

Component dffe
port(d, clk, clrn, prn, ena:in std_logic; q: out std_logic);
end component;


signal D, Q, E, Neodato,P:std_logic_vector (9 downto 0);
signal Enable :std_logic;

--***********************************************************--
--DECLARACION LOGICA							   						  --
--***********************************************************--

begin

 --La variable interna "Neodato" toma el valor de la variable de entrada "NUM" con un valor proveniente del Registro de Instrucciones--
Neodato(0)<=NUM(0);
Neodato(1)<=NUM(1);
Neodato(2)<=NUM(2);
Neodato(3)<=NUM(3);
Neodato(4)<=NUM(4);
Neodato(5)<=NUM(5);
Neodato(6)<=NUM(6);
Neodato(7)<=NUM(7);
Neodato(8)<=NUM(8);
Neodato(9)<=NUM(9);

--Se signa la variable de netrada "Enable_PC" a la variable interna "Enable" para ser usada en la logica combinatoria-- 
Enable<=Enable_PC;

-- Logica combinatoria para realizar la carga de cada uno de los registros del Program Counter--
D(0)<= (((not Q(0)) and Enable and (not Enable_cargar_PC)) xor (Enable_cargar_PC and Neodato(0)));
D(1)<= (((not Q(1)) and Enable and (not Enable_cargar_PC)) xor (Enable_cargar_PC and Neodato(1)));
D(2)<= (((not Q(2)) and Enable and (not Enable_cargar_PC)) xor (Enable_cargar_PC and Neodato(2)));
D(3)<= (((not Q(3)) and Enable and (not Enable_cargar_PC)) xor (Enable_cargar_PC and Neodato(3)));
D(4)<= (((not Q(4)) and Enable and (not Enable_cargar_PC)) xor (Enable_cargar_PC and Neodato(4)));
D(5)<= (((not Q(5)) and Enable and (not Enable_cargar_PC)) xor (Enable_cargar_PC and Neodato(5)));
D(6)<= (((not Q(6)) and Enable and (not Enable_cargar_PC)) xor (Enable_cargar_PC and Neodato(6)));
D(7)<= (((not Q(7)) and Enable and (not Enable_cargar_PC)) xor (Enable_cargar_PC and Neodato(7)));
D(8)<= (((not Q(8)) and Enable and (not Enable_cargar_PC)) xor (Enable_cargar_PC and Neodato(8)));
D(9)<= (((not Q(9)) and Enable and (not Enable_cargar_PC)) xor (Enable_cargar_PC and Neodato(9)));

--Logica combinatoria para que el Program Counter comience a contar secuencialmente "Enable_PC"--
P(0)<=(Enable and Q(0));
P(1)<=(P(0) and Q(1));
P(2)<=(P(1) and Q(2));
P(3)<=(P(2) and Q(3));
P(4)<=(P(3) and Q(4));
P(5)<=(P(4) and Q(5));
P(6)<=(P(5) and Q(6));
P(7)<=(P(6) and Q(7));
P(8)<=(P(7) and Q(8));
P(9)<=(P(8) and Q(9));

--Logica combinatoria para habilitar los "Enable" de cada registro teniendo en cuenta si esta activa la señal de contar secuencialmente o la señal de "Enable_cargar_PC", con esta logica se asegura de que solo suceda una accion, es decir, solo se puede contar o cargar el program counter por separado--
E(0)<= (Enable xor Enable_cargar_PC);
E(1)<=(P(0) xor Enable_cargar_PC);
E(2)<=(P(1) xor Enable_cargar_PC);
E(3)<=(P(2) xor Enable_cargar_PC);
E(4)<=(P(3) xor Enable_cargar_PC);
E(5)<=(P(4) xor Enable_cargar_PC);
E(6)<=(P(5) xor Enable_cargar_PC);
E(7)<=(P(6) xor Enable_cargar_PC);
E(8)<=(P(7) xor Enable_cargar_PC);
E(9)<=(P(8) xor Enable_cargar_PC);

--Definicion de las variables que componen el componete DFFE que son los Flip-Flop tipo D--
dato0: dffe port map(D(0), clk, '1', '1', E(0), Q(0));
dato1: dffe port map(D(1), clk, '1', '1', E(1), Q(1));
dato2: dffe port map(D(2), clk, '1', '1', E(2), Q(2));
dato3: dffe port map(D(3), clk, '1', '1', E(3), Q(3));
dato4: dffe port map(D(4), clk, '1', '1', E(4), Q(4));
dato5: dffe port map(D(5), clk, '1', '1', E(5), Q(5));
dato6: dffe port map(D(6), clk, '1', '1', E(6), Q(6));
dato7: dffe port map(D(7), clk, '1', '1', E(7), Q(7));
dato8: dffe port map(D(8), clk, '1', '1', E(8), Q(8));
dato9: dffe port map(D(9), clk, '1', '1', E(9), Q(9));

--La señal de salida "SALIDA" toma los valores que tiene la variable interna "Q"--
SALIDA<= Q; 

end Program_CounterArch;
--***********************************************************--