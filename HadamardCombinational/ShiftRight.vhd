LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

library work;
use work.HadamardPackage.all;

entity ShiftRight IS
generic( num: integer := 10 );
port(
		a: 	 in std_logic_vector(num -1 downto 0);
		s: 	 out std_logic_vector(num - 1 downto 0)
);
end ShiftRight;

architecture structure of ShiftRight is

	begin
		SR: Mux          
		port map('0', a(num - 1), '0', s(num - 1));
		generateShifters:        
			for i in num - 2 to 0 generate
				SR: Mux  
            port map(a(i+1), a(i), '0', s(i));
		end generate generateShifters;
	end structure;