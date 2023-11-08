-- Trabajo SED 23/24 Grupo 2
-- Modulo display
-- Entidad central del display

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity display is
    Port (
        digits_0to3 : in std_logic_vector(15 downto 0);
        digits_4to7 : in std_logic_vector(15 downto 0);
        blink_ctrl : in std_logic_vector(7 downto 0);
        CLK  : in std_logic;
        SEGMENT_CRTL : out STD_LOGIC_VECTOR (6 downto 0);
        digctrl_CTRL : out STD_LOGIC_VECTOR (7 downto 0)
    );
end display;




architecture Behavioral of display is
    
    component Prescaler is
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
    component catodo_decoder IS
        PORT (
        code : IN std_logic_vector(3 DOWNTO 0);
        led : OUT std_logic_vector(6 DOWNTO 0)
        );
    END component catodo_decoder;
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
            blink_in: IN std_logic_vector(7 DOWNTO 0);
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
    div_freq_contador : Prescaler generic map(
            DIVIDER_VALUE => 10000
    )
    port map(
        clk_in => CLK,
        clk_out => counter_clk
    );


    -- Clock blink
    div_freq_blink : Prescaler generic map(
            DIVIDER_VALUE => 100000000
    )
    port map(
        clk_in => CLK,
        clk_out => blink_clk
    );
    

    -- contador
    contador_multiplexacion : contador port map (code => contador_out, clk => counter_clk);


    -- multiplexor:
    mux : mux8_4c port map (
    in0 => digits_0to3(15 downto 12),
    in1 => digits_0to3(11 downto 8),
    in2 => digits_0to3(7 downto 4),
    in3 => digits_0to3(3 downto 0),
    in4 => digits_4to7(15 downto 12),
    in5 => digits_4to7(11 downto 8),
    in6 => digits_4to7(7 downto 4),
    in7 => digits_4to7(3 downto 0),
    select_c => contador_out,
    out_c => code_display
    );


    -- Blink
    blink_controler1 : blink_controler PORT map(
    code_in => code_display,
    code_out => code_display_blink,
    counter_in => contador_out,
    blink_in => blink_ctrl,
    clk => blink_clk
    );


    -- Anodos del display:
    decodificador_anodos : anodo_decoder port map (digctrl => digctrl_CTRL, DIGISEL => contador_out);


    -- Catodos del display:
    disp_decoder: catodo_decoder port map (LED => SEGMENT_CRTL, CODE => code_display_blink);


end Behavioral;


