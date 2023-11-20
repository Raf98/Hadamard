library ieee;
use ieee.std_logic_1164.all;

library work;
use work.HadamardPackage.all;

entity RegisterNBits is 
generic(num:		integer := 4);

port
(
	clk,load, clear:	in  std_logic;
	d:						in  std_logic_vector(num - 1 downto 0);
	q:						out std_logic_vector(num - 1 downto 0)
);
end RegisterNBits;

architecture structure of RegisterNBits is


begin

	RN:for i in 0 to num-1 generate
		
		regs:Register1Bit port map(clk, load, clear, d(i), q(i));
		
	end generate;

end structure;