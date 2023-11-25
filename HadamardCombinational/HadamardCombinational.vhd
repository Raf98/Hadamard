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
	 x0, x1, x2, x3:     out std_logic_vector(num downto 0);
	 y0, y1, y2, y3:     out std_logic_vector(num + 1 downto 0);
    s0, s1, s2, s3:     out std_logic_vector(num downto 0)
);
end HadamardCombinational;

architecture structure of HadamardCombinational is
	 
    signal a0, a1, a2, a3:		std_logic_vector(num downto 0);
	 signal b0, b1, b2, b3:    std_logic_vector(num + 1 downto 0);
	 signal c0, c1, c2, c3: 	std_logic_vector(num + 1 downto 0);
    signal carry:    			std_logic_vector(num	   downto 0);
    signal bOp:  					std_logic_vector(num - 1 downto 0);
	
	 begin
	 
	 carry(0)<= '0';
	 
    Adder0: RippleCarry  
    port map('0', w0, w2, '0', a0(num - 1 downto 0), carry(1));
	 a0(num) <= carry(1);

    Adder1: RippleCarry  
    port map('0', w1, w3, '0', a1(num - 1 downto 0), carry(2));
	 a1(num) <= carry(2);

    Sub0: RippleCarry  
    port map('0', w0, w2, '1', a2(num - 1 downto 0), carry(3));
	 a2(num) <= carry(3);

    Sub1: RippleCarry  
    port map('0', w1, w3, '1', a3(num - 1 downto 0), carry(4));
	 a3(num) <= carry(4);
	 
	 x0 <= a0;
	 x1 <= a1;
	 x2 <= a2;
	 x3 <= a3;

	 Adder2: RippleCarry
	 generic map(num => 9)
    port map('0', a0, a1, '0', b0(num downto 0), carry(5));
	 b0(num + 1) <= carry(5);
	 
	 Sub2: RippleCarry
	 generic map(num => 9)
    port map('0', a0, a1, '1', b1(num downto 0), carry(6));
	 b1(num + 1) <= carry(6);

    Adder3: RippleCarry
	 generic map(num => 9)
    port map('0', a2, a3, '0', b2(num downto 0), carry(7));
	 b2(num + 1) <= carry(7);

    Sub3: RippleCarry
	 generic map(num => 9)
    port map('0', a2, a3, '1', b3(num downto 0), carry(8));
	 b3(num + 1) <= carry(8);
	 
	 y0 <= b0;
	 y1 <= b1;
	 y2 <= b2;
	 y3 <= b3;
	 
	 SR0: ShiftRight
	 port map(b0, c0);
	 
	 SR1: ShiftRight
	 port map(b1, c1);
	 
	 SR2: ShiftRight
	 port map(b2, c2);
	 
	 SR3: ShiftRight
	 port map(b3, c3);
	 
	 s0 <= c0(num downto 0);
	 s1 <= c1(num downto 0);
	 s2 <= c2(num downto 0);
	 s3 <= c3(num downto 0);
        
	end structure;