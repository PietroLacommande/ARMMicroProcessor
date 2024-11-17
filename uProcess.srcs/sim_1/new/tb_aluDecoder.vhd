----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2024 02:30:20 PM
-- Design Name: 
-- Module Name: tb_aluDecoder - Behavioral
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

entity tb_aluDecoder is
--  Port ( );
end tb_aluDecoder;

architecture Behavioral of tb_aluDecoder is

component AluDecoder
    port(
            Funct: in STD_LOGIC_VECTOR(4 downto 0);
            ALUOp: in STD_LOGIC; 
            ALUControl: out STD_LOGIC_VECTOR(1 downto 0);
            FlagW: out STD_LOGIC_VECTOR(1 downto 0)
            );
        
end component;



--declare signals in and out of component
signal i_Funct:  STD_LOGIC_VECTOR(4 downto 0);
signal i_ALUOp: STD_LOGIC; 
signal o_ALUControl: STD_LOGIC_VECTOR(1 downto 0);
signal o_FlagW: STD_LOGIC_VECTOR(1 downto 0);


--Signals for expected results
signal expected_ALUControl: STD_LOGIC_VECTOR(1 downto 0);
signal expected_FlagW: STD_LOGIC_VECTOR(1 downto 0);



begin


--instantiate one unit under test and map the ports
AluDecoder_inst: AluDecoder
port map(
       Funct =>i_Funct,
       ALUOp => i_ALUOp,
       ALUControl => o_ALUControl,
       FlagW => o_FlagW
);  

process begin
i_ALUOp <= '0';


expected_ALUControl <= "00";
expected_FlagW <= "00";


 wait for 10 ns; -- Adjust time as needed

i_ALUOp <= '0';
i_Funct <= "01000";


expected_ALUControl <= "00";
expected_FlagW <= "00";


 wait for 10 ns; -- Adjust time as needed





-- Test case 2: ALUOp = 1, Funct = 0100 (ADD), Funct0 = 0
    i_ALUOp <= '1';
    i_Funct <= "01000";
    expected_ALUControl <= "00";
    expected_FlagW <= "00";
    wait for 10 ns;

    -- Test case 3: ALUOp = 1, Funct = 0100 (ADD), Funct0 = 1
    i_ALUOp <= '1';
    i_Funct <= "01001";
    expected_ALUControl <= "00";
    expected_FlagW <= "11";
    wait for 10 ns;

    -- Test case 4: ALUOp = 1, Funct = 0010 (SUB), Funct0 = 0
    i_ALUOp <= '1';
    i_Funct <= "00100";
    expected_ALUControl <= "01";
    expected_FlagW <= "00";
    wait for 10 ns;

    -- Test case 5: ALUOp = 1, Funct = 0010 (SUB), Funct0 = 1
    i_ALUOp <= '1';
    i_Funct <= "00101";
    expected_ALUControl <= "01";
    expected_FlagW <= "11";
    wait for 10 ns;

    -- Test case 6: ALUOp = 1, Funct = 0000 (AND), Funct0 = 0
    i_ALUOp <= '1';
    i_Funct <= "00000";
    expected_ALUControl <= "10";
    expected_FlagW <= "00";
    wait for 10 ns;

    -- Test case 7: ALUOp = 1, Funct = 0000 (AND), Funct0 = 1
    i_ALUOp <= '1';
    i_Funct <= "00001";
    expected_ALUControl <= "10";
    expected_FlagW <= "10";
    wait for 10 ns;

    -- Test case 8: ALUOp = 1, Funct = 1100 (ORR), Funct0 = 0
    i_ALUOp <= '1';
    i_Funct <= "11000";
    expected_ALUControl <= "11";
    expected_FlagW <= "00";
    wait for 10 ns;

    -- Test case 9: ALUOp = 1, Funct = 1100 (ORR), Funct0 = 1
    i_ALUOp <= '1';
    i_Funct <= "11001";
    expected_ALUControl <= "11";
    expected_FlagW <= "10";
    wait for 10 ns;

    -- Finish simulation
    wait;




end process;
end Behavioral;
