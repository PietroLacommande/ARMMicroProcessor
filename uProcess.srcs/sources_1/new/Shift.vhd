----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2024 07:06:41 PM
-- Design Name: 
-- Module Name: Shift - Behavioral
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
use IEEE.NUMERIC_STD.ALL; -- Required for arithmetic operations on std_logic_vector

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Shift is
--  Port ( );
    port(  
        control: in STD_LOGIC_VECTOR(6 downto 0);
        inputValue : in STD_LOGIC_VECTOR(31 downto 0);
        outputValue : out STD_LOGIC_VECTOR(31 downto 0));

end Shift;

architecture Behavioral of Shift is

begin


process(inputValue, control)
variable shift_amount : integer range 0 to 31; -- Shift amount extracted from control[6:2]

begin

shift_amount := to_integer(unsigned(control(6 downto 2)));

case control(1 downto 0) is
    
    --Logical shift left
    when "00" =>
      outputValue <= std_logic_vector(shift_left(unsigned(inputValue),  shift_amount));
       
    --Logical shift right
     when "01" =>
       outputValue <= std_logic_vector(shift_right(unsigned(inputValue),  shift_amount)); 
    
    --Arithemetic shift right
    when "10" =>
      outputValue <= std_logic_vector(shift_right(signed(inputValue),  shift_amount)); 
      
   
   --Rotate right
      when "11" =>
        outputValue <= inputValue(shift_amount - 1 downto 0) & inputValue(31 downto shift_amount); 
    
    when others =>
        outputValue <= (others => '0'); 
    
    end case;

end process;    
end Behavioral;
