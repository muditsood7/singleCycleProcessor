library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_3_1 is
    Generic ( WIDTH : POSITIVE := 16 );
    Port ( A : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           B : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           C : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           S : in STD_LOGIC_VECTOR(1 downto 0);
           O : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0) );
end MUX_3_1;

architecture Behavioral of MUX_3_1 is
begin
    O <= A when S = "00" else
         B when S = "01" else
         C;
end Behavioral;
