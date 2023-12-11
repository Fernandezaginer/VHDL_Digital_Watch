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
        buzzer      : out std_logic
        );
end fsm_global;

architecture Behavioral of fsm_global is
---------------------------------------------------------------------------------------------------------------------------
--DECLARACION DE COMPONENTES
---------------------------------------------------------------------------------------------------------------------------

component AjusteHora is
    generic (
    codeState : std_logic_vector (5 downto 0) := "100000"   --Estado de funcionamiento (ajuste o alarma)
    );
    Port ( buttons      : in STD_LOGIC_VECTOR (3 downto 0);
           format12_24  : in STD_LOGIC;
           clk          : in STD_LOGIC;
           stateActive  : in STD_LOGIC_VECTOR (5 downto 0);
           digits0to3   : out STD_LOGIC_VECTOR (15 downto 0);
           digits4to7   : out STD_LOGIC_VECTOR (15 downto 0);
           blinkControl : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component RelojMostrarHora is
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
end component;

component Cronometro is
    Port (  clk         :in std_logic;
            buttons     : in std_logic_vector(3 downto 0);
            stateActive : in std_logic_vector(5 downto 0);
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
        buttons     : in std_logic_vector(3 downto 0);
        stateActive : in std_logic_vector(5 downto 0);
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl  : out std_logic_vector(7 downto 0);
        out_mode    : out std_logic
    );
end component;
---------------------------------------------------------------------------------------------------------------------------
--DECLARACION DE SEÑALES
---------------------------------------------------------------------------------------------------------------------------
    --MAQUINA DE ESTADOS
    --S0: Cambia hora; S1:Muestra hora; S2: set alarma; S3: Cronometro; S4: Formato hora 12/24h
    type STATES is (S0,S1,S2,S3,S4,S5);
    signal currentState: STATES := S0; --El primer estado es ajustar la hora
    signal nextState: STATES;
    
------SEÑALES GENERALES QUE SE ASIGNARAN A LA SALIDA----------------
    signal dig0to3General   : std_logic_vector(15 downto 0):="0000000000000000";
    signal dig4to7General   : std_logic_vector(15 downto 0);
    signal blinkGeneral     : std_logic_vector(7 downto 0);
    
    --Vector de señales de activación componentes
    signal stateAct : std_logic_vector (5 downto 0); 
    
--------SEÑALES DE SALIDA DE CADA COMPONENTE/ESTADO--------
    --Señales salida cambiar hora
    signal dig0to3CambHora : std_logic_vector(15 downto 0);
    signal dig4to7CambHora : std_logic_vector(15 downto 0);
    signal blinkCambHora   : std_logic_vector(7 downto 0);

    --Señales salida reloj mostrar hora
    signal dig0to3Reloj : std_logic_vector(15 downto 0);
    signal dig4to7Reloj : std_logic_vector(15 downto 0);
    signal blinkReloj   : std_logic_vector(7 downto 0);
    
    --Señales salida alarma
    signal dig0to3Alarma : std_logic_vector(15 downto 0);
    signal dig4to7Alarma : std_logic_vector(15 downto 0);
    signal blinkAlarma   : std_logic_vector(7 downto 0);
    
    --Señales salida cronometro
    signal dig0to3Crono : std_logic_vector(15 downto 0);
    signal dig4to7Crono : std_logic_vector(15 downto 0);
    signal blinkCrono   : std_logic_vector(7 downto 0);
    
    --Señales salida formato 12/24h
    signal dig0to3Formato   : std_logic_vector(15 downto 0);
    signal dig4to7Formato   : std_logic_vector(15 downto 0);
    signal blinkFormato     : std_logic_vector(7 downto 0);
    signal outFormat12_24   : std_logic := '0'; --señal formato de hora 12/24h
    
begin
---------------------------------------------------------------------------------------------------------------------------
--INSTANCIACION DE COMPONENTES
---------------------------------------------------------------------------------------------------------------------------
------------------INSTANCIACION CAMBIO DE HORA--------------------------
    instCambHora : AjusteHora 
        generic map(
            codeState => "100000"   --Estado de funcionamiento (ajuste o alarma)
        )
        Port map( 
           buttons      =>  buttons,
           format12_24  =>  outFormat12_24,
           clk          =>  clk,
           stateActive  =>  stateAct,
           digits0to3   =>  dig0to3CambHora,
           digits4to7   =>  dig4to7CambHora,
           blinkControl =>  blinkCambHora 
        );

------------------INSTANCIACION RELOJ--------------------------
    instReloj : RelojMostrarHora
        Port map(
            alarmaMins     => dig0to3Alarma,
            alarmaHora     => dig0to3Alarma,
            formatMode     => outFormat12_24,    --Recibe el formato 12/24 de el componente correspondiente
            clk            => clk, 
            inicialMins    => dig0to3CambHora,
            inicialHora    => dig4to7CambHora,
	        digits_0to3    => dig0to3Reloj,
	        digits_4to7    => dig4to7Reloj,
	        blink_ctrl     => blinkReloj,
	        alarmaOn       => buzzer
	    );

------------------INSTANCIACION ALARMA--------------------------
    instAlarma : AjusteHora 
        generic map(
            codeState => "001000"   --Estado de funcionamiento (ajuste o alarma)
        )
        Port map( 
           buttons      =>  buttons,
           format12_24  =>  outFormat12_24,
           clk          =>  clk,
           stateActive  =>  stateAct,
           digits0to3   =>  dig0to3Alarma,
           digits4to7   =>  dig4to7Alarma,
           blinkControl =>  blinkAlarma 
        );
        
------------------INSTANCIACION CRONO--------------------------
    intsCronometro : Cronometro
		Port map(
	        clk            => clk, 
	        buttons        => buttons,
	        stateActive    => stateAct,
	        digits_0to3    => dig0to3Crono,
	        digits_4to7    => dig4to7Crono,
	        blink_ctrl     => blinkCrono
		);
------------------INSTANCIACION FORMATO HORA--------------------------		
    instFormat12_24 : display_12_24
		generic map(
			MODE_NUM => "1000"
			)
	    Port map (
            clk             => clk,
	        buttons         => buttons,
	        stateActive     => stateAct,
	        digits_0to3     => dig0to3Formato,
	        digits_4to7     => dig4to7Formato,
	        blink_ctrl      => blinkFormato,
	        out_mode        => outFormat12_24
	    );

---------------------------------------------------------------------------------------------------------------------------
--MAQUINA DE ESTADOS
---------------------------------------------------------------------------------------------------------------------------    
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
            when others =>
        end case;                
    end process;

--Logica de estados
    process (currentState)
    begin    
        case currentState is
            --AJUSTAR HORA
            when S0 =>
                stateAct <= ('1', others => '0');
                dig0to3General <=  dig0to3CambHora;
                dig4to7General <=  dig4to7CambHora;
                blinkGeneral   <=  blinkCambHora;
            --RELOJ
            when S1 =>
                stateAct <= "010000";
                dig0to3General <= dig0to3Reloj;
                dig4to7General <= dig4to7Reloj;
                blinkGeneral   <= blinkReloj;
            --ALARMA
            when S2 =>
                stateAct <= "001000";    
                dig0to3General <= dig0to3Alarma;
                dig4to7General <= dig4to7Alarma;
                blinkGeneral   <= blinkAlarma;
            --CRONOMETRO             
            when S3 =>
                stateAct <= "000100" ;  
                dig0to3General <= dig0to3Crono;
                dig4to7General <= dig4to7Crono;
                blinkGeneral <= blinkCrono;
            --FORMATO DE HORA 
            when S4 =>
                stateAct <= "000010" ;   
                dig0to3General<=dig0to3Formato;
                dig4to7General<=dig4to7Formato;
                blinkGeneral<= blinkFormato;          
            when others =>
        end case;
    end process; 
    
    --ASIGNACION DE SALIDAS
    digits_0to3 <= dig0to3General;
    digits_4to7 <= dig4to7General;
    blink_ctrl  <= blinkGeneral;                                                                                                                
end Behavioral;
