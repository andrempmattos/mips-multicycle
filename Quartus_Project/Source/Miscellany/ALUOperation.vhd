library ieee;
use ieee.std_logic_1164.all;

entity ALUOperation is 
	port(
		ULAOp: in std_logic_vector(1 downto 0);
		funct: in std_logic_vector(5 downto 0);
		Operation: out std_logic_vector(2 downto 0)
	);
end entity;

architecture Behavioral of ALUOperation is
begin

Operation <= "010" when ULAOp="00" else 	-- SUM
			 "110" when ULAOp="01" else 		-- SUB
			 "111" when funct(3)='1' else 	-- SLT
			 "001" when funct(0)='1' else 	-- OR
			 "000" when funct(2)='1' else 	-- AND
			 "010" when funct(1)='0' else 	-- SUM
			 "110"; 									-- SUB

end architecture;