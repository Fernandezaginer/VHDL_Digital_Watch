-- Trabajo SED 23/24 Grupo 2
-- Modulo cronometro
-- Entidad cronometro

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Cronometro is
  Port (clk:in std_logic;
        buttons: in std_logic_vector(3 downto 0);
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl : out std_logic_vector(7 downto 0)         
   );
end Cronometro;

architecture Behavioral of Cronometro is
    signal clkSec: std_logic ;  --Reloj periodo 1 sec
    signal clkMin: std_logic ;  --Reloj periodo 1 min
    signal clkHora: std_logic ; --reloj periodo 1 hora
    signal udsSecs: std_logic_vector(3 downto 0);
    signal decSecs: std_logic_vector(3 downto 0);
    signal udsMin: std_logic_vector(3 downto 0);
    signal decMin: std_logic_vector(3 downto 0); 
begin


end Behavioral;
