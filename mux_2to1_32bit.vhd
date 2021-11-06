-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 4
-- Percobaan : TP 1
-- Tanggal : 3 November 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : mux_2to1_32bit.vhd
-- Deskripsi : Implementasi 2 to 1 multiplexer

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY mux_2to1_32bit IS
	PORT (
			D1 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1
			D2 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
			Y : OUT std_logic_vector (31 DOWNTO 0); -- Selected Data
			S : IN std_logic -- Selector
		);
END ENTITY;

ARCHITECTURE behavior OF mux_2to1_32bit IS
	BEGIN
			WITH S SELECT
				 Y <=  D1 WHEN '0',
					   D2 WHEN '1',
					   (OTHERS => '0') WHEN OTHERS;

	END behavior;
