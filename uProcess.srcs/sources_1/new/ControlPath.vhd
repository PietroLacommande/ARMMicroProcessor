----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2024 04:18:53 PM
-- Design Name: 
-- Module Name: ControlPath - Behavioral
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

entity ControlPath is
--  Port ( );
    port(
        --Inputs
        Cond: in STD_LOGIC_VECTOR(3 downto 0);  
        AluFlags: in STD_LOGIC_VECTOR(3 downto 0);     
        Op: in STD_LOGIC_VECTOR(1 downto 0);
        Funct: in STD_LOGIC_VECTOR(5 downto 0); 
        Rd: in STD_LOGIC_VECTOR(3 downto 0);
        Clock: in STD_LOGIC;  
        Reset: in STD_LOGIC;
        
        --outputs
--        PCSrc: out STD_LOGIC; 
        RegWrite: out STD_LOGIC;   
        MemWrite: out STD_LOGIC;
        MemtoReg: out STD_LOGIC; 
        AluSrc: out STD_LOGIC;   
        ImmSrc: out STD_LOGIC_VECTOR(1 downto 0);
        RegSrc: out STD_LOGIC_VECTOR(1 downto 0); 
        AluControl: out STD_LOGIC_VECTOR(1 downto 0)
        );  
       
end ControlPath;

architecture Behavioral of ControlPath is

signal FlagW: STD_LOGIC_VECTOR(1 downto 0);
signal PCS, RegW, MemW: STD_LOGIC;

component ControlUnit is
--  Port ( );
port(
        Op: in STD_LOGIC_VECTOR(1 downto 0);   
        Funct: in STD_LOGIC_VECTOR(5 downto 0);
        Rd: in STD_LOGIC_VECTOR(3 downto 0); 
        

        MemtoReg: out STD_LOGIC; 
        MemWrite: out STD_LOGIC;   
        ALUControl: out STD_LOGIC_VECTOR(1 downto 0);
        ALUSrc: out STD_LOGIC; 
        ImmSrc: out STD_LOGIC_VECTOR(1 downto 0);  
        RegWrite: out STD_LOGIC;
        RegSrc: out STD_LOGIC_VECTOR(1 downto 0);
        FlagW: out STD_LOGIC_VECTOR(1 downto 0)
        ); 
        
end component;

component RegisterFlags is
--  Port ( );
    port(
--        PCS: in STD_LOGIC; 
        RegW: in STD_LOGIC;   
        MemW: in STD_LOGIC;
        FlagW: in STD_LOGIC_VECTOR(1 downto 0); 
        AluFlags: in STD_LOGIC_VECTOR(3 downto 0);  
        Clock: in STD_LOGIC;
        Reset: in STD_LOGIC;
        Cond: in STD_LOGIC_VECTOR(3 downto 0); 
        
        
--        PCSrc: out STD_LOGIC; 
        RegWrite: out STD_LOGIC;   
        MemWrite: out STD_LOGIC
        ); 
        
end component;

begin
ControlUnitInst: ControlUnit port map(
    Op => Op,
    Funct => Funct,
    Rd => Rd,

    MemtoReg => MemtoReg,
    MemWrite => MemW,
    ALUControl => AluControl,
    ALUSrc => AluSrc,
    ImmSrc => ImmSrc,
    RegWrite => RegW,
    RegSrc => RegSrc,
    FlagW => FlagW
);    

RegisterFlagsInst: RegisterFlags  port map(
        --PCS 
        RegW=> RegW, 
        MemW=> MemW,
        FlagW => FlagW,
        AluFlags => AluFlags,
        Clock => Clock,
        Reset => Reset,
        Cond => Cond,
        
        
--        PCSrc => 
        RegWrite => RegWrite,
        MemWrite => MemWrite
        ); 

end Behavioral;
