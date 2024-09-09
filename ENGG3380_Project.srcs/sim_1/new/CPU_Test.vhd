library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU_Test is
end CPU_Test;

architecture Behavioral of CPU_Test is
    constant tick : time := 100 ns;
    signal clk, reset : std_logic := '0';
	signal mem_dump : std_logic := '0';
begin
    UUT : entity work.CPU port map ( clk => clk,
                                     reset => reset,
                                     mem_dump => mem_dump );
                                     
    driver : process is
    begin
        reset <= '0'; 
        wait for 50 ns;
        reset <= '1';
        wait;
    end process driver;
    
    clk_process : process is
    begin
        for i in 0 to 16 loop
            clk <= '1'; wait for tick / 2;
            clk <= '0'; wait for tick / 2;
        end loop;
        wait;
    end process clk_process;
end Behavioral;
