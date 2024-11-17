----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2024 02:52:40 AM
-- Design Name: 
-- Module Name: ALU_flags - Behavioral
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

entity ALU_flags is
--  Port ( );
    port(a, b: in STD_LOGIC_VECTOR(31 downto 0);
         AluSelect: in STD_LOGIC_VECTOR(1 downto 0);
         ResultFinal: inout STD_LOGIC_VECTOR(31 downto 0);
         Zero: out STD_LOGIC;
         Negative: out STD_LOGIC;
         Carry: out STD_LOGIC;
         oVerflow: out STD_LOGIC
         );
end ALU_flags;

architecture Behavioral of ALU_flags is
    
    component ALU32bits
    port(inputA, inputB: in STD_LOGIC_VECTOR(31 downto 0);
         AluControl: in STD_LOGIC_VECTOR(1 downto 0);
         Result: out STD_LOGIC_VECTOR(31 downto 0);
         Cout: out STD_LOGIC;
         Bout: out STD_LOGIC;
         TempSum: out STD_LOGIC);
    end component;
    
    
    
    signal outputCarry: STD_LOGIC;
    signal outputBorrow: STD_LOGIC;
    signal resultSum1bit: STD_LOGIC;

begin
    ALU32bitsInst: ALU32bits port map(a,b,AluSelect, ResultFinal,outputCarry,outputBorrow,resultSum1bit);
    Zero<= and(not(ResultFinal));
    Negative <= ResultFinal(31);
    oVerflow <= (not(AluSelect(1))) and (a(31) xor resultSum1bit) and (not((AluSelect(0) xor a(31) xor b(31))));

    process (all)
    begin
        if(AluSelect(0)='0') then
            Carry <= (outputCarry) and (not(AluSelect(1)));
        elsif (AluSelect(0)='1') then
            Carry <= (outputBorrow) and (not(AluSelect(1)));
        end if;
    end process;

    

    
    
 

end Behavioral;
