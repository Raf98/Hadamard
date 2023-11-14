library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;

library work;
use work.HadamardPackage.all;


entity PingPongBuffer is
generic(
	num:		integer := 32;
	addrNum:	integer := 4
);
port
(
	adressRead1:	in std_logic_vector(addrNum - 1 downto 0);
	adressRead2:	in std_logic_vector(addrNum - 1 downto 0);
	
	dataRead1:		out std_logic_vector(num-1 downto 0);
	dataRead2:		out std_logic_vector(num-1 downto 0);
	
	adressWrite:	in std_logic_vector(addrNum - 1 downto 0);
	dataWrite:		in std_logic_vector(num-1 downto 0);
	
	clk:				in std_logic;
	
	writeRegister:	in std_logic
	
	
);
end PingPongBuffer;


architecture behavior of PingPongBuffer is

type registers is array( 0 to num-1 ) of std_logic_vector( num-1 downto 0 );
signal regBank:	registers;

begin
	
	process( clk, writeRegister )

	begin
	
		if ( clk = '1' and clk'event and writeRegister = '1' ) then 
			regBank( conv_integer( adressWrite )  ) <= dataWrite( num-1 downto 0 );  
		end if;
		
	end process;

	
	dataRead1 <= regBank(  conv_integer( AdressRead1 )  );
	dataRead2 <= regBank(  conv_integer( AdressRead2 )  );

end behavior;