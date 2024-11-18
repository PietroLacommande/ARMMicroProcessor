----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2024 07:15:26 AM
-- Design Name: 
-- Module Name: InstructionMemory - Behavioral
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

entity InstructionMemory is
--  Port ( );
    port(
        PCprime: in STD_LOGIC_VECTOR(31 downto 0);
        Rd: out STD_LOGIC_VECTOR(31 downto 0);
        Clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        PcOut: out STD_LOGIC_VECTOR(31 downto 0)
        );
        
end InstructionMemory;

architecture Behavioral of InstructionMemory is
    type mem_array is array (31 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
    signal Mem : mem_array:= (
                                 0 => "11100000010000000000000000000000",
                                   1 => "11100010100000000010000000000101",
                                   2 => "11100010100000000011000000001100",
                                   3 => "11100010010000110111000000001001",
                                   4 => "11100001100001110100000000000010",
                                   5 => "11100000000000110101000000000100",
                                   6 => "11100000100001010101000000000100",
                                   7 => "11100000010101011000000000000111",
                                   8 => "11100000010100111000000000000100",
                                   9 => "11100010100000000101000000000000",
                                   10 => "11100000010101111000000000000010",
                                   11 => "10110010100001010111000000000001",
                                   12 => "11100000010001110111000000000010",
                                   13 => "11100101100000110111000001010100",
                                   14 => "11100101100100000010000001100000",
                                   15 => "11100000100010000101000000000000",
                                   16 => "11100010100000000010000000001110",
                                   17 => "11100010100000000010000000001101",
                                   18 => "11100010100000000010000000001010",
                                   19 => "11100101100000000010000001100100",
                                   others => (others => '0')
                                  );
                             

component RegisterModule is
generic(
    N: integer);
port(
     clk: in std_logic;
     reset: in std_logic;
     enable: in std_logic;
     data_in: in STD_LOGIC_VECTOR(N-1 downto 0);
     data_out: out STD_LOGIC_VECTOR(N-1 downto 0)
     );   
                               
end component;

signal PC: STD_LOGIC_VECTOR(31 downto 0);
                             
begin
RegisterModuleInst: RegisterModule 
generic map(
    N=>32)

port map(
    clk => Clk,
    reset => reset,
    enable => '1', --toujours à 1 car ici le module n'a pas besoin de enable
    data_in => PCprime,
    data_out => PC
);



Rd<= Mem(TO_INTEGER(UNSIGNED(PC(6 downto 2))));
PcOut <= PC;
        
       

end Behavioral;
