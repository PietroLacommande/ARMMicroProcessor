----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2024 02:11:19 AM
-- Design Name: 
-- Module Name: PersonalMux - Behavioral
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

entity PersonalMux is
    port(d0, d1: in STD_LOGIC_VECTOR(31 downto 0);
         s: in STD_LOGIC;
         y: out STD_LOGIC_VECTOR(31 downto 0));
end PersonalMux;

architecture Behavioral of PersonalMux is

begin
    y<= d1 when s='1' else d0;

end Behavioral;
