-- Trabajo SED 23/24 Grupo 2
-- Modulo gestor de entradas botones
-- Contiene los sincronizadores y detecores de flanco


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity gestor_de_entradas is
	Port(
        CLK  : in std_logic;
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

end gestor_de_entradas;


architecture Structual of gestor_de_entradas is 
	component SYNCHRNZR is
	    port (
	        CLK : in std_logic;
	        ASYNC_IN : in std_logic;
	        SYNC_OUT : out std_logic
	    );
	end component;
	component EDGEDTCTR_V2 is
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
	EDGEDTCTR_up : EDGEDTCTR_V2 port map (CLK => CLK, SYNC_IN => s_up, EDGE => UP);

	SYNCHRNZR_down : SYNCHRNZR port map (CLK => CLK, ASYNC_IN => DOWN_SW, SYNC_OUT => s_down);
	EDGEDTCTR_down : EDGEDTCTR_V2 port map (CLK => CLK, SYNC_IN => s_down, EDGE => DOWN);

	SYNCHRNZR_left : SYNCHRNZR port map (CLK => CLK, ASYNC_IN => LEFT_SW, SYNC_OUT => s_left);
	EDGEDTCTR_left : EDGEDTCTR_V2 port map (CLK => CLK, SYNC_IN => s_left, EDGE => LEFT);

	SYNCHRNZR_right : SYNCHRNZR port map (CLK => CLK, ASYNC_IN => RIGHT_SW, SYNC_OUT => s_right);
	EDGEDTCTR_right : EDGEDTCTR_V2 port map (CLK => CLK, SYNC_IN => s_right, EDGE => RIGHT);

	SYNCHRNZR_ok : SYNCHRNZR port map (CLK => CLK, ASYNC_IN => OK_SW, SYNC_OUT => s_ok);
	EDGEDTCTR_ok : EDGEDTCTR_V2 port map (CLK => CLK, SYNC_IN => s_ok, EDGE => OK);

end Structual;


