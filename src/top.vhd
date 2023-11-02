library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity top is
    Port (
        digits_0to3 : in std_logic_vector(15 downto 0);
        digits_4to7 : in std_logic_vector(15 downto 0);
        SW : in std_logic_vector(15 downto 0);
        blink_pairs : in std_logic_vector(3 downto 0);
        CLK100MHZ  : in std_logic;
        SEGMENT : out STD_LOGIC_VECTOR (6 downto 0);
        digctrl : out STD_LOGIC_VECTOR (7 downto 0)
    );
end top;





architecture Behavioral of top is
    
    component FrequencyDivider is
        generic (
            DIVIDER_VALUE : integer := 2
        );
        Port (
            clk_in  : in  STD_LOGIC;
            clk_out : out STD_LOGIC
        );
    end component;
    component contador is
      Port (
        code : out std_logic_vector(2 downto 0);
        clk : in std_logic
      );
    end component;
    component decoder IS
        PORT (
        code : IN std_logic_vector(3 DOWNTO 0);
        led : OUT std_logic_vector(6 DOWNTO 0)
        );
    END component decoder;
    component mux8_4c IS
        PORT (
            in0 : IN std_logic_vector(3 DOWNTO 0);
            in1 : IN std_logic_vector(3 DOWNTO 0);
            in2 : IN std_logic_vector(3 DOWNTO 0);
            in3 : IN std_logic_vector(3 DOWNTO 0);
            in4 : IN std_logic_vector(3 DOWNTO 0);
            in5 : IN std_logic_vector(3 DOWNTO 0);
            in6 : IN std_logic_vector(3 DOWNTO 0);
            in7 : IN std_logic_vector(3 DOWNTO 0);
            select_c : IN std_logic_vector(2 DOWNTO 0);
            out_c : OUT std_logic_vector(3 DOWNTO 0)
        );
    END component mux8_4c;
    component anodo_decoder is
        port (
            digctrl : out std_logic_vector(7 downto 0);
            DIGISEL : in std_logic_vector(2 downto 0)
        );
    end component;
    component blink_controler IS
        PORT (
            code_in : IN std_logic_vector(3 DOWNTO 0);
            code_out : OUT std_logic_vector(3 DOWNTO 0);
            counter_in: IN std_logic_vector(2 DOWNTO 0);
            blink_in: IN std_logic_vector(3 DOWNTO 0);
            clk : IN std_logic
        );
    END component;

    signal counter_clk : std_logic;
    signal blink_clk : std_logic;
    signal contador_out : std_logic_vector(2 downto 0);
    signal code_display : std_logic_vector(3 downto 0);
    signal code_display_blink : std_logic_vector(3 downto 0);
    
begin
    
    
    -- Clocks mult
    div_freq_contador : FrequencyDivider generic map(
            DIVIDER_VALUE => 100000
    )
    port map(
        clk_in => CLK100MHZ,
        clk_out => counter_clk
    );


    -- Clock blink
    div_freq_blink : FrequencyDivider generic map(
            DIVIDER_VALUE => 100000000
    )
    port map(
        clk_in => CLK100MHZ,
        clk_out => blink_clk
    );
    

    -- contador
    contador_multiplexacion : contador port map (code => contador_out, clk => counter_clk);


    -- multiplexor:
    mux : mux8_4c port map (
    in0 => SW(15 downto 12),
    in1 => SW(11 downto 8),
    in2 => SW(7 downto 4),
    in3 => SW(3 downto 0),
    in4 => SW(15 downto 12),
    in5 => SW(11 downto 8),
    in6 => SW(7 downto 4),
    in7 => SW(3 downto 0),
    select_c => contador_out,
    out_c => code_display
    );


    -- Blink
    blink_controler1 : blink_controler PORT map(
    code_in => code_display,
    code_out => code_display_blink,
    counter_in => contador_out,
    blink_in => SW(3 downto 0),
    clk => blink_clk
    );


    -- Anodos del display:
    decodificador_anodos : anodo_decoder port map (digctrl => digctrl, DIGISEL => contador_out);


    -- Catodos del display:
    disp_decoder: decoder port map (LED => SEGMENT, CODE => code_display);


end Behavioral;


