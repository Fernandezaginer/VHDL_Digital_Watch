-- Trabajo SED 23/24 Grupo 2
-- Modulo cronometro
-- Entidad reloj

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity RelojMostrarHora is
    Port (  formatMode   : in STD_LOGIC;
            clk          :in std_logic;
            inicialMins  : in std_logic_vector(15 downto 0); --Inicial primer display
            inicialHora : in std_logic_vector(15 downto 0);  --inicial segundo display
            digits_0to3  : out std_logic_vector(15 downto 0);
            digits_4to7  : out std_logic_vector(15 downto 0);
            blink_ctrl   : out std_logic_vector(7 downto 0)  
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
signal udsSecs  : std_logic_vector(3 downto 0):= inicialMins (3 downto 0);
signal decSecs  : std_logic_vector(3 downto 0):= inicialMins (7 downto 4);
signal udsMin   : std_logic_vector(3 downto 0):= inicialMins (11 downto 8);
signal decMin   : std_logic_vector(3 downto 0):= inicialMins (15 downto 12);

--SEGUNDO DISPLAY
signal udsHora  : std_logic_vector(3 downto 0) := inicialHora (3 downto 0);
signal decHora  : std_logic_vector(3 downto 0) := inicialHora (7 downto 4);
signal digVacios : std_logic_vector(7 downto 0) := "00000000";

--MAXIMO DE HORAS INICIALMENTE 24
signal maxUdsHora : std_logic_vector(3 downto 0) := "0100";
signal maxDecHora : std_logic_vector(3 downto 0) := "0010";

signal format : std_logic := formatMode;

begin
    instRelojes: RelojesDeTiempo
    Port map(
 
	       clkIn    =>     clk,
           clkSec   =>     clkSec_S,
           clkDSec  =>     clkDSec_s,
           clkMin   =>     clkMin_s,
           clkDMin  =>     clkDMin_s
		);

    process(clk, format)
    begin
        --SUMA UNIDADES DE SEGUNDOS
        if rising_edge (clkSec_s) then
            if udsSecs = "1001" then
                udsSecs <= "0000";
            else
                udsSecs <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(udsSecs)) + 1, udsSecs'length));
            end if;
        end if;
        
        --SUMA DECENAS DE SEGUNDOS
        if rising_edge (clkDSec_s) then
            if decSecs = "0101" then
                decSecs <= "0000";
            else
                decSecs <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(decSecs)) + 1, decSecs'length));
            end if;
        end if;
        
        --SUMA UNIDADES DE MINUTOS
        if rising_edge (clkMin_s) then
            if udsMin = "1001" then
                udsMin <= "0000";
            else
                udsMin <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(udsMin)) + 1, udsMin'length));
            end if;
        end if;
        
        --SUMA DECENAS DE MINUTOS
        if rising_edge (clkDMin_s) then
            if decMin = "0101" then
                decMin <= "0000";
            else
                decMin <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(decMin)) + 1, decMin'length));
            end if;
        end if;
        
        --SUMA UNIDADES DE HORAS
        if rising_edge (clkDMin_s) and decMin = "0101" and udsMin = "1001" then
            if udsHora = "1001" or (decHora = maxDecHora and udsHora = maxUdsHora) then 
                udsHora <= "0000";
            else 
                udsHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(udsHora)) + 1, udsHora'length));
            end if;
        end if;
        
        --SUMA DECENAS DE HORAS
        if rising_edge (clkDMin_s) and (udshora = "1001" or (decHora = maxDecHora and udsHora = maxUdshora)) then
            if decHora = maxDecHora and udsHora = maxUdshora then 
                decHora <= "0000";
            else
                decHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(decHora)) + 1, decHora'length));
            end if;
        end if; 
       
        --Paso de 12h a 24h
        if rising_edge (format) then
            --Cambia los máximos para que cuente hasta el nuevo maximo
            maxUdsHora <= "0100";
            maxDecHora <= "0010";
            
            -- Si uds es de 0-7 es decir de 0-7 y de 10-12 horas suma una decena y dos unidades (12 horas mas)
            if (udsHora >= "0000" and udsHora < "1000")then
                decHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(decHora)) + 1, decHora'length));
                udsHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(udsHora)) + 2, udsHora'length));
            --Mayor que 7 y menor que 10, de 8-9 pone las decenas a 2 y resta 8 horas
            elsif udsHora > "0111" and udsHora < "1010" then 
                udsHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(udsHora)) - 8, udsHora'length));
                decHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(decHora)) + 2, decHora'length));
            end if;
        end if;
        -- Paso de 24h a 12h
        if falling_edge(format) then
             --Cambia los máximos para que cuente hasta el nuevo maximo
            maxUdsHora <= "0010";
            maxDecHora <= "0001"; 
            
            -- De 13-19 y de 22-24 resta una decena y dos unidades (12 horas menos)
            if (decHora = "0001" and udsHora > "0010") or (decHora = "0010" and udsHora > "0001") then
                decHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(decHora)) - 1, decHora'length));
                udsHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(udsHora)) - 2, udsHora'length));
            --De 20-21 pone las decenas a 0 y suma 8 horas
            elsif decHora = "0010" and udsHora < "0010" then 
                udsHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(udsHora)) + 8, udsHora'length));
                decHora <= "0000";
            end if;          
        end if;          
    end process;
            
digits_0to3<= decMin & udsMin & decSecs & udsSecs;
digits_4to7<= digVacios & decHora & udsHora;
--Propuesta REVISAR blink control
blink_ctrl <= (others => '1');
end Behavioral;
