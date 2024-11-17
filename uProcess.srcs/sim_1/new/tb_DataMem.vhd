----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2024 06:29:43 PM
-- Design Name: 
-- Module Name: tb_DataMem - Behavioral
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

entity tb_DataMem is
--  Port ( );
end tb_DataMem;

architecture Behavioral of tb_DataMem is

--declare unit under test
component DataMem 
--  Port ( );
    port(A, WD: in STD_LOGIC_VECTOR(31 downto 0);
        CLK, WE: in STD_LOGIC;
        RD: out STD_LOGIC_VECTOR(31 downto 0)); 
end component;

--declare signals in and out of the component
signal i_A: STD_LOGIC_VECTOR(31 downto 0);
signal i_WD: STD_LOGIC_VECTOR(31 downto 0);
signal i_CLK: STD_LOGIC;  
signal i_WE: STD_LOGIC;
signal o_RD: STD_LOGIC_VECTOR(31 downto 0); 
signal expected_RD1 : STD_LOGIC_VECTOR(31 downto 0);

constant CLK_PERIOD : time := 10 ns;


begin

--instantiate one unit under test and map the ports
DataMemInst: DataMem
port map(i_A, i_WD, i_CLK, i_WE, o_RD);



    -- Clock process
CLK_process: process
    begin
        i_CLK <= '0';
        wait for CLK_PERIOD/2;
        i_CLK <= '1';
        wait for CLK_PERIOD/2;
end process;

process begin
-- Initialize signals
    i_WE <= '0';
    i_WD <= 32x"00"; 
    i_A <= 32x"00";
    expected_RD1 <= 32x"00000000";
    wait for CLK_PERIOD;
    
    -- Test case 1: Writing to register A3 and checking the value
    i_WE <= '1';
    i_A <= 32x"05";
    i_WD <= 32x"4545EF"; -- Write value 4545EF to register 5
    expected_RD1 <= 32x"00";
    wait for CLK_PERIOD; -- Wait for clock edge

    -- Check register read for A1 and A2
    i_WE <= '0';
    i_A <= 32x"05"; -- Reading register 2, expecting 1
    expected_RD1 <= 32x"4545EF";
     wait;



end process;

end Behavioral;
