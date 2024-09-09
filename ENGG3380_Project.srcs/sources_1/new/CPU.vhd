library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use STD.TEXTIO.ALL;

entity CPU is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           mem_dump : in STD_LOGIC);
end CPU;

architecture Behavioral of CPU is
    -- Components
    component ALU_16
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           S : in STD_LOGIC_VECTOR (1 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0);
           C_out : out STD_LOGIC );
    end component;

    component Registers
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           A_addr : in STD_LOGIC_VECTOR (3 downto 0);
           A_data : in STD_LOGIC_VECTOR (15 downto 0);
           load : in STD_LOGIC;
           B_addr : in STD_LOGIC_VECTOR (3 downto 0);
           C_addr : in STD_LOGIC_VECTOR (3 downto 0);
           B_data : out STD_LOGIC_VECTOR (15 downto 0);           
           C_data : out STD_LOGIC_VECTOR (15 downto 0));
    end component; 
    
    component Control 
    Port ( op : in STD_LOGIC_VECTOR (3 downto 0);
           alu_op : out STD_LOGIC_VECTOR (1 downto 0);
           alu_src : out STD_LOGIC;
           reg_dest : out STD_LOGIC;
           reg_load : out STD_LOGIC;
           reg_src : out STD_LOGIC_VECTOR (1 downto 0);
           mem_read : out STD_LOGIC;
           mem_write : out STD_LOGIC );
    end component;    
    
    component Sign_Extend
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0));
    end component;
    
    component MUX_2_1
    Generic ( WIDTH : POSITIVE := 16 );
    Port ( A : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           B : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           S : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0) );
    end component;
    
    component MUX_3_1
    Generic ( WIDTH : POSITIVE := 16 );
    Port ( A : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           B : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           C : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           S : in STD_LOGIC_VECTOR(1 downto 0);
           O : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0) );
    end component;
    
    component Memory
    Generic ( INPUT : STRING := "in.txt";
              OUTPUT : STRING := "out.txt" );
    Port ( clk : in STD_LOGIC;
           read_en : in STD_LOGIC;
           write_en : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (15 downto 0);
           data_in : in STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (15 downto 0);
           mem_dump : in STD_LOGIC := '0' );
    end component;
    
    component PC_Register
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (15 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0) );
    end component;
    
    -- Signals
    signal instruction : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    signal op : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal rd : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal rs : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal rt : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    
    signal ALU_result : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    signal C_out : STD_LOGIC := '0' ;
    signal ALU_src_mux_out : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    
    signal Sign_Extend_out : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    
    signal rs_data : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    signal rt_data : STD_LOGIC_VECTOR(15 downto 0) := x"0000"; 

    signal Registers_dest_mux_out : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Registers_src_mux_out : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    
    signal Control_alu_src : STD_LOGIC := '0';
    signal Control_alu_op : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal Control_reg_dest : STD_LOGIC := '0';
    signal Control_reg_src : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal Control_reg_load : STD_LOGIC := '0';
    signal Control_mem_read : STD_LOGIC := '0';
    signal Control_mem_write : STD_LOGIC := '0';
    
    signal Memory_data_out : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    
    signal slt_input : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    
    signal PC_Register_input : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    signal PC_Register_output : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
begin
    -- Implement the program counter
    PC : PC_Register port map ( clk => clk,
                                reset => reset,
                                input => PC_Register_input,
                                output => PC_Register_output );
    PC_Register_input <= PC_Register_output + 2;
                          
    -- Implement the instruction memory handler      
    Instruction_MEM : Memory generic map ( INPUT => "Instr.txt" )
                             port map ( clk => clk,
                                        read_en => '1',
                                        write_en => '0',
                                        addr => PC_Register_output,
                                        data_in => x"0000",
                                        data_out => instruction,
                                        mem_dump => mem_dump );
       
    op <= instruction(15 downto 12);
    rd <= instruction(11 downto 8);
    rs <= instruction(7 downto 4);
    rt <= instruction(3 downto 0);
    
    -- Implement the control unit
    CPU_Control : Control port map ( op => op,
                                     alu_op => Control_alu_op,
                                     alu_src => Control_alu_src,
                                     reg_dest => Control_reg_dest,
                                     reg_load => Control_reg_load,
                                     reg_src => Control_reg_src,
                                     mem_read => Control_mem_read,
                                     mem_write => Control_mem_write );
                    
    -- Implement the registers
    CPU_Registers : Registers port map ( clk => clk,
                                         reset => reset,
                                         a_addr => rd,
                                         a_data => Registers_src_mux_out,
                                         load => Control_reg_load,
                                         b_addr => rs,
                                         c_addr => Registers_dest_mux_out,
                                         b_data => rs_data,
                                         c_data => rt_data );
                                         
    -- Implement the sign extension
    CPU_Sign_Extend : Sign_Extend port map ( A => rt,
                                             O => Sign_Extend_out );
                                             
    -- Implement the register destination mux
    CPU_reg_dest_mux : MUX_2_1 generic map ( 4 ) 
                               port map ( A => rt,
                                          B => rd,
                                          S => Control_reg_dest,
                                          O => Registers_dest_mux_out );
    -- Execution phase
    -- Implement the ALU source mux
    CPU_ALU_src_mux : MUX_2_1 generic map ( 16 )
                              port map ( A => rt_data,
                                         B => Sign_Extend_out,
                                         S => Control_alu_src,
                                         O => ALU_src_mux_out );
                                        
   -- Set up the ALU
   CPU_ALU : ALU_16 port map ( A => rs_data,
                               B => ALU_src_mux_out,
                               S => Control_alu_op,
                               O => ALU_result,
                               C_out => C_out );

   -- Implement the data memory
   CPU_MEM : Memory port map ( clk => clk,
                               read_en => Control_mem_read,
                               write_en => Control_mem_write,
                               addr => ALU_result,
                               data_in => rt_data,
                               data_out => Memory_data_out,
                               mem_dump => mem_dump );

    -- Set the SLT input
    slt_input <= ( 0 => ALU_result(15),
                   others => '0' );
                   
    -- Implement the register read-out mux
    CPU_reg_src_mux : MUX_3_1 generic map ( 16 )
                              port map ( A => Memory_data_out,
                                         B => ALU_result,
                                         C => slt_input,
                                         S => Control_reg_src,
                                         O => Registers_src_mux_out );
end Behavioral;
