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
	 clock, clear:			in  std_logic;
    w:     					in  std_logic_vector(num - 1 downto 0);
	 x0, X1:     			out std_logic_vector(num downto 0);
	 z0:						out std_logic_vector(num + 1 downto 0);
	 y0, y1, y2, y3:     out std_logic_vector(num - 1 downto 0);
	 v0, v1, v2, v3:		out std_logic_vector(num	  downto 0);
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
	 
	 signal sub0, sub1:		std_logic;
	 signal sel:		std_logic_vector(wNum - 1 downto 0);
	 signal sel0, sel1:		std_logic_vector(rNum - 1 downto 0);
	 signal selReg0, selReg1:	std_logic_vector(rNum - 1 downto 0);
	 signal writeReg: std_logic_vector(rNum - 1 downto 0);
	 signal counter:  std_logic_vector(4        downto 0) := (others=>'0');
	
	 begin
	 
	 Buffer0: PingPongBuffer
	 port map(	adressWrite 	=>	selReg0,
	 				dataWrite 		=> w,
	 				w0 				=> a0,
					w1 				=> a1,
					w2 				=> a2,
					w3 				=> a3,
	 				clk 			  	=> clock,
	 				writeRegister 	=> writeReg(0));
					
	 
	 y0 <= a0;
	 y1 <= a1;
	 y2 <= a2;
	 y3 <= a3;
	   			
	 MuxMulti0: MuxMulti
	 port map(a0, a1, sel0(0), b0);
	 
	 MuxMulti1: MuxMulti
	 port map(a2, a3, sel0(1), b1);
	 
	 carry(0)<= '0';
	 
	 Adder0: RippleCarry  
    port map('0', b0, b1, sub0, c0(num - 1 downto 0), carry(1));
	 c0(num) <= carry(1);
	 
	 X0 <= C0;
	 
	 
	 Buffer1: PingPongBuffer
	 generic map(num => 9)
	 port map(	adressWrite 	=>	selReg0,
	 				dataWrite 		=> c0,
	 				w0 				=> d0,
					w1 				=> d1,
					w2 				=> d2,
					w3 				=> d3,
	 				clk 			  	=> clock,
	 				writeRegister 	=> writeReg(1));
	   			
					
	 v0 <= d0;
	 v1 <= d1;
	 v2 <= d2;
	 v3 <= d3;
	 
					
	 MuxMulti2: MuxMulti
	 generic map(num => 9)
	 port map(d0, d2, sel1(0), e0);
	 
	 MuxMulti3: MuxMulti
	 generic map(num => 9)
	 port map(d1, d3, sel1(1), e1);
	 
	 Adder1: RippleCarry
	 generic map(num => 9)
    port map('0', e0, e1, sub1, f0(num downto 0), carry(2));
	 f0(num + 1) <= carry(2);
	 
	 z0 <= f0;
	 
	 SR: ShiftRight
	 port map(f0, g0);
	 
	 s <= g0(num downto 0);
	 
	 ------------------------Processo de escrita na barreira temporal----------


	process(clock, clear)

	begin
	
		if(clear = '1') then
			sel0 <= "00";
			sel1 <= "00";
			writeReg <= "01";
			sub0 <= '0';
			sub1 <= '0';
			selReg0 <= "00";
		elsif(clock = '1' and clock'event and clear = '0')then
		
			-- ESCRITA NO BUFFER0; LEITURA DO BUFFER1
			if (counter = "0000") then
				selReg0 <= "01";
				sub1 <= '1';
				sel0 <= "11";
			elsif(counter = "00001")then
				selReg0 <= "10";
				sub0 <= '1';
				sub1 <= '0';
				sel0 <= "00";
				sel1 <= "11";
			elsif(counter = "00010")then
				selReg0 <= "11";
				sub1 <= '1';
				sel0 <= "11";
			elsif(counter = "00011")then
				writeReg <= "11";
				selReg0 <= "00";
				sel0 <= "00";
				sel1 <= "00";
				sub0 <= '0';
				sub1 <= '0';
				
			-- LEITURA DO BUFFER0; ESCRITA DO BUFFER1
			elsif(counter = "00100")then
				selReg0 <= "01";
				sel0 <= "11";
				sub1 <= '1';
			elsif(counter = "00101")then
				selReg0 <= "10";
				sel0 <= "00";
				sel1 <= "11";
				sub0 <= '1';
				sub1 <= '0';
			elsif(counter = "00110")then
				selReg0 <= "11";
				sel0 <= "11";
				sub1 <= '1';
			elsif(counter = "00111")then
				--writeReg <= "01";
				selReg0 <= "00";
				sel1 <= "00";
				sub1 <= '0';
				sub0 <= '0';
				
			-- ESCRITA NO BUFFER0; LEITURA DO BUFFER1
			elsif(counter = "01000")then
				selReg0 <= "01";
				sub1 <= '1';
			elsif(counter = "01001")then
				selReg0 <= "10";
				sub1 <= '0';
				sel1 <= "11";
			elsif(counter = "01010")then
				selReg0 <= "11";
				sub1 <= '1';
				selReg1 <= "11";
			elsif(counter = "01011")then
				--writeReg <= "10";
				sel0 <= "00";
				sel1 <= "00";
				selReg0 <= "00";
				sub0 <= '0';
				sub1 <= '0';
				
			-- LEITURA DO BUFFER0; ESCRITA DO BUFFER1
			elsif(counter = "01100")then
				selReg0 <= "01";
				sel0 <= "11";
				sub1 <= '1';
			elsif(counter = "01101")then
				selReg0 <= "10";
				sub0 <= '1';
				sub1 <= '0';
				sel0 <= "00";
			elsif(counter = "01110")then
				selReg0 <= "11";
				sel0 <= "11";
				sub1 <= '1';
			end if;
			counter <= counter + "00001";
			if(counter >= "01111") then
				counter <= "00000";
				sel0 <= "00";
				sel1 <= "00";
				writeReg <= "01";
				sub0 <= '0';
				sub1 <= '0';
				selReg0 <= "00";
			end if;
		end if;
	end process;
    
	end structure;