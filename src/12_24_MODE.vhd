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
        clk : in std_logic;
        mode: in std_logic_vector(3 downto 0);
        buttons: in std_logic_vector(3 downto 0);
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl : out std_logic_vector(7 downto 0);
        out_mode : out std_logic
    );
end display_12_24;


architecture Behavioral of display_12_24 is
    signal out_mode_s : std_logic := '0';
begin
    process(clk)
	begin
	   if (buttons = "1000" and mode = "1000") then
	       out_mode_s <= '1';
	   elsif (buttons = "0001" and mode = "1000") then
	       out_mode_s <= '0';
       end if;	   
	end process;
    out_mode <= out_mode_s;
	digits_0to3 <= "0010010000001100" when out_mode_s = '1' else "0001001000001100";
	digits_4to7 <= "0000000000000000" when out_mode_s = '1' else "0000000000000000";
    blink_ctrl <= "11110000";
end Behavioral;


