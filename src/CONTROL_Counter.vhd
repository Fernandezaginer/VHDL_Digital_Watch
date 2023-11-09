-- Trabajo SED 23/24 Grupo 2
-- Modulo control
-- Contador del modo del sistema


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity control_counter is
	generic(
		max_count : integer := 8    -- numero maximo incluido en la cuenta
	);
	Port (
        clk : in std_logic;
        counter_in : in std_logic;
        counter_out : out std_logic_vector(3 downto 0)
    );
end control_counter;



architecture Behavioral of control_counter is
    signal var_contador : integer := 0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if counter_in = '1' then
	            var_contador <= var_contador + 1;
	            if var_contador > max_count then
		            var_contador <= 0;
	            end if;
            end if;
        end if;
    end process;
    counter_out <= std_logic_vector(to_signed(var_contador,4));
end Behavioral;
