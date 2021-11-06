-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 3
-- Percobaan : 4
-- Tanggal : 23 Oktober 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : register.vhd
-- Deskripsi : Implementasi register

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY reg_file IS
	PORT (
		clock : IN STD_LOGIC; -- clock
		WR_EN : IN STD_LOGIC; -- write enable
		ADDR_1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- Input 1
		ADDR_2 : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- Input 2
		ADDR_3 : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- Input 3
		WR_Data_3 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);-- write data
		RD_Data_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);-- read data 1
		RD_Data_2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- read data 2
		);
END ENTITY;

ARCHITECTURE behavior OF reg_file IS 
TYPE ramtype IS ARRAY (31 DOWNTO 0) OF std_logic_vector (31 DOWNTO 0);
SIGNAL mem: ramtype;
	BEGIN
		PROCESS (clock, WR_EN)
		BEGIN
			IF ((WR_EN = '0') and (falling_edge(clock)))  THEN
					RD_Data_1 <= mem(to_integer(unsigned(ADDR_1)));
					RD_Data_2 <= mem(to_integer(unsigned(ADDR_2)));
			END IF;
			IF ((WR_EN = '1') and (rising_edge(clock))) THEN
				mem(to_integer(unsigned(ADDR_3))) <= WR_Data_3;	
			END IF;
		END PROCESS;
END behavior;