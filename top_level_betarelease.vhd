-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 5
-- Percobaan : 1
-- Tanggal : 13 November 2020
-- Rombongan : A
-- Nama (NIM) 1 : William Christian (13218010)
-- Nama File : top_level.vhd
-- Deskripsi : Implementasi top_level
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY top_level IS
	PORT(
	-- INPUT
	CLK_IN : IN STD_LOGIC;
	Reset : IN STD_LOGIC; 
	-- OUTPUT
	out_PC_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_PC_out: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_INSTR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_Sig_Jmp : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
	out_Sig_Bne : OUT STD_LOGIC;
	out_Sig_Branch : OUT STD_LOGIC;
	out_Sig_MemtoReg : OUT STD_LOGIC;
	out_Sig_MemRead : OUT STD_LOGIC;
	out_Sig_MemWrite : OUT STD_LOGIC;
	out_Sig_RegDest : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
	out_Sig_RegWrite : OUT STD_LOGIC;
	out_Sig_ALUSrc : OUT STD_LOGIC_VECTOR (1 DOWNTO 0) ;
	out_Sig_ALUCtrl : OUT STD_LOGIC;
	out_RD_Data_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_RD_Data_2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_WR_Data_3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_ADDR_3 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	out_D_Out_SignExtend : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_D_Out_LF2628 : OUT STD_LOGIC_VECTOR(27 DOWNTO 0);
	out_D_Out_LF3232 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_D_Out_BusMerge : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_Y_mux4to1_toALU : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_RESULT_ALU : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_EQ : OUT STD_LOGIC;
	out_RD_Data_DataMem : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_RESULT_PCADDER: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_RESULT_PCADDER_2: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_D1_JumpMux : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_D1_ResetMux : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_OUT_1_combinational : OUT STD_LOGIC
	);
END top_level;

