-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 4
-- Percobaan : TP 4
-- Tanggal : 3 November 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : tugas4.vhd
-- Deskripsi : Implementasi kompartor

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY bus_merger IS
	PORT (
			DATA_IN1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			DATA_IN2 : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
			DATA_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
END bus_merger;

ARCHITECTURE behavior OF bus_merger IS
	BEGIN
		DATA_OUT <= DATA_IN1 & DATA_IN2;
	END behavior;
