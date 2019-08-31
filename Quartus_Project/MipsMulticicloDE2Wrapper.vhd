library ieee;
use ieee.std_logic_1164.all;

entity MipsMulticicloDE2Wrapper is
	port(
		CLOCK_50: in std_logic;
		KEY: in std_logic_vector(3 downto 0); -- key(0):clock, key(1):reset
		SW: in std_logic_vector(7 downto 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0);
		LEDR: out std_logic_vector(15 downto 0);
		LEDG: out std_logic_vector(3 downto 0)
	);
end;

architecture Structural of MipsMulticicloDE2Wrapper is
	
	component MipsMulticycle is
		port (
			Clock, Reset: in std_logic;
			InstructionAddress, DataAddress, InstructionValue, DataValue, ALUValue: out std_logic_vector(15 downto 0);
			ControlSignals: out std_logic_vector(15 downto 0);
			ControlState: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component Decoder7Segments is
		port (
			Input: in std_logic_vector(3 downto 0);
			Display: out std_logic_vector(6 downto 0)
		);
	end component;
	
	component Debounce is
		port(
			Clock: in std_logic;
			Data: in std_logic;
			DebouncedData: out std_logic
		);
	end component;
	
	signal InstructionAddress, DataAddress, InstructionValue, DataValue, ALUValue: std_logic_vector(15 downto 0);
	signal ControlSignals: std_logic_vector(15 downto 0);
	signal ControlState16Bits: std_logic_vector(15 downto 0);
	signal ControlState: std_logic_vector(3 downto 0);
	signal DebClock, DebReset: std_logic;
	
	constant LetterS: std_logic_vector(3 downto 0) := "0101";
	constant AuxiliaryZero: std_logic_vector(11 downto 0) := "000000000000";

begin
	
	DebClk: Debounce port map(CLOCK_50, not(KEY(0)), DebClock);
	DebRst: Debounce port map(CLOCK_50, not(KEY(1)), DebReset);

	Mips: MipsMulticycle 
		port map (
			DebClock, DebReset,
			InstructionAddress, DataAddress, InstructionValue, DataValue, ALUValue, 
			ControlSignals, ControlState
		);
		
	H0: Decoder7Segments port map(InstructionAddress(3 downto 0), HEX0);	
	H1: Decoder7Segments port map(InstructionAddress(7 downto 4), HEX1);	
	H2: Decoder7Segments port map(DataAddress(3 downto 0), HEX2);	
	H3: Decoder7Segments port map(DataAddress(7 downto 4), HEX3);	
	H4: Decoder7Segments port map(DataValue(3 downto 0), HEX4);	
	H5: Decoder7Segments port map(DataValue(7 downto 4), HEX5);	
	H6: Decoder7Segments port map(ControlState, HEX6);	
	H7: Decoder7Segments port map(LetterS, HEX7);
	
	ControlState16Bits <= AuxiliaryZero & ControlState;
	
	LEDG <= KEY;
	
	LEDR <= InstructionAddress 	when SW(0)='1' else
			DataAddress 				when SW(1)='1' else
			InstructionValue 			when SW(2)='1' else
			DataValue 					when SW(3)='1' else
			ALUValue 					when SW(4)='1' else
			ControlSignals 			when SW(5)='1' else
			ControlState16Bits; 
end;

	