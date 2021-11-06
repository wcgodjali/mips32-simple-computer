-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 4
-- Percobaan : 1
-- Tanggal : 3 November 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : cla32.vhd
-- Deskripsi : Implementasi Carry-Lookahead Adder 32 bit
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;
ENTITY cla_32 IS
	PORT (
		OPRND_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operand 1
		OPRND_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Operand 2
		C_IN : IN STD_LOGIC; -- Carry In
		RESULT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- Result
		C_OUT : OUT STD_LOGIC -- Overflow
	);
END cla_32;

ARCHITECTURE behavior OF cla_32 IS
	SIGNAL C_1 : STD_LOGIC;
	SIGNAL C_2 : STD_LOGIC;
	SIGNAL C_3 : STD_LOGIC;
	SIGNAL C_4 : STD_LOGIC;
	SIGNAL C_5 : STD_LOGIC;
	SIGNAL C_6 : STD_LOGIC;
	SIGNAL C_7 : STD_LOGIC;
	SIGNAL C_8 : STD_LOGIC;
	SIGNAL C_9 : STD_LOGIC;
	SIGNAL C_10 : STD_LOGIC;
	SIGNAL C_11 : STD_LOGIC;
	SIGNAL C_12 : STD_LOGIC;
	SIGNAL C_13 : STD_LOGIC;
	SIGNAL C_14 : STD_LOGIC;
	SIGNAL C_15 : STD_LOGIC;
	SIGNAL C_16 : STD_LOGIC;
	SIGNAL C_17 : STD_LOGIC;
	SIGNAL C_18 : STD_LOGIC;
	SIGNAL C_19 : STD_LOGIC;
	SIGNAL C_20 : STD_LOGIC;
	SIGNAL C_21 : STD_LOGIC;
	SIGNAL C_22 : STD_LOGIC;
	SIGNAL C_23 : STD_LOGIC;
	SIGNAL C_24 : STD_LOGIC;
	SIGNAL C_25 : STD_LOGIC;
	SIGNAL C_26 : STD_LOGIC;
	SIGNAL C_27 : STD_LOGIC;
	SIGNAL C_28 : STD_LOGIC;
	SIGNAL C_29 : STD_LOGIC;
	SIGNAL C_30 : STD_LOGIC;
	SIGNAL C_31 : STD_LOGIC;
