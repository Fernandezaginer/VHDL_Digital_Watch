-- Trabajo SED 23/24 Grupo 2
-- Modulo cronometro
-- Entidad reloj

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RelojMostrarHora is
    Port (  formatMode  : in STD_LOGIC;
            clk         :in std_logic;

            digits_0to3 : out std_logic_vector(15 downto 0);
            digits_4to7 : out std_logic_vector(15 downto 0);
            blink_ctrl  : out std_logic_vector(7 downto 0)  
    );
end RelojMostrarHora;

architecture Behavioral of RelojMostrarHora is
component RelojesDeTiempo is
    Port ( clkIn    : in STD_LOGIC;
           clkSec   : out STD_LOGIC;
           clkDSec  : out STD_LOGIC;
           clkMin   : out std_logic;
           clkDMin  : out std_logic
    );
end component;
--CADA SEÑAL DE RELOJ MARCA CON SU FLANCO DE SUBIDA UN INCREMENTO DE TIEMPO
signal clkSec_s   : std_logic;
signal clkDSec_s  : std_logic;
signal clkMin_s   : std_logic;
signal clkDMin_s  : std_logic;

--PRIMER DISPLAY
signal udsSecs  : std_logic_vector(3 downto 0) := "0000";
signal decSecs  : std_logic_vector(3 downto 0):= "0000";
signal udsMin   : std_logic_vector(3 downto 0):= "0000";
signal decMin   : std_logic_vector(3 downto 0):= "0000";

--SEGUNDO DISPLAY
signal udsHora  : std_logic_vector(3 downto 0) := "0000";
signal decHora  : std_logic_vector(3 downto 0) := "0000";

begin
    instRelojes: RelojesDeTiempo
    Port map(
 
	       clkIn    =>     clk,
           clkSec   =>     clkSec_S,
           clkDSec  =>     clkDSec_s,
           clkMin   =>     clkMin_s,
           clkDMin  =>     clkDMin_s
		);

-------HACER LOGICA-------HACER LOGICA-------HACER LOGICA-------HACER LOGICA-------HACER LOGICA-------HACER LOGICA-------HACER LOGICA
--NO LIMITAR POR STATEACT YA QUE EL RELOJ TIENE QUE ESTAR CORRIENDO INDEPENDIENTEMENTE DEL MODO GLOBAL

digits_0to3<= decMin & udsMin & decSecs & udsSecs;
digits_4to7<= "00000000" & decHora & udsHora;
--Propuesta REVISAR blink control
blink_ctrl <= (others => '1');
end Behavioral;
