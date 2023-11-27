library ieee;
use ieee.std_logic_1164.all;


entity Register1Bit is 
port
(
	clk, load, clear: in std_logic;
	d:					 	in std_logic;
	q:					 	out std_logic
);
end Register1Bit;

architecture behavior of Register1Bit is

begin

process(clk, clear)

variable qTemp:	std_logic;

begin
	
	if (clk'event and clk = '1') then
		if (clear = '1') then
			qTemp := '0';
		elsif (load = '1') then
			qTemp := d;
		else
			qTemp := qTemp;
		end if;
	end if;
	
	q<=qTemp;
	
end process;



end behavior; 