----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2024 04:21:53 PM
-- Design Name: 
-- Module Name: tb_datapath - Behavioral
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
use IEEE.STD_LOGIC_TEXTIO.all; 
use STD.TEXTIO.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_datapath is
--  Port ( );
end tb_datapath;

architecture Behavioral of tb_datapath is

component Datapath is

    port(
        Clock: in STD_LOGIC;
        Reset: in STD_LOGIC;
        ALUResult: inout STD_LOGIC_VECTOR(31 downto 0);
        WriteData: inout STD_LOGIC_VECTOR(31 downto 0)
        );


end component;


--declare signals in and out of component
signal o_S_ALUResult: STD_LOGIC_VECTOR(31 downto 0);
signal o_S_WriteData: STD_LOGIC_VECTOR(31 downto 0);
signal i_Clock: STD_LOGIC;
signal i_Reset: STD_LOGIC;


signal expected_ALUResult: STD_LOGIC_VECTOR(31 downto 0);
signal expected_WriteData: STD_LOGIC_VECTOR(31 downto 0);


begin

--instantiate one unit under test and map the ports
DatapathInst: Datapath
port map(
     Clock =>i_Clock,
     Reset =>i_Reset,
     ALUResult => o_S_ALUResult,
     WriteData => o_S_WriteData
);
    
process begin
    i_Reset<= '1'; wait for 2ns;
    i_Reset<='0'; wait;
end process;
 
--generate clock
process begin    
    i_Clock<= '0'; wait for 5ns;
    i_Clock<= '1'; wait for 5ns;
end process; 
-- run tests
    

-- run tests
process is
    file tv: text;
    variable L: line;
    
    
   variable vector_ALUResult: STD_LOGIC_VECTOR(31 downto 0);
   variable vector_WriteData: STD_LOGIC_VECTOR(31 downto 0);

    variable dummy: character;
    variable vectornum: integer := 0;
    variable errors: integer := 0;
    
begin
    wait for 2ns;
    FILE_OPEN(tv, "C:/Users/Pietr/Desktop/GEI1084/uProcess/ExpectedData.txt", READ_MODE);
        while not endfile(tv) loop
            -- read the next line of test vectors and split into pieces
           readline(tv, L);
           read(L, vector_ALUResult);
           read(L, dummy); -- skip over underscore
           read(L, vector_WriteData);

            expected_ALUResult <= vector_ALUResult;
            expected_WriteData <= o_S_WriteData;
            
            if vector_ALUResult /= o_S_ALUResult then
                  report "Error: ExpectedALUResult = " & to_hstring(o_S_ALUResult);
                  errors := errors + 1;
                  
            end if;
            
            if vector_WriteData /= o_S_WriteData then
                  report "Error: ExpectedData = " & to_hstring(o_S_WriteData);
                  errors := errors + 1;
                              
            end if;           
          
            
              vectornum := vectornum + 1;
              
        wait for 10ns;              
end loop;
            
-- summarize results at end of simulation
if (errors = 0) then
    report "NO ERRORS -- " &
           integer'image(vectornum) & 
           " tests completed successfully." 
           severity note;
else
    report integer'image(vectornum) & 
           " tests completed, errors=" & 
           integer'image(errors)
           severity note;

end if;
end process;
end Behavioral;
