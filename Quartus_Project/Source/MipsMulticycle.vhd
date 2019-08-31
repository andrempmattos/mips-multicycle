library ieee;
use ieee.std_logic_1164.all;

entity MipsMulticycle is
	port(
		Clock, Reset: in std_logic;
		InstructionAddress, DataAddress, InstructionValue, DataValue, ALUValue: out std_logic_vector(15 downto 0);
		ControlSignals: out std_logic_vector(15 downto 0);
		ControlState: out std_logic_vector(3 downto 0)
	);
end entity;

architecture Structural of MipsMulticycle is
	
	component Datapath is
		port(
	        Clock_mips, clock_ram, Reset: in std_logic;
	        PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: in std_logic;
	        ULAFonteB, ULAOp, FontePC: in std_logic_vector(1 downto 0);
	        opcode: out std_logic_vector(5 downto 0);
	        InstructionAddress, DataAddress, InstructionValue, DataValue, ALUValue: out std_logic_vector(15 downto 0)
    	);
	end component;
	
	component ControlBlock is
		port(
	    	Clock, Reset: in std_logic;
	    	PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: out std_logic;
	    	ULAFonteB, ULAOp, FontePC: out std_logic_vector(1 downto 0);
	    	opcode: in std_logic_vector(5 downto 0);
	    	ControlState: out std_logic_vector(3 downto 0)
	   );
	end component;
	
	component clockDivider is
		port(
			clock_in : in std_logic;
			clock_out : out std_logic := '0'
		);
	end component;
	
	signal PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, ULAFonteA, EscReg, RegDst, clock_Mips: std_logic;
	signal FontePC, ULAFonteB, ULAOp: std_logic_vector(1 downto 0);
	signal opcode: std_logic_vector(5 downto 0);
	
begin
	ControlSignals <= PCEscCond & PCEsc & IouD & LerMem & EscMem &
					  MemParaReg & IREsc & ULAOp & ULAFonteA & EscReg & 
					  RegDst & FontePC & ULAFonteB;
				
	CB: ControlBlock 
		port map(
			Clock_mips, Reset, 
			PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA, ULAFonteB, ULAOp, FontePC, opcode, 
			ControlState 
		);
	
	DP: Datapath 
		port map(
			Clock_mips, clock, Reset, 
			PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA, ULAFonteB, ULAOp, FontePC, opcode, 
			InstructionAddress, DataAddress, InstructionValue, DataValue, ALUValue
		);
		
	CD: clockDivider port map(clock,clock_Mips);
	
end architecture;