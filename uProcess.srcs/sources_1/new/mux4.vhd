----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2024 01:16:16 AM
-- Design Name: 
-- Module Name: mux4 - Behavioral
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

entity mux4 is
--  Port ( );

    port(d0, d1, d2, d3: in STD_LOGIC_VECTOR(31 downto 0);
         s: in STD_LOGIC_VECTOR(1 downto 0);
         y: out STD_LOGIC_VECTOR(31 downto 0));
end mux4;

architecture Behavioral of mux4 is
    component PersonalMux2
        port(d0, d1: in STD_LOGIC_VECTOR(31 downto 0);
            s: in STD_LOGIC;
            y: out STD_LOGIC_VECTOR(31 downto 0));
    end component;
    
    
    signal low, high: STD_LOGIC_VECTOR(31 downto 0);
    
    
begin
    lowmux: PersonalMux2 port map  (d0, d1, s(0), low);  
    highmux: PersonalMux2 port map (d2, d3, s(0), high);
    finalmux: PersonalMux2 port map (low, high, s(1), y);

    

end Behavioral;
