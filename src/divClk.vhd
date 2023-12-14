library ieee;
use ieee.std_logic_1164.all;

entity clock_divider is
    generic (
        DIVISOR : natural := 10
    );
    port (
        clk_in  : in  std_logic;
        clk_out : out std_logic
    );
end entity clock_divider;

architecture behavior of clock_divider is
    signal counter : natural range 0 to DIVISOR-1 := 0;
    signal clkOut : std_logic := '0';
begin
    process (clk_in)
    begin
        if rising_edge(clk_in) then
            if counter = DIVISOR-1 then
                clkOut <= '1';
                counter <= 0;
            else
                counter <= counter + 1;
                clkOut <= '0';
            end if;
        end if;
    end process;
    clk_out <= clkOut;
end architecture behavior;
