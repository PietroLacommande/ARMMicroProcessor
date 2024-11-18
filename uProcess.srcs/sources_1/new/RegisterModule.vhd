----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2024 02:52:23 PM
-- Design Name: 
-- Module Name: Register - Behavioral
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

entity RegisterModule is
--  Port ( );
    generic(
        N: integer  
            );
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        data_in: in STD_LOGIC_VECTOR(N-1 downto 0);
        data_out: out STD_LOGIC_VECTOR(N-1 downto 0)
        );
end RegisterModule;

architecture Behavioral of RegisterModule is


begin
    process(CLK, reset, data_in)
    begin 
        if reset='1' then 
            data_out<= (others => '0');
        elsif  rising_edge(clk) then 
            if enable ='1' then
                data_out<= data_in;
            end if;
        end if;           

    end process;
end Behavioral;
