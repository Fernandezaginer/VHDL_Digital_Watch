-- Trabajo SED 23/24 Grupo 2
-- Sumador BCD de 4 digitos
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
		in1 : in std_logic_vector(3 downto 0);
		in2 : in std_logic_vector(3 downto 0);
		in3 : in std_logic_vector(3 downto 0);
		out0 : out std_logic_vector(3 downto 0);
		out1 : out std_logic_vector(3 downto 0);
		out2 : out std_logic_vector(3 downto 0);
		out3 : out std_logic_vector(3 downto 0);
		carry : out std_logic_vector(3 downto 0)
	);
end entity;


architecture Behavioral of bcd_adder is
	
	component bcd_adder is
		port(
			clk : in std_logic;
			suma : in std_logic_vector(3 downto 0);
			in0 : in std_logic_vector(3 downto 0);
			out0 : out std_logic_vector(3 downto 0);
			carry : out std_logic_vector(3 downto 0)
		);
	end component;

	signal integer_in : integer;
	signal integer_out : integer;
	signal integer_suma : integer;
	signal c0 : std_logic_vector(3 downto 0);
	signal c1 : std_logic_vector(3 downto 0);
	signal c2 : std_logic_vector(3 downto 0);

begin
	
	adder1 :  bcd_adder
		port map (
			clk => clk,
			suma => suma,
			in0 => in0,
			out0 => out0,
			carry => c0
		);

	adder2 :  bcd_adder
		port map (
			clk => clk,
			suma => c0,
			in0 => in1,
			out0 => out1,
			carry => c1
		);


	adder3 :  bcd_adder
		port map (
			clk => clk,
			suma => c1,
			in0 => in2,
			out0 => out2,
			carry => c2
		);


	adder4 :  bcd_adder
		port map (
			clk => clk,
			suma => c2,
			in0 => in3,
			out0 => out3,
			carry => carry
		);

end Behavioral;



