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
    w:     in  std_logic_vector(num - 1 downto 0);
    s:     out std_logic_vector(num - 1 downto 0)
);
end HadamardPipeline1SamplePerCycle;

architecture structure of HadamardPipeline1SamplePerCycle is

	 type hadamard_entries is array (wNum - 1 downto 0) of std_logic_vector(num - 1 downto 0);
	 
	 signal wOut:  	hadamard_entries;
	 signal aTemp:    hadamard_entries;
    signal a:    		hadamard_entries;
	 signal aOut:  	hadamard_entries;
	 signal bTemp:    hadamard_entries;
	 signal b:    		hadamard_entries;
    signal c:    		std_logic_vector(num	   downto 0);
    signal bOp:  		std_logic_vector(num - 1 downto 0);
	 signal sub:		std_logic;
	 signal sel:		std_logic_vector(wNum - 1 downto 0);
	 signal selReg:	std_logic_vector(rNum - 1 downto 0);
	 signal counter :  std_logic_vector(4 downto 0);
	
	 begin
	 
	 Buffer0: PingPongBuffer
	 port map(	adressWrite 	=>	selReg,
	 				dataWrite 		=> w,
	 				w0 				=> wOut(0),
					w1 				=> wOut(1),
					w2 				=> wOut(2),
					w3 				=> wOut(3),
	 				clk 			  	=> clock,
	 				writeRegister 	=> '1');
	   			
	 MuxMulti0: MuxMulti
	 port map(wOut(0), wOut(1), sel(0), aTemp(0));
	 
	 MuxMulti1: MuxMulti
	 port map(wOut(2), wOut(3), sel(1), aTemp(1));
	 
	 Adder0: RippleCarry  
    port map('0', aTemp(0), aTemp(1), '0', a(0), c(1));
	 
	 Buffer1: PingPongBuffer
	 port map(	adressWrite 	=>	selReg,
	 				dataWrite 		=> a(0),
	 				w0 				=> aOut(0),
					w1 				=> aOut(1),
					w2 				=> aOut(2),
					w3 				=> aOut(3),
	 				clk 			  	=> clock,
	 				writeRegister 	=> '0');
	   			
	 MuxMulti2: MuxMulti
	 port map(wOut(0), wOut(1), sel(2), aTemp(0));
	 
	 MuxMulti3: MuxMulti
	 port map(wOut(2), wOut(3), sel(3), aTemp(1));
	 
	 Adder1: RippleCarry
    port map('0', bTemp(0), bTemp(1), '0', b(0), c(1));
	 
	 SR: ShiftRight
	 port map(b(0), s);
					    
    c(0)<= '0';
	 
	 
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