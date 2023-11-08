-- Trabajo SED 23/24 Grupo 2
-- Modulo display
-- Entidad contador, para realizar la multiplexación por tiempo de todos los digitos del display



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;


library UNISIM;
use UNISIM.VComponents.all;

entity contador is
  Port (
    code : out std_logic_vector(2 downto 0);
    clk : in std_logic
  );
end contador;

architecture Behavioral of contador is
    signal var_contador : integer := 0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if var_contador = 7 then
               var_contador <= 0;
            end if;
            var_contador <= var_contador + 1;
        end if;
    end process;
    code <= std_logic_vector(to_signed(var_contador,3));
end Behavioral;
