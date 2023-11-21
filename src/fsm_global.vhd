----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2023 19:01:21
-- Design Name: 
-- Module Name: fsm_global - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_global is
  Port (
        clk         : in std_logic;
        buttons     : in std_logic_vector(3 downto 0);
        modeButt    : in std_logic;
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl  : out std_logic_vector(7 downto 0);
        led         : out std_logic;
        buzzer      : out std_logic
        );
end fsm_global;

architecture Behavioral of fsm_global is
    type STATES is (S1,S2,S3,S4,S5,S6,S7,S8,S9);
    signal currentState: STATES := S1;
    signal nextState: STATES;
    
    signal stateAct : std_logic_vector (8 downto 0); --Vector de señales de activación componentes
    
begin
--Paso a siguiente estado
    process (clk)
    begin
        if rising_edge (clk) then
            currentState <= nextState;
        end if;
    end process;
            
--Cambio de estado
    process(modeButt, currentState)
    begin
        nextState <= currentState;
        case currentState is
            when S1 =>
                if modeButt='1' then
                nextState <= S2;
                 end if;
            when S2 =>
                if modeButt='1' then
                nextState <= S3;
                end if;                    
            when S3 =>
                if modeButt='1' then
                nextState <= S4;
                end if; 
            when S4 =>
                if modeButt='1' then
                nextState <= S5;
                end if;
            when S5 =>
                if modeButt='1' then
                nextState <= S6;
                end if; 
            when S6 =>
                if modeButt='1' then
                nextState <= S7;
                end if;
            when S7 =>
                if modeButt='1' then
                nextState <= S8;
                end if;
            when S8 =>
                if modeButt='1' then
                nextState <= S9;
                end if;
            when S9 =>
                if modeButt='1' then
                nextState <= S1;
                end if;
        end case;                
    end process;

--Logica de estados
    process (currentState)
    begin    
        case currentState is
            when S1 =>
                stateAct <= ('1', others => '0');
            when S2 =>
                stateAct <= "010000000";               
            when S3 =>
                stateAct <= "001000000" ;    
            when S4 =>
                stateAct <= "000100000" ;   
            when S5 =>
                stateAct <= "000010000" ;    
            when S6 =>
                stateAct <= "000001000" ;   
            when S7 =>
                stateAct <= "000000100" ;   
            when S8 =>
                stateAct <= "000000010" ;   
            when S9 =>
                stateAct <= "000000001"; 
        end case;
    end process;                                                                                                                                  
end Behavioral;
