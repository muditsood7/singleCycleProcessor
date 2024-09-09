library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use STD.TEXTIO.ALL;

entity ALU is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S : in STD_LOGIC_VECTOR (1 downto 0);
           O : out STD_LOGIC;
           C_out : out STD_LOGIC );
end ALU;

architecture Behavioral of ALU is
    -- Components
    component Full_Adder
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           O : out STD_LOGIC;
           C_out : out STD_LOGIC );
    end component;
    
    component ALT_MUX_3_1
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           S : in STD_LOGIC_VECTOR(1 downto 0);
           O : out STD_LOGIC );
    end component;
    
    component AND_Gate 
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           O : out STD_LOGIC );
    end component;
    
    component OR_Gate 
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           O : out STD_LOGIC );
    end component;
    
    -- Signals
    signal O_Full_Adder : STD_LOGIC;
    signal O_OR_Gate : STD_LOGIC;
    signal O_And_Gate : STD_LOGIC;
    signal Not_B : STD_LOGIC;
begin
    Not_B <= B xor S(0);

    -- All potential outputs
    FA : Full_Adder Port map(
        A => A,
        B => Not_B,
        C_in => C_in,
        O => O_Full_Adder,
        C_out => C_out 
    );
    
    AG : AND_Gate Port map(
        A => A,
        B => B,
        O => O_AND_Gate
    );
    
    OG : OR_Gate Port map(
        A => A,
        B => B,
        O => O_OR_Gate
    );
    
    -- Switch the actual output
    MUX : ALT_MUX_3_1 Port map(
        A => O_Full_Adder,
        B => O_AND_Gate,
        C => O_OR_Gate,
        S => S,
        O => O
    );
end Behavioral;
