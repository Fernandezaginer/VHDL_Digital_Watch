

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FrequencyDivider is
	generic (
	    DIVIDER_VALUE : integer := 2
	);
    Port (
        clk_in  : in  STD_LOGIC;
        clk_out : out STD_LOGIC
    );
end FrequencyDivider;

architecture Behavioral of FrequencyDivider is
    signal counter : integer range 0 to 1 := 0;
    signal clk_out_internal : STD_LOGIC := '0';
begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if counter = DIVIDER_VALUE - 1 then
                counter <= 0;
                clk_out_internal <= not clk_out_internal;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_out_internal;
end Behavioral;


