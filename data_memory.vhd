-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 3
-- Percobaan : 1
-- Tanggal : 18 November 2013
-- Kelompok : VI
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : data_memory.vhd

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY data_memory IS
	PORT (
			ADDR : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- alamat
			WR_EN : IN STD_LOGIC; --Indikator Penulisan
			RD_EN : IN STD_LOGIC; --Indikator Pembacaan
			clock : IN STD_LOGIC ; -- clock
			RD_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			WR_Data : IN STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE structural OF data_memory IS

COMPONENT altsyncram
-- komponen memori
	GENERIC
	(
		init_file : STRING; -- name of the .mif file
		operation_mode : STRING; -- the operation mode
		widthad_a : NATURAL; -- width of address_a[]
		width_a : NATURAL -- width of data_a[]
	);
PORT
	(
		wren_a : IN STD_LOGIC; -- Write Enable Activation
		rden_a : IN STD_LOGIC; -- Read Enable Activation
		clock0 : IN STD_LOGIC; -- Clock
		address_a : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- Address Input
		q_a : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- Data Output
		data_a : IN STD_LOGIC_VECTOR (31 DOWNTO 0) -- Data Input
	);
END COMPONENT;
BEGIN	
	altsyncram_component : altsyncram
	GENERIC MAP
	(
		init_file => "dmemory.mif",
		operation_mode => "SINGLE_PORT",
		widthad_a => 8,
		width_a => 32
	)
	PORT MAP
	(
		wren_a => WR_EN, 
		rden_a => RD_EN, 
		clock0 => clock,
		address_a => ADDR,
		q_a => RD_Data, 
		data_a => WR_Data
	);
END structural;

