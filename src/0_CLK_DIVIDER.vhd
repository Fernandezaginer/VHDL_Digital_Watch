-- Trabajo SED 23/24 Grupo 2
-- Modulo display
-- Entidad preescaladora del reloj


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Prescaler is
    generic (
        DIVIDER_VALUE : integer := 16
    );
    Port (
        clk_in  : in  STD_LOGIC;
        clk_out : out STD_LOGIC
    );
end Prescaler;

architecture Behavioral of Prescaler is
    signal counter : integer := 1;
    signal clk_out_internal : STD_LOGIC := '0';
begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if counter >= DIVIDER_VALUE - 1 then
                counter <= 1;
                clk_out_internal <= not clk_out_internal;
            else
                counter <= counter + 2;
            end if;
        end if;
    end process;

    clk_out <= clk_out_internal;
end Behavioral;


