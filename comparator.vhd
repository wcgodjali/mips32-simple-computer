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

ENTITY comparator IS
	PORT (
		D_1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		D_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		EQ : OUT STD_LOGIC -- Hasil Perbandingan EQ
	);
END comparator;

ARCHITECTURE behavior OF comparator IS
	BEGIN
	PROCESS(D_1, D_2) IS
		BEGIN
			IF (D_1 = D_2) THEN
				EQ <= '1';
			ELSIF (D_1 /= D_2) THEN
				EQ <= '0';
			END IF;
	END PROCESS;
	END behavior;
