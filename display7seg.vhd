library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hex_to_sseg is
	generic(
      N: integer:=16); -- 16 bits
	port(
		binary: in std_logic_vector (N-1 downto 0);
		sseg: out std_logic_vector (6 downto 0);
		decimal: out integer range 0 to 65535
		);
end hex_to_sseg;

architecture arch of hex_to_sseg is
	signal seg_val: std_logic_vector (6 downto 0);
	signal dec_val: integer range 0 to 65535;
begin
	decimal <= to_integer(unsigned(binary));

	-- Verifica se o valor decimal está dentro do intervalo permitido
	dec_val <= decimal;
	
	-- Separa o valor decimal em dígitos e converte para bits
	seg_val <= "0000000" & std_logic_vector(to_unsigned(dec_val mod 10, 7));
	dec_val <= dec_val / 10;
	seg_val <= "0000000" & std_logic_vector(to_unsigned(dec_val mod 10, 7)) & seg_val;
	dec_val <= dec_val / 10;
	seg_val <= "0000000" & std_logic_vector(to_unsigned(dec_val mod 10, 7)) & seg_val;
	dec_val <= dec_val / 10;
	seg_val <= "0000000" & std_logic_vector(to_unsigned(dec_val mod 10, 7)) & seg_val;
	dec_val <= dec_val / 10;
	seg_val <= "0000000" & std_logic_vector(to_unsigned(dec_val mod 10, 7)) & seg_val;
	dec_val <= dec_val / 10;
	seg_val <= "0000000" & std_logic_vector(to_unsigned(dec_val, 7)) & seg_val;
		 
	-- Atribui a saída dos segmentos aos displays
	sseg <= seg_val;

end arch;