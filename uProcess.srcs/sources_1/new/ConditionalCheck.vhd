----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2024 03:17:14 PM
-- Design Name: 
-- Module Name: ConditionalCheck - Behavioral
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

entity ConditionalCheck is
--  Port ( );
    port (
        cond : in STD_LOGIC_VECTOR(3 downto 0);  
        Flags_high : in STD_LOGIC_VECTOR(1 downto 0); -- Flags [3:2] 
        Flags_low : in STD_LOGIC_VECTOR(1 downto 0);  -- Flags [1:0]      
        CondEx : out STD_LOGIC                  
     );
end ConditionalCheck;

architecture Behavioral of ConditionalCheck is

begin
process(cond, Flags_high, Flags_low)
    begin
        case cond is
            when "0000" =>  -- EQ (Equal)
                CondEx <= Flags_low(0);  -- Z flag (bit 0)
            when "0001" =>  -- NE (Not Equal)
                CondEx <= not Flags_low(0);  -- Z? (bit 0)
            when "0010" =>  -- CS/HS (Carry Set/Unsigned Higher or Same)
                CondEx <= Flags_high(1);  -- C flag (bit 3)
            when "0011" =>  -- CC/LO (Carry Clear/Unsigned Lower)
                CondEx <= not Flags_high(1);  -- C? (bit 3)
            when "0100" =>  -- MI (Minus/Negative)
                CondEx <= Flags_high(0);  -- N flag (bit 2)
            when "0101" =>  -- PL (Plus/Positive or Zero)
                CondEx <= not Flags_high(0);  -- N? (bit 2)
            when "0110" =>  -- VS (Overflow Set)
                CondEx <= Flags_low(1);  -- V flag (bit 1)
            when "0111" =>  -- VC (No Overflow/Overflow Clear)
                CondEx <= not Flags_low(1);  -- V? (bit 1)
            when "1000" =>  -- HI (Unsigned Higher)
                CondEx <= (Flags_high(1) and not Flags_low(0));  -- C and Z?
            when "1001" =>  -- LS (Unsigned Lower or Same)
                CondEx <= (Flags_low(0) or not Flags_high(1));  -- Z or C?
            when "1010" =>  -- GE (Signed Greater or Equal)
                CondEx <= not(Flags_high(0) xor Flags_low(1));  -- N ? V = 0
            when "1011" =>  -- LT (Signed Less Than)
                CondEx <= (Flags_high(0) xor Flags_low(1));  -- N ? V = 1
            when "1100" =>  -- GT (Signed Greater)
                CondEx <= (not(Flags_low(0)) and (not((Flags_high(0) xor Flags_low(1)))));  -- Z? and N ? V = 0
            when "1101" =>  -- LE (Signed Less or Equal)
                CondEx <= Flags_low(0) or (Flags_high(0) xor Flags_low(1));  -- Z or N ? V = 1
            when others =>  -- AL (Always/Unconditional)
                CondEx <= '1';
        end case;
    end process;

end Behavioral;





