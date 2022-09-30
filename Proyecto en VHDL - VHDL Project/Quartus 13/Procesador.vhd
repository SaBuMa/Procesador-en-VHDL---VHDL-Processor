--***********************************************************--
--        	PONTIFICIA UNIVERSIDAD JAVERIANA	             	 --
--        		ORGANIZACIÓN DE COMPUTADORES 	                --
--                   													 --
-- Nombres: Santiago Burgos, Camila Moya, Dayanna Méndez     --
-- Título: Proyecto Final: Procesador								 --
-- Fecha: 02/12/2020                 								 --
--                                                           --
--***********************************************************--

--Este bloque es en donde se unen y se conectan todos los bloques funcionales dentro del procesador--

--***********************************************************--
--DEFINICIÓN DE LAS LIBRERÍAS 
--***********************************************************--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 

--***********************************************************--
--DEFINICION DE LAS ENTRADAS Y SALIDAS
--***********************************************************--
entity Procesador is 
port(
		Enable										: in std_logic;
		Reset											: in std_logic;
		clk											: in std_logic;
		Interrupt									: in std_logic;
		salida_estado								: out std_logic_vector (44 downto 0);
		OP												: out std_logic_vector (3 downto 0);
		salida_ram									: out std_logic_vector(15 downto 0);
		entrada_ram									: out std_logic_vector(15 downto 0);
		salida_reg_instrucciones 				: out std_logic_vector(9 downto 0);
		direccion_pc								: out std_logic_vector(9 downto 0);
		Enables 										: out std_logic_vector(12 downto 0);
		salida_reg_dato							: out std_logic_vector(15 downto 0);
		salida_banderas							: out std_logic_vector(3 downto 0)
		
);
end entity Procesador; 

--***********************************************************--
--DEFINICIÓN DE ARQUITECTURA                        		    --
--***********************************************************--
architecture ProcesadorArch of Procesador is

--***********************************************************--
--DEFINICIÓN DE CADA BLOQUE DEL PROCESADOR  		                   --
--***********************************************************--
component ALU is 
port(
		A												: in std_logic_vector(15 downto 0);
		B												: in std_logic_vector(15 downto 0);
		OP												: in std_logic_vector(3 downto 0);
		Overflow										: out std_logic;
		Zero											: out std_logic;
		Negativo 									: out std_logic;
		Carry_out									: out std_logic;
		Salida										: out std_logic_vector(15 downto 0)
);
end component; 

component Stack is
port(
        clk											:in std_logic;
		  Cont_up									:in std_logic;
		  Cont_down									:in std_logic;
        SALIDA										:out std_logic_vector(9 downto 0)
);
end component Stack;

component Program_Counter is
port(
        clk											: in std_logic;
		  Enable_PC									: in std_logic;
		  Enable_cargar_PC						: in std_logic;
		  NUM											: in std_logic_vector(9 downto 0);
        SALIDA										: out std_logic_vector(9 downto 0)
);
end component Program_Counter;

component Registro_datos is
port(
		data_in										: in std_logic_vector(15 downto 0);
		Enable										: in std_logic;
		Reset											: in std_logic;
		clk 											: in std_logic;
		data_out										: out std_logic_vector(15 downto 0)
	  );
end component Registro_datos;              

component Registro_instrucciones is
port(
		data_in										: in std_logic_vector(15 downto 0);
		Enable										: in std_logic;
		Reset											: in std_logic;
		clk 											: in std_logic;
		Opcode										: out std_logic_vector(3 downto 0);
		Modo											: out std_logic_vector(1 downto 0);
		data_out										: out std_logic_vector(9 downto 0)
	  );
end component Registro_instrucciones;

component Selector_dato_01 is 
port(		
		Selector										: in  std_logic_vector(1 downto 0);
		Dato_OUT_Memoria							: in std_logic_vector(15 downto 0);
		Dato_OUT_ALU								: in std_logic_vector(15 downto 0);
		Dato_OUT_Reg_Inst							: in std_logic_vector(9 downto 0);
		Salida_Sel_dato_01						: out std_logic_vector(15 downto 0)
);
end component Selector_dato_01; 


