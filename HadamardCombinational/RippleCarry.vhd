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
    
    begin
		  c(0)<= op;
        generateAdders:        
            for i in 0 to num-1 generate
						  bOp(i) <= (b(i) xor op);
                    FA:FullAdder  
                    port map(c(i), a(i), bOp(i), s(i), c(i+1));
        end generate generateAdders;
        cLast<=c(num);
    
end structure;