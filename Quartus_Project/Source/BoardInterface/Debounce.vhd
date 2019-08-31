library ieee;
use ieee.std_logic_1164.all;
 
entity Debounce is
	port(
		Clock: in std_logic;
		Data: in std_logic;
		DebouncedData: out std_logic
	);
end;
 
architecture Behavioral of Debounce is
	signal OP1, OP2, OP3, OP4, OP5, OP6: std_logic; 
begin
	process(Clock) is
	begin
		if rising_edge(Clock) then
			OP1 <= Data;
			OP2 <= OP1;
			OP3 <= OP2;
			OP4 <= OP3;
			OP5 <= OP4;
			OP6 <= OP5;
		end if;
	end process;
 
	DebouncedData <= OP1 and OP2 and OP3 and OP4 and OP5 and OP6;
end;