component Selector_dato_02 is 
port(		
		Selector										: in std_logic;
		Dato_OUT_Reg_Datos						: in std_logic_vector(15 downto 0);
		Dato_OUT_PC									: in std_logic_vector(9 downto 0);
		Salida_Sel_dato_02						: out std_logic_vector(15 downto 0)
);
end component Selector_dato_02;

component Selector_direccion is 
port(		
		Selector										: in  std_logic_vector(1 downto 0);
		Dato_OUT_SP									: in std_logic_vector(9 downto 0);
		Dato_OUT_PC									: in std_logic_vector(9 downto 0);
		Dato_OUT_Reg_Inst							: in std_logic_vector(9 downto 0);
		Dato_OUT_Reg_Dato_B_02					: in std_logic_vector(9 downto 0);
		Salida_sel_direccion						: out std_logic_vector(9 downto 0)
);
end component Selector_direccion; 

component Registro_PC_dir is
port(
		data_in										: in std_logic_vector(9 downto 0);
		Enable										: in std_logic;
		Reset											: in std_logic;
		clk 											: in std_logic;
		data_out										: out std_logic_vector(9 downto 0)
);
end component Registro_PC_dir;              

component Registro_bandera is
port(
		Enable										: in std_logic;
		Reset											: in std_logic;
		clk 											: in std_logic;
		Overflow										: in std_logic;
		Zero											: in std_logic;
		Negativo										: in std_logic;
		Carry_out									: in std_logic;
		data_out										: out std_logic_vector(3 downto 0)
	  );
end component Registro_bandera;              

component Control is 
port(
		clk 											: in std_logic;    
		Reset         								: in std_logic;
		Enable        								: in std_logic;
		Interrupt									: in std_logic;
		Reg_Inst_OPcode							: in std_logic_vector(3 downto 0);
		Reg_Inst_Modo								: in std_logic_vector(1 downto 0);
		Banderas      								: in std_logic_vector(3 downto 0);
		ALU_Opcode									: out std_logic_vector(3 downto 0);
		Enable_Reg_Inst		 					: out std_logic;
		Enable_Reg_Datos							: out std_logic;
		Enable_Reg_Dato_B		 					: out std_logic;
		Enable_PC 									: out std_logic;
		Enable_cargar_PC							: out std_logic;
		Count_up 									: out std_logic;
		Count_down 									: out std_logic;
		Enable_Reg_PC_dir 						: out std_logic;
		Enable_Reg_Band 							: out std_logic;
		Selector_direccion 						: out std_logic_vector(1 downto 0);
		Selector_dato_01 							: out std_logic_vector(1 downto 0);
		Selector_dato_02 							: out std_logic;
		Selector_dato_B 							: out std_logic;
		Ren           								: out std_logic;
		Wen           								: out std_logic;
		prueba_estado								: out std_logic_vector (44 downto 0)
		
);
end component Control; 

component RAM is
port(
		address										: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		clock											: IN STD_LOGIC ;
		data											: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rden											: IN STD_LOGIC ;
		wren											: IN STD_LOGIC ;
		q												: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
);
end component RAM;

component Registro_Dato_B is
port(
		data_in										: in std_logic_vector(15 downto 0);
		Enable										: in std_logic;
		Reset											: in std_logic;
		clk 											: in std_logic;
		data_out_02									: out std_logic_vector(9 downto 0);
		data_out										: out std_logic_vector(15 downto 0)
	  );
end component Registro_Dato_B;


component Selector_dato_B is 
port(		
		Selector										: in 	std_logic;
		Dato_OUT_Memoria							: in std_logic_vector(15 downto 0);
		Dato_OUT_Reg_Inst							: in std_logic_vector(9 downto 0);
		Salida_Sel_dato_B							: out std_logic_vector(15 downto 0)
);
end component Selector_dato_B;

