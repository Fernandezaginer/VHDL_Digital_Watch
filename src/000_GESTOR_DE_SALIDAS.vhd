-- Trabajo SED 23/24 Grupo 2
-- Entidad gestor de salidas
-- Modulo display y modulo alarma


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity gestor_de_salidas is
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
		buttons_beep : in std_logic_vector(3 downto 0);
		ok_beep : in std_logic;
        SEGMENT_CRTL : out STD_LOGIC_VECTOR (6 downto 0);
        digctrl_CTRL : out STD_LOGIC_VECTOR (7 downto 0);
		buzzer : out std_logic
	);
end gestor_de_salidas;





architecture Structual of gestor_de_salidas is

	component display is
	    generic(
	        MODE_DISP_CATODO : std_logic_vector(3 downto 0) := "1111"
	        );
	    Port (
	        mode : in std_logic_vector(3 downto 0); 
	        digits_0to3 : in std_logic_vector(15 downto 0);
	        digits_4to7 : in std_logic_vector(15 downto 0);
	        blink_ctrl : in std_logic_vector(7 downto 0);
	        CLK  : in std_logic;
	        SEGMENT_CRTL : out STD_LOGIC_VECTOR (6 downto 0);
	        digctrl_CTRL : out STD_LOGIC_VECTOR (7 downto 0)
	    );
	end component;

	component alarma is
		port(
			clk : in std_logic;
			on1 : in std_logic;
			on2 : in std_logic;
			buzzer : out std_logic;
			buttons_beep : in std_logic_vector(3 downto 0);
			ok_beep : in std_logic
		);	
	end component;

begin


	controlador_de_displays : display
	    generic map(
	        MODE_DISP_CATODO => MODE_DISP_CATODO
	        )
	    Port map (
	        mode => mode,
	        digits_0to3 => digits_0to3,
	        digits_4to7 => digits_4to7,
	        blink_ctrl => blink_ctrl,
	        CLK  => CLK,
	        SEGMENT_CRTL => SEGMENT_CRTL,
	        digctrl_CTRL => digctrl_CTRL
	    );



	controlador_alarma : alarma
		port map(
			clk => CLK,
			on1 => on1,
			on2 => on2,
			buzzer => buzzer,
			buttons_beep => buttons_beep,
			ok_beep => ok_beep
		);


end Structual;






