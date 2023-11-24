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
	 --ENTRADAS
	 clock, clear:			in  std_logic;
    w:     					in  std_logic_vector(num - 1 downto 0);
	 
	 
	 --SAIDAS AUXILIARES, PARA VERIFICAR VALORES
	 x0:     				out std_logic_vector(num downto 0);			--imprime saida do primeiro somador
	 z0:						out std_logic_vector(num + 1 downto 0);	--imprime saida do segundo somador
	 y0, y1, y2, y3:     out std_logic_vector(num - 1 downto 0);	--imprime valores de entrada escritos no primeiro buffer
	 v0, v1, v2, v3:		out std_logic_vector(num	  downto 0);	--imprime valores de entrada escritos no segundo buffer
	 s0, s1:					out std_logic_vector(1 downto 0);			--imprime valores dos sinais seletores dos muxes
	 u0, u1:					out std_logic;                            --imprime valores dos sinais de selecao de operacao dos somadores
	 
	 --SAIDA
    s:     					out std_logic_vector(num	  downto 0)
);
end HadamardPipeline1SamplePerCycle;

architecture structure of HadamardPipeline1SamplePerCycle is
	 
	 --SINAIS DE SAIDAS INTERMEDIARIAS DA PARTE OPERATIVA DO CIRCUITO
	 signal a0, a1, a2, a3:		std_logic_vector(num - 1 downto 0);
	 signal b0, b1, b2, b3:    std_logic_vector(num - 1 downto 0);
	 signal c0, c1, c2, c3: 	std_logic_vector(num     downto 0);
	 signal d0, d1, d2, d3: 	std_logic_vector(num	    downto 0);
	 signal e0, e1, e2, e3: 	std_logic_vector(num	    downto 0);
	 signal f0, f1, f2, f3: 	std_logic_vector(num + 1 downto 0);
	 signal g0, g1, g2, g3: 	std_logic_vector(num + 1 downto 0);

	 --sinal de carry
    signal carry:    			std_logic_vector(num	    downto 0);				
	 
	 signal sub0, sub1:		std_logic;													--selecionam tipo da operacao para os somadores/ subtratores
	 signal sel0, sel1:		std_logic_vector(rNum - 1 downto 0);				--selecionam quais entradas do muxes utilizar nas operacoes
	 signal selReg0, selReg1:	std_logic_vector(rNum - 1 downto 0);			--selecionam os registradores a serem escritos naquele ciclo para cada buffer
	 signal counter:  std_logic_vector(1 downto 0) := (others=>'0');	--		--responsavel por armazenar o valor atual da contagem, necessaria para controlar o pipeline
	
	 type states is (waitClear, initialize, cycle_0_4_8_12, cycle_1_5_9, cycle_2_6_10, cycle_3_7_11);
	 signal currentState, nextState : states;
	
	 begin
	 
	 Buffer0: PingPongBuffer
	 port map(	adressWrite 	=>	selReg0,
	 				dataWrite 		=> w,
	 				w0 				=> a0,
					w1 				=> a1,
					w2 				=> a2,
					w3 				=> a3,
	 				clk 			  	=> clock,
	 				writeRegister 	=> '1');
					
	 
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
	 s0 <= sel0;
	 s1 <= sel1;
	 u0 <= sub0;
	 u1 <= sub1;
	 
	 
	 Buffer1: PingPongBuffer
	 generic map(num => 9) 
	 port map(	adressWrite 	=>	selReg1,
	 				dataWrite 		=> c0,
	 				w0 				=> d0,
					w1 				=> d1,
					w2 				=> d2,
					w3 				=> d3,
	 				clk 			  	=> clock,
	 				writeRegister 	=> '1');
	   			
					
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
	 
	 ------------------------Processo de escrita/leitura no pipeline----------

	 
	 


