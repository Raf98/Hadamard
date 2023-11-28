-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "11/22/2023 02:55:58"
                                                            
-- Vhdl Test Bench template for design  :  HadamardPipeline
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;                                

ENTITY HadamardPipeline_TB IS
END HadamardPipeline_TB;
ARCHITECTURE HadamardPipeline_arch OF HadamardPipeline_TB IS
-- constants                                                 
-- signals                                                   
SIGNAL clear : STD_LOGIC;
SIGNAL clock : STD_LOGIC;
SIGNAL w0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL w1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL w2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL w3 : STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL s0 : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL s1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL s2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL s3 : STD_LOGIC_VECTOR(9 DOWNTO 0);

COMPONENT HadamardPipeline
	PORT (
	--ENTRADAS TEMPORAIS
	clear : IN STD_LOGIC;
	clock : IN STD_LOGIC;
	
	--ENTRADAS DE DADOS
	w0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	w1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	w2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	w3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	--SAIDAS
	s0 : BUFFER STD_LOGIC_VECTOR(9 DOWNTO 0);
	s1 : BUFFER STD_LOGIC_VECTOR(9 DOWNTO 0);
	s2 : BUFFER STD_LOGIC_VECTOR(9 DOWNTO 0);
	s3 : BUFFER STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

function str_to_stdvec(inp: string) return std_logic_vector is
	variable temp: std_logic_vector(inp'range);
	begin
		for i in inp'range loop
			if (inp(i) = '1') then
				temp(i) := '1';
			elsif (inp(i) = '0') then
				temp(i) := '0';
			end if;
		end loop;
		return temp;
	end function str_to_stdvec;

function stdvec_to_str(inp: std_logic_vector) return string is
		variable temp: string(inp'left+1 downto 1);
	begin
		for i in inp'reverse_range loop
			if (inp(i) = '1') then
				temp(i+1) := '1';
			elsif (inp(i) = '0') then
				temp(i+1) := '0';
			end if;
		end loop;
		return temp;
	end function stdvec_to_str;
	
	
	file input, output: text;

BEGIN
	pipe : entity work.HadamardPipeline
	PORT MAP (
-- list connections between master ports and signals
	clear => clear,
	clock => clock,
	
	w0 => w0,
	w1 => w1,
	w2 => w2,
	w3 => w3,
	
	s0 => s0,
	s1 => s1,
	s2 => s2,
	s3 => s3
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;    
                                       
clockProcess: PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
      clock <= '1', '0' AFTER 1 ns;
  		WAIT FOR 2 ns;                                                         
END PROCESS;

clear <= '1', '0' after 0.5 ns;

stimulus_in: process 
	variable inline: line;
	--
	variable out0: std_logic_vector(9 downto 0);
	variable out1: std_logic_vector(9 downto 0);
	variable out2: std_logic_vector(9 downto 0);
	variable out3: std_logic_vector(9 downto 0);
	variable str_out0: string(10 downto 1);
	variable str_out1: string(10 downto 1);
	variable str_out2: string(10 downto 1);
	variable str_out3: string(10 downto 1);
	variable outline: line;	
		--
	variable num0: string(8 downto 1);
	variable num1: string(8 downto 1);
	variable num2: string(8 downto 1);
	variable num3: string(8 downto 1);
	variable blank: string(2 downto 1);
	
	variable counter: integer;
	
    begin
		counter := 0;
		
    
		FILE_OPEN(input, "hadamard_input.txt", READ_MODE);
		--FILE_OPEN(output, "pipeline_output.txt", WRITE_MODE);
						
		wait until (clear = '0');
		while counter <= 101 loop
		
			--LENDO ENTRADAS
			if not endfile(input) then
			
				readline(input, inline);
				
				read(inline, num0);
				w0 <= str_to_stdvec(num0);
				
				read(inline, blank(1)); 								--le o espaco vazio entre os valores de cada linha de entrada
				read(inline, num1);
				w1 <= str_to_stdvec(num1);
				
				read(inline, blank(1));
				read(inline, num2);
				w2 <= str_to_stdvec(num2);
				
				read(inline, blank(1));
				read(inline, num3);
				w3 <= str_to_stdvec(num3);
			
			
				wait until(clock'event and clock = '1');
			
			else 
				wait until(clock'event and clock = '1');
				wait until(clock'event and clock = '1');
				wait until(clock'event and clock = '1');
				wait until(clock'event and clock = '1');
				wait until(clock'event and clock = '1');
				file_close(input);
				assert false report "end of simulation" severity failure;
			end if;
			
			
			--ESCREVENDO SAIDAS
--			if counter >= 2 then
--			
--				out0 := s0;
--				str_out0 := stdvec_to_str(out0);
--				write(outline, str_out0);
--				write(outline, blank(1));
--				
--				out1 := s1;
--				str_out1 := stdvec_to_str(out1);
--				write(outline, str_out1);
--				write(outline, blank(1));
--				
--				out2 := s2;
--				str_out2 := stdvec_to_str(out2);
--				write(outline, str_out2);
--				write(outline, blank(1));
--				
--				out3 := s3;
--				str_out3 := stdvec_to_str(out3);
--				write(outline, str_out3);
--				write(outline, blank(1));
--				
--				writeline(output, outline);
--				
--			end if;
--			
			counter := counter + 1;
		end loop;		
		
		file_close(input);
		--file_close(output);
		--writeline(output, outline);
		--wait for 500ms;
		--assert false report "end of simulation" severity failure;
	end process;
                                          
END HadamardPipeline_arch;
