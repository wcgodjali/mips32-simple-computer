-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 4
-- Percobaan : 5
-- Tanggal : 3 November 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : inverter.vhd
-- Deskripsi : Implementasi inverter

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY inverter IS
	PORT (
		neu : IN std_logic_vector (31 DOWNTO 0); 
		inv : OUT std_logic_vector (31 DOWNTO 0)
	);
END inverter;

ARCHITECTURE behavior OF inverter IS
	BEGIN
		inv <= NOT(neu);
	END behavior;