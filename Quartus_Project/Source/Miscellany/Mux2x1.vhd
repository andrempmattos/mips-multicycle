library ieee;
use ieee.std_logic_1164.all;

entity Mux2x1 is 
	generic(VectorLength: positive := 32);
	port (
		InputA, InputB: in std_logic_vector(VectorLength-1 downto 0);
		Selection: in std_logic;
		Output: out std_logic_vector(VectorLength-1 downto 0)
	);
end entity;

architecture Behavioral of Mux2x1 is
begin
	Output <= InputA when Selection = '0' else
			  InputB;
end architecture;
