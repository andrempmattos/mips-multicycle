library ieee;
use ieee.std_logic_1164.all;

entity Mux4x1 is 
    generic(VectorLength: positive := 32);
    port(
        InputA, InputB, InputC, InputD: in std_logic_vector(VectorLength-1 downto 0);
        Selection: in std_logic_vector(1 downto 0);
        Output: out std_logic_vector(VectorLength-1 downto 0)
    );
end entity;

architecture Behavioral of Mux4x1 is
begin
	Output <= InputA when Selection = "00" else
			  InputB when Selection = "01" else
			  InputC when Selection = "10" else
			  InputD;
end architecture;