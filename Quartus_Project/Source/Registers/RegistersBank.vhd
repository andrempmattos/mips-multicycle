library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegistersBank is 
   	generic(
      	VectorLength: positive := 32;
      	BitsRegisterAddress: positive := 5
   	);
   	port(
      	Clock, Reset: in std_logic;
      	EscReg: in std_logic;
      	RegisterReadAddressA, RegisterReadAddressB, RegisterWriteAddress: in std_logic_vector(BitsRegisterAddress-1 downto 0);
      	RegisterWrite: in std_logic_vector(VectorLength-1 downto 0);      
      	RegisterReadA, RegisterReadB: out std_logic_vector(VectorLength-1 downto 0)
   	);
end entity;

architecture Comportamental of RegistersBank is 
	type RegistersBank_t is array(0 to 2**BitsRegisterAddress) of std_logic_vector(VectorLength-1 downto 0);
	signal CurrentState, NextState: RegistersBank_t;
begin

-- State register
StateRegister: process(Clock, Reset)
begin
	if Reset = '1' then
		for i in CurrentState'range loop
			CurrentState(i) <= (others => '0');
		end loop;
	elsif rising_edge(Clock) then
		CurrentState <= NextState;
	end if;
end process;

-- Next state logic
NextStateLogic: process(CurrentState, EscReg, RegisterWriteAddress, RegisterWrite) is
begin
	NextState <= CurrentState;
	for i in CurrentState'range loop
		if EscReg = '1' then
			if i = to_integer(unsigned(RegisterWriteAddress)) then
				NextState(i) <= RegisterWrite; 
			end if;
		end if;
	end loop;
end process;

-- Output logic
RegisterReadA <= CurrentState(to_integer(unsigned(RegisterReadAddressA)));
RegisterReadB <= CurrentState(to_integer(unsigned(RegisterReadAddressB)));

end architecture;
