library ieee;
use ieee.std_logic_1164.all;

entity LeftShift is 
   	generic(VectorLength: positive := 32);
   	port(
      	Input: in std_logic_vector(VectorLength-1 downto 0);
      	Output: out std_logic_vector(VectorLength-1 downto 0)
   	);
end entity;

architecture Behavioral of LeftShift is
begin
	Output <= Input(VectorLength-3 downto 0) & "00";
end architecture;
