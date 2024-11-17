----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2024 02:27:29 PM
-- Design Name: 
-- Module Name: tb_extend - Behavioral
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

entity tb_extend is
--  Port ( );
end tb_extend;



architecture Behavioral of tb_extend is

--declare unit under test
component Extend 
    Port(instruc: in STD_LOGIC_VECTOR(23 downto 0);
        ImmSrc: in STD_LOGIC_VECTOR(1 downto 0);
        extended: out STD_LOGIC_VECTOR(31 downto 0));
end component;

--declare signals in and out of the component
Signal s_instruc: STD_LOGIC_VECTOR(23 downto 0);
Signal s_ImmSrc: STD_LOGIC_VECTOR(1 downto 0);
Signal s_extended: STD_LOGIC_VECTOR(31 downto 0);
Signal expected: STD_LOGIC_VECTOR(31 downto 0);

begin


--instantiate one unit under test and map the ports
Extend_inst: Extend
port map(s_instruc, s_ImmSrc, s_extended);  


process begin
s_ImmSrc<= "00";
s_instruc <= 0x"E6001F";
expected <= 0x"0000001F";

wait for 10 ns;

s_ImmSrc<= "01";
s_instruc <= 0x"170E5F";
expected <= 0x"00000E5F";
wait for 10 ns;

s_ImmSrc<= "10";
s_instruc <= 0x"5F14F1";
expected <= 0x"005F14F1";
wait;


end process;
end Behavioral;
