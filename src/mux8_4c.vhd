
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;

ENTITY mux8_4c IS
    PORT (
        in0 : IN std_logic_vector(3 DOWNTO 0);
        in1 : IN std_logic_vector(3 DOWNTO 0);
        in2 : IN std_logic_vector(3 DOWNTO 0);
        in3 : IN std_logic_vector(3 DOWNTO 0);
        in4 : IN std_logic_vector(3 DOWNTO 0);
        in5 : IN std_logic_vector(3 DOWNTO 0);
        in6 : IN std_logic_vector(3 DOWNTO 0);
        in7 : IN std_logic_vector(3 DOWNTO 0);
        select_c : IN std_logic_vector(2 DOWNTO 0);
        out_c : OUT std_logic_vector(3 DOWNTO 0)
    );
END ENTITY mux8_4c;


ARCHITECTURE dataflow OF mux8_4c IS
BEGIN
    WITH select_c SELECT
    out_c <= in0 WHEN "000",
    in1 WHEN "001",
    in2 WHEN "010",
    in3 WHEN "011",
    in4 WHEN "100",
    in5 WHEN "101",
    in6 WHEN "110",
    in7 WHEN "111";
END dataflow;



