library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Sign_Extend is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0));
end Sign_Extend;

architecture Behavioral of Sign_Extend is
begin
    O <= ( 0 => A(0),
           1 => A(1),
           2 => A(2),
           others => A(3) ); 
end Behavioral;
