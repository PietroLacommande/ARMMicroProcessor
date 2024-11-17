----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2024 03:31:21 AM
-- Design Name: 
-- Module Name: tb_aluflags - Behavioral
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

entity tb_alu32flags is
--  Port ( );
end tb_alu32flags;

architecture Behavioral of tb_alu32flags is

component ALU_flags 
    port(a, b: in STD_LOGIC_VECTOR(31 downto 0);
         AluSelect: in STD_LOGIC_VECTOR(1 downto 0);
         ResultFinal: inout STD_LOGIC_VECTOR(31 downto 0);
         Zero: out STD_LOGIC;
         Negative: out STD_LOGIC;
         Carry: out STD_LOGIC;
         oVerflow: out STD_LOGIC
         );
end component;


--declare signals in and out of component
signal i_a: STD_LOGIC_VECTOR(31 downto 0);
signal i_b: STD_LOGIC_VECTOR(31 downto 0);
signal i_s: STD_LOGIC_VECTOR(1 downto 0);
signal o_result: STD_LOGIC_VECTOR(31 downto 0);        
signal o_Zero: STD_LOGIC;
signal o_Negative: STD_LOGIC;
signal o_Carry: STD_LOGIC;
signal o_oVerflow: STD_LOGIC;

--Signals for expected results
signal result_expected: STD_LOGIC_VECTOR(31 downto 0);        
signal Zero_expected: STD_LOGIC;
signal Negative_expected: STD_LOGIC;
signal Carry_expected: STD_LOGIC;
signal oVerflow_expected: STD_LOGIC;


begin


--instantiate one unit under test and map the ports
ALU_flagsInst: ALU_flags
port map(i_a,i_b,i_s,o_result,o_Zero,o_Negative, o_Carry, o_oVerflow);  

-- run tests
process is
    file tv: text;
    variable L: line;
    variable vector_AluControl: std_logic_vector(1 downto 0);
    variable vector_inA: std_logic_vector(31 downto 0);
    variable vector_inB: std_logic_vector(31 downto 0);
    variable vector_outExpectedResult: std_logic_vector(31 downto 0);
    variable vector_outFlags: std_logic_vector(3 downto 0);
    variable dummy: character;
    variable vectornum: integer := 0;
    variable errors: integer := 0;
    
begin
    FILE_OPEN(tv, "C:/Users/Pietr/Desktop/GEI1084/Devoir1v3/Testvec.txt", READ_MODE);
        while not endfile(tv) loop
            -- read the next line of test vectors and split into pieces
           readline(tv, L);
           read(L, vector_AluControl);
           read(L, dummy); -- skip over underscore
           read(L, vector_inA);
           read(L, dummy); -- skip over underscore
           read(L, vector_inB);
           read(L, dummy); -- skip over underscore
           read(L, vector_outExpectedResult);
           read(L, dummy); -- skip over underscore
           read(L, vector_outFlags);

           i_a<= vector_inA;
           i_b<= vector_inB;
           i_s<= vector_AluControl;
           
           result_expected<= vector_outExpectedResult;
           Negative_expected <= vector_outFlags(3);
           Zero_expected <= vector_outFlags(2);
           Carry_expected <= vector_outFlags(1);
           oVerflow_expected <= vector_outFlags(0);
            
            
            if o_result /= result_expected then
                  report "Error: o_result = " & to_hstring(o_result);
                  errors := errors + 1;
                  
            end if;      
            
            if o_Zero /= Zero_expected then
                 report "Error test-case# " & integer'image(vectornum)  & ": o_Zero = " & std_logic'image(o_Zero) & " when result= " & to_hstring(result_expected);
                 errors := errors + 1;
            end if;      

            if o_Negative /= Negative_expected then
                 report "Error test-case# " & integer'image(vectornum)  & ": o_Negative = " & std_logic'image(o_Negative) & " when result= " & to_hstring(result_expected);
                 errors := errors + 1;
            end if;      

            if o_Carry /= Carry_expected then
                 report "Error test-case# " & integer'image(vectornum)  & ": o_Carry = " & std_logic'image(o_Carry)  & " when result= " & to_hstring(result_expected);
                 errors := errors + 1;
            end if;  
            
            if o_oVerflow /= oVerflow_expected then
                 report "Error test-case# " & integer'image(vectornum)  & ": o_oVerflow = " & std_logic'image(o_oVerflow)  & " when result= " & to_hstring(result_expected);
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
