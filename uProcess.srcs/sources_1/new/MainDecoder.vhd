----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2024 04:01:14 PM
-- Design Name: 
-- Module Name: MainDecoder - Behavioral
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

entity MainDecoder is
--  Port ( );
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
       
end MainDecoder;

architecture Behavioral of MainDecoder is
    
begin

process(Op, Funct5, Funct0) begin
    case Op is 
        when "00" =>
            if(Funct5 = '0') then
                Branch <= '0';
                MemtoReg <= '0';
                MemW <= '0';
                ALUSrc <= '0';
                ImmSrc <= "--";
                RegW <= '1';
                RegSrc <= "00";
                ALUOp <= '1';
          
            
            elsif(Funct5 = '1') then
                Branch <= '0';
                MemtoReg <= '0';
                MemW <= '0';
                ALUSrc <= '1';
                ImmSrc <= "00";
                RegW <= '1';
                RegSrc <= "-0";
                ALUOp <= '1';
            end if;


          when "01" =>
            if(Funct0 = '0') then
                Branch <= '0';
                MemtoReg <= '-';
                MemW <= '1';
                ALUSrc <= '1';
                ImmSrc <= "01";
                RegW <= '0';
                RegSrc <= "10";
                ALUOp <= '0';
          
            
            elsif(Funct0 = '1') then
                Branch <= '0';
                MemtoReg <= '1';
                MemW <= '0';
                ALUSrc <= '1';
                ImmSrc <= "01";
                RegW <= '1';
                RegSrc <= "-0";
                ALUOp <= '0';
            end if;
            
            
            when others =>
                Branch <= '-';
                MemtoReg <= '-';
                MemW <= '-';
                ALUSrc <= '-';
                ImmSrc <= "--";
                RegW <= '-';
                RegSrc <= "--";
                ALUOp <= '-';
                      
      end case;   
      
         
end process;
            
end Behavioral;
