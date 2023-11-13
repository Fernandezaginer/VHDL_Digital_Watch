-- Trabajo SED 23/24 Grupo 2
-- Paquete de declaración de componentes


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;


package my_components is
	

	----------------------------------------------------------------------------
	--                          FUNCIONALIDADES
	----------------------------------------------------------------------------

	component display_12_24 is
	    Port (
            clk : in std_logic;
	        mode: in std_logic_vector(3 downto 0);
	        buttons: in std_logic_vector(3 downto 0);
	        digits_0to3 : out std_logic_vector(15 downto 0);
	        digits_4to7 : out std_logic_vector(15 downto 0);
	        blink_ctrl : out std_logic_vector(7 downto 0);
	        out_mode : out std_logic
	    );
	end component;


	component day_alarm_selec is
		port(
	        digits_0to3 : out std_logic_vector(15 downto 0);
	        digits_4to7 : out std_logic_vector(15 downto 0);
	        blink_ctrl : out std_logic_vector(7 downto 0);
	        CLK  : in std_logic;
	        buttons: in std_logic_vector(3 downto 0);
	        day_sel : out std_logic_vector(6 downto 0)
		);
	end component;



	----------------------------------------------------------------------------
	--                           I/O
	----------------------------------------------------------------------------

	component display is
	    Port (
	        digits_0to3 : in std_logic_vector(15 downto 0);
	        digits_4to7 : in std_logic_vector(15 downto 0);
	        blink_ctrl : in std_logic_vector(7 downto 0);
	        CLK  : in std_logic;
	        SEGMENT_CRTL : out STD_LOGIC_VECTOR (6 downto 0);
	        digctrl_CTRL : out STD_LOGIC_VECTOR (7 downto 0)
	    );
	end component;

	component button_interface is
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

	component alarma is
		port(
			clk : in std_logic;
			on1 : in std_logic;
			on2 : in std_logic;
			buzzer : out std_logic;
			buttons_beep : in std_logic_vector(3 downto 0);
			mode_beep : in std_logic
		);	
	end component;




	----------------------------------------------------------------------------
	--                           INTERNAL
	----------------------------------------------------------------------------

	component mux16_nc IS
	    generic (
	        CHANEL_LENGTH : integer := 16
	    );
	    PORT (
	        in0 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in1 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in2 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in3 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in4 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in5 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in6 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in7 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in8 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in9 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in10 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in11 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in12 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in13 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in14 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        in15 : IN std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0);
	        select_c : IN std_logic_vector(3 DOWNTO 0);
	        out_c : OUT std_logic_vector(CHANEL_LENGTH - 1 DOWNTO 0)
	    );
	END component;


	component control_counter is
		generic(
			max_count : integer := 8
		);
		Port (
	        clk : in std_logic;
	        counter_in : in std_logic;
	        counter_out : out std_logic_vector(3 downto 0)
	    );
	end component;


	component day_alarm_selec is
		port(
	        digits_0to3 : out std_logic_vector(15 downto 0);
	        digits_4to7 : out std_logic_vector(15 downto 0);
	        blink_ctrl : out std_logic_vector(7 downto 0);
	        CLK  : in std_logic;
	        buttons: in std_logic_vector(3 downto 0);
	        day_sel : out std_logic_vector(6 downto 0)
		);
	end component;



end package my_components;



