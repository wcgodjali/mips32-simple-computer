-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 3
-- Percobaan : 1
-- Tanggal : 23 Oktober 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : instrucMEM.vhd
-- Deskripsi : Implementasi instruction memory
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY sign_extender IS
	PORT (
		D_In :IN std_logic_vector (15 DOWNTO 0); -- Data Input 1
		D_Out :OUT std_logic_vector (31 DOWNTO 0) -- Data Input 2
	);
END sign_extender;

ARCHITECTURE behavior OF sign_extender IS
BEGIN
	PROCESS(D_In)
	BEGIN 
		IF (D_In(15) = '0') THEN
			D_Out (15 downto 0) <= D_In;
			D_Out (31 downto 16) <= (OTHERS => '0');
		ELSIF(D_In(15) = '1') THEN
			D_Out (15 downto 0) <= D_In;
			D_Out (31 downto 16) <= (OTHERS => '1');
		END IF;
	END PROCESS;
END behavior;
