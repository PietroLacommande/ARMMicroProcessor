----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2024 01:53:03 PM
-- Design Name: 
-- Module Name: tb_mainDecoder - Behavioral
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

entity tb_mainDecoder is
--  Port ( );
end tb_mainDecoder;

architecture Behavioral of tb_mainDecoder is


component MainDecoder 
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

end component;


--declare signals in and out of component
signal i_Op: STD_LOGIC_VECTOR(1 downto 0); 
signal i_Funct5: STD_LOGIC; 
signal i_Funct0: STD_LOGIC; 
signal o_RegW: STD_LOGIC;
signal o_MemW: STD_LOGIC;
signal o_MemtoReg: STD_LOGIC;
signal o_ALUSrc: STD_LOGIC;
signal o_AluOp: STD_LOGIC;
signal o_ImmSrc: STD_LOGIC_VECTOR(1 downto 0);
signal o_RegSrc: STD_LOGIC_VECTOR(1 downto 0);
       
       
signal o_Branch: STD_LOGIC; --not used in lab#3


--Signals for expected results
signal expected_RegW: STD_LOGIC;
signal expected_MemW: STD_LOGIC;
signal expected_MemtoReg: STD_LOGIC;
signal expected_ALUSrc: STD_LOGIC;
signal expected_AluOp: STD_LOGIC;
signal expected_ImmSrc: STD_LOGIC_VECTOR(1 downto 0);
signal expected_RegSrc: STD_LOGIC_VECTOR(1 downto 0);
signal expected_Branch: STD_LOGIC; --not used in lab#3




begin

--instantiate one unit under test and map the ports
MainDecoder_inst: MainDecoder
port map(
       Op => i_Op,
       Funct5 => i_Funct5,
       Funct0 => i_Funct0,
       RegW => o_RegW,
       MemW => o_MemW,
       MemtoReg => o_MemtoReg,
       ALUSrc => o_ALUSrc,
       AluOp => o_AluOp,
       ImmSrc => o_ImmSrc,
       RegSrc => o_RegSrc,
      Branch => o_Branch
);  

process begin
i_Op <= "00";
i_Funct5 <= '0';
i_Funct0 <= '-';

expected_Branch <= '0';
expected_MemtoReg <= '0';
expected_MemW <= '0';
expected_ALUSrc <= '0';
expected_ImmSrc <= "--";
expected_RegW <= '1';   
expected_RegSrc <= "00";
expected_AluOp <= '1';

 wait for 10 ns; -- Adjust time as needed
    -- Check outputs here if necessary

    -- Test case 2: DP Imm (00 1 X)
    i_Op <= "00";
    i_Funct5 <= '1';
    i_Funct0 <= '-';

    expected_Branch <= '0';
    expected_MemtoReg <= '0';
    expected_MemW <= '0';
    expected_ALUSrc <= '1';
    expected_ImmSrc <= "00";
    expected_RegW <= '1';
    expected_RegSrc <= "-0";
    expected_AluOp <= '1';
    
    wait for 10 ns;



    -- Test case 3: STR (01 X 0)
    i_Op <= "01";
    i_Funct5 <= '-';
    i_Funct0 <= '0';

    expected_Branch <= '0';
    expected_MemtoReg <= '-';
    expected_MemW <= '1';
    expected_ALUSrc <= '1';
    expected_ImmSrc <= "01";
    expected_RegW <= '0';
    expected_RegSrc <= "10";
    expected_AluOp <= '0';

    wait for 10 ns;

    -- Test case 4: LDR (01 X 1)
    i_Op <= "01";
    i_Funct5 <= '-';
    i_Funct0 <= '1';

    expected_Branch <= '0';
    expected_MemtoReg <= '1';
    expected_MemW <= '0';
    expected_ALUSrc <= '1';
    expected_ImmSrc <= "01";
    expected_RegW <= '1';
    expected_RegSrc <= "-0";
    expected_AluOp <= '0';

    wait for 10 ns;

    -- Finish simulation
    wait;



end process;


end Behavioral;
