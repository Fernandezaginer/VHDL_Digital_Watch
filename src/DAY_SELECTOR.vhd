-- Trabajo SED 23/24 Grupo 2
-- Modulo selector de dias de alarma
-- Entidad principal


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;



entity day_alarm_selec is
    generic(
        MODE_NUM : std_logic_vector(3 downto 0) := "1111"
        );
	port(
        mode: in std_logic_vector(3 downto 0);
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl : out std_logic_vector(7 downto 0);
        CLK  : in std_logic;
        buttons: in std_logic_vector(3 downto 0);
        day_sel : out std_logic_vector(6 downto 0)
	);
end entity day_alarm_selec;



architecture Structual of day_alarm_selec is
	signal out_sel_days : std_logic_vector(6 downto 0) := "0011111";
	signal selected_day : integer := 0;
begin
	

	-- activate / deactivate days
    process(CLK)
    begin
    	if rising_edge(clk) and mode = MODE_NUM then
	        if buttons = "0001" then         -- activate
	            out_sel_days(selected_day) <= '1';
	        elsif buttons = "0010" then      -- left
	            selected_day <= selected_day - 1;
	        elsif buttons = "0100" then      -- right
	            selected_day <= selected_day + 1;
	        elsif buttons = "1000" then      -- deactivate
	            out_sel_days(selected_day) <= '0';
	        end if;
	        if selected_day < 0 then
	            selected_day <= 0;
	        end if;
	        if selected_day > 6 then
	            selected_day <= 6;
	        end if;
        end if;
    end process;
	
	
	-- blink control
	with selected_day select
	blink_ctrl <= "10000000" when 0,
		"01000000" when 1,
		"00100000" when 2,
		"00010000" when 3,
		"00001000" when 4,
		"00000100" when 5,
		"00000010" when 6,
		"11111111" when others;


	-- output display:
	with out_sel_days(0) select
	digits_0to3(15 downto 12) <= "0000" when '1',
		"1111" when '0';
	with out_sel_days(1) select
	digits_0to3(11 downto 8) <= "0001" when '1',
		"1111" when '0';
	with out_sel_days(2) select
	digits_0to3(7 downto 4) <= "0010" when '1',
		"1111" when '0';
	with out_sel_days(3) select
	digits_0to3(3 downto 0) <= "0011" when '1',
		"1111" when '0';
	with out_sel_days(4) select
	digits_4to7(15 downto 12) <= "0100" when '1',
		"1111" when '0';
	with out_sel_days(5) select
	digits_4to7(11 downto 8) <= "0101" when '1',
		"1111" when '0';
	with out_sel_days(6) select
	digits_4to7(7 downto 4) <= "0110" when '1',
		"1111" when '0';
	digits_4to7(3 downto 0) <= "1111";


	-- output
	day_sel <= out_sel_days;

end architecture Structual;


