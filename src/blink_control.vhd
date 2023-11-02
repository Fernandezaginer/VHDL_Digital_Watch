

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;


ENTITY blink_controler IS
	PORT (
		code_in : IN std_logic_vector(3 DOWNTO 0);
		code_out : OUT std_logic_vector(3 DOWNTO 0);
		counter_in: IN std_logic_vector(2 DOWNTO 0);
		blink_in: IN std_logic_vector(3 DOWNTO 0);
		clk : IN std_logic
	);
END ENTITY blink_controler;


ARCHITECTURE dataflow OF blink_controler IS
BEGIN
	process (clk)
      begin
        if clk = '1' then
            code_out <= code_in;
        else
            if ((counter_in(2 downto 1) = "00") and (blink_in(3) = '1')) then
                code_out <= "1111";
            elsif ((counter_in(2 downto 1) = "01") and (blink_in(2) = '1')) then
                code_out <= "1111";
            elsif ((counter_in(2 downto 1) = "10") and (blink_in(1) = '1')) then
                code_out <= "1111";
            elsif ((counter_in(2 downto 1) = "11") and (blink_in(0) = '1')) then
                code_out <= "1111";
            else
                code_out <= code_in;
            end if;
        end if;
	end process;

END dataflow;



