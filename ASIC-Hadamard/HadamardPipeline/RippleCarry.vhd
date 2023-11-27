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
		  
		  --Faz checagem geral de overflow valido. O valor do ultimo bit da saida eh considerado pois pode indicar um valor negativo
		  --a ser propagado para outro sinal de n+1 bits, ou seja, garante a integridade do sinal em um sistema de complemento de 2. 
			
		  over <= (c(num) xor c(num - 1)) or x(num - 1);	
		  
		  
		  --Quando op = 0, i.e., é feita uma soma, considera o ultimo carry out como 1 apenas quando ao menos um dos MSBs de entrada eh 1,
		  --ou seja, quando ao menos uma das entradas eh negativa. Assim, no caso de um overflow positivo, (por ex, 127 + 1), o ultimo
		  --carry out sera zerado, indicando que eh um valor positivo.
		  
		  --Quando op = 1, uma subtracao, desconsidera o ultimo carry out como 1 apenas para o caso em que a primeira entrada é positiva
		  --e a segunda negativa pois, para esse caso, pode ocorrer um overflow positivo na saida, o qual sera erroneamente considerado
		  --como negativo, caso essa condicao nao seja aplicada.
		  
        with op select
		  cLast <= 	over and (a(num - 1) or b(num - 1))  when '0',				 
						over and not(not a(num - 1) and b(num - 1)) when others; 
		  
    
end structure;