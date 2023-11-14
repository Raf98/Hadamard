LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

library work;
use work.HadamardPackage.all;

entity ShiftRight IS
generic( num: integer := 8 );
port(
		a: 	 in std_logic_vector(num -1 downto 0);
		s: 	 out std_logic_vector(num - 1 downto 0)
);
end ShiftRight;

architecture structure of ShiftRight is

	begin

			generateShifters:        
				for i in 0 to num - 2 generate
					SR: Mux  
               port map(a(i+1), a(i), '1', s(i));
			end generate generateShifters;
			SR: Mux  
         port map('0', a(num - 1), '1', s(num - 1));        
	end structure;