
entity anodo_decoder is
    port (
        digctrl : out std_logic_vector(2 downto 0);
        DIGISEL : in std_logic_vector(2 downto 0)
    );
end anodo_decoder;

architecture BEHAVIORAL of anodo_decoder is
   begin
  digctrl(7) <= '0' when DIGSEL = "000" else '1';
  digctrl(6) <= '0' when DIGSEL = "001" else '1';
  digctrl(5) <= '0' when DIGSEL = "010" else '1';
  digctrl(4) <= '0' when DIGSEL = "011" else '1';
  digctrl(3) <= '0' when DIGSEL = "100" else '1';
  digctrl(2) <= '0' when DIGSEL = "101" else '1';
  digctrl(1) <= '0' when DIGSEL = "110" else '1';
  digctrl(0) <= '0' when DIGSEL = "111" else '1';
end BEHAVIORAL;








