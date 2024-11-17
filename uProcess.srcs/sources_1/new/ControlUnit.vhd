----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2024 06:08:29 PM
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
--  Port ( );
port(
--        Cond: in STD_LOGIC_VECTOR(3 downto 0); 
        Op: in STD_LOGIC_VECTOR(1 downto 0);   
        Funct: in STD_LOGIC_VECTOR(5 downto 0);
        Rd: in STD_LOGIC_VECTOR(3 downto 0); 
--        Flags: in STD_LOGIC_VECTOR(3 downto 0);  --pour le labo #4
        

        MemtoReg: out STD_LOGIC; 
        MemWrite: out STD_LOGIC;   
        ALUControl: out STD_LOGIC_VECTOR(1 downto 0);
        ALUSrc: out STD_LOGIC; 
        ImmSrc: out STD_LOGIC_VECTOR(1 downto 0);  
        RegWrite: out STD_LOGIC;
        RegSrc: out STD_LOGIC_VECTOR(1 downto 0);
        FlagW: out STD_LOGIC_VECTOR(1 downto 0)
        ); 
        
end ControlUnit;

architecture Behavioral of ControlUnit is

component MainDecoder is
 port(Op: in STD_LOGIC_VECTOR(1 downto 0);
       Funct5: in STD_LOGIC; 
       Funct0: in STD_LOGIC; 
       RegW: out STD_LOGIC;
       MemW: out STD_LOGIC;
       MemtoReg: out STD_LOGIC;
       ALUSrc: out STD_LOGIC;
       AluOp: out STD_LOGIC;
       ImmSrc: out STD_LOGIC_VECTOR(1 downto 0);
       RegSrc: out STD_LOGIC_VECTOR(1 downto 0);
       
       
       Branch: out STD_LOGIC --not used in lab#3
);
end component;


component AluDecoder is
    port(
            Funct: in STD_LOGIC_VECTOR(4 downto 0);
            ALUOp: in STD_LOGIC; 
            ALUControl: out STD_LOGIC_VECTOR(1 downto 0);
            FlagW: out STD_LOGIC_VECTOR(1 downto 0)
            );
        
end component;


signal s_AluOp: STD_LOGIC;

begin

MainDecoderInst1: MainDecoder 
    port map(
        Op => Op, 
        Funct5 => Funct(5),
        Funct0 => Funct(0),
        AluOp => s_AluOp,
        
        RegW => RegWrite,
        MemW => MemWrite,
        MemtoReg => MemtoReg,
        ALUSrc => ALUSrc,
        ImmSrc => ImmSrc,
        RegSrc => RegSrc
             
    );
    
AluDecoderInst1: AluDecoder
    port map(
       Funct => Funct(4 downto 0),
       ALUOp => s_AluOp,
       ALUControl => ALUControl,
       FlagW => FlagW
       );
end Behavioral;
