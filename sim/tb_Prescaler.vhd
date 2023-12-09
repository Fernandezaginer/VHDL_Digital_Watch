-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 6.11.2023 18:40:22 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_Prescaler is
end tb_Prescaler;

architecture tb of tb_Prescaler is

    component Prescaler is
      generic (
          DIVIDER_VALUE : integer := 8
      );
        port (clk_in  : in std_logic;
              clk_out : out std_logic);
    end component;

    signal clk_in  : std_logic;
    signal clk_out : std_logic;
	signal DIVIDER_VALUE : integer := 16;


begin

    dut : Prescaler
    generic map(
      DIVIDER_VALUE => DIVIDER_VALUE
    )
    port map (clk_in  => clk_in,
              clk_out => clk_out);

    stimuli : process
    begin
    	
        for count in 0 to (DIVIDER_VALUE/2) loop
          clk_in <= '1';
          wait for 100 ns;
          clk_in <= '0';
          wait for 100 ns;
		  assert clk_out = '0'
            report "ERROR en el prescaler"
            severity failure;
		end loop;

    	
        for count in 0 to (DIVIDER_VALUE/2) loop
          clk_in <= '1';
          wait for 100 ns;
          clk_in <= '0';
          wait for 100 ns;
		  assert clk_out = '1'
            report "ERROR en el prescaler"
            severity failure;
		end loop;


        assert false
          report "SIM OK"
          severity failure;


        wait;
    end process;
end tb;

