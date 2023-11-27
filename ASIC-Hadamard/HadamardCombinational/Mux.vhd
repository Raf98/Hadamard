library ieee;
use ieee.std_logic_1164.all;

entity Mux is
port
(
	a,b:		in std_logic;
	sel:		in std_logic;
	s:			out std_logic
);
end Mux;


architecture structure of Mux is

begin

		--with sel select
		--s <= 	a when '0',
		--		b when others;
		s <= (not sel and a) or (sel and b);

end structure;