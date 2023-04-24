library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_gray is
   generic(
      N: integer:=16); -- 16 bits
   port(
      counter: in std_logic;
      reset: in std_logic;
		enable: in std_logic;
      gray: out std_logic_vector(N-1 downto 0);
		binary_counter: out std_logic_vector (N-1 downto 0)
		);
end counter_gray;

architecture arch of counter_gray is
	signal binary_count: std_logic_vector(N-1 downto 0);
	signal gray_count: std_logic_vector(N-1 downto 0);
begin
	process (counter,reset)
	begin
		if (reset = '1') then
			binary_count <= (others => '0');
		elsif (counter'event and counter='1') then
			if (enable = '1') then
				binary_count <= std_logic_vector(unsigned(binary_count) + 1);
			end if;
		end if;
		
		gray_count(0) <= binary_count(0);
		for i in 1 to (N-1) loop
			gray_count(i) <= binary_count(i) xor binary_count(i-1);
		end loop;
	end process;

	gray <= gray_count;
	binary_counter <= binary_count;
end arch;