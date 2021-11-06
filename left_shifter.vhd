-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 4
-- Percobaan : 2
-- Tanggal : 3 November 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : left_shifter.vhd
-- Deskripsi : Implementasi left shifter dua kali
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY lshift_32_32 IS
	PORT (
	D_IN : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Input 32-bit;
	D_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- Output 32-bit;
	);
END lshift_32_32;

ARCHITECTURE behavior OF lshift_32_32 IS
BEGIN
	D_OUT <= std_logic_vector(shift_left(unsigned(D_IN), 2));
END behavior;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY lshift_26_28 IS
	PORT (
	D_IN : IN STD_LOGIC_VECTOR (25 DOWNTO 0); -- Input 26-bit;
	D_OUT : OUT STD_LOGIC_VECTOR (27 DOWNTO 0) -- Output 28-bit;
	);
END lshift_26_28;

ARCHITECTURE behavior OF lshift_26_28 IS
BEGIN
	D_OUT(27 downto 2) <= std_logic_vector(shift_left(unsigned(D_IN), 2));
END behavior;