library ieee;
use ieee.std_logic_1164.all;

entity RegisterNBits is
    generic(
        VectorLength: positive:= 32
    );
    port(
        Clock, Reset, Enable: in std_logic;
        Input: in std_logic_vector(VectorLength-1 downto 0);
        Output: out std_logic_vector(VectorLength-1 downto 0)
    );
end entity;

architecture Behavioral of RegisterNBits is
subtype State_t is std_logic_vector(VectorLength-1 downto 0);
signal CurrentState, NextState: State_t; 
begin
    -- Next state logic 
    NextState <= Input when Enable = '1' else
                 CurrentState;
   
    -- Memory/state element
    process(Reset, Clock)
    begin
        if (Reset = '1') then
            CurrentState <= (others=>'0');
        elsif (rising_edge(Clock)) then
            CurrentState <= NextState;
        end if;
    end process;
   
    -- Output logic
    Output <= CurrentState;
    
end architecture;