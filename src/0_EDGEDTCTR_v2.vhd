-- Trabajo SED 23/24 Grupo 2
-- Detector de flanco para los botones
-- mejorado anti debouncing


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity EDGEDTCTR_V2 is
    port (
        CLK : in std_logic;
        SYNC_IN : in std_logic;
        EDGE : out std_logic
    );
end EDGEDTCTR_V2;


architecture BEHAVIORAL of EDGEDTCTR_V2 is
    signal clk_count : integer := 0;
    signal out_s : std_logic := '0';
    signal end_s : std_logic := '0';
    begin
    
    process (CLK)
    begin
        if rising_edge(CLK) then

            if end_s = '1' then
                end_s <= '0';
                out_s <= '0';
            elsif SYNC_IN = '0' then
                clk_count <= clk_count + 1;
                if clk_count > 1000000 then
                    clk_count <= 1000000;
                end if;
            elsif clk_count >= 1000000 then
                clk_count <= 0;
                out_s <= '1';
                end_s <= '1';
            end if;
        end if;
    end process;
    
    EDGE <= out_s;

end BEHAVIORAL;



