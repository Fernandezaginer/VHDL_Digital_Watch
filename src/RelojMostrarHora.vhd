-- Trabajo SED 23/24 Grupo 2
-- Modulo cronometro
-- Entidad reloj

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity RelojMostrarHora is
    Port (  alarmaMins   : in std_logic_vector(15 downto 0);
            alarmaHora   : in std_logic_vector(15 downto 0);
            formatMode   : in STD_LOGIC;
            clk          : in std_logic;
            inicialMins  : in std_logic_vector(15 downto 0); --Inicial primer display
            inicialHora  : in std_logic_vector(15 downto 0);  --inicial segundo display
            digits_0to3  : out std_logic_vector(15 downto 0);
            digits_4to7  : out std_logic_vector(15 downto 0);
            blink_ctrl   : out std_logic_vector(7 downto 0);
            alarmaOn     : out std_logic
    );
end RelojMostrarHora;

architecture Behavioral of RelojMostrarHora is
component clock_divider is
generic (
    DIVISOR : natural := 10
);
port (
    clk_in  : in  std_logic;
    clk_out : out std_logic
);
end component;

--SEÑAL DE RELOJ QUE TIENE UN FLANCO DE SUBIDA CADA SEGUNDO
signal clkSec_s   : std_logic;

--PRIMER DISPLAY
signal udsSecs  : std_logic_vector(3 downto 0):= inicialMins (3 downto 0);
signal decSecs  : std_logic_vector(3 downto 0):= inicialMins (7 downto 4);
signal udsMin   : std_logic_vector(3 downto 0):= inicialMins (11 downto 8);
signal decMin   : std_logic_vector(3 downto 0):= inicialMins (15 downto 12);

signal udsMin_inicial   : std_logic_vector(3 downto 0):= inicialMins (11 downto 8);
signal decMin_inicial   : std_logic_vector(3 downto 0):= inicialMins (15 downto 12);

--SEGUNDO DISPLAY
signal udsHora  : std_logic_vector(3 downto 0) := inicialHora (3 downto 0);
signal decHora  : std_logic_vector(3 downto 0) := inicialHora (7 downto 4);

signal udsHora_inicial  : std_logic_vector(3 downto 0) := inicialHora (3 downto 0);
signal decHora_inicial  : std_logic_vector(3 downto 0) := inicialHora (7 downto 4);
signal digVacios : std_logic_vector(7 downto 0) := "11111111";

--MAXIMO DE HORAS INICIALMENTE 24
signal maxUdsHora : std_logic_vector(3 downto 0) := "0100";
signal maxDecHora : std_logic_vector(3 downto 0) := "0010";

signal format : std_logic := formatMode;

begin
    div_cl_sec : clock_divider generic map(
            DIVISOR => 100000000 --Paso de frec a 1 sec 
    )
    port map(
        clk_in => clk,
        clk_out => clkSec_S
    );
    		
    process(clk, format)
    begin
        if rising_edge(clkSec_S) then
            if udsSecs = "1001" then --Limite udsSecs = 9
                udsSecs <= "0000";
                if decSecs = "0101" then --Limite decsecs = 5
                    decSecs <= "0000";
                    if udsMin = "1001" then --Limite udsMin = 9
                        udsMin <= "0000";
                        if decMin = "0101" then --Limite decMin = 5
                            decMin <= "0000";
                            if udsHora = "1001" or (decHora = maxDecHora and udsHora = maxUdsHora) then 
                                udsHora <= "0000";
                                if decHora = maxDecHora and udsHora = maxUdshora then 
                                    decHora <= "0000";
                                else
                                    decHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(decHora)) + 1, decHora'length));
                                end if;
                            else
                                udsHora <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(udsHora)) + 1, udsHora'length));
                            end if;
                        else 
                            decMin <=std_logic_vector(to_unsigned(TO_INTEGER(unsigned(decMin)) + 1, decMin'length)); --Suma "10" min
                        end if;
                    else
                        udsMin <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(udsMin)) + 1, udsMin'length)); --Suma 1 min
                    end if;
                else
                    decSecs <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(decSecs)) + 1, decSecs'length)); --Suma "10" secs
                end if;
            else
                udsSecs <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(udsSecs)) + 1, udsSecs'length)); --se hace un cast a unsigned int para sumar 1 y se vuelve a pasar a std_vector
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
        
        --ACTUALIZACION DE HORA AJUSTADA
        if udsMin_inicial /= inicialMins(11 downto 8) or decMin_inicial /= inicialMins(15 downto 12) or udsHora_inicial /= inicialHora(3 downto 0) or decHora_inicial /= inicialHora(7 downto 4) then
            udsMin <= inicialMins (11 downto 8);
            decMin <= inicialMins (15 downto 12);
            udsHora <= inicialHora (3 downto 0);
            decHora <= inicialHora (7 downto 4);
            
            udsMin_inicial <=inicialMins(11 downto 8);
            decMin_inicial <= inicialMins(15 downto 12);
            udsHora_inicial<=inicialHora(3 downto 0);  
            decHora_inicial <= inicialHora(7 downto 4);
        end if; 
    end process;
    
    --ACTIVACION ALARMA
    alarmaOn <= '1' when alarmaMins = decMin & udsMin & decSecs & udsSecs and alarmaHora = digVacios & decHora & udsHora else '0';
    
    digits_0to3<= decMin & udsMin & decSecs & udsSecs;
    digits_4to7<= digVacios & decHora & udsHora;
    blink_ctrl <= (others => '0');
end Behavioral;
