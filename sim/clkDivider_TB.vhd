library ieee;
use ieee.std_logic_1164.all;

entity tb_clock_divider is
end tb_clock_divider;

architecture tb of tb_clock_divider is

    component clock_divider
        port (clk_in  : in std_logic;
              clk_out : out std_logic);
    end component;

    signal clk_in  : std_logic;
    signal clk_out : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : clock_divider
    port map (clk_in  => clk_in,
              clk_out => clk_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2;

    -- EDIT: Check that clk_in is really your main clock signal
    clk_in <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

        -- EDIT Add stimuli here
        
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_clock_divider of tb_clock_divider is
    for tb
    end for;
end cfg_tb_clock_divider;