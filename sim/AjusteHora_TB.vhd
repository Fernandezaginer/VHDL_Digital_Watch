library ieee;
use ieee.std_logic_1164.all;

entity tb_AjusteHora is
end tb_AjusteHora;

architecture tb of tb_AjusteHora is

    component AjusteHora
        port (buttons      : in std_logic_vector (3 downto 0);
              format12_24  : in std_logic;
              clk          : in std_logic;
              stateActive  : in std_logic_vector (7 downto 0);
              digits0to3   : out std_logic_vector (15 downto 0);
              digits4to7   : out std_logic_vector (15 downto 0);
              blinkControl : out std_logic_vector (7 downto 0));
    end component;

    signal buttons      : std_logic_vector (3 downto 0);
    signal format12_24  : std_logic;
    signal clk          : std_logic;
    signal stateActive  : std_logic_vector (7 downto 0);
    signal digits0to3   : std_logic_vector (15 downto 0);
    signal digits4to7   : std_logic_vector (15 downto 0);
    signal blinkControl : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : AjusteHora
    port map (buttons      => buttons,
              format12_24  => format12_24,
              clk          => clk,
              stateActive  => stateActive,
              digits0to3   => digits0to3,
              digits4to7   => digits4to7,
              blinkControl => blinkControl);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2;

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        buttons <= (others => '0');
        format12_24 <= '0';
        stateActive <= "10000000";
        buttons <= "0010";
        buttons <= "0001";
        wait for 3 * TbPeriod;
        buttons <= "0100";
        buttons <="1000";
        wait for 3*TbPeriod;
        buttons <= "0100";
        buttons <= "0001";

        
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_AjusteHora of tb_AjusteHora is
    for tb
    end for;
end cfg_tb_AjusteHora;