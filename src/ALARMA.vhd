-- Trabajo SED 23/24 Grupo 2
-- Modulo alarma
-- Entidad principal


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity alarma is
	port(
		clk : in std_logic;
		on1 : in std_logic;
		on2 : in std_logic;
		buzzer : out std_logic;
		buttons_beep : in std_logic_vector(3 downto 0);
		ok_beep : in std_logic
	);	
end entity alarma;


architecture Behavioral of alarma is
	component Prescaler is
	    generic (
	        DIVIDER_VALUE : integer := 16
	    );
	    Port (
	        clk_in  : in  STD_LOGIC;
	        clk_out : out STD_LOGIC
	    );
	end component;

	signal on3 : std_logic;
	signal freq_buzzer : std_logic;
	signal buzzer_on :std_logic;
	signal buzzer_beep_counter : integer;

	constant BUZZER_BEEPS_COUNTS : integer := 2000000; 

begin
	
	-- beep buttons
	process(CLK)
	begin
		if rising_edge(CLK) then
			if on3 = '1' and buzzer_beep_counter < BUZZER_BEEPS_COUNTS then
				buzzer_beep_counter <= buzzer_beep_counter + 1;
			end if;

			if buzzer_beep_counter = BUZZER_BEEPS_COUNTS then
				on3 <= '0';
				buzzer_beep_counter <= 0;
			end if;

			if buttons_beep(0) = '1' or buttons_beep(1) = '1' or buttons_beep(2) = '1' or buttons_beep(3) = '1' or ok_beep = '1' then
				on3 <= '1';
				buzzer_beep_counter <= 0;
			end if;
		end if;
	end process;


	-- tone frequency
	Prescaler_freq_buzzer : Prescaler generic map(DIVIDER_VALUE => 100000)
	port map (clk_in => clk, clk_out => freq_buzzer);
	

	-- buzzer out square signal
	buzzer_on <= on1 or on2 or on3;
	buzzer <= freq_buzzer and buzzer_on;

end architecture Behavioral;



