-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 5
-- Percobaan : 5
-- Tanggal : 13 November 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : combinational.vhd
-- Deskripsi : Implementasi rangkaian kombinasional

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY combinational IS
	PORT (
		IN_1 : IN std_logic; 
		IN_2 : IN std_logic;
		IN_3 : IN std_logic; 
		OUT_1 :OUT std_logic
	);
END combinational;

ARCHITECTURE behavior OF combinational IS
	BEGIN
		OUT_1 <= (NOT(IN_1) AND IN_2) OR (IN_3 AND IN_1);
	END behavior;