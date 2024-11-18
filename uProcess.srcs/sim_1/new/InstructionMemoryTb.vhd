library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_RegisterModule is
end tb_RegisterModule;

architecture Behavioral of tb_RegisterModule is
    component RegisterModule is
        generic(
            N: integer  
        );
        port(
            clk: in std_logic;
            reset: in std_logic;
            enable: in std_logic;
            data_in: in STD_LOGIC_VECTOR(N-1 downto 0);
            data_out: out STD_LOGIC_VECTOR(N-1 downto 0)
        );
    end component;

    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal enable   : std_logic := '1';
    signal data_in  : std_logic_vector(31 downto 0) := (others => '0');
    signal data_out : std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;
begin
    -- Instantiate RegisterModule
    uut: RegisterModule
        generic map (
            N => 32
        )
        port map (
            clk => clk,
            reset => reset,
            enable => enable,
            data_in => data_in,
            data_out => data_out
        );

    -- Clock process
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Test process
    test_process : process
    begin
        -- Reset the register
        reset <= '1';
        wait for clk_period;
        reset <= '0';

        -- Apply test inputs
        data_in <= X"00000004";
        wait for clk_period;
        data_in <= X"00000008";
        wait for clk_period;
        data_in <= X"0000000C";

        -- Disable register updates
        enable <= '0';
        wait for clk_period;

        -- Enable again
        enable <= '1';
        data_in <= X"00000010";
        wait for clk_period;

        -- Stop simulation
        wait;
    end process;
end Behavioral;
