----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2024 02:41:12 PM
-- Design Name: 
-- Module Name: DataMem - Behavioral
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

entity DataMem is
--  Port ( );
    port(A, WD: in STD_LOGIC_VECTOR(31 downto 0);
        CLK, WE: in STD_LOGIC;
        RD: out STD_LOGIC_VECTOR(31 downto 0)); 
end DataMem;

architecture Behavioral of DataMem is
    type mem_array is array (63 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
    signal Mem : mem_array:= (X"00000000",X"00000000",X"00000000",X"00000000",
                             X"00000000",X"00000000", X"00000000",X"00000000",
                             X"00000000",X"00000000",X"00000000",X"00000000",
                             X"00000000",X"00000000",X"00000000",X"00000000",
                             X"00000000",X"00000000",X"00000000",X"00000000",
                              X"00000000",X"00000000", X"00000000",X"00000000",
                              X"00000000",X"00000000",X"00000000",X"00000000",
                              X"00000000",X"00000000",X"00000000",X"00000000",
                              X"00000000",X"00000000",X"00000000",X"00000000",
                               X"00000000",X"00000000", X"00000000",X"00000000",
                               X"00000000",X"00000000",X"00000000",X"00000000",
                               X"00000000",X"00000000",X"00000000",X"00000000",
                               X"00000000",X"00000000",X"00000000",X"00000000",
                                X"00000000",X"00000000", X"00000000",X"00000000",
                                X"00000000",X"00000000",X"00000000",X"00000000",
                                X"00000000",X"00000000",X"00000000",X"00000000"          
                             );
begin

RD<= Mem(TO_INTEGER(UNSIGNED(A(5 downto 0))));

process(CLK) begin
    if rising_edge(CLK) then
       
        if(WE='1') then
            Mem(TO_INTEGER(UNSIGNED(A(5 downto 0))))<= WD;
       
        end if;
    end if;
    
end process;

end Behavioral;
