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
    s0, s1, s2, s3:     out std_logic_vector(num + 1 downto 0)
);
end HadamardCombinational;

architecture structure of HadamardCombinational is

	 type hadamard_entries is array (wNum - 1 downto 0) of std_logic_vector(num - 1 downto 0);
	 
    signal a0, a1, a2, a3:		std_logic_vector(num downto 0);
	 signal b0, b1, b2, b3:    std_logic_vector(num + 1 downto 0);
    signal c:    std_logic_vector(num	   downto 0);
    signal bOp:  std_logic_vector(num - 1 downto 0);
	
	 begin
    Adder0: RippleCarry  
    port map('0', w0, w2, '0', a0(num - 1 downto 0), c(1));
	 a0(num) <= c(1);

    Adder1: RippleCarry  
    port map('0', w1, w3, '0', a1(num - 1 downto 0), c(2));
	 a1(num) <= c(2);

    Sub0: RippleCarry  
    port map('0', w0, w2, '1', a2(num - 1 downto 0), c(3));
	 a2(num) <= c(3);

    Sub1: RippleCarry  
    port map('0', w1, w3, '1', a3(num - 1 downto 0), c(4));
	 a3(num) <= c(4);

	 Adder2: RippleCarry
	 generic map(num => 9)
    port map('0', a0, a1, '0', b0(num downto 0), c(5));
	 b0(num + 1) <= c(5);

    Adder3: RippleCarry
	 generic map(num => 9)
    port map('0', a2, a3, '0', b1(num downto 0), c(6));
	 b1(num + 1) <= c(6);

    Sub2: RippleCarry
	 generic map(num => 9)
    port map('0', a0, a1, '1', b2(num downto 0), c(7));
	 b2(num + 1) <= c(7);

    Sub3: RippleCarry
	 generic map(num => 9)
    port map('0', a2, a3, '1', b3(num downto 0), c(8));
	 b3(num + 1) <= c(8);
	 
	 SR0: ShiftRight
	 port map(b0, s0);
	 
	 SR1: ShiftRight
	 port map(b1, s1);
	 
	 SR2: ShiftRight
	 port map(b2, s2);
	 
	 SR3: ShiftRight
	 port map(b3, s3);
    
    
    c(0)<= '0';
    
	end structure;