--***********************************************************--
--DEFINICIÓN DE SEÑALES DE CONEXIÓN  		                   --
--***********************************************************--
--Declaración de señales de la ALU
signal Zero_signal								: std_logic;
signal Overflow_signal							: std_logic;
signal Negativo_signal							: std_logic;
signal Carry_out_sumador_signal				: std_logic;
Signal Dato_OUT_ALU_signal 					: std_logic_vector (15 downto 0);
signal ALU_Opcode_signal						: std_logic_vector (3 downto 0);

--Del registro de instrucciones 
signal Enable_Reg_Inst_signal 				: std_logic; 
signal Opcode_signal 							: std_logic_vector (3 downto 0); 
signal Modo_signal 								: std_logic_vector (1 downto 0);
signal Dato_OUT_Reg_Inst_signal				: std_logic_vector (9 downto 0);
		
--Del registro de datos 
signal Enable_Reg_Datos_signal 				: std_logic;
signal Dato_OUT_Reg_Datos_signal				: std_logic_vector (15 downto 0);

--Del registro Dato B 
signal Enable_Reg_Dato_B_signal 				: std_logic; 
signal Dato_OUT_Reg_Dato_B_02_signal		: std_logic_vector (9 downto 0);
signal Dato_OUT_Reg_Dato_B_signal			: std_logic_vector (15 downto 0);

--Del Program Counter
signal Enable_PC_signal 						: std_logic;
signal Enable_cargar_PC_signal 				: std_logic;
signal Salida_PC_signal 						: std_logic_vector(9 downto 0);

--Del Stack Pointer 
signal Count_up_signal 							: std_logic;
signal Count_down_signal 						: std_logic;
signal Salida_Stack_signal 					: std_logic_vector(9 downto 0);

--Del registro PC_dir
signal Enable_Reg_PC_dir_signal 				: std_logic;
	
--Del Registro de banderas
signal Enable_Reg_Band_signal					: std_logic;
signal Salida_Reg_Band_Signal    			: std_logic_vector (3 downto 0);

--Del selector direccion
signal Selector_direccion_signal 			: std_logic_vector (1 downto 0);
signal Salida_Selector_direccion_signal 	: std_logic_vector(9 downto 0);

--Del Selector Selector_dato_01
signal Selector_dato_01_signal 				: std_logic_vector (1 downto 0);
signal Salida_Sel_dato_01_signal 			: std_logic_vector (15 downto 0);

--Del selector Selector_dato_02
signal Selector_dato_02_signal   			: std_logic;

--Del selector Selector_dato_B
signal Selector_dato_B_signal    			: std_logic;
signal Salida_Sel_dato_B_signal				: std_logic_vector (15 downto 0);

--De la RAM
signal Ren_signal   								: std_logic;
signal Wen_signal  								: std_logic;
signal Direccion_Memoria_signal				: std_logic_vector (9 downto 0);
signal Dato_IN_Memoria_signal					: std_logic_vector (15 downto 0);
signal Dato_OUT_Memoria_signal				: std_logic_vector (15 downto 0);

--Del control
signal Estado_signal								: std_logic_vector (44 downto 0);


--***********************************************************--
--CONEXIÓN DE ENTRADAS Y SALIDAS
--***********************************************************--
begin

salida_ram<= Dato_OUT_Memoria_signal;
entrada_ram<=Dato_IN_Memoria_signal;
direccion_pc<=Direccion_Memoria_signal;
salida_estado<=Estado_signal;
OP <= Opcode_signal;
salida_reg_instrucciones<=Dato_OUT_Reg_Inst_signal;
salida_reg_dato<=Dato_OUT_Reg_Datos_signal;

Enables(0)<=Enable_Reg_Inst_signal;
Enables(1)<=Enable_Reg_Datos_signal;
Enables(2)<=Enable_Reg_Dato_B_signal;
Enables(3)<=Enable_PC_signal;
Enables(4)<=Enable_cargar_PC_signal;
Enables(5)<=Count_up_signal;
Enables(6)<=Count_down_signal;
Enables(7)<=Enable_Reg_PC_dir_signal;
Enables(8)<=Enable_Reg_Band_signal;
Enables(9)<=Selector_dato_02_signal;
Enables(10)<=Selector_dato_B_signal;
Enables(11)<=Ren_signal;
Enables(12)<=Wen_signal;

