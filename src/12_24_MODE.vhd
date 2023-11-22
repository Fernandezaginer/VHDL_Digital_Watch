-- Trabajo SED 23/24 Grupo 2
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
    generic(
        MODE_NUM : std_logic_vector(3 downto 0) := "1111"
        );
    Port (
        clk : in std_logic;
        buttons: in std_logic_vector(3 downto 0);
        stateActive: in std_logic_vector(5 downto 0);
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl : out std_logic_vector(7 downto 0);
        out_mode : out std_logic
    );
end display_12_24;


architecture Behavioral of display_12_24 is
    signal out_mode_s : std_logic := '1';
begin
    process(clk)
	begin
	   if stateActive = "000001" then
           if (buttons = "0001") then
               out_mode_s <= '1';
           elsif (buttons = "1000") then
               out_mode_s <= '0';
           end if;	
       end if;   
	end process;
    out_mode <= out_mode_s;
	digits_0to3 <= "0010010011111100" when out_mode_s = '1'  AND stateActive = "000001" 
	   else "0001001011111100" when out_mode_s = '0'  AND stateActive = "000001" ;
	digits_4to7 <= "1111111111111111" when out_mode_s = '1' AND stateActive = "000001" 
	   else "1111111111111111" when out_mode_s = '0'  AND stateActive = "000001" ;
    blink_ctrl <= "11110000" when stateActive = "000001";
end Behavioral;


