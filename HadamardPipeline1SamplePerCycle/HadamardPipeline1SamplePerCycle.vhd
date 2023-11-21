library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

library work;
use work.HadamardPackage.all;

entity HadamardPipeline1SamplePerCycle is

generic
(  
	num:        integer := 8; 
	wNum:       integer := 4;
	rNum:			integer := 2
);

port
(
	 clock, load, clear:	in  std_logic;
    w0, w1, w2, w3:     in  std_logic_vector(num - 1 downto 0);
	 x0, x1, x2, x3:     out std_logic_vector(num downto 0);
	 y0, y1, y2, y3:     out std_logic_vector(num + 1 downto 0);
    s:     					out std_logic_vector(num	  downto 0)
);
end HadamardPipeline1SamplePerCycle;

architecture structure of HadamardPipeline1SamplePerCycle is

	 type hadamard_entries is array (wNum - 1 downto 0) of std_logic_vector(num - 1 downto 0);
	 
	 signal a0, a1, a2, a3:		std_logic_vector(num - 1 downto 0);
	 signal b0, b1, b2, b3:    std_logic_vector(num - 1 downto 0);
	 signal c0, c1, c2, c3: 	std_logic_vector(num     downto 0);
	 signal d0, d1, d2, d3: 	std_logic_vector(num	    downto 0);
	 signal e0, e1, e2, e3: 	std_logic_vector(num	    downto 0);
	 signal f0, f1, f2, f3: 	std_logic_vector(num + 1 downto 0);
	 signal g0, g1, g2, g3: 	std_logic_vector(num + 1 downto 0);

	 
    signal carry:    			std_logic_vector(num	   downto 0);
	 
	 signal sub:		std_logic;
	 signal sel:		std_logic_vector(wNum - 1 downto 0);
	 signal selReg:	std_logic_vector(rNum - 1 downto 0);
	 signal w:			std_logic_vector(num - 1  downto 0);
	 signal counter:  std_logic_vector(4        downto 0);
	
	 begin
	 
	 Buffer0: PingPongBuffer
	 port map(	adressWrite 	=>	selReg,
	 				dataWrite 		=> w,
	 				w0 				=> a0,
					w1 				=> a1,
					w2 				=> a2,
					w3 				=> a3,
	 				clk 			  	=> clock,
	 				writeRegister 	=> '1');
	   			
	 MuxMulti0: MuxMulti
	 port map(a0, a1, sel(0), b0);
	 
	 MuxMulti1: MuxMulti
	 port map(a2, a3, sel(1), b1);
	 
	 carry(0)<= '0';
	 
	 Adder0: RippleCarry  
    port map('0', b0, b1, sub, c0(num - 1 downto 0), carry(1));
	 c0(num) <= carry(1);
	 
	 Buffer1: PingPongBuffer
	 generic map(num => 9)
	 port map(	adressWrite 	=>	selReg,
	 				dataWrite 		=> c0,
	 				w0 				=> d0,
					w1 				=> d1,
					w2 				=> d2,
					w3 				=> d3,
	 				clk 			  	=> clock,
	 				writeRegister 	=> '0');
	   			
	 MuxMulti2: MuxMulti
	 generic map(num => 9)
	 port map(d0, d1, sel(2), e0);
	 
	 MuxMulti3: MuxMulti
	 generic map(num => 9)
	 port map(d2, d3, sel(3), e1);
	 
	 Adder1: RippleCarry
	 generic map(num => 9)
    port map('0', e0, e1, sub, f0(num downto 0), carry(2));
	 f0(num + 1) <= carry(2);
	 
	 SR: ShiftRight
	 port map(f0, g0);
	 
	 s <= g0(num downto 0);
	 
	 
	 ------------------------Processo de escrita na barreira temporal----------

	process(clock, sel)

	begin

		if(clock = '1' and clock'event)then
			if (counter = "0000") then
				sub <= '0';
				selReg <= "00";
				sel <= "0001";
			elsif(counter = "00001")then
				selReg <= "01";
				sel <= "0010";
			elsif(counter = "00010")then
				sub <= '1';
				selReg <= "10";
				sel <= "0001";
			elsif(counter = "00011")then
				selReg <= "11";
				sel <= "0010";
			end if;
			counter <= counter + "00001";
		end if;
	end process;
    
	end structure;