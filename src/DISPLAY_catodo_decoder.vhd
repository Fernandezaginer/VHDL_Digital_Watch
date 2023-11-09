-- Trabajo SED 23/24 Grupo 2
-- Modulo display
-- Entidad decodificadora del número a mostrar en el display


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;


ENTITY catodo_decoder IS
PORT (
code : IN std_logic_vector(3 DOWNTO 0);
led : OUT std_logic_vector(6 DOWNTO 0)
);
END ENTITY catodo_decoder;


ARCHITECTURE dataflow OF catodo_decoder IS
BEGIN

    -- gfedcba
    WITH code SELECT
    led <= "1000000" WHEN "0000",
    "1111001" WHEN "0001",
    "0100100" WHEN "0010",
    "0110000" WHEN "0011",
    "0011001" WHEN "0100",
    "0010010" WHEN "0101",
    "0000010" WHEN "0110",
    "1111000" WHEN "0111",
    "0000000" WHEN "1000",
    "0010000" WHEN "1001",
    "0011100" WHEN "1010",  -- º
    "1000110" WHEN "1011",  -- C
    "0101001" WHEN "1100",  -- h
    "1111111" WHEN others;

    -- Dias de la semana
    -- gfedcba
    --WITH code SELECT
    --led <= "1110001" WHEN "0000", --L
    --"0110111" WHEN "0001", -- M
    --"1110110" WHEN "0010", -- X
    --"1100001" WHEN "0011", -- J
    --"1000001" WHEN "0100", -- V
    --"0010010" WHEN "0101", -- S
    --"1000000" WHEN "0110", -- D
    --"1111111" WHEN others;

END ARCHITECTURE dataflow;
