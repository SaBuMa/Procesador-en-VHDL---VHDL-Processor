--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque se encarga de manejar las posiciones de momeria reservadas para guardar el Program Counter cuando en el programa salta a una subrutina o tiene una interrupcion--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity Stack is
port(
        clk: in std_logic;		  
		  Cont_up: in std_logic;
		  Cont_down: in std_logic;
        SALIDA: out std_logic_vector(9 downto 0)
);
end entity Stack;

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--
architecture StackArch of Stack is

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--
Component dffe
port(d, clk, clrn, prn, ena:in std_logic; q: out std_logic);
end component;


signal D, Q, E, Aux1, Aux2  :std_logic_vector (9 downto 0);
signal up, down :std_logic;

--***********************************************************--
--DECLARACION LOGICA							   						  --
--***********************************************************--
begin

--Las variables internas de "up" y "down" toma las variables que entran a este bloque siendo "Cont_up" y "Cont_down" respectivamente--
up<=Cont_up;
down<=Cont_down;

--La variable interna "D" toma la salida que esta en la variable "Q"--
D(0)<= not Q(0);
D(1)<= not Q(1);
D(2)<= not Q(2);
D(3)<= not Q(3);
D(4)<= not Q(4);
D(5)<= not Q(5);
D(6)<= not Q(6);
D(7)<= not Q(7);
D(8)<= not Q(8);
D(9)<= not Q(9);

--La variable interna "Aux1" se encarga de realizar la logica combinatoria para habilitar los "enable" de los registros y asi poder contar de forma ascendente--
Aux1(0)<=(Q(0) and up);
Aux1(1)<=(Aux1(0) and Q(1));
Aux1(2)<=(Aux1(1) and Q(2));
Aux1(3)<=(Aux1(2) and Q(3));
Aux1(4)<=(Aux1(3) and Q(4));
Aux1(5)<=(Aux1(4) and Q(5));
Aux1(6)<=(Aux1(5) and Q(6));
Aux1(7)<=(Aux1(6) and Q(7));
Aux1(8)<=(Aux1(7) and Q(8));
Aux1(9)<=(Aux1(8) and Q(9));

--La variable interna "Aux2" se encarga de realizar la logica combinatoria para habilitar los "enable" de los registros y asi poder contar de forma Descendente--
Aux2(0)<=(not Q(0) and Down);
Aux2(1)<=(Aux2(0) and (not Q(1)));
Aux2(2)<=(Aux2(1) and (not Q(2)));
Aux2(3)<=(Aux2(2) and (not Q(3)));
Aux2(4)<=(Aux2(3) and (not Q(4)));
Aux2(5)<=(Aux2(4) and (not Q(5)));
Aux2(6)<=(Aux2(5) and (not Q(6)));
Aux2(7)<=(Aux2(6) and (not Q(7)));
Aux2(8)<=(Aux2(7) and (not Q(8)));
Aux2(9)<=(Aux2(8) and (not Q(9)));

--La variable "E" se encarga de hacer la logica combinatoria y asi escoger entre contar de forma ascdendente o de forma descendente dependiendo de la señal de entrada--
E(0)<= (up xor down);
E(1)<= (Aux1(0) xor Aux2(0));
E(2)<= (Aux1(1) xor Aux2(1));
E(3)<= (Aux1(2) xor Aux2(2));
E(4)<= (Aux1(3) xor Aux2(3));
E(5)<= (Aux1(4) xor Aux2(4));
E(6)<= (Aux1(5) xor Aux2(5));
E(7)<= (Aux1(6) xor Aux2(6));
E(8)<= (Aux1(7) xor Aux2(7));
E(9)<= (Aux1(8) xor Aux2(8));

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

--La variable de salida "SALIDA" toma los valores guardados en la variable interna "Q"--
SALIDA<= Q; 

end Stackarch;
--***********************************************************--