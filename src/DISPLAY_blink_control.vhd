-- Trabajo SED 23/24 Grupo 2
-- Modulo display
-- Entidad de control del parpadeo de los dígitos



LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;


ENTITY blink_controler IS
	PORT (
		code_in : IN std_logic_vector(3 DOWNTO 0);
		code_out : OUT std_logic_vector(3 DOWNTO 0);
		counter_in: IN std_logic_vector(2 DOWNTO 0);
		blink_in: IN std_logic_vector(7 DOWNTO 0);
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
            if ((counter_in = "000") and (blink_in(7) = '1')) then
                code_out <= "1111";
            elsif ((counter_in = "001") and (blink_in(6) = '1')) then
                code_out <= "1111";
            elsif ((counter_in = "010") and (blink_in(5) = '1')) then
                code_out <= "1111";
            elsif ((counter_in = "011") and (blink_in(4) = '1')) then
                code_out <= "1111";
            elsif ((counter_in = "100") and (blink_in(3) = '1')) then
                code_out <= "1111";
            elsif ((counter_in = "101") and (blink_in(2) = '1')) then
                code_out <= "1111";
            elsif ((counter_in = "110") and (blink_in(1) = '1')) then
                code_out <= "1111";
            elsif ((counter_in = "111") and (blink_in(0) = '1')) then
                code_out <= "1111";
            else
                code_out <= code_in;
            end if;
        end if;
	end process;

END dataflow;



