----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/09/2024 12:43:35 AM
-- Design Name: 
-- Module Name: Extend - Behavioral
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

entity Extend is
--  Port ( );
    Port(instruc: in STD_LOGIC_VECTOR(23 downto 0);
        ImmSrc: in STD_LOGIC_VECTOR(1 downto 0);
        extended: out STD_LOGIC_VECTOR(31 downto 0));
end Extend;

architecture Behavioral of Extend is

begin

process(ImmSrc, instruc) begin
    
    case ImmSrc is
        
        when "00" =>
            extended <= X"000000" & instruc(7 downto 0);

        when "01" =>
            extended <= X"00000" & instruc(11 downto 0);
            
        when "10" =>
             extended <= X"00" & instruc(23 downto 0);
             
         when others =>
             extended <= (others => '0');  -- Default: set all bits to zero
             
             
    end case;
end process;

end Behavioral;
