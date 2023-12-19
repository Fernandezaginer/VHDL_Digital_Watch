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
            day_up       : out std_logic; 
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

signal udsHoraDisp  : std_logic_vector(3 downto 0) := inicialHora (3 downto 0);
signal decHoraDisp  : std_logic_vector(3 downto 0) := inicialHora (7 downto 4);

signal udsHora_inicial  : std_logic_vector(3 downto 0) := inicialHora (3 downto 0);
signal decHora_inicial  : std_logic_vector(3 downto 0) := inicialHora (7 downto 4);
signal digVacios : std_logic_vector(7 downto 0) := "11111111";

--MAXIMO DE HORAS INICIALMENTE 24
signal maxUdsHora : std_logic_vector(3 downto 0) := "0011";
signal maxDecHora : std_logic_vector(3 downto 0) := "0010";

signal format : std_logic;
--signal horaen12 : std_logic := '0';
signal alarmaUdsMin : std_logic_vector(3 downto 0) := "0011";
signal alarmadecMin : std_logic_vector(3 downto 0):= "0011";
signal alarmaUdsHora : std_logic_vector(3 downto 0):= "0001";
signal alarmadecHora : std_logic_vector(3 downto 0):= "0001";


begin
     
    div_cl_sec : clock_divider generic map(
            DIVISOR => 100000000 --Paso de frec a 1 sec 
    )
    port map(
        clk_in => clk,
        clk_out => clkSec_S
    );
    
    format <= formatMode;   
    alarmaUdsMin <= alarmaMins(11 downto 8);
    alarmaDecMin <= alarmaMins(15 downto 12);
    alarmaUdsHora <= alarmaHora(3 downto 0);
    alarmaDecHora <= alarmaHora(7 downto 4);
    process(clk)
    begin
        day_up <= '0';
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
                                    day_up <= '1';
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
    



----        --Paso de 12h a 24h  V2
        if to_integer(unsigned(decHora)) > 0 and to_integer(unsigned(udsHora)) > 2 and format = '0' then
            udsHoraDisp <= std_logic_vector(to_unsigned(to_integer(unsigned(udsHora)) - 2 , 4));
            decHoraDisp <= std_logic_vector(to_unsigned(to_integer(unsigned(decHora)) - 1 , 4));
        else
            udsHoraDisp <= udsHora;
            decHoraDisp <= decHora;
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
    alarmaOn <= '1' when ((alarmaUdsMin = udsMin) and (alarmaDecMin = decMin) and (alarmaUdsHora = udsHora) and (alarmaDecHora = decHora) and (decSecs = "0000") and (udsSecs < "0010")) else '0';
    
    digits_0to3<= decMin & udsMin & decSecs & udsSecs;
    digits_4to7<= digVacios & decHoraDisp & udsHoraDisp;

    blink_ctrl <= (others => '0');
end Behavioral;
