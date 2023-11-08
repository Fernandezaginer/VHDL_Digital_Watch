-- Trabajo SED 23/24 Grupo 2
-- Modulo display
-- Entidad de configuración de la
-- visualizacion en formato 12h/24h

-- out_mode:
-- 1 == 24h
-- 0 == 12h

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity display_12_24 is
    Port (
        mode: in std_logic_vector(3 downto 0);
        buttons: in std_logic_vector(3 downto 0);
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl : out std_logic_vector(7 downto 0);
        out_mode : out std_logic
    );
end display_12_24;


architecture Behavioral of display is
    signal out_mode_s : std_logic := 0;
begin
	out_mode <= '1' when (buttons = "1000" and mode = "1000") else unaffected;
	out_mode <= '0' when (buttons = "0010" and mode = "1000") else unaffected;
    out_mode_s <= out_mode;

	digits_0to3 <= "0010010000001100" when out_mode = 1 else "0001001000001100";
	digits_4to7 <= "0000000000000000" when out_mode = 1 else "0000000000000000";
    blink_ctrl <= "11110000";
end Behavioral;


