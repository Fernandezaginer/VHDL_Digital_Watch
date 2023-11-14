-- Trabajo SED 23/24 Grupo 2
-- Sumador simple BCD
-- Entidad general


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity bcd_adder is
	port(
		clk : in std_logic;
		suma : in std_logic_vector(3 downto 0);
		in0 : in std_logic_vector(3 downto 0);
		out0 : out std_logic_vector(3 downto 0);
		carry : out std_logic_vector(3 downto 0)
	);
end entity;


architecture Behavioral of bcd_adder is

	signal integer_in : integer := 0;
	signal integer_out : integer := 0;
	signal integer_suma : integer := 0;
begin
	process(clk)
	begin
		--integer_in <= TO_INTEGER(signed(in0));
		--integer_suma <= TO_INTEGER(signed(suma));
		integer_out <= integer_in + integer_suma;

		if integer_out < 10 then
			--out0 <= std_logic_vector(to_signed(integer_out,4));
			carry <= "0000";
		else
            --out0 <= std_logic_vector(to_signed(integer_out - 10,4));
			carry <= "0001";			
		end if; 
	end process;
end Behavioral;





