-- Trabajo SED 23/24 Grupo 2
-- Modulo display
-- Multiplexor para seleccionar la entrada al display según el estado



LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;

ENTITY mux16_nc IS
    generic (
        CHANEL_LENGTH : integer := 16
    );
    PORT (
        in0 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in1 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in2 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in3 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in4 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in5 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in6 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in7 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in8 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in9 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in10 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in11 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in12 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in13 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in14 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        in15 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
        select_c : IN std_logic_vector(3 DOWNTO 0);
        out_c : OUT std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0)
    );
END ENTITY mux16_nc;

ARCHITECTURE dataflow OF mux16_nc IS
BEGIN
    WITH select_c SELECT
    out_c <= in0 WHEN "0000",
    in1 WHEN "0001",
    in2 WHEN "0010",
    in3 WHEN "0011",
    in4 WHEN "0100",
    in5 WHEN "0101",
    in6 WHEN "0110",
    in7 WHEN "0111",
    in8 WHEN "1000",
    in9 WHEN "1001",
    in10 WHEN "1010",
    in11 WHEN "1011",
    in12 WHEN "1100",
    in13 WHEN "1101",
    in14 WHEN "1110",
    in15 WHEN "1111";
END dataflow;




