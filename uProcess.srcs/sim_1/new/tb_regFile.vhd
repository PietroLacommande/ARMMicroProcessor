----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2024 03:03:18 PM
-- Design Name: 
-- Module Name: tb_regFile - Behavioral
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


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity tb_regFile is
----  Port ( );
--end tb_regFile;

--architecture Behavioral of tb_regFile is

--begin


--end Behavioral;
----------------------------------------------------------------------------------
-- Test Bench for RegisterFile
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_regFile is
--  No ports in a test bench
end tb_regFile;

architecture Behavioral of tb_regFile is

--declare unit under test

    -- Signals to connect with the RegisterFile entity
    signal A1, A2, A3 : STD_LOGIC_VECTOR(3 downto 0);
    signal WD3, R15 : STD_LOGIC_VECTOR(31 downto 0);
    signal CLK, WE3 : STD_LOGIC;
    signal RD1, RD2 : STD_LOGIC_VECTOR(31 downto 0);
    signal expected_RD1, expected_RD2 : STD_LOGIC_VECTOR(31 downto 0);
    -- Clock period constant
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the RegisterFile module
    UUT: entity work.RegisterFile
    port map(
        A1 => A1,
        A2 => A2,
        A3 => A3,
        WD3 => WD3,
        CLK => CLK,
        WE3 => WE3,
        RD1 => RD1,
        RD2 => RD2
    );

    -- Clock process
    CLK_process: process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize signals
        A1 <= "0000";
        A2 <= "0001";
        A3 <= "0010";
        WD3 <= X"00000000";
        R15 <= X"00000000";
        WE3 <= '0';
        expected_RD1 <= X"00000000";
        expected_RD2 <= X"00000000";
        wait for CLK_PERIOD;
        
        -- Test case 1: Writing to register A3 and checking the value
        A3 <= "0010";
        WD3 <= X"00000001"; -- Write value 1 to register 2
        WE3 <= '1';
        expected_RD1 <= X"00000000";
        expected_RD2 <= X"00000000";
        wait for CLK_PERIOD; -- Wait for clock edge

        -- Check register read for A1 and A2
        WE3 <= '0';
        A1 <= "0010"; -- Reading register 2, expecting 1
        expected_RD1 <= X"00000001";
        A2 <= "0001"; -- Reading register 1, expecting 0
        expected_RD2 <= X"00000000";
        wait for CLK_PERIOD;
        
        -- Test case 2: Write a new value to another register and read it
        A3 <= "0011";
        WD3 <= X"00000010"; -- Write value 2 to register 3
        WE3 <= '1';
        expected_RD1 <= X"00000001";
        expected_RD2 <= X"00000000";
        wait for CLK_PERIOD;

        -- Check the new written value
        WE3 <= '0';
        A1 <= "0011"; -- Reading register 3, expecting 2
        expected_RD1 <= X"00000010";
        expected_RD2 <= X"00000000";        
        wait for CLK_PERIOD;

        -- End simulation
        wait;
    end process;
end Behavioral;
