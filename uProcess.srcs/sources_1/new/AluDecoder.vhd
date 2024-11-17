----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2024 05:40:37 PM
-- Design Name: 
-- Module Name: AluDecoder - Behavioral
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

entity AluDecoder is
    port(
            Funct: in STD_LOGIC_VECTOR(4 downto 0);
            ALUOp: in STD_LOGIC; 
            ALUControl: out STD_LOGIC_VECTOR(1 downto 0);
            FlagW: out STD_LOGIC_VECTOR(1 downto 0)
            );
        
end AluDecoder;

architecture Behavioral of AluDecoder is

begin


process(Funct, ALUOp) begin
    case ALUOp is 
        
        when '0' =>
            ALUControl<= "00";
            FlagW<= "00";


         when '1' =>
         
            if(Funct(4 downto 1) = "0100") then
                ALUControl<= "00";
                
                if(Funct(0) ='0') then
                    FlagW<= "00";
                
                elsif(Funct(0) ='1') then 
                    FlagW<= "11";
                end if;
            
            
            elsif(Funct(4 downto 1) = "0010") then
                ALUControl<= "01";
                
                if(Funct(0) ='0') then
                    FlagW<= "00";
                
                elsif(Funct(0) ='1') then 
                    FlagW<= "11";
                end if;
            
            elsif(Funct(4 downto 1) = "0000") then
                ALUControl<= "10";
                
                if(Funct(0) ='0') then
                    FlagW<= "00";
                
                elsif(Funct(0) ='1') then 
                    FlagW<= "10";
                end if;
                
                
            elsif(Funct(4 downto 1) = "1100") then
                ALUControl<= "11";
                
                if(Funct(0) ='0') then
                    FlagW<= "00";
                
                elsif(Funct(0) ='1') then 
                    FlagW<= "10";
                end if;
            
            end if;
          when others =>
              ALUControl<= "--"; 
              FlagW<= "--";       
      end case;   
      
         
end process;

end Behavioral;