salida_banderas<=Salida_Reg_Band_Signal;


ALU_portmap: ALU port map(Dato_OUT_Reg_Datos_signal,Dato_OUT_Reg_Dato_B_signal,ALU_Opcode_signal,Overflow_signal,Zero_signal,Negativo_signal,Carry_out_sumador_signal,Dato_OUT_ALU_signal);

Registro_instrucciones_portmap: Registro_instrucciones port map (Dato_OUT_Memoria_signal,Enable_Reg_Inst_signal,Reset,clk,Opcode_signal,Modo_signal,Dato_OUT_Reg_Inst_signal);

Registro_datos_portmap: Registro_datos port map (Salida_Sel_dato_01_signal,Enable_Reg_Datos_signal,Reset,clk,Dato_OUT_Reg_Datos_signal);

Registro_dato_B_portmap: Registro_dato_B port map (Salida_Sel_dato_B_signal,Enable_Reg_Dato_B_signal,Reset,clk,Dato_OUT_Reg_Dato_B_02_signal,Dato_OUT_Reg_Dato_B_signal);

Program_Counter_portmap: Program_Counter port map (clk,Enable_PC_signal,Enable_cargar_PC_signal,Dato_OUT_Reg_Inst_signal,Salida_PC_signal);

Stack_portmap: Stack port map (clk,Count_up_signal,Count_down_signal,Salida_Stack_signal);

Registro_PC_dir_portmap: Registro_PC_dir port map (Salida_Selector_direccion_signal,Enable_Reg_PC_dir_signal,Reset,clk,Direccion_Memoria_signal);

Registro_bandera_portmap: Registro_bandera port map (Enable_Reg_Band_signal,Reset,clk,Overflow_signal,Zero_signal,Negativo_signal,Carry_out_sumador_signal,Salida_Reg_Band_Signal);

Selector_direccion_portmap: Selector_direccion port map (Selector_direccion_signal,Salida_Stack_signal,Salida_PC_signal,Dato_OUT_Reg_Inst_signal,Dato_OUT_Reg_Dato_B_02_signal,Salida_Selector_direccion_signal);

Selector_dato_01_portmap: Selector_dato_01 port map (Selector_dato_01_signal,Dato_OUT_Memoria_signal,Dato_OUT_ALU_signal,Dato_OUT_Reg_Inst_signal,Salida_Sel_dato_01_signal);

Selector_dato_02_portmap: Selector_dato_02 port map (Selector_dato_02_signal,Dato_OUT_Reg_Datos_signal,Salida_PC_signal,Dato_IN_Memoria_signal);

Selector_dato_B_portmap: Selector_dato_B port map (Selector_dato_B_signal,Dato_OUT_Memoria_signal,Dato_OUT_Reg_Inst_signal,Salida_Sel_dato_B_signal);

RAM_portmap: RAM port map(Direccion_Memoria_signal,clk,Dato_IN_Memoria_signal,Ren_signal,Wen_signal,Dato_OUT_Memoria_signal);

Control_portmap: Control port map (clk,Reset,Enable,Interrupt,Opcode_signal,Modo_signal,Salida_Reg_Band_Signal,ALU_Opcode_signal,Enable_Reg_Inst_signal,Enable_Reg_Datos_signal,Enable_Reg_Dato_B_signal,Enable_PC_signal,Enable_cargar_PC_signal,Count_up_signal,Count_down_signal,Enable_Reg_PC_dir_signal,Enable_Reg_Band_signal,Selector_direccion_signal,Selector_dato_01_signal,Selector_dato_02_signal,Selector_dato_B_signal,Ren_signal,Wen_signal,Estado_signal);

end ProcesadorArch;
--***********************************************************--