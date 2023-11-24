-- Trabajo SED 23/24 Grupo 2
-- Componente Reloj
--Divide el clk 100MHz en 2 relojes, 1Hz, 0,1Hz (1 sec y 10 sec)


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RelojesDeTiempo is
    Port ( clkIn    : in STD_LOGIC;
           clkSec   : out STD_LOGIC;
           clkDSec  : out STD_LOGIC;
           clkMin   : out std_logic;
           clkDMin  : out std_logic
    );
end RelojesDeTiempo;

architecture Behavioral of RelojesDeTiempo is
--Declaración Prescaler
    component clock_divider is
        generic (
        DIVISOR : natural := 10
    );
    port (
        clk_in  : in  std_logic;
        clk_out : out std_logic
    );
    end component;

    signal SclkSec   :  STD_LOGIC;
    signal SclkDSec  :  STD_LOGIC;
    signal SclkMin   :  std_logic := '0';
    signal SclkDMin   : std_logic := '0';
    
    signal contadorDecSec : integer := 0;
    signal contadorMin : integer := 0;
begin

-- Clocks mult
    div_cll_sec : clock_divider generic map(
            DIVISOR => 100000000 --Paso de frec a 1 sec 
    )
    port map(
        clk_in => clkIn,
        clk_out => SclkSec
    );

    div_cll_Dsec : clock_divider generic map(
            DIVISOR => 1000000000--Paso de frec a 10 sec 
    )
    port map(
        clk_in => clkIn,
        clk_out => SclkDSec
    );
    
    process(clkIn,SclkDSec)
    begin
        if rising_edge(SclkDSec) then
            if contadorDecSec = 5 then
                contadorDecSec <= 0;
                SclkMin <= NOT SclkMin;
                if contadorMin = 9 then
                    contadorMin <= 0;
                    SclkDMin <= NOT SclkDMin;
                else
                    contadorMin <= contadorMin + 1;
                    SclkDMin <= '0';
                end if;
            else    
                contadorDecSec <= contadorDecSec + 1;
                SclkMin <= '0';
            end if;
        end if;
    end process;
    
    clkSec <= SclkSec;
    clkDSec <= SclkDSec;
    clkMin <= SclkMin;
    clkDMin <= SclkDMin;
end Behavioral;
