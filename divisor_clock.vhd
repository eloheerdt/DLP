library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor_clock is
	generic(
	 N: integer:=24);
	port(
		clk: in std_logic;
		max_tick: out std_logic
		);
end divisor_clock;

architecture arch of divisor_clock is
	signal r_reg: unsigned(N-1 downto 0);
	signal r_next: unsigned(N-1 downto 0);	
begin
	process(clk)
	begin
		if (clk'event and clk='1') then	
			r_reg <= r_next;
		end if;
	end process;
	--next state logic
	r_next <= r_reg + 1;
	-- output
	max_tick <= '1' when r_reg=1 else '0';
end arch;