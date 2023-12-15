-- Trabajo SED 23/24 Grupo 2
-- Selector de año
-- Entidad general


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
--use IEEE.fixed_float_types.all;

library UNISIM;
use UNISIM.VComponents.all;



entity year_selector is
	generic(
		MODE_NUM  : std_logic_vector(7 downto 0) := "11111111"
	);
	port(
		clk : in std_logic;
		buttons : in std_logic_vector(3 downto 0);
        stateActive: in std_logic_vector(7 downto 0);
		year_up : in std_logic;
		digits_0to3 : out std_logic_vector(15 downto 0);
		digits_4to7 : out std_logic_vector(15 downto 0);
		blink_ctrl : out std_logic_vector(7 downto 0);
		year_out : out integer                               -- No en BCD
	);
end entity;


architecture Structual of year_selector is 

	component EDGEDTCTR_V2 is
	    port (
	        CLK : in std_logic;
	        SYNC_IN : in std_logic;
	        EDGE : out std_logic
	    );
	end component;

	signal year_up_edge : std_logic;
	signal year : integer := 2023;
	signal year_3 : integer := 2;
	signal year_2 : integer := 0;
	signal year_1 : integer := 2;
	signal year_0 : integer := 3;
	
	signal c3 : real := 1000.0;
	signal c2 : real := 100.0;
	signal c1 : real := 10.0;
	signal c0 : real := 1.0;

begin


	detector_flanco: EDGEDTCTR_V2
	    port map (
	        CLK => CLK,
	        SYNC_IN => year_up,
	        EDGE => year_up_edge
	    );


	process(clk)
	begin
		if rising_edge(clk) then
			if year_up_edge = '1' then
				year <= year + 1;
			end if;

	    	if stateActive = MODE_NUM then
		        if buttons = "0001" then         -- up
				year <= year + 1;
		        elsif buttons = "1000" then      -- down
				year <= year - 1;
		        end if;
	        end if;
		
            year_3 <= (year / 1000) mod 10;
            year_2 <= (year / 100) mod 10;
            year_1 <= (year / 10) mod 10;
            year_0 <= year mod 10;
            
		end if;		
	end process;


	digits_0to3(15 downto 12) <= std_logic_vector(to_unsigned(year_3,4));
	digits_0to3(11 downto 8) <= std_logic_vector(to_unsigned(year_2,4));
	digits_0to3(7 downto 4) <=  std_logic_vector(to_unsigned(year_1,4));
	digits_0to3(3 downto 0) <=  std_logic_vector(to_unsigned(year_0,4));

	digits_4to7 <= "1111111111111111";

	blink_ctrl(3 downto 0) <= "0000";
	blink_ctrl(7 downto 4) <= "1111" when mode = MODE_NUM  else "0000";

	year_out <= year;
	
end architecture;


