LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

library work;
use work.HadamardPackage.all;

entity ShiftRight is
generic( num: integer := 10 );
port(
		a: 	 in  std_logic_vector(num - 1 downto 0);
		s: 	 out std_logic_vector(num - 1 downto 0)
);
end ShiftRight;

architecture structure of ShiftRight is

	begin         
		generateShifters:        
			for i in 0 to num - 2 generate
				SR: Mux  
				port map(a => a(i+1), b => a(i), sel => '0', s => s(i));
		end generate generateShifters;
		SR: Mux
		port map(a => '0', b => a(num - 1), sel => '0', s => s(num - 1));
	end structure;