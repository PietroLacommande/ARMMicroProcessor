----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/09/2024 12:29:55 AM
-- Design Name: 
-- Module Name: RegisterFile - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile is
--  Port ( );
     Port(A1, A2, A3: in STD_LOGIC_VECTOR(3 downto 0);
       WD3: in STD_LOGIC_VECTOR(31 downto 0);
       CLK: in STD_LOGIC;
       WE3: in STD_LOGIC;
       RD1, RD2: out STD_LOGIC_VECTOR(31 downto 0));
       
end RegisterFile;

architecture Behavioral of RegisterFile is
    type mem_array is array (15 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
    signal Mem : mem_array:= (X"00000000",X"00000000",X"00000000",X"00000000",
                             X"00000000",X"00000000", X"00000000",X"00000000",
                             X"00000000",X"00000000",X"00000000",X"00000000",
                             X"00000000",X"00000000",X"00000000",X"00000000");
begin

process(A1,A2)
begin
    RD1<= Mem(TO_INTEGER(UNSIGNED(A1)));
    RD2 <= Mem(TO_INTEGER(UNSIGNED(A2)));
end process;

process(CLK) begin
    if rising_edge(CLK) then
        if WE3='1' then
            Mem(TO_INTEGER(UNSIGNED(A3)))<= WD3;
        end if;
    end if;
    
end process;
end Behavioral;
