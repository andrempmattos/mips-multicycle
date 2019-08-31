library ieee;
use ieee.std_logic_1164.all;

entity Memory is 
	port(
		Clock: in std_logic;
		ReadMem, WrtMem: in std_logic;
		DataWrt: in std_logic_vector(31 downto 0);
		Address: in std_logic_vector(31 downto 0);
		DataRd: out std_logic_vector(31 downto 0)
	);
end entity;

architecture RAM of Memory is 
component bram is
	port(
		address	: in std_logic_vector (7 downto 0);
		clock	: in std_logic := '1';
		data	: in std_logic_vector (31 downto 0);
		wren	: in std_logic;
		q		: out std_logic_vector (31 downto 0)
	);
end component;

begin

SectorA: bram port map (Address(7 downto 0), Clock, DataWrt, WrtMem, DataRd);
--SectorB: bram port map (????, Clock, DataWrt, WrtMem, DataRd);

end architecture;