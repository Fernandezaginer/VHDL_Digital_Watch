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
	port(
        digits_0to3 : out std_logic_vector(15 downto 0);
        digits_4to7 : out std_logic_vector(15 downto 0);
        blink_ctrl : out std_logic_vector(7 downto 0);
        CLK  : in std_logic;
        buttons: in std_logic_vector(3 downto 0);
        day_sel : out std_logic_vector(6 downto 0)
	);
end entity day_alarm_selec;



architecture Structual of day_alarm_selec is
	signal out_sel_days : std_logic_vector(6 downto 0);
	signal selected_day : integer := 0;
begin
	

	-- activate / deactivate days
	process(CLK)
	begin
--		if buttons(0) = '1' then         -- activate
--			out_sel_days(selected_day) = '1';
--		elsif buttons(1) = '1' then      -- left
--			selected_day <= selected_day - 1 when (selected_day - 1 >= 0) else 0
--		elsif buttons(2) = '1' then      -- right
--			selected_day <= selected_day + 1 when (selected_day + 1 <= 6) else 6
--		elsif buttons(3) = '1' then      -- deactivate
--			out_sel_days(selected_day) = '0';
--		end if;
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
		"00000000" when others;


	-- output display:
	with out_sel_days(0) select
	digits_0to3(15 downto 12) <= "0001" when '1',
		"0000" when others;
	with out_sel_days(1) select
	digits_0to3(11 downto 8) <= "0010" when '1',
		"0000" when others;
	with out_sel_days(2) select
	digits_0to3(7 downto 4) <= "0011" when '1',
		"0000" when others;
	with out_sel_days(3) select
	digits_0to3(3 downto 0) <= "0100" when '1',
		"0000" when others;
	with out_sel_days(4) select
	digits_4to7(15 downto 12) <= "0101" when '1',
		"0000" when others;
	with out_sel_days(5) select
	digits_4to7(11 downto 8) <= "0110" when '1',
		"0000" when others;
	with out_sel_days(6) select
	digits_4to7(7 downto 4) <= "0111" when '1',
		"0000" when others;
	digits_4to7(3 downto 0) <= "000";


	-- output
	day_sel <= out_sel_days;

end architecture Structual;


