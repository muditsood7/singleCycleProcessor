library IEEE;
use IEEE.STD_LOGIC_1164.ALL;                                
use IEEE.STD_LOGIC_UNSIGNED.all;

entity MUX_2_1 is
    Generic ( WIDTH : POSITIVE := 16 );
    Port ( A : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           B : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           S : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0) );
end MUX_2_1;

architecture Behavioral of MUX_2_1 is
begin
    O <= A when S = '0' else
         B;
end Behavioral;
