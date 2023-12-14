-- Trabajo SED 23/24 Grupo 2
-- Entidad principal del despertador


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;

--use work.my_components.all;



entity TOP is
    Port (
        CLK100MHZ  : in std_logic;  
		BTNU : in std_logic;
		BTNC : in std_logic;
		BTNL : in std_logic;
		BTNR : in std_logic;
		BTND : in std_logic;
		BUZZER : out std_logic;
		SEGMENT : out STD_LOGIC_VECTOR (6 downto 0);
        digctrl : out STD_LOGIC_VECTOR (7 downto 0)
    );
end TOP;

architecture Structual of TOP is

	----------------------------------------------------------------------------
	--                           I/O
	----------------------------------------------------------------------------

	component gestor_de_salidas is
	    generic(
	        MODE_DISP_CATODO : std_logic_vector(3 downto 0) := "1111"
	        );
	    Port (
	        mode : in std_logic_vector(3 downto 0); 
	        digits_0to3 : in std_logic_vector(15 downto 0);
	        digits_4to7 : in std_logic_vector(15 downto 0);
	        blink_ctrl : in std_logic_vector(7 downto 0);
	        CLK  : in std_logic;
			on1 : in std_logic;
			on2 : in std_logic;
			ok_beep : in std_logic;
			buttons_beep : in std_logic_vector(3 downto 0);
	        SEGMENT_CRTL : out STD_LOGIC_VECTOR (6 downto 0);
	        digctrl_CTRL : out STD_LOGIC_VECTOR (7 downto 0);
			buzzer : out std_logic
		);
	end component;



	component gestor_de_entradas is
		Port(
	        CLK : in std_logic;
			UP_SW : in std_logic;
			LEFT_SW : in std_logic;
			RIGHT_SW : in std_logic;
			DOWN_SW : in std_logic;
			OK_SW : in std_logic;
			UP : out std_logic;
			LEFT : out std_logic;
			RIGHT : out std_logic;
			DOWN : out std_logic;
			OK : out std_logic
		);
	end component;
	
	component fsm_global is
      Port (
            clk         : in std_logic;
            buttons     : in std_logic_vector(3 downto 0);
            modeButt    : in std_logic;
            digits_0to3 : out std_logic_vector(15 downto 0);
            digits_4to7 : out std_logic_vector(15 downto 0);
            blink_ctrl  : out std_logic_vector(7 downto 0);
            buzzer      : out std_logic
            );
end component;

	
	----------------------------------------------------------------------------
	--                     SEÑALES GENERALES
	----------------------------------------------------------------------------
	signal UP : std_logic := '0';
	signal LEFT : std_logic := '0';
	signal RIGHT : std_logic := '0';
	signal DOWN : std_logic := '0';
	signal OK : std_logic := '0';

	signal buttons : std_logic_vector(3 downto 0);


    signal digits_0to3 : std_logic_vector(15 downto 0);
    signal digits_4to7 : std_logic_vector(15 downto 0);
    signal blink_ctrl : std_logic_vector(7 downto 0);

    signal mode : std_logic_vector(3 downto 0);
    constant MODE_DAY_SELECT : std_logic_vector(3 downto 0):= "0101";
    signal alarma_1_on : std_logic;
    signal alarma_2_on  : std_logic:='0';

begin
	

	buttons(0) <= UP;
	buttons(1) <= LEFT;
	buttons(2) <= RIGHT;
	buttons(3) <= DOWN;


	----------------------------------------------------------------------------
	--                  COMPONENTES GENERALES
	----------------------------------------------------------------------------

	gestor_de_salidas_a : gestor_de_salidas
	    generic map(
	        MODE_DISP_CATODO => MODE_DAY_SELECT
	        )
	    port map(
	        mode => mode,
	        digits_0to3 => digits_0to3,
	        digits_4to7 => digits_4to7,
	        blink_ctrl => blink_ctrl,
	        CLK => CLK100MHZ,
			on1 => alarma_1_on,
			on2 => alarma_2_on,
			buttons_beep => buttons,
			ok_beep => OK,
	        SEGMENT_CRTL => SEGMENT,
	        digctrl_CTRL => digctrl,
			buzzer => BUZZER
		);

	buttons_c : gestor_de_entradas
		Port map(
	        CLK => CLK100MHZ,
			UP_SW => BTNU,
			LEFT_SW => BTNL,
			RIGHT_SW => BTNR,
			DOWN_SW => BTND,
			OK_SW => BTNC,
			UP => UP,
			LEFT => LEFT,
			RIGHT => RIGHT,
			DOWN => DOWN,
			OK => OK
		);

    fsmInstance : fsm_global
        port map(
            clk => CLK100MHZ,
            buttons  => buttons,
            modeButt => ok,
            digits_0to3 => digits_4to7,
            digits_4to7 => digits_0to3,
            blink_ctrl => blink_ctrl,
            buzzer => alarma_1_on
        );

end Structual;