--	pipelineProcess: process(clock, clear)
--
--	begin
--	
--		-- inicializacao feita pelo clear, selecionando o endereco 0 do buffer de entrada para ser escrito
--		-- como eh o unico sinal necessario para o primeiro processo de escrita, eh a unica a ser inicializada
--		if(clear = '1') then
--		
--			selReg0 <= "00";
--			
--		elsif(clock = '1' and clock'event and clear = '0')then
--		
--			-- no ciclo 0 (primeiro ciclo), escreve no endereco 0 do buffer de entrada e define que
--			-- o proximo endereco/ registrador a ser escrito eh o 1
--			
--			-- os demais sinais estao assim organizados para que o pipeline funcione corretamente,
--			-- sendo assim, as selecoes de sub0 e sel0 soh farao sentido na segunda bateria de ciclos,
--			-- que comeca no ciclo 4 (se contarmos a partir do ciclo 0), que eh o mesmo ciclo em que 
--			-- o primeira carga de escrita no buffer de entrada tem seu valor gravado em a0, a1, a2 e a3, 
--			-- cujos valores serao, a partir daqui, lidos e usados como base para o mux selecionar, com sel0,
--			-- quais entradas utilizar no somador, com operacao escolhida por sub0	
--			
--			-- tambem no ciclo 4 define que, no proximo ciclo, o resultado da soma de a0 com a1 devera ser
--			-- escrito no registrador de endereco 0 do buffer de "saida"/ buffer 2
--			
--			-- o sinal sub1 do passa a ser usado apenas em ciclos posteriores (a partir do ciclo 12), fazendo a subtracao
--			-- sob os valores escolhidos nos muxes por meio de sel1 no seu ciclo imediatamente anterior (d2 e d3), 
--			-- com a escrita do resultado sendo realizada no endereco 3 do segundo buffer
--			
--			
--			if (counter = "00") then
--			
--				selReg0 <= "01";
--				
--				sub0 <= '0';
--				sel0 <= "00";
--
--				selReg1 <= "00";
--				
--				sub1 <= '1';
--				
--			-- no ciclo 5, eh realizada a primeira escrita no buffer de saida, no endereco 0, como 
--			-- selecionado no ciclo 4 e, a partir do ciclo 9 (decimo ciclo), temos o primeiro valor na saida,
--			-- sendo este o calculo da soma de d0 e d1, os quais representam os valores gravados 
--			-- previamente nos ciclos 5 e 6 nos enderecos 0 e 1, respectivamente
--				
--			elsif(counter = "01")then
--			
--				selReg0 <= "10";
--				
--				sel0 <= "11";
--				
--				selReg1 <= "01";
--				
--				sub1 <= '0';
--				sel1 <= "00";
--				
--				
--			elsif(counter = "10")then
--			
--				selReg0 <= "11";
--				
--				sub0 <= '1';
--				sel0 <= "00";
--				
--				selReg1 <= "10";
--				
--				sub1 <= '1';
--				
--			elsif(counter = "11")then
--				
--				selReg0 <= "00";
--				
--				sel0 <= "11";
--				
--				selReg1 <= "11";
--				
--				sub1 <= '0';
--				sel1 <= "11";
--				
--			end if;
--			
--			counter <= counter + "01"; 
--		end if;
--	end process;


	reset_FSM: process(clear,clock)
	begin
		if (clear = '1') then
			currentState <= waitClear;
		elsif (clock = '1' AND clock'event) then
			currentState <= nextState;
		end if;
	end process;
	
	
	process_FSM: process(currentState)
	begin
		
		case currentState is
		
		when waitClear =>
		
			sub0 <= '0';
			sel0 <= "00";
			sub1 <= '0';
			sel1 <= "00";
		
			nextState <= initialize;
			
		when initialize =>
			--ciclo 0
			selReg0 <= "00";
			
			nextState <= cycle_0_4_8_12;
			
		when cycle_0_4_8_12 =>
			--ciclo 0/1
			selReg0 <= "01";
			--ciclo 4
			sub0 <= '0';
			sel0 <= "00";
			--ciclo 8/9
			selReg1 <= "00";
			--ciclo 12	
			sub1 <= '1';
			sel1 <= "11";
			
			nextState <= cycle_1_5_9;
			
		when cycle_1_5_9 =>
			--ciclo 1/2
			selReg0 <= "10";
			--ciclo 5
			sub0 <= '0';
			sel0 <= "11";
			--ciclo 9/10	
			selReg1 <= "01";
			--ciclo 9	
			sub1 <= '0';
			sel1 <= "00";
				
			nextState <= cycle_2_6_10;
				
				
		when cycle_2_6_10 =>
				--ciclo 2/3
				selReg0 <= "11";
				--ciclo 6
				sub0 <= '1';
				sel0 <= "00";
				--ciclo 10/11
				selReg1 <= "10";
				--ciclo 10
				sub1 <= '1';
				sel1 <= "00";
				
				nextState <= cycle_3_7_11;
				
	  when cycle_3_7_11 =>
				--ciclo 3/4
				selReg0 <= "00";
				--ciclo 7
				sub0 <= '1';
				sel0 <= "11";
				--ciclo 11/12
				selReg1 <= "11";
				--ciclo 11
				sub1 <= '0';
				sel1 <= "11";
				
				nextState <= cycle_0_4_8_12;
				
	  end case;
			
	end process;

    
	end structure;