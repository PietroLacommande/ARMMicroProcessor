----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2024 03:29:38 PM
-- Design Name: 
-- Module Name: Datapath - Behavioral
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

entity Datapath is
--  Port ( );
    port(
        Clock: in STD_LOGIC;
        Reset: in STD_LOGIC;
        ALUResult: inout STD_LOGIC_VECTOR(31 downto 0);
        WriteData: inout STD_LOGIC_VECTOR(31 downto 0);
        
        o_ZeroFlag: inout STD_LOGIC;
        o_RegWrite: inout STD_LOGIC
                );

end Datapath;

architecture Behavioral of Datapath is

component ControlPath is
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
       
end component;




component  Extend is
--  Port ( );
    Port(instruc: in STD_LOGIC_VECTOR(23 downto 0);
        ImmSrc: in STD_LOGIC_VECTOR(1 downto 0);
        extended: out STD_LOGIC_VECTOR(31 downto 0));
end component;

component RegisterFile 
--  Port ( );
     Port(A1, A2, A3: in STD_LOGIC_VECTOR(3 downto 0);
       WD3: in STD_LOGIC_VECTOR(31 downto 0);
       CLK: in STD_LOGIC;
       WE3: in STD_LOGIC;
       RD1, RD2: out STD_LOGIC_VECTOR(31 downto 0));
       
end component;


component DataMem 
--  Port ( );
    port(A, WD: in STD_LOGIC_VECTOR(31 downto 0);
        CLK, WE: in STD_LOGIC;
        RD: out STD_LOGIC_VECTOR(31 downto 0)); 
end component;

component ALU_flags 
--  Port ( );
    port(a, b: in STD_LOGIC_VECTOR(31 downto 0);
         AluSelect: in STD_LOGIC_VECTOR(1 downto 0);
         ResultFinal: inout STD_LOGIC_VECTOR(31 downto 0);
         Zero: out STD_LOGIC;
         Negative: out STD_LOGIC;
         Carry: out STD_LOGIC;
         oVerflow: out STD_LOGIC
         );
end component;

component PersonalMux 
    port(d0, d1: in STD_LOGIC_VECTOR(31 downto 0);
         s: in STD_LOGIC;
         y: out STD_LOGIC_VECTOR(31 downto 0));
end component;


component InstructionMemory
    port(
        PCprime: in STD_LOGIC_VECTOR(31 downto 0);
        Rd: out STD_LOGIC_VECTOR(31 downto 0);
        Clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        PcOut: out STD_LOGIC_VECTOR(31 downto 0)
        );
        
end component;

component Additionneur is
    port(
            a, b: in  STD_LOGIC_VECTOR(31 downto 0); 
            y: out STD_LOGIC_VECTOR(31 downto 0)); 
end component;


signal RA1, RA2, SrcA, SrcB, ExtImm, ReadData : STD_LOGIC_VECTOR(31 downto 0);
signal MemtoReg, MemWrite, ALUSrc, RegWrite: STD_LOGIC; 
signal ALUControl, ImmSrc, RegSrc: STD_LOGIC_VECTOR(1 downto 0);

signal s_ALUResult, s_WriteData: STD_LOGIC_VECTOR(31 downto 0);
signal Result: STD_LOGIC_VECTOR(31 downto 0);
signal flag_Zero, flag_Negative, flag_Carry, flag_oVerflow: STD_LOGIC;
signal s_PCprime: STD_LOGIC_VECTOR(31 downto 0);
signal Instruction:  STD_LOGIC_VECTOR(31 downto 0);
signal s_PcOut: STD_LOGIC_VECTOR(31 downto 0);
signal PCPlus4, PCPlus8 : STD_LOGIC_VECTOR(31 downto 0);


begin
ALUResult<= s_ALUResult;
WriteData <= s_WriteData;
o_ZeroFlag <= flag_Zero;
o_RegWrite <= RegWrite;


ControlPathInst: ControlPath
    port map(
         Cond => Instruction(31 downto 28),
         AluFlags => flag_Carry & flag_Negative & flag_oVerflow & flag_Zero,
         Op => Instruction(27 downto 26),
         Funct =>  Instruction(25 downto 20),
         Rd => Instruction(15 downto 12),
         Clock => Clock,
         Reset => Reset,
       
       --outputs
--        PCSrc: out STD_LOGIC; 
         RegWrite => RegWrite, 
         MemWrite => MemWrite,
         MemtoReg => MemtoReg,
         AluSrc => ALUSrc,
         ImmSrc => ImmSrc,
         RegSrc => RegSrc,
         AluControl => ALUControl
           );
        


PersonalMuxinst1: PersonalMux 
    port map(
        d0 => "0000000000000000000000000000" & Instruction(19 downto 16),  -- 28-bit zero
        d1 => "0000000000000000000000000000000" & Instruction(15),
        s => RegSrc(0), 
        y => RA1
    );
    
PersonalMuxinst2: PersonalMux 
    port map(
        d0 => 28x"0" & Instruction(3 downto 0),
        d1 => 28x"0" & Instruction(15 downto 12), 
        s => RegSrc(1), 
        y => RA2
    );
RegisterFileinst: RegisterFile 
        port map(
            A1 => RA1(3 downto 0),
            A2 => RA2(3 downto 0),
            A3 => Instruction(15 downto 12),
            WD3 => Result,
            CLK => Clock,
            WE3 => RegWrite,
            RD1 => SrcA,
            RD2 => s_WriteData
        ); 

           
Extendinst: Extend 
    port map(
        instruc => Instruction(23 downto 0),
        ImmSrc => ImmSrc,
        extended => ExtImm
    );
    
PersonalMuxinst3: PersonalMux 
        port map(
            d0 => WriteData,
            d1 => ExtImm,
            s => ALUSrc,
            y => SrcB
        );

ALU_flagsinst: Alu_flags 
    port map(
        a => SrcA,
        b => SrcB,
        AluSelect => ALUControl,
        ResultFinal => s_ALUResult,
        Zero => flag_Zero,
        Negative => flag_Negative,
        Carry => flag_Carry,
        oVerflow => flag_oVerflow
    );
    

    
DataMemInst: DataMem 
        port map(
            A => s_ALUResult,
            WD => s_WriteData,
            CLK => Clock,
            WE => MemWrite,
            RD => ReadData
        );
        
        

PersonalMuxinst4: PersonalMux 
    port map(
        d0 => s_ALUResult,
        d1 => ReadData,
        s => MemtoReg,
        y => Result
    );   
    
    
    
    
    
    
--AJOUT LABORATOIRE 4
    PcMux: PersonalMux 
    port map(
        d0 => PCPlus4,
        d1 => s_ALUResult,
        s => '0',
        y => s_PCprime
    );   
    
 InstructionMemoryInst: InstructionMemory
--  Port ( );
    port map(
        PCprime => s_PCprime,
        Rd => Instruction,
        Clk => Clock,
        reset => Reset,
        PcOut => s_PcOut
        );
        
AdditionneurInst4:Additionneur
    port map(
            a => s_PcOut,
            b => 0x"00000004",
            y => PCPlus4);

AdditionneurInst8:Additionneur
    port map(
            a => 0x"00000004",
            b => PCPlus4,
            y => PCPlus8);
                            

end Behavioral;
