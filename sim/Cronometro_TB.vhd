-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 19.11.2023 14:54:07 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_Cronometro is
end tb_Cronometro;

architecture tb of tb_Cronometro is

    component Cronometro
        port (clk         : in std_logic;
              buttons     : in std_logic_vector (3 downto 0);
              stateActive: in std_logic_vector(7 downto 0);
              digits_0to3 : out std_logic_vector (15 downto 0);
              digits_4to7 : out std_logic_vector (15 downto 0);
              blink_ctrl  : out std_logic_vector (7 downto 0));
    end component;

    signal clk         : std_logic;
    signal buttons     : std_logic_vector (3 downto 0);
    signal digits_0to3 : std_logic_vector (15 downto 0);
    signal digits_4to7 : std_logic_vector (15 downto 0);
    signal blink_ctrl  : std_logic_vector (7 downto 0);
    signal stateActive: std_logic_vector(7 downto 0);
    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Cronometro
    port map (clk         => clk,
              buttons     => buttons,
              stateActive => stateActive,
              digits_0to3 => digits_0to3,
              digits_4to7 => digits_4to7,
              blink_ctrl  => blink_ctrl);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 ;

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
    ------------------ELIMINAR CONDICION CLKSec DE CRONOMETRO.VHD PARA PROBAR--------------------
    stateActive <="10000000";
    --Para simular el funcionamiento cambiar en el Cronometro.vhd -> DIVIDER_VALUE => 1
        -- EDIT Adapt initialization as needed
        buttons <= "0001";
        wait for 20 * TbPeriod;
        buttons <= "0010";
        wait for 20 * TbPeriod;
        buttons <= "0001";
        wait for 20*TbPeriod;
        buttons <="0100";
        wait for 20*TbPeriod;
        buttons <= "0001";
        wait for 20*TbPeriod;
        buttons <= "0010";
        wait for 20*TbPeriod;
        buttons <="0100";
        wait for 20*TbPeriod;
        buttons <="0001";
     

        -- Stop the clock and hence terminate the simulation
             wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Cronometro of tb_Cronometro is
    for tb
    end for;
end cfg_tb_Cronometro;