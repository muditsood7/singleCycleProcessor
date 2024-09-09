library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity OR_Gate is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           O : out STD_LOGIC );
end OR_Gate;

architecture Behavioral of OR_Gate is
begin
    O <= A or B;
end Behavioral;