BEGIN
	C_1 <= ( OPRND_1(0) and OPRND_2(0) ) or ( (OPRND_1(0) xor OPRND_2(0)) and C_IN );
	C_2 <= ( OPRND_1(1) and OPRND_2(1) ) or ( (OPRND_1(1) xor OPRND_2(1)) and C_1 );
	C_3 <= ( OPRND_1(2) and OPRND_2(2) ) or ( (OPRND_1(2) xor OPRND_2(2)) and C_2 );
	C_4 <= ( OPRND_1(3) and OPRND_2(3) ) or ( (OPRND_1(3) xor OPRND_2(3)) and C_3 );
	C_5 <= ( OPRND_1(4) and OPRND_2(4) ) or ( (OPRND_1(4) xor OPRND_2(4)) and C_4 );
	C_6 <= ( OPRND_1(5) and OPRND_2(5) ) or ( (OPRND_1(5) xor OPRND_2(5)) and C_5 );
	C_7 <= ( OPRND_1(6) and OPRND_2(6) ) or ( (OPRND_1(6) xor OPRND_2(6)) and C_6 );
	C_8 <= ( OPRND_1(7) and OPRND_2(7) ) or ( (OPRND_1(7) xor OPRND_2(7)) and C_7 );
	C_9 <= ( OPRND_1(8) and OPRND_2(8) ) or ( (OPRND_1(8) xor OPRND_2(8)) and C_8 );
	C_10 <= ( OPRND_1(9) and OPRND_2(9) ) or ( (OPRND_1(9) xor OPRND_2(9)) and C_9 );
	C_11 <= ( OPRND_1(10) and OPRND_2(10) ) or ( (OPRND_1(10) xor OPRND_2(10)) and C_10 );
	C_12 <= ( OPRND_1(11) and OPRND_2(11) ) or ( (OPRND_1(11) xor OPRND_2(11)) and C_11 );
	C_13 <= ( OPRND_1(12) and OPRND_2(12) ) or ( (OPRND_1(12) xor OPRND_2(12)) and C_12 );
	C_14 <= ( OPRND_1(13) and OPRND_2(13) ) or ( (OPRND_1(13) xor OPRND_2(13)) and C_13 );
	C_15 <= ( OPRND_1(14) and OPRND_2(14) ) or ( (OPRND_1(14) xor OPRND_2(14)) and C_14 );
	C_16 <= ( OPRND_1(15) and OPRND_2(15) ) or ( (OPRND_1(15) xor OPRND_2(15)) and C_15 );
	C_17 <= ( OPRND_1(16) and OPRND_2(16) ) or ( (OPRND_1(16) xor OPRND_2(16)) and C_16 );
	C_18 <= ( OPRND_1(17) and OPRND_2(17) ) or ( (OPRND_1(17) xor OPRND_2(17)) and C_17 );
	C_19 <= ( OPRND_1(18) and OPRND_2(18) ) or ( (OPRND_1(18) xor OPRND_2(18)) and C_18 );
	C_20 <= ( OPRND_1(19) and OPRND_2(19) ) or ( (OPRND_1(19) xor OPRND_2(19)) and C_19 );
	C_21 <= ( OPRND_1(20) and OPRND_2(20) ) or ( (OPRND_1(20) xor OPRND_2(20)) and C_20 );
	C_22 <= ( OPRND_1(21) and OPRND_2(21) ) or ( (OPRND_1(21) xor OPRND_2(21)) and C_21 );
	C_23 <= ( OPRND_1(22) and OPRND_2(22) ) or ( (OPRND_1(22) xor OPRND_2(22)) and C_22 );
	C_24 <= ( OPRND_1(23) and OPRND_2(23) ) or ( (OPRND_1(23) xor OPRND_2(23)) and C_23 );
	C_25 <= ( OPRND_1(24) and OPRND_2(24) ) or ( (OPRND_1(24) xor OPRND_2(24)) and C_24 );
	C_26 <= ( OPRND_1(25) and OPRND_2(25) ) or ( (OPRND_1(25) xor OPRND_2(25)) and C_25 );
	C_27 <= ( OPRND_1(26) and OPRND_2(26) ) or ( (OPRND_1(26) xor OPRND_2(26)) and C_26 );
	C_28 <= ( OPRND_1(27) and OPRND_2(27) ) or ( (OPRND_1(27) xor OPRND_2(27)) and C_27 );
	C_29 <= ( OPRND_1(28) and OPRND_2(28) ) or ( (OPRND_1(28) xor OPRND_2(28)) and C_28 );
	C_30 <= ( OPRND_1(29) and OPRND_2(29) ) or ( (OPRND_1(29) xor OPRND_2(29)) and C_29 );
	C_31 <= ( OPRND_1(30) and OPRND_2(30) ) or ( (OPRND_1(30) xor OPRND_2(30)) and C_30 );
	C_OUT <= ( OPRND_1(31) and OPRND_2(31) ) or ( (OPRND_1(31) xor OPRND_2(31)) and C_31 );
	RESULT(0) <= OPRND_1(0) xor OPRND_2(0) xor C_IN ;
	RESULT(1) <= OPRND_1(1) xor OPRND_2(1) xor C_1 ;
	RESULT(2) <= OPRND_1(2) xor OPRND_2(2) xor C_2 ;
	RESULT(3) <= OPRND_1(3) xor OPRND_2(3) xor C_3 ;
	RESULT(4) <= OPRND_1(4) xor OPRND_2(4) xor C_4 ;
	RESULT(5) <= OPRND_1(5) xor OPRND_2(5) xor C_5 ;
	RESULT(6) <= OPRND_1(6) xor OPRND_2(6) xor C_6 ;
	RESULT(7) <= OPRND_1(7) xor OPRND_2(7) xor C_7 ;
	RESULT(8) <= OPRND_1(8) xor OPRND_2(8) xor C_8 ;
	RESULT(9) <= OPRND_1(9) xor OPRND_2(9) xor C_9 ;
	RESULT(10) <= OPRND_1(10) xor OPRND_2(10) xor C_10 ;
	RESULT(11) <= OPRND_1(11) xor OPRND_2(11) xor C_11 ;
	RESULT(12) <= OPRND_1(12) xor OPRND_2(12) xor C_12 ;
	RESULT(13) <= OPRND_1(13) xor OPRND_2(13) xor C_13 ;
	RESULT(14) <= OPRND_1(14) xor OPRND_2(14) xor C_14 ;
	RESULT(15) <= OPRND_1(15) xor OPRND_2(15) xor C_15 ;
	RESULT(16) <= OPRND_1(16) xor OPRND_2(16) xor C_16 ;
	RESULT(17) <= OPRND_1(17) xor OPRND_2(17) xor C_17 ;
	RESULT(18) <= OPRND_1(18) xor OPRND_2(18) xor C_18 ;
	RESULT(19) <= OPRND_1(19) xor OPRND_2(19) xor C_19 ;
	RESULT(20) <= OPRND_1(20) xor OPRND_2(20) xor C_20 ;
	RESULT(21) <= OPRND_1(21) xor OPRND_2(21) xor C_21 ;
	RESULT(22) <= OPRND_1(22) xor OPRND_2(22) xor C_22 ;
	RESULT(23) <= OPRND_1(23) xor OPRND_2(23) xor C_23 ;
	RESULT(24) <= OPRND_1(24) xor OPRND_2(24) xor C_24 ;
	RESULT(25) <= OPRND_1(25) xor OPRND_2(25) xor C_25 ;
	RESULT(26) <= OPRND_1(26) xor OPRND_2(26) xor C_26 ;
	RESULT(27) <= OPRND_1(27) xor OPRND_2(27) xor C_27 ;
	RESULT(28) <= OPRND_1(28) xor OPRND_2(28) xor C_28 ;
	RESULT(29) <= OPRND_1(29) xor OPRND_2(29) xor C_29 ;
	RESULT(30) <= OPRND_1(30) xor OPRND_2(30) xor C_30 ;
	RESULT(31) <= OPRND_1(31) xor OPRND_2(31) xor C_31 ;
END behavior;

