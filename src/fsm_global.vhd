-- Trabajo SED 23/24 Grupo 2
-- Maquina de estados


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
---------------------------------------------------------------------------------------------------------------------------
--DECLARACION DE COMPONENTES
---------------------------------------------------------------------------------------------------------------------------
    component Cronometro is
    Port (  clk         :in std_logic;
            buttons     : in std_logic_vector(3 downto 0);
            stateActive : in std_logic_vector(4 downto 0);
            digits_0to3 : out std_logic_vector(15 downto 0);
            digits_4to7 : out std_logic_vector(15 downto 0);
            blink_ctrl  : out std_logic_vector(7 downto 0)         
   );
end component;

component display_12_24 is
    generic(
        MODE_NUM : std_logic_vector(3 downto 0) := "1111"
        );
    Port (
        clk : in std_logic;
        buttons: in std_logic_vector(3 downto 0);
        stateActive: in std_logic_vector(4 downto 0);
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl : out std_logic_vector(7 downto 0);
        out_mode : out std_logic
    );
end component;
---------------------------------------------------------------------------------------------------------------------------
--DECLARACION DE SEÑALES
---------------------------------------------------------------------------------------------------------------------------
    --MAQUINA DE ESTADOS
    --S0: Muestra hora; S1:Cambia hora; S2: set alarma; S3: Cronometro; S4: Formato hora 12/24h
    type STATES is (S0,S1,S2,S3,S4,S5);
    signal currentState: STATES := S1;
    signal nextState: STATES;
    
    --Señales generales que se asignaran a la salida
    signal dig0to3General : std_logic_vector(15 downto 0);
    signal dig4to7General : std_logic_vector(15 downto 0);
    signal blinkGeneral : std_logic_vector(7 downto 0);
    
    signal stateAct : std_logic_vector (5 downto 0); --Vector de señales de activación componentes
    
    --Señales salida cronometro
    signal dig0to3Crono : std_logic_vector(15 downto 0);
    signal dig4to7Crono : std_logic_vector(15 downto 0);
    signal blinkCrono : std_logic_vector(7 downto 0);
    --Señales salida formato 12/24h
    signal dig0to3Formato : std_logic_vector(15 downto 0);
    signal dig4to7Formato : std_logic_vector(15 downto 0);
    signal blinkFormato : std_logic_vector(7 downto 0);
    signal outFormat12_24 : std_logic := '0'; --señal formato de hora 12/24h
    
begin
------------------INSTANCIACION CRONO--------------------------
    intsCronometro : Cronometro
		Port map(
	        clk => clk, 
	        buttons => buttons,
	        stateActive => stateAct,
	        digits_0to3 => dig0to3Crono,
	        digits_4to7 => dig4to7Crono,
	        blink_ctrl => blinkCrono
		);
------------------INSTANCIACION FORMATO HORA--------------------------		
    instFormat12_24 : display_12_24
		generic map(
			MODE_NUM => "1000"
			)
	    Port map (
            clk => clk,
	        buttons => buttons,
	        stateActive => stateAct,
	        digits_0to3 => dig0to3Formato,
	        digits_4to7 => dig4to7Formato,
	        blink_ctrl => blinkFormato,
	        out_mode => outFormat12_24
	    );
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
            when S0 =>
                if modeButt='1' then
                nextState <= S1;
                end if;
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
                nextState <= S0;
                end if; 
        end case;                
    end process;

--Logica de estados
    process (currentState)
    begin    
        case currentState is
            when S0 =>
                stateAct <= ('1', others => '0');
            when S1 =>
                stateAct <= "01000";
            when S2 =>
                stateAct <= "00100";    
            --CRONOMETRO             
            when S3 =>
                stateAct <= "00010" ;  
                dig0to3General<=dig0to3Crono;
                dig4to7General<=dig4to7Crono;
                blinkGeneral<=blinkCrono;
            --FORMATO DE HORA 
            when S4 =>
                stateAct <= "00001" ;   
                dig0to3General<=dig0to3Formato;
                dig4to7General<=dig4to7Formato;
                blinkGeneral<=blinkFormato;              
        end case;
    end process; 
    
    --ASIGNACION DE SALIDAS
    digits_0to3 <= dig0to3General;
    digits_4to7 <= dig4to7General;
    blink_ctrl  <= blinkGeneral;                                                                                                                
end Behavioral;
