library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Registers is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           A_addr : in STD_LOGIC_VECTOR (3 downto 0);
           A_data : in STD_LOGIC_VECTOR (15 downto 0);
           load : in STD_LOGIC;
           B_addr : in STD_LOGIC_VECTOR (3 downto 0);
           C_addr : in STD_LOGIC_VECTOR (3 downto 0);
           B_data : out STD_LOGIC_VECTOR (15 downto 0);           
           C_data : out STD_LOGIC_VECTOR (15 downto 0));
end Registers;

architecture Behavioral of Registers is
    type RAM_TYPE is ARRAY(15 downto 0) of STD_LOGIC_VECTOR(15 downto 0);
    signal REG : RAM_TYPE;
begin
    process(clk, load, reset)
    begin
        if (reset = '0') then
            REG <= ( 0 => x"0000",
                     1 => x"0001",
                     2 => x"0002",
                     3 => x"0003",
                     4 => x"0004",
                     5 => x"0005",
                     6 => x"0006",
                     7 => x"0007",
                     8 => x"0008",
                     9 => x"0009",
                     10 => x"000a",
                     11 => x"000b",
                     12 => x"000c",
                     13 => x"000d",
                     14 => x"000e",
                     15 => x"000f" );
        elsif rising_edge(clk) then
            if (load = '1') then
                REG(conv_integer(A_addr)) <= A_data;
            end if; 
        end if;
        
        -- Ensure the zero register is still zero and the other one resets
        REG(0) <= x"0000";
        REG(1) <= x"0001";
    end process;
    
    -- Change the B and C data
    B_data <= REG(conv_integer(B_addr));
    C_data <= REG(conv_integer(C_addr));
end Behavioral;
