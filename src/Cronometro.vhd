-- Trabajo SED 23/24 Grupo 2
-- Modulo cronometro
-- Entidad cronometro

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Cronometro is
    generic (
        codeState : std_logic_vector (7 downto 0) := "10000000"   --Estado de funcionamiento (ajuste o alarma)
    );
  Port (clk:in std_logic;
        buttons: in std_logic_vector(3 downto 0);
        stateActive: in std_logic_vector(7 downto 0);
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl : out std_logic_vector(7 downto 0)         
   );
end Cronometro;

architecture Behavioral of Cronometro is
    component clock_divider is
        generic (
        DIVISOR : natural := 10
    );
    port (
        clk_in  : in  std_logic;
        clk_out : out std_logic
    );
    end component;
    
--Señales    
    signal clkSec : std_logic ;  --Reloj de 1 sec
    
    signal udsSecs: std_logic_vector(3 downto 0) := "0000";
    signal decSecs: std_logic_vector(3 downto 0):= "0000";
    signal udsMin: std_logic_vector(3 downto 0):= "0000";
    signal decMin: std_logic_vector(3 downto 0):= "0000"; 
     
--S0=reset||S1=play||S2=pause
    type STATES is (S0,S1,S2);
    signal currentState: STATES := S0;
    signal nextState: STATES;
begin

    div_clK_sec : clock_divider generic map(
            DIVISOR => 100000000 --Paso de frec a 1 sec 
    )
    port map(
        clk_in => clk,
        clk_out => clkSec
    );
    
--Paso a sig estado
    process ( stateActive, buttons, clk)
    begin
        if stateActive = codeState then
            if rising_edge(clk) then
                currentState <= nextState;
            end if;
        end if;
    end process;   
    
--Cambio estado
    process ( stateActive, buttons, currentState)
    begin
        if stateActive = codeState then
            nextState <= currentState;
            case currentState is
                when S0 =>
                    if buttons = "0001" then
                        nextState <= S1;
                    end if;
                when S1 =>
                    if buttons = "0100" then
                        nextState <= S0;
                    elsif buttons = "0010" then
                        nextState <= S2;
                    end if;
                when S2 =>
                    if buttons = "0100" then
                        nextState <= S0;
                    elsif buttons = "0001" then
                        nextState <= S1;
                    end if;            
                when others =>
            end case;
        end if;
    end process;   

--Logica de estados
    process (stateActive, currentState, clk)
    begin
        if rising_edge (clkSec) then
            case currentState is
                when S0 => --Reset
                    udsSecs<="0000"; decSecs<="0000"; udsMin<="0000"; decMin<="0000";
                when S1 => --Play
                        if udsSecs = "1001" then --Limite udsSecs = 9
                            udsSecs <= "0000";
                            if decSecs = "0101" then --Limite decsecs = 5
                                decSecs <= "0000";
                                if udsMin = "1001" then --Limite udsMin = 9
                                    udsMin <= "0000";
                                    if decMin = "0101" then --Limite decMin = 5
                                        decMin <= "0000";
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
                when S2 => --Pause
                    --null;
                when others =>       
            end case;            
        end if;
    end process;
    digits_0to3<= decMin & udsMin & decSecs & udsSecs;
    blink_ctrl <= (others => '0');

end Behavioral;
