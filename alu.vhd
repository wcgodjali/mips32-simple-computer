-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 4
-- Percobaan : 5
-- Tanggal : 3 November 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : alu.vhd
-- Deskripsi : Implementasi ALU
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY ALU IS
	PORT (
		OPRND_A : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1
		OPRND_B : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
		OP_SEL : IN std_logic ; -- Operation Select
		RESULT : OUT std_logic_vector (31 DOWNTO 0) -- Data Output
	);
END ALU;

ARCHITECTURE behavior OF ALU IS 
	COMPONENT cla_32 IS 
	PORT (
		OPRND_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operand 1
		OPRND_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Operand 2
		C_IN : IN STD_LOGIC; -- Carry In
		RESULT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- Result
		C_OUT : OUT STD_LOGIC -- Overflow
	);
	END COMPONENT;
	
	COMPONENT mux_2to1_32bit IS
	PORT (
			D1 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1
			D2 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
			Y : OUT std_logic_vector (31 DOWNTO 0); -- Selected Data
			S : IN std_logic -- Selector
		);
	END COMPONENT;
	
	COMPONENT inverter IS
	PORT (
		neu : IN std_logic_vector (31 DOWNTO 0); 
		inv : OUT std_logic_vector (31 DOWNTO 0) 
	);
	END COMPONENT;
	
	SIGNAL SIG_1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL SIG_2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL OUTPUT : std_logic_vector (31 DOWNTO 0);
	 
BEGIN
	inverter_0		 :	inverter
						PORT MAP
						(
							neu => OPRND_B, inv => SIG_1
						);
						
	mux_2to1_32_0	 : mux_2to1_32bit
					   PORT MAP
					   (
						  D1 => OPRND_B, D2 => SIG_1, Y => SIG_2, S=> OP_SEL
					   );
	
	cla_32_0		: cla_32
					  PORT MAP
					  (
						OPRND_1 => OPRND_A, OPRND_2 => SIG_2, C_IN=> OP_SEL, RESULT => OUTPUT
						);
	RESULT <= OUTPUT;
	
END behavior;
	
	