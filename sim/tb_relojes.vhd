-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 24.11.2023 09:58:01 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_RelojesDeTiempo is
end tb_RelojesDeTiempo;

architecture tb of tb_RelojesDeTiempo is

    component RelojesDeTiempo
        port (clkIn   : in std_logic;
              clkSec  : out std_logic;
              clkDSec : out std_logic;
              clkMin  : out std_logic;
              clkDMin : out std_logic);
    end component;

    signal clkIn   : std_logic;
    signal clkSec  : std_logic;
    signal clkDSec : std_logic;
    signal clkMin  : std_logic;
    signal clkDMin : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : RelojesDeTiempo
    port map (clkIn   => clkIn,
              clkSec  => clkSec,
              clkDSec => clkDSec,
              clkMin  => clkMin,
              clkDMin => clkDMin);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2;

    -- EDIT: Check that clkIn is really your main clock signal
    clkIn <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

        
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_RelojesDeTiempo of tb_RelojesDeTiempo is
    for tb
    end for;
    end cfg_tb_RelojesDeTiempo;