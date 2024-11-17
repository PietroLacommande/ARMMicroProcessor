----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2024 01:12:41 AM
-- Design Name: 
-- Module Name: ALU32bits - Behavioral
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

entity ALU32bits is
--  Port ( );
    port(inputA, inputB: in STD_LOGIC_VECTOR(31 downto 0);
         AluControl: in STD_LOGIC_VECTOR(1 downto 0);
         Result: out STD_LOGIC_VECTOR(31 downto 0);
         Cout: out STD_LOGIC;
         Bout: out STD_LOGIC;
         TempSum: out STD_LOGIC);
end ALU32bits;

architecture Behavioral of ALU32bits is
    
    
    component mux4
        port(d0, d1, d2, d3: in STD_LOGIC_VECTOR(31 downto 0);
             s: in STD_LOGIC_VECTOR(1 downto 0);
             y: out STD_LOGIC_VECTOR(31 downto 0));
    end component;
    
    
    component adder
        port(a,b: in STD_LOGIC_VECTOR(31 downto 0);
             cin: in STD_LOGIC;
             s: out STD_LOGIC_VECTOR (31 downto 0);
             cout: out STD_LOGIC);
    end component;
    

signal output_adder: STD_LOGIC_VECTOR(31 downto 0);
signal output_subtractor: STD_LOGIC_VECTOR(31 downto 0);
signal output_and: STD_LOGIC_VECTOR(31 downto 0);
signal output_or: STD_LOGIC_VECTOR(31 downto 0);


begin

    output_and <= inputA and inputB;
    output_or <= inputA or inputB;
    
       
    adder1: adder port map(inputA, inputB, '0', output_adder, Cout);
    subtractor1: adder port map(inputA, not(inputB),'1',output_subtractor, Bout);

    
    process (AluControl, output_adder, output_subtractor)
    begin
        if(AluControl(0)='0') then
            TempSum <= output_adder(31);
        elsif (AluControl(0)='1') then
            TempSum <= output_subtractor(31);
        end if;
    end process;
    
    mux4inst: mux4 port map (output_adder,output_subtractor, output_and,output_or,AluControl, Result);
   
end Behavioral;
