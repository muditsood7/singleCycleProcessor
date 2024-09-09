library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC_Register is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (15 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0) );
end PC_Register;

architecture Behavioral of PC_Register is
begin
    process(clk, reset)
    begin
        if reset = '0' then
            output <= ( others => '0' );
        elsif rising_edge(clk) then
            output <= input;
        end if;
    end process;
end Behavioral;
