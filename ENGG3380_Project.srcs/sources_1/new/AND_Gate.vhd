library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity AND_Gate is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           O : out STD_LOGIC );
end AND_Gate;

architecture Behavioral of AND_Gate is
begin
    O <= A and B;
end Behavioral;
