library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Full_Adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           O : out STD_LOGIC;
           C_out : out STD_LOGIC);
end Full_Adder;

architecture Behavioral of Full_Adder is
begin
    O <= A xor B xor C_in;
    C_out <= (A and B) or ((A xor B) and C_in);
end Behavioral;
