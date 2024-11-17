----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2024 08:47:25 AM
-- Design Name: 
-- Module Name: Additionneur - Behavioral
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
use IEEE.STD_LOGIC_1164.all;  
use IEEE.NUMERIC_STD_UNSIGNED.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Additionneur is
--  Port ( );
    port(
            a, b: in  STD_LOGIC_VECTOR(31 downto 0); 
            y: out STD_LOGIC_VECTOR(31 downto 0)); 
end Additionneur;

architecture Behavioral of Additionneur is

begin

    y <= a + b;
end Behavioral;
