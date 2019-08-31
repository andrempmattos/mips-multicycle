library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Arithmetic is
generic(VectorLength: positive := 32);
	port ( 
		InputA, InputB: in std_logic_vector(VectorLength-1 downto 0);
		CarryIn: in std_logic;
		Output: out std_logic_vector(VectorLength-1 downto 0)
	);
end entity;

architecture Behavioral of Arithmetic is
begin
	Output <= std_logic_vector(signed(InputA) + signed(InputB)) when CarryIn='0' else
		  	  std_logic_vector(signed(InputA) - signed(InputB));
end architecture;
