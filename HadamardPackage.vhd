library ieee;
use ieee.std_logic_1164.all;


package HadamardPackage is
	-------------------------Full Adder-------------------------------
	
	 component FullAdder IS 
    PORT 
    (
        cin, a, b:     IN STD_LOGIC;
        s, cout:       OUT STD_LOGIC
    );
    END component;
    
	-------------------------RippleCarry Adder------------------------
	component RippleCarry is
	generic(num:        integer := 8);
	port
	(
		c0:    in std_logic;
		a,b:   in std_logic_vector(num - 1 downto 0);
		op:    in std_logic;
		s:     out std_logic_vector(num - 1 downto 0);
		cLast: out std_logic
	);
	end component;
	
	-------------------------Mux------------------------
	
	component Mux is
	port
	(
		a,b:		in std_logic;
		sel:		in std_logic;
		s:			out std_logic
	);
	end component;
	
		-------------------------Mux------------------------
	
	component ShiftRight is
	generic(num:        integer := 8);
	port(
		a: 	 in std_logic_vector(num -1 downto 0);
		s: 	 out std_logic_vector(num - 1 downto 0)
	);
	end component;

	
	-------------------------Registrador de 1 bit------------------------
	
	component Register1Bit is 	
	port
	(
		clk,load,d:		in std_logic;
		q:		out std_logic
	);
	end component;
	
	--------------------------Registrador de 8 bits-----------------------
	
	
	component RegisterNBits is 
	generic(num:		integer := 8);

	port
	(
		clk,load:	in std_logic;
		d:		in std_logic_vector(num-1 downto 0);
		q:		out std_logic_vector(num-1 downto 0)
	);
	end component;

	
	-----------------------Mux de N bits----------------------------------
	
	
	component MuxMulti is
	generic( num: integer := 8 );
	port 
	(
		a,b:		in std_logic_vector(num-1 downto 0);
		sel:		in std_logic;
		s:			out std_logic_vector(num-1 downto 0)
	);
	end component;

end HadamardPackage;