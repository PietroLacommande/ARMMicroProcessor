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
--                                 0 => "1110_00_1_1010_1_0000_0001_000000001010",   --Immediate value, Op =01 for testing, 
--                                  0 => "11100011010100000000000000001010",   --Immediate value, Op =00 for testing, 
                                  0=> "11100011010100000001000000000001",
                                  1=> "11100011010100000001000000000011",
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
