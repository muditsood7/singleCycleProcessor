library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALT_MUX_3_1 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           S : in STD_LOGIC_VECTOR(1 downto 0);
           O : out STD_LOGIC );
end ALT_MUX_3_1;

architecture Behavioral of ALT_MUX_3_1 is
begin
    O <= B when S = "10" else
         C when S = "11" else
         A;
end Behavioral;
