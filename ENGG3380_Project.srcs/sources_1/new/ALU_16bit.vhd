library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_16 is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           S : in STD_LOGIC_VECTOR (1 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0);
           C_out : out STD_LOGIC );
end ALU_16;

architecture Behavioral of ALU_16 is
    component ALU
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S : in STD_LOGIC_VECTOR(1 downto 0);
           O : out STD_LOGIC;
           C_out : out STD_LOGIC );
    end component;
    
    signal RC : STD_LOGIC_VECTOR(14 downto 0);
begin
    ALU_0 : ALU Port map( A => A(0), B => B(0), C_in => S(0), S => S, O => O(0), C_out => RC(0) );
    ALU_1 : ALU Port map( A => A(1), B => B(1), C_in => RC(0), S => S, O => O(1), C_out => RC(1) );
    ALU_2 : ALU Port map( A => A(2), B => B(2), C_in => RC(1), S => S, O => O(2), C_out => RC(2) );
    ALU_3 : ALU Port map( A => A(3), B => B(3), C_in => RC(2), S => S, O => O(3), C_out => RC(3) );
    ALU_4 : ALU Port map( A => A(4), B => B(4), C_in => RC(3), S => S, O => O(4), C_out => RC(4) );
    ALU_5 : ALU Port map( A => A(5), B => B(5), C_in => RC(4), S => S, O => O(5), C_out => RC(5) );
    ALU_6 : ALU Port map( A => A(6), B => B(6), C_in => RC(5), S => S, O => O(6), C_out => RC(6) );
    ALU_7 : ALU Port map( A => A(7), B => B(7), C_in => RC(6), S => S, O => O(7), C_out => RC(7) );
    ALU_8 : ALU Port map( A => A(8), B => B(8), C_in => RC(7), S => S, O => O(8), C_out => RC(8) );
    ALU_9 : ALU Port map( A => A(9), B => B(9), C_in => RC(8), S => S, O => O(9), C_out => RC(9) );
    ALU_10 : ALU Port map( A => A(10), B => B(10), C_in => RC(9), S => S, O => O(10), C_out => RC(10) );
    ALU_11 : ALU Port map( A => A(11), B => B(11), C_in => RC(10), S => S, O => O(11), C_out => RC(11) );
    ALU_12 : ALU Port map( A => A(12), B => B(12), C_in => RC(11), S => S, O => O(12), C_out => RC(12) );
    ALU_13 : ALU Port map( A => A(13), B => B(13), C_in => RC(12), S => S, O => O(13), C_out => RC(13) );
    ALU_14 : ALU Port map( A => A(14), B => B(14), C_in => RC(13), S => S, O => O(14), C_out => RC(14) );
    ALU_15 : ALU Port map( A => A(15), B => B(15), C_in => RC(14), S => S, O => O(15), C_out => C_out );
 
end Behavioral;
