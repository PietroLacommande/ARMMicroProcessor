----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2024 01:21:31 AM
-- Design Name: 
-- Module Name: adder - Behavioral
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
use IEEE.NUMERIC_STD_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
--  Port ( );
    port(a,b: in STD_LOGIC_VECTOR(31 downto 0);
         cin: in STD_LOGIC;
         s: out STD_LOGIC_VECTOR (31 downto 0);
         cout: out STD_LOGIC);
end adder;

architecture Behavioral of adder is
    signal result: STD_LOGIC_VECTOR(32 downto 0);
    
begin
    result<= ("0" & a)+ ("0" &b) +cin;
    s <= result(31 downto 0);
    cout <= result(32);

end Behavioral;
