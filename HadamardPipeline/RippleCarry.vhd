library ieee;
use ieee.std_logic_1164.all;

library work;
use work.HadamardPackage.all;

entity RippleCarry is
generic(num:        integer := 8);
port
(
    c0:    	in std_logic;
    a,b:    in std_logic_vector(num - 1 downto 0);
    op:     in std_logic;
    s:      out std_logic_vector(num - 1 downto 0);
    cLast:  out std_logic
);
end RippleCarry;

architecture structure of RippleCarry is

    signal c:    std_logic_vector(num downto 0);
    signal bOp:  std_logic_vector(num - 1 downto 0);
	 signal x:	  std_logic_vector(num - 1 downto 0);
	 signal over: std_logic; 
    
    begin
		  c(0)<= op;
        generateAdders:        
            for i in 0 to num-1 generate
						  bOp(i) <= (b(i) xor op);
                    FA:FullAdder  
                    port map(c(i), a(i), bOp(i), x(i), c(i+1));
						  s(i) <= x(i);
        end generate generateAdders;
		  
		  over <= (c(num) xor c(num - 1)) or x(num - 1);
		  
        with op select
		  cLast <= 	over and (a(num - 1) or b(num - 1))  when '0',
						over when others;
		  
    
end structure;