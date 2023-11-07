-- Trabajo SED 23/24 Grupo 2
-- Entidad principal del despertador



entity TOP is
    Port (
        digits_0to3 : in std_logic_vector(15 downto 0);
        digits_4to7 : in std_logic_vector(15 downto 0);
        SW : in std_logic_vector(15 downto 0);
        blink_pairs : in std_logic_vector(3 downto 0);
        CLK100MHZ  : in std_logic;
        SEGMENT : out STD_LOGIC_VECTOR (6 downto 0);
        digctrl : out STD_LOGIC_VECTOR (7 downto 0)
    );
end TOP;

architecture Structual of TOP is
	component display is
	    Port (
	        digits_0to3 : in std_logic_vector(15 downto 0);
	        digits_4to7 : in std_logic_vector(15 downto 0);
	        SW : in std_logic_vector(15 downto 0);
	        blink_pairs : in std_logic_vector(3 downto 0);
	        CLK100MHZ  : in std_logic;
	        SEGMENT : out STD_LOGIC_VECTOR (6 downto 0);
	        digctrl : out STD_LOGIC_VECTOR (7 downto 0)
	    );
	end component;
begin





end Structual;



