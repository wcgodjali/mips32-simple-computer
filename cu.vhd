-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 4
-- Percobaan : 6
-- Tanggal : 3 November 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : cu.vhd
-- Deskripsi : Implementasi CU
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY cu IS
	PORT (
		OP_In : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		FUNCT_In : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		Sig_Jmp : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_Bne : OUT STD_LOGIC;
		Sig_Branch : OUT STD_LOGIC;
		Sig_MemtoReg : OUT STD_LOGIC;
		Sig_MemRead : OUT STD_LOGIC;
		Sig_MemWrite : OUT STD_LOGIC;
		Sig_RegDest : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_RegWrite : OUT STD_LOGIC;
		Sig_ALUSrc : OUT STD_LOGIC_VECTOR (1 DOWNTO 0) ;
		Sig_ALUCtrl : OUT STD_LOGIC
	);
END cu;

ARCHITECTURE behavior OF cu IS
BEGIN
	PROCESS(OP_In, FUNCT_In)
	BEGIN
		IF (Op_In = "000000") and (FUNCT_In = "100000") THEN --ADD
			Sig_Jmp <= "00" ;
			Sig_Bne <= '0';
			Sig_Branch <= '0' ;
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegDest <= "01";
			Sig_RegWrite <= '1';
			Sig_ALUSrc <= "00";
			Sig_ALUCtrl <= '0';
		ELSIF (Op_In = "000000") and (FUNCT_In = "100010") THEN --SUB
			Sig_Jmp <= "00" ;
			Sig_Bne <= '0';
			Sig_Branch <= '0' ;
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegDest <= "01";
			Sig_RegWrite <= '1';
			Sig_ALUSrc <= "00";
			Sig_ALUCtrl <= '1';
		ELSIF (Op_In = "000100") THEN --BEQ
			Sig_Jmp <= "00" ;
			Sig_Bne <= '0';
			Sig_Branch <= '1' ;
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegWrite <= '0';
		ELSIF (Op_In = "000101")  THEN --BNE
			Sig_Jmp <= "00" ;
			Sig_Bne <= '1';
			Sig_Branch <= '0' ;
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegWrite <= '0';
		ELSIF (Op_In = "001000")  THEN --ADDI
			Sig_Jmp <= "00" ;
			Sig_Bne <= '0';
			Sig_Branch <= '0' ;
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegDest <= "00";
			Sig_RegWrite <= '1';
			Sig_ALUSrc <= "01";
			Sig_ALUCtrl <= '0';
		ELSIF (Op_In = "001001")  THEN --ADDI
			Sig_Jmp <= "00" ;
			Sig_Bne <= '0';
			Sig_Branch <= '0' ;
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegDest <= "00";
			Sig_RegWrite <= '1';
			Sig_ALUSrc <= "01";
			Sig_ALUCtrl <= '0';
		ELSIF (Op_In = "100011") THEN --LW
			Sig_Jmp <= "00" ;
			Sig_Bne <= '0';
			Sig_Branch <= '0' ;
			Sig_MemtoReg <= '1';
			Sig_MemRead <= '1';
			Sig_MemWrite <= '0';
			Sig_RegDest <= "00";
			Sig_RegWrite <= '1';
			Sig_ALUSrc <= "01";
			Sig_ALUCtrl <= '0';
		ELSIF (Op_In = "101011")  THEN --SW
			Sig_Jmp <= "00" ;
			Sig_Bne <= '0';
			Sig_Branch <= '0' ;
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '1';
			Sig_RegDest <= "00";
			Sig_RegWrite <= '0';
			Sig_ALUSrc <= "01";
			Sig_ALUCtrl <= '0';
		ELSIF (Op_In = "000010") THEN --JMP
			Sig_Jmp <= "01" ;
			Sig_Bne <= '0';
			Sig_Branch <= '0' ;
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegWrite <= '1';
		ELSIF (Op_In = "000000") and (FUNCT_In = "000000") THEN --NOP
			Sig_Jmp <= "00" ;
			Sig_Bne <= '0';
			Sig_Branch <= '0' ;
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegDest <= "00";
			Sig_RegWrite <= '0';
			Sig_ALUSrc <= "00";
			Sig_ALUCtrl <= '0';
		END IF;
	END PROCESS;
END behavior;
