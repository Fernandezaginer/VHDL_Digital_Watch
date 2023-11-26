-- Trabajo SED 23/24 Grupo 2
-- Selector de fecha
-- Entidad general


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity time_count is
	generic(
		MODE_NUM_SET_TIME => "1000",
		MODE_NUM_RUN_CNT => "0000"
	);
	port(
		clk : in std_logic;
		buttons : in std_logic(3 downto 0);
		mode : in std_logic_vector(3 downto 0);
		day_up : in std_logic;
		digits_0to3 : out std_logic_vector(3 downto 0);
		digits_4to7 : out std_logic_vector(3 downto 0);
		blink_ctrl : out std_logic_vector(7 downto 0);
		year_up : in std_logic
	);
end entity;


architecture Structual of time_count is 

	
	-- Prescaler component

	signal clk_1hz : std_logic;
	
	signal digit_selc : std_logic_vector(2 downto 0);
	
	signal hour_sel : integer := 0;
	signal min_sel : integer := 0;
	signal sec_sel : integer := 0;
	
	signal hour : integer;
	signal min : integer;
	signal sec : integer;

	signal hour_msb : integer;
	signal hour_lsb : integer;
	signal min_msb : integer;
	signal min_lsb : integer;
	signal sec_msb : integer;
	signal sec_lsb : integer;
	
begin

	-- Pescaler
	

	process(clk):
	begin
		if rising_edge(clk) and mode = MODE_NUM_SET_TIME then
			
		end if;
	end process;

	process(clk_1hz):
	begin
		if rising_edge(clk_1hz) and mode = MODE_NUM_RUN_CNT then
			
		end if;
	end process;



	digits_0to3(15 downto 8) <= "11111111";

	digits_0to3(7 downto 4) <= std_logic_vector(to_unsigned(hour_msb,4));
	digits_0to3(3 downto 0) <= std_logic_vector(to_unsigned(hour_lsb,4));

	digits_4to7(15 downto 12) <= std_logic_vector(to_unsigned(min_msb,4));
	digits_4to7(11 downto 8) <= std_logic_vector(to_unsigned(min_lsb,4));
	digits_4to7(7 downto 4) <=  std_logic_vector(to_unsigned(sec_msb,4));
	digits_4to7(3 downto 0) <=  std_logic_vector(to_unsigned(sec_lsb,4));
	
	
	blink_ctrl(7 downto 6) <= "00";
	blink_ctrl(5 downto 4) <= "00" when mode = MODE_NUM_SET_TIME and digit_selc = "100" else "00";
	blink_ctrl(3 downto 2) <= "11" when mode = MODE_NUM_SET_TIME and digit_selc = "010" else "00";
	blink_ctrl(1 downto 0) <= "11" when mode = MODE_NUM_SET_TIME and digit_selc = "001" else "00";



end architecture;

