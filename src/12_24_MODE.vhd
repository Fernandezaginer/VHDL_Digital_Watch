-- Trabajo SED 23/24 Grupo 2
-- Entidad de configuración de la
-- visualizacion en formato 12h/24h

-- out_mode:
-- 1 == 24h
-- 0 == 12h

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity display_12_24 is
    generic(
        MODE_NUM : std_logic_vector(7 downto 0) := "11111111"
        );
    Port (
        clk : in std_logic;
        buttons: in std_logic_vector(3 downto 0);
        stateActive: in std_logic_vector(7 downto 0);
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl : out std_logic_vector(7 downto 0);
        out_mode : out std_logic
    );
end display_12_24;


architecture Behavioral of display_12_24 is
    --signal out_mode_s : std_logic := '1';
    
    type STATES is (S0,S1);
    signal currentState: STATES := S0; --El primer estado es ajustar la hora
    signal nextState: STATES;

    signal out_mode_s : std_logic;
begin
    --Paso a siguiente estado
    process (clk)
    begin
        if rising_edge (clk) then
            currentState <= nextState;
        end if;
    end process;
    
    --Cambio de estado
    process(buttons, currentState)
    begin
    if stateActive = MODE_NUM then
        nextState <= currentState;
        case currentState is
            when S0 =>
                if buttons = "1000" then
                nextState <= S1;
                end if;
            when S1 =>
                if buttons = "0001" then
                nextState <= S0;
                end if;
            when others =>
        end case; 
    end if;               
    end process;
    
    --Logica de estados
    process (currentState)
    begin    
        case currentState is

            when S0 =>
                out_mode_s <= '1'; 

            when S1 =>
                out_mode_s <= '0';   
            when others =>
        end case;
    end process;
    
--    process(clk)
--	begin
--	   if stateActive = MODE_NUM then
--           if (buttons = "0001") then
--               out_mode_s <= '1';
--           end if;
--           if (buttons = "1000") then
--               out_mode_s <= '0';
--           end if;	
--       end if;   
--	end process;
	--0 = 12h; 1 = 24H;
    out_mode <= out_mode_s;
	digits_0to3 <= "0010010011111100" when out_mode_s = '1'  AND stateActive = MODE_NUM 
	   else "0001001011111100" when out_mode_s = '0'  AND stateActive = MODE_NUM ;
	digits_4to7 <= "1111111111111111" when out_mode_s = '1' AND stateActive = MODE_NUM
	   else "1111111111111111" when out_mode_s = '0'  AND stateActive = MODE_NUM;
    blink_ctrl <= "11111111" when stateActive = MODE_NUM;
end Behavioral;


