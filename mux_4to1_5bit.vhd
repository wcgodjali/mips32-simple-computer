-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 4
-- Percobaan : TP 3
-- Tanggal : 3 November 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : tugas3.vhd
-- Deskripsi : Implementasi 4 to 1 multiplexer lecar data 5 bit

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY mux_4to1_5bit IS
	PORT (
		D1 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 1
		D2 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 2
		D3 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 3
		D4 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 4
		Y : OUT std_logic_vector (4 DOWNTO 0); -- Selected Data
		S : IN std_logic_vector (1 DOWNTO 0) -- Selector
	);
END mux_4to1_5bit;

ARCHITECTURE behavior OF mux_4to1_5bit IS
	BEGIN
			WITH S SELECT
				 Y <=  D1 WHEN "00",
					   D2 WHEN "01",
					   D3 WHEN "10",
					   D4 WHEN "11",
					   (OTHERS => '0') WHEN OTHERS;
	END behavior;
