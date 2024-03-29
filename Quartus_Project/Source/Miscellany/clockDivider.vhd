library ieee;
use ieee.std_logic_1164.all;

entity clockDivider is
	port(
		clock_in : in std_logic;
		clock_out : out std_logic
	);
end entity;

architecture behavioural of clockDivider is

signal clock_out_s : std_logic := '1';

begin
divisor: process(clock_in)
begin
	if rising_edge(clock_in) then
		clock_out_s <= not clock_out_s;
	end if;
end process;

clock_out <= clock_out_s;

end architecture;