ARCHITECTURE behavior OF top_level IS
	-- COMPONENT LISTS
	
	COMPONENT data_memory IS
	PORT (
			ADDR : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- alamat
			WR_EN : IN STD_LOGIC; --Indikator Penulisan
			RD_EN : IN STD_LOGIC; --Indikator Pembacaan
			clock : IN STD_LOGIC ; -- clock
			RD_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			WR_Data : IN STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT mux_2to1_32bit IS
	PORT (
			D1 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1
			D2 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
			Y : OUT std_logic_vector (31 DOWNTO 0); -- Selected Data
			S : IN std_logic -- Selector
		);
	END COMPONENT;
	
	COMPONENT sign_extender IS
	PORT (
		D_In :IN std_logic_vector (15 DOWNTO 0); -- Data Input 1
		D_Out :OUT std_logic_vector (31 DOWNTO 0) -- Data Input 2
	);
	END COMPONENT;
	
	COMPONENT bus_merger IS
	PORT (
			DATA_IN1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			DATA_IN2 : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
			DATA_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT cla_32 IS
	PORT (
		OPRND_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operand 1
		OPRND_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Operand 2
		C_IN : IN STD_LOGIC; -- Carry In
		RESULT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- Result
		C_OUT : OUT STD_LOGIC -- Overflow
	);
	END COMPONENT;
	
	COMPONENT combinational IS
	PORT (
		IN_1 : IN std_logic; 
		IN_2 : IN std_logic;
		IN_3 : IN std_logic; 
		OUT_1 :OUT std_logic
	);
	END COMPONENT;
	
	COMPONENT comparator IS
	PORT (
		D_1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		D_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		EQ : OUT STD_LOGIC -- Hasil Perbandingan EQ
	);
	END COMPONENT;
	
	COMPONENT inverter IS
	PORT (
		neu : IN std_logic_vector (31 DOWNTO 0); 
		inv : OUT std_logic_vector (31 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT lshift_32_32 IS
	PORT (
	D_IN : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Input 32-bit;
	D_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- Output 32-bit;
	);
	END COMPONENT;
	
	COMPONENT lshift_26_28 IS
	PORT (
	D_IN : IN STD_LOGIC_VECTOR (25 DOWNTO 0); -- Input 26-bit;
	D_OUT : OUT STD_LOGIC_VECTOR (27 DOWNTO 0) -- Output 28-bit;
	);
	END COMPONENT;
	
	COMPONENT mux_4to1_5bit IS
	PORT (
		D1 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 1
		D2 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 2
		D3 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 3
		D4 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 4
		Y : OUT std_logic_vector (4 DOWNTO 0); -- Selected Data
		S : IN std_logic_vector (1 DOWNTO 0) -- Selector
	);
	END COMPONENT;
	
	COMPONENT mux_4to1_32bit IS
	PORT (
		D1 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1
		D2 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
		D3 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 3
		D4 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 4
		Y : OUT std_logic_vector (31 DOWNTO 0); -- Selected Data
		S : IN std_logic_vector (1 DOWNTO 0) -- Selector
	);
	END COMPONENT;
	
	COMPONENT program_counter IS
	PORT (
		clk : IN STD_LOGIC;
		PC_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		PC_out : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT instruction_memory IS
	PORT (
			ADDR : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- alamat
			clock : IN STD_LOGIC ; -- clock
			INSTR : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- output
	);
	END COMPONENT;
	
	COMPONENT cu IS
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
		Sig_ALUSrc : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		Sig_ALUCtrl : OUT STD_LOGIC  
	);
	END COMPONENT;
	
	COMPONENT reg_file IS
	PORT (
		clock : IN STD_LOGIC; -- clock
		WR_EN : IN STD_LOGIC; -- write enable
		ADDR_1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- Input 1
		ADDR_2 : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- Input 2
		ADDR_3 : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- Input 3
		WR_Data_3 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);-- write data
		RD_Data_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);-- read data 1
		RD_Data_2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- read data 2
		);
	END COMPONENT;
	
	COMPONENT ALU IS
	PORT (
		OPRND_A : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1
		OPRND_B : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
		OP_SEL : IN std_logic ; -- Operation Select
		RESULT : OUT std_logic_vector (31 DOWNTO 0) -- Data Output
	);
	END COMPONENT;
	
	-- SIGNAL LISTS
	SIGNAL sgn_PC_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_PC_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_INSTR : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_Sig_Jmp : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL sgn_Sig_Bne : STD_LOGIC;
	SIGNAL sgn_Sig_Branch : STD_LOGIC;
	SIGNAL sgn_Sig_MemtoReg : STD_LOGIC;
	SIGNAL sgn_Sig_MemRead : STD_LOGIC;
	SIGNAL sgn_Sig_MemWrite : STD_LOGIC;
	SIGNAL sgn_Sig_RegDest : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL sgn_Sig_RegWrite : STD_LOGIC;
	SIGNAL sgn_Sig_ALUSrc : STD_LOGIC_VECTOR (1 DOWNTO 0) ;
	SIGNAL sgn_Sig_ALUCtrl : STD_LOGIC;
	SIGNAL sgn_RD_Data_1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_RD_Data_2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_WR_Data_3 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_ADDR_3 : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL sgn_D_Out_SignExtend : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_D_Out_LF2628 : STD_LOGIC_VECTOR(27 DOWNTO 0);
	SIGNAL sgn_D_Out_LF3232 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_D_Out_BusMerge : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_Y_mux4to1_toALU : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_RESULT_ALU : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_EQ : STD_LOGIC;
	SIGNAL sgn_RD_Data_DataMem : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_RESULT_PCADDER: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_RESULT_PCADDER_2: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_D1_JumpMux : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_D1_ResetMux : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sgn_OUT_1_combinational : STD_LOGIC; 
	SIGNAL sgn_zero_5bit : STD_LOGIC_VECTOR(4 DOWNTO 0) ;
	SIGNAL sgn_zero_32bit : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	SIGNAL sgn_add4_32bit : STD_LOGIC_VECTOR(31 DOWNTO 0) ;
	SIGNAL sgn_zero_1bit : STD_LOGIC ;
	
BEGIN
	sgn_zero_5bit <= "00000";
	sgn_zero_32bit <= "00000000000000000000000000000000";
	sgn_add4_32bit <= "00000000000000000000000000000100";
	sgn_zero_1bit <= '0';
	PC_1 : program_counter
	PORT MAP ( 
	clk => CLK_IN, 
	PC_in =>  sgn_PC_in, 
	PC_out => sgn_PC_out );
	
	instruction_mem_1 : instruction_memory
	PORT MAP ( 
	ADDR => sgn_PC_out(7 DOWNTO 0), 
	clock => CLK_IN, 
	INSTR => sgn_INSTR);
	
	control_unit_1 : cu
	PORT MAP (OP_In => sgn_INSTR(31 DOWNTO 26),
		FUNCT_In => sgn_INSTR(5 DOWNTO 0),
		Sig_Jmp => sgn_Sig_Jmp,
		Sig_Bne => sgn_Sig_Bne,
		Sig_Branch => sgn_Sig_Branch,
		Sig_MemtoReg => sgn_Sig_MemtoReg,
		Sig_MemRead => sgn_Sig_MemRead,
		Sig_MemWrite => sgn_Sig_MemWrite,
		Sig_RegDest => sgn_Sig_RegDest,
		Sig_RegWrite => sgn_Sig_RegWrite,
		Sig_ALUSrc => sgn_Sig_ALUSrc,
		Sig_ALUCtrl => sgn_Sig_ALUCtrl);
	
	register_1 : reg_file
	PORT MAP (
		clock => CLK_IN,
		WR_EN => sgn_Sig_RegWrite,
		ADDR_1 => sgn_INSTR(25 DOWNTO 21),
		ADDR_2 => sgn_INSTR(20 DOWNTO 16),
		ADDR_3 => sgn_ADDR_3,
		WR_Data_3 => sgn_WR_Data_3,
		RD_Data_1 => sgn_RD_Data_1,
		RD_Data_2 => sgn_RD_Data_2
		);
		
	mux_4to1_32bit_ADDR_3 : mux_4to1_5bit
	PORT MAP(
		D1 => sgn_INSTR(20 DOWNTO 16),
		D2 => sgn_INSTR(15 DOWNTO 11),
		D3 => sgn_zero_5bit,
		D4 => sgn_zero_5bit,
		Y => sgn_ADDR_3,
		S => sgn_Sig_RegDest
	);
	
	sign_extender_1 : sign_extender
	PORT MAP(
		D_In => sgn_INSTR(15 DOWNTO 0),
		D_Out => sgn_D_Out_SignExtend
	);
	
	lshift_26_28_1 : lshift_26_28
	PORT MAP(
	D_IN  => sgn_INSTR(25 DOWNTO 0),
	D_OUT => sgn_D_Out_LF2628
	);
	
	bus_merger_1 : bus_merger
	PORT MAP(
	DATA_IN1 => sgn_RESULT_PCADDER(31 DOWNTO 28),
	DATA_IN2 => sgn_D_Out_LF2628,
	DATA_OUT => sgn_D_Out_BusMerge
	);
	
	comparator_1 : comparator
	PORT MAP(
		D_1 => sgn_RD_Data_1,
		D_2 => sgn_RD_Data_2,
		EQ => sgn_EQ
	);
	
	mux_4to1_32bit_1_RD_Data_2 : mux_4to1_32bit
	PORT MAP(
		D1 => sgn_RD_Data_2,
		D2 => sgn_D_Out_SignExtend,
		D3 => sgn_zero_32bit,
		D4 => sgn_zero_32bit, 
		Y => sgn_Y_mux4to1_toALU,
		S => sgn_Sig_ALUSrc
	);
	
	lshift_32_32_1 : lshift_32_32
	PORT MAP(
	D_IN => sgn_D_Out_SignExtend,
	D_OUT => sgn_D_Out_LF3232
	);
	
	ALU_1 : ALU
	PORT MAP(
		OPRND_A => sgn_RD_Data_1,
		OPRND_B => sgn_Y_mux4to1_toALU,
		OP_SEL => sgn_Sig_ALUCtrl,
		RESULT => sgn_RESULT_ALU
	);
	
	data_memory_1 : data_memory
	PORT MAP(
			ADDR => sgn_RESULT_ALU(7 DOWNTO 0),
			WR_EN => sgn_Sig_MemWrite,
			RD_EN => sgn_Sig_MemRead,
			clock => CLK_IN,
			RD_Data => sgn_RD_Data_DataMem,
			WR_Data => sgn_RD_Data_2
	);
	
	combinational_1 : combinational
	PORT MAP(
		IN_1 => sgn_EQ,
		IN_2 => sgn_Sig_Bne,
		IN_3 => sgn_Sig_Branch,
		OUT_1 => sgn_OUT_1_combinational
	);
	
	cla_32_PC : cla_32
	PORT MAP(
		OPRND_1 => sgn_PC_out,
		OPRND_2 => sgn_add4_32bit,
		C_IN => sgn_zero_1bit,
		RESULT => sgn_RESULT_PCADDER
	);
	
	mux_2to1_32bit_1_MemtoReg : mux_2to1_32bit
	PORT MAP(
			D1 => sgn_RESULT_ALU,
			D2 => sgn_RD_Data_DataMem,
			Y => sgn_WR_Data_3,
			S => sgn_Sig_MemtoReg
		);
	
	cla_32_LS3232 : cla_32
	PORT MAP(
		OPRND_1 => sgn_D_Out_LF3232,
		OPRND_2 => sgn_RESULT_PCADDER,
		C_IN => sgn_zero_1bit,
		RESULT => sgn_RESULT_PCADDER_2
	);
	
	mux_2to1_32bit_2_reset : mux_2to1_32bit
	PORT MAP(
			D1 => sgn_D1_ResetMux,
			D2 => sgn_zero_32bit,
			Y => sgn_PC_in,
			S => Reset
		);
	
	mux_2to1_32bit_combinational : mux_2to1_32bit
	PORT MAP(
			D1 => sgn_RESULT_PCADDER,
			D2 => sgn_RESULT_PCADDER_2,
			Y => sgn_D1_JumpMux,
			S => sgn_OUT_1_combinational
		);
	
	mux_4to1_32bit_JUMP : mux_4to1_32bit
	PORT MAP(
		D1 => sgn_D1_JumpMux,
		D2 => sgn_D_Out_BusMerge,
		D3 => sgn_zero_32bit,
		D4 => sgn_zero_32bit,
		Y => sgn_D1_ResetMux,
		S => sgn_Sig_Jmp
	);
	
	-- DIRECTING FLOATING SIGNAL TO OUTPUT PORT
	out_PC_in  <= sgn_PC_in;
	out_PC_out <= sgn_PC_out;
	out_INSTR <= sgn_INSTR ;
	out_Sig_Jmp <= sgn_Sig_Jmp  ;
	out_Sig_Bne <= sgn_Sig_Bne ;
	out_Sig_Branch <= sgn_Sig_Branch ;
	out_Sig_MemtoReg <= sgn_Sig_MemtoReg ;
	out_Sig_MemRead <= sgn_Sig_MemRead ;
	out_Sig_MemWrite <= sgn_Sig_MemWrite;
	out_Sig_RegDest <= sgn_Sig_RegDest  ;
	out_Sig_RegWrite <= sgn_Sig_RegWrite ;
	out_Sig_ALUSrc <= sgn_Sig_ALUSrc   ;
	out_Sig_ALUCtrl <= sgn_Sig_ALUCtrl ;
	out_RD_Data_1 <= sgn_RD_Data_1 ;
	out_RD_Data_2 <= sgn_RD_Data_2 ;
	out_WR_Data_3 <= sgn_WR_Data_3 ;
	out_ADDR_3 <= sgn_ADDR_3 ;
	out_D_Out_SignExtend <= sgn_D_Out_SignExtend ;
	out_D_Out_LF2628 <= sgn_D_Out_LF2628 ;
	out_D_Out_LF3232  <= sgn_D_Out_LF3232;
	out_D_Out_BusMerge  <= sgn_D_Out_BusMerge ;
	out_Y_mux4to1_toALU <= sgn_Y_mux4to1_toALU ;
	out_RESULT_ALU <= sgn_RESULT_ALU ;
	out_EQ  <= sgn_EQ;
	out_RD_Data_DataMem <= sgn_RD_Data_DataMem;
	out_RESULT_PCADDER <= sgn_RESULT_PCADDER;
	out_RESULT_PCADDER_2 <= sgn_RESULT_PCADDER_2;
	out_D1_JumpMux <= sgn_D1_JumpMux ;
	out_D1_ResetMux <= sgn_D1_ResetMux  ;
	out_OUT_1_combinational <= sgn_OUT_1_combinational ;

	
END behavior;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	