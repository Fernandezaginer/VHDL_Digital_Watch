-- Trabajo SED 23/24 Grupo 2
-- Selector de fecha
-- Entidad general


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity date_selector is
	generic(
		MODE_NUM  : std_logic_vector(7 downto 0) := "11111111"
	);
	port(
		clk : in std_logic;
		buttons : in std_logic_vector(3 downto 0);
        stateActive: in std_logic_vector(7 downto 0);
		day_up : in std_logic;
		digits_0to3 : out std_logic_vector(15 downto 0);
		digits_4to7 : out std_logic_vector(15 downto 0);
		blink_ctrl : out std_logic_vector(7 downto 0);
		year_up : out std_logic
	);
end entity;


architecture Structual of date_selector is 

	component EDGEDTCTR_V2 is
	    port (
	        CLK : in std_logic;
	        SYNC_IN : in std_logic;
	        EDGE : out std_logic
	    );
	end component;

	type MonthDayMax is array(0 to 11) of integer;
	signal dia_maximo_segun_mes: MonthDayMax := (31,30,31,30,31,31,30,31,30,31,28,31);
	signal selected_day : integer := 0;
	signal day: integer := 1;
	signal month: integer := 1;
	signal day_msb: integer := 0;
	signal day_lsb: integer := 1;
	signal month_msb: integer := 0;
	signal month_lsb: integer := 1;
	signal day_up_edge : std_logic;
	signal year_flag : std_logic := '0';

	signal digit_sel : std_logic_vector(1 downto 0) := "01";
begin


	detector_flanco: EDGEDTCTR_V2
	    port map (
	        CLK => CLK,
	        SYNC_IN => day_up,
	        EDGE => day_up_edge
	    );


	process(clk)
	begin
		if rising_edge(clk) then

			if year_flag = '1' then
				year_flag <= '0';
				year_up <= '0';
			end if;
			
			if day_up_edge = '1' then
				day <= day + 1;
				if day >= dia_maximo_segun_mes(month) then
					day <= 1;
					month <= month + 1;
					if month >= 13 then
						month <= 1;
						year_up <= '1';
						year_flag <= '1';
					end if;
				end if;

	    	elsif stateActive = MODE_NUM then
		        if buttons = "0001" then         -- up
		            if (digit_sel = "01" and day < 31) then
		              day <= day + 1;
		            end if;
                    if (digit_sel = "10" and month < 12) then
                        month <= month +1;
                    end if;
		        	--day <= day + 1 when (digit_sel = "01" and day < 31) else day;
		        	--month <= month + 1 when (digit_sel = "10" and month < 12) else month;
		        elsif buttons = "0010" then      -- left
					digit_sel <= "01";
		        elsif buttons = "0100" then      -- right
					digit_sel <= "10";
		        elsif buttons = "1000" then      -- down
		            if (digit_sel = "01" and day > 1) then
		              day <= day - 1;
		            end if;
                    if (digit_sel = "10" and month > 1) then
                        month <= month - 1;
                    end if;
		        	--day <= day - 1 when (digit_sel = "01" and day > 1) else day;
		        	--month <= month - 1 when (digit_sel = "10" and month > 1) else month;
		        end if;
		        if selected_day < 0 then
		            selected_day <= 0;
		        end if;
		        if selected_day > 6 then
		            selected_day <= 6;
		        end if;
	        end if;

	       	if month > 9 then
	       		month_msb <= 1;
	       		month_lsb <= month - 10;
	       	else 
	       		month_msb <= 0;
	       		month_lsb <= month;
	       	end if;
	       	
	       	if day >= 10 then
	       		day_msb <= (day / 10) mod 10;
	       		day_lsb <= day - (((day / 10) mod 10)*10);
	       	else 
	       		day_msb <= 0;
	       		day_lsb <= day;
	       	end if;

		end if;
	end process;

	digits_0to3 <= "1111111111111111";

	digits_4to7(15 downto 12) <= std_logic_vector(to_unsigned(day_msb,4));
	digits_4to7(11 downto 8) <= std_logic_vector(to_unsigned(day_lsb,4));
	digits_4to7(7 downto 4) <= std_logic_vector(to_unsigned(month_msb,4));
	digits_4to7(3 downto 0) <= std_logic_vector(to_unsigned(month_lsb,4));

	blink_ctrl(7 downto 6) <= "11" when stateActive = MODE_NUM and digit_sel = "01" else "00";
	blink_ctrl(5 downto 4) <= "11" when stateActive = MODE_NUM and digit_sel = "10" else "00";
	blink_ctrl(3 downto 2) <= "11" when stateActive = MODE_NUM and digit_sel = "01" else "00";
	blink_ctrl(1 downto 0) <= "11" when stateActive = MODE_NUM and digit_sel = "10" else "00";



end architecture;






