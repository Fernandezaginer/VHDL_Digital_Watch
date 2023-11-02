library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity anodo_decoder is
    port (
        digctrl : out std_logic_vector(7 downto 0);
        DIGISEL : in std_logic_vector(2 downto 0)
    );
end anodo_decoder;

architecture BEHAVIORAL of anodo_decoder is
   begin
  digctrl(7) <= '0' when DIGISEL = "000" else '1';
  digctrl(6) <= '0' when DIGISEL = "001" else '1';
  digctrl(5) <= '0' when DIGISEL = "010" else '1';
  digctrl(4) <= '0' when DIGISEL = "011" else '1';
  digctrl(3) <= '0' when DIGISEL = "100" else '1';
  digctrl(2) <= '0' when DIGISEL = "101" else '1';
  digctrl(1) <= '0' when DIGISEL = "110" else '1';
  digctrl(0) <= '0' when DIGISEL = "111" else '1';
end BEHAVIORAL;

