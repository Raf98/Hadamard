library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;

library work;
use work.HadamardPackage.all;


entity PingPongBuffer is
generic(
	num:		integer := 8;
	addrNum:	integer := 2;
	rNum:		integer := 4
);
port
(	
	adressWrite:	 		in std_logic_vector(addrNum - 1 downto 0);
	dataWrite:		 		in std_logic_vector(num - 1 downto 0);
	
	w0, w1, w2, w3: 		out std_logic_vector(num - 1 downto 0);
	
	clk, writeRegister:	in std_logic
);
end PingPongBuffer;


architecture behavior of PingPongBuffer is

type registers is array( 0 to rNum - 1 ) of std_logic_vector( num - 1 downto 0 );
signal regBank:	registers;

begin
	
	process( clk, writeRegister )

	begin
	
		if ( clk = '1' and clk'event ) then
			if ( writeRegister = '1' ) then
				regBank( conv_integer( adressWrite )  ) <= dataWrite( addrNum - 1 downto 0 );
			end if;
			w0 <= regBank(0) after 1ns;
			w1 <= regBank(1);
			w2 <= regBank(2);
			w3 <= regBank(3);
		end if;
		
	end process;

end behavior;