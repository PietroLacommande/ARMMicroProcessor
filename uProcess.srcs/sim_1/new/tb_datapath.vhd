----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2024 04:21:53 PM
-- Design Name: 
-- Module Name: tb_datapath - Behavioral
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
use IEEE.STD_LOGIC_TEXTIO.all; 
use STD.TEXTIO.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_datapath is
--  Port ( );
end tb_datapath;

architecture Behavioral of tb_datapath is

component Datapath is

    port(
        Clock: in STD_LOGIC;
        Reset: in STD_LOGIC;
        ALUResult: inout STD_LOGIC_VECTOR(31 downto 0);
        WriteData: inout STD_LOGIC_VECTOR(31 downto 0);
        
        o_ZeroFlag: inout STD_LOGIC;
        o_RegWrite: inout STD_LOGIC
        );


end component;


--declare signals in and out of component
signal o_S_ALUResult: STD_LOGIC_VECTOR(31 downto 0);
signal o_S_WriteData: STD_LOGIC_VECTOR(31 downto 0);
signal s_o_ZeroFlag: STD_LOGIC;
signal s_o_RegWrite:  STD_LOGIC;
signal i_Clock: STD_LOGIC;
signal i_Reset: STD_LOGIC;



begin

--instantiate one unit under test and map the ports
DatapathInst: Datapath
port map(
     Clock =>i_Clock,
     Reset =>i_Reset,
     ALUResult => o_S_ALUResult,
     WriteData => o_S_WriteData,
      o_ZeroFlag=> s_o_ZeroFlag,
      o_RegWrite=> s_o_RegWrite
);
    
process begin
    i_Reset<= '1'; wait for 2ns;
    i_Reset<='0'; wait;
end process;
 
--generate clock
process begin    
    i_Clock<= '1'; wait for 5ns;
    i_Clock<= '0'; wait for 5ns;
end process; 

end Behavioral;
