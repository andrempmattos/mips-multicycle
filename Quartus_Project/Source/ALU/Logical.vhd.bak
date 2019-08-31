library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Logical is
generic(VectorLength: positive := 32);
	port ( 
		InputA, InputB: in std_logic_vector(VectorLength-1 downto 0);
		SelectionAndOr: in std_logic;
		OutputSlt, OutputAndOr: out std_logic_vector(VectorLength-1 downto 0)
	);
end entity;

architecture Behavioral of Logical is
begin

OutputAndOr <= InputA and InputB when SelectionAndOr='0' else
		 	   InputA or InputB;

OutputSlt <= (0 => '1', others => '0') when signed(InputA) < signed(InputB) else 
			 (others => '0');

end architecture;