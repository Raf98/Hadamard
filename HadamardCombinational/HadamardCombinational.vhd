library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

library work;
use work.HadamardPackage.all;

entity HadamardCombinational is

generic
(
	num:        integer := 8; 
	wNum:       integer := 4
);

port
(
    w0, w1, w2, w3:     in  std_logic_vector(num - 1 downto 0);
    s0, s1, s2, s3:     out std_logic_vector(num - 1 downto 0)
);
end HadamardCombinational;

architecture structure of HadamardCombinational is

	 type hadamard_entries is array (wNum - 1 downto 0) of std_logic_vector(num - 1 downto 0);
	 
    signal a:    hadamard_entries;
	 signal b:    hadamard_entries;
    signal c:    std_logic_vector(num	   downto 0);
    signal bOp:  std_logic_vector(num - 1 downto 0);
	
	 begin
    Adder0: RippleCarry  
    port map('0', w0, w2, '0', a(0), c(1));

    Adder1: RippleCarry  
    port map('0', w1, w3, '0', a(1), c(2));

    Sub0: RippleCarry  
    port map('0', w0, w2, '1', a(2), c(3));

    Sub1: RippleCarry  
    port map('0', w1, w3, '1', a(3), c(4));

    Adder2: RippleCarry  
    port map(c(1), a(0), a(1), '0', b(0), c(5));

    Adder3: RippleCarry  
    port map(c(2), a(2), a(3), '0', b(1), c(6));

    Sub2: RippleCarry  
    port map(c(3), a(0), a(1), '1', b(2), c(7));

    Sub3: RippleCarry  
    port map(c(4), a(2), a(3), '1', b(3), c(8));
	 
	 SR0: ShiftRight
	 port map(b(0), s0);
	 
	 SR1: ShiftRight
	 port map(b(1), s1);
	 
	 SR2: ShiftRight
	 port map(b(2), s2);
	 
	 SR3: ShiftRight
	 port map(b(3), s3);
    
    c(0)<= '0';
    
	end structure;