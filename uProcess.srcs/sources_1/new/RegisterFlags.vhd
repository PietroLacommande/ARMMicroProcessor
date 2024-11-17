    ----------------------------------------------------------------------------------
    -- Company: 
    -- Engineer: 
    -- 
    -- Create Date: 11/07/2024 02:17:18 PM
    -- Design Name: 
    -- Module Name: RegisterFlags - Behavioral
    -- Project Name: 
    -- Target Devices: 
    -- Tool Versions: 
    -- Description: 
    -- 
    -- Dependencies: 
    -- 
    -- Revision:
    -- Revision 0.01 - File Created
    -- Additional Comments:
    -- 
    ----------------------------------------------------------------------------------
    
    
    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    
    -- Uncomment the following library declaration if using
    -- arithmetic functions with Signed or Unsigned values
    --use IEEE.NUMERIC_STD.ALL;
    
    -- Uncomment the following library declaration if instantiating
    -- any Xilinx leaf cells in this code.
    --library UNISIM;
    --use UNISIM.VComponents.all;
    
    entity RegisterFlags is
    --  Port ( );
        port(
    --        PCS: in STD_LOGIC; 
            RegW: in STD_LOGIC;   
            MemW: in STD_LOGIC;
            FlagW: in STD_LOGIC_VECTOR(1 downto 0); 
            AluFlags: in STD_LOGIC_VECTOR(3 downto 0);  
            Clock: in STD_LOGIC;
            Reset: in STD_LOGIC;
            Cond: in STD_LOGIC_VECTOR(3 downto 0); 
            
            
--            PCSrc: out STD_LOGIC; 
            RegWrite: out STD_LOGIC;   
            MemWrite: out STD_LOGIC
            ); 
            
    end RegisterFlags;
    
    architecture Behavioral of RegisterFlags is
    
    component RegisterModule is 
        generic (
            N: integer);
        port(
            clk: in std_logic;
            reset: in std_logic;
            enable: in std_logic;
            data_in: in STD_LOGIC_VECTOR(N-1 downto 0);
            data_out: out STD_LOGIC_VECTOR(N-1 downto 0)
            );
    end component;
    
    component ConditionalCheck is
    --  Port ( );
        port (
            cond : in STD_LOGIC_VECTOR(3 downto 0);  
            Flags_high : in STD_LOGIC_VECTOR(1 downto 0); -- Flags [3:2] 
            Flags_low : in STD_LOGIC_VECTOR(1 downto 0);  -- Flags [1:0]      
            CondEx : out STD_LOGIC                  
         );
    end component;
    
    signal FlagWrite1: std_logic;
    signal FlagWrite0: std_logic;
    
    signal AluFlags10: STD_LOGIC_VECTOR(1 downto 0);
    signal AluFlags32: STD_LOGIC_VECTOR(1 downto 0);
    signal s_CondEx: STD_LOGIC;
    
    begin
    
    --    PCSrc <= PCS and s_CondEx;
        RegWrite <= RegW and s_CondEx;
        MemWrite <= MemW and s_CondEx;
        FlagWrite1<= FlagW(1) and s_CondEx;
        FlagWrite0<= FlagW(0) and s_CondEx;
        
        RegisterModule0Inst: RegisterModule 
        generic map (
            N => 2 
            )
        
        port map(
            clk => Clock,
            reset => Reset,
            enable => FlagWrite0,
            data_in => AluFlags(1 downto 0),
            data_out => AluFlags10
            );
        
        RegisterModule1Inst: RegisterModule 
        generic map(
            N=> 2)
        
        port map(
            clk => Clock,
            reset => Reset,
            enable => FlagWrite1,
            data_in => AluFlags(3 downto 2),
            data_out => AluFlags32);
                    
       ConditionalCheckInst: ConditionalCheck port map(
           cond => Cond,
           Flags_high => AluFlags32,
           Flags_low => AluFlags10,   
           CondEx => s_CondEx
           );
        
    
    end Behavioral;
