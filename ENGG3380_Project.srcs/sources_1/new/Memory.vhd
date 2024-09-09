library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use STD.TEXTIO.ALL;

entity Memory is
    Generic ( INPUT : STRING := "in.txt";
              OUTPUT : STRING := "out.txt" );
    Port ( clk : in STD_LOGIC;
           read_en : in STD_LOGIC;
           write_en : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (15 downto 0);
           data_in : in STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (15 downto 0);
           mem_dump : in STD_LOGIC := '0' );
end Memory;

architecture Behavioral of Memory is
    type MEM_TYPE is ARRAY(0 to 33) of STD_LOGIC_VECTOR(7 downto 0);
    
    impure function init_mem return MEM_TYPE is
        file in_file : TEXT;
        variable in_line : LINE;
        variable byte : BIT_VECTOR(7 downto 0);
        variable mem: MEM_TYPE;
    begin
        if INPUT'length = 0 then
            return mem;
        end if;
        
        file_open(in_file, INPUT, READ_MODE);
        for row in MEM_TYPE'range loop
            readline(in_file, in_line);
            read(in_line, byte);
            mem(row) := to_stdlogicvector(byte);
        end loop;
        
        return mem;
    end function init_mem;
    
    signal mem : MEM_TYPE := init_mem;

    procedure dump_mem is
        file out_file : TEXT;
        variable out_line : LINE;
        variable byte : BIT_VECTOR(7 downto 0);
    begin
        if OUTPUT'length = 0 then
            report "The mem_dump port was triggered, but no file name was given.";
            report "Specify a file name for the generic OUTPUT in the entity declaration to enable memory dump.";
            return;
        end if;
        
        file_open(out_file, OUTPUT, WRITE_MODE);
        for row in MEM_TYPE'range loop
            byte := to_bitvector(mem(row));
            write(out_line, byte);
            writeline(out_file, out_line);
        end loop;
    end procedure dump_mem;
begin
    read_process : process(read_en, mem, addr) is
    begin
        if read_en = '1' then
            data_out(7 downto 0) <= mem(conv_integer(addr(7 downto 0)));
            data_out(15 downto 8) <= mem(conv_integer(addr(7 downto 0)) + 1);
        end if;
    end process read_process;
    
    write_process : process(clk) is
    begin
        if rising_edge(clk) and write_en = '1' then
            mem(conv_integer(addr(7 downto 0))) <= data_in(7 downto 0);
            mem(conv_integer(addr(7 downto 0)) + 1) <= data_in(15 downto 8);
        end if;
    end process write_process;
    
    mem_dump_process : process(mem_dump) is
    begin
        if rising_edge(mem_dump) then
            dump_mem;
        end if;
    end process mem_dump_process;
end Behavioral;
