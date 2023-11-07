-- Trabajo SED 23/24 Grupo 2
-- Modulo botones
-- Contienen los sincronizadores y detecores de flanco



entity button_interface is
	Port(
        CLK  : in std_logic;
		UP_SW : in std_logic;
		LEFT_SW : in std_logic;
		RIGHT_SW : in std_logic;
		DOWN_SW : in std_logic;
		OK_SW : in std_logic;
		UP : in std_logic;
		LEFT : in std_logic;
		RIGHT : in std_logic;
		DOWN : in std_logic;
		OK : in std_logic
	);

end button_interface;


architecture Structual of button_interface is 
	component SYNCHRNZR is
	    port (
	        CLK : in std_logic;
	        ASYNC_IN : in std_logic;
	        SYNC_OUT : out std_logic
	    );
	end component;
	component EDGEDTCTR is
	    port (
	        CLK : in std_logic;
	        SYNC_IN : in std_logic;
	        EDGE : out std_logic
	    );
	end component;

	signal s_up : std_logic;
	signal s_down : std_logic;
	signal s_left : std_logic;
	signal s_right : std_logic;
	signal s_ok : std_logic;
begin

	SYNCHRNZR_up : SYNCHRNZR port map (CLK => CLK, ASYNC_IN => UP_SW, SYNC_OUT => s_up);
	EDGEDTCTR_up : EDGEDTCTR port map (CLK => CLK, SYNC_IN => s_up, EDGE => UP);

	SYNCHRNZR_down : SYNCHRNZR port map (CLK => CLK, ASYNC_IN => DOWN_SW, SYNC_OUT => s_down);
	EDGEDTCTR_down : EDGEDTCTR port map (CLK => CLK, SYNC_IN => s_down, EDGE => DOWN);

	SYNCHRNZR_left : SYNCHRNZR port map (CLK => CLK, ASYNC_IN => LEFT_SW, SYNC_OUT => s_left);
	EDGEDTCTR_left : EDGEDTCTR port map (CLK => CLK, SYNC_IN => s_left, EDGE => LEFT);

	SYNCHRNZR_right : SYNCHRNZR port map (CLK => CLK, ASYNC_IN => RIGHT_SW, SYNC_OUT => s_right);
	EDGEDTCTR_right : EDGEDTCTR port map (CLK => CLK, SYNC_IN => s_right, EDGE => RIGHT);

	SYNCHRNZR_ok : SYNCHRNZR port map (CLK => CLK, ASYNC_IN => OK_SW, SYNC_OUT => s_ok);
	EDGEDTCTR_ok : EDGEDTCTR port map (CLK => CLK, SYNC_IN => s_ok, EDGE => OK);

end Structual


