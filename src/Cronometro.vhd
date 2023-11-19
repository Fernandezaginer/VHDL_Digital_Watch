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
--Declaración Prescaler
    component Prescaler is
        generic (
            DIVIDER_VALUE : integer := 2
        );
        Port (
            clk_in  : in  STD_LOGIC;
            clk_out : out STD_LOGIC
        );
    end component;
--Señales    
    signal clkSec: std_logic ;  --Reloj periodo 1 sec
    signal udsSecs: std_logic_vector(3 downto 0);
    signal decSecs: std_logic_vector(3 downto 0);
    signal udsMin: std_logic_vector(3 downto 0);
    signal decMin: std_logic_vector(3 downto 0); 
     
--S0=reset||S1=play||S2=pause
    type STATES is (S0,S1,S2);
    signal currentState: STATES := S0;
    signal nextState: STATES;
begin
-- Clocks mult
    div_cll_sec : Prescaler generic map(
            DIVIDER_VALUE => 100000000 --Paso de frec a 1 sec 
    )
    port map(
        clk_in => clk,
        clk_out => clkSec
    );
--Paso a sig estado
    process (buttons, clkSec)
    begin
        if buttons = "0100" then
            currentState <= S0;
        elsif clkSec'event and clkSec = '1' then
            currentState <= nextState;
        end if;
    end process;   
    
end Behavioral;
