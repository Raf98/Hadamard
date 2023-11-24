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
-- Generated on "11/24/2023 06:00:55"
                                                            
-- Vhdl Test Bench template for design  :  HadamardPipeline1SamplePerCycle
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;                                     

ENTITY HadamardPipeline1SamplePerCycle_vhd_tst IS
END HadamardPipeline1SamplePerCycle_vhd_tst;
ARCHITECTURE HadamardPipeline1SamplePerCycle_arch OF HadamardPipeline1SamplePerCycle_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clear : STD_LOGIC;
SIGNAL clock : STD_LOGIC;

SIGNAL start:	STD_LOGIC;

SIGNAL w : STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL y0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL y1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL y2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL y3 : STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL u0 : STD_LOGIC;
SIGNAL s0 : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL x0 : STD_LOGIC_VECTOR(8 DOWNTO 0);

SIGNAL v0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL v1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL v2 : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL v3 : STD_LOGIC_VECTOR(8 DOWNTO 0);

SIGNAL s1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL u1 : STD_LOGIC;

SIGNAL z0 : STD_LOGIC_VECTOR(9 DOWNTO 0);

SIGNAL s : STD_LOGIC_VECTOR(8 DOWNTO 0);
COMPONENT HadamardPipeline1SamplePerCycle
	PORT (
	clear : IN STD_LOGIC;
	clock : IN STD_LOGIC;
	
	w : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	y0 : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
	y1 : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
	y2 : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
	y3 : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);

	u0 : BUFFER STD_LOGIC;
	s0 : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
	x0 : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0);
	
	v0 : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0);
	v1 : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0);
	v2 : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0);
	v3 : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0);
	
	u1 : BUFFER STD_LOGIC;
	s1 : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);

	z0 : BUFFER STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	s : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0)

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
	i1 : HadamardPipeline1SamplePerCycle
	PORT MAP (
-- list connections between master ports and signals
	clear => clear,
	clock => clock,
	s => s,
	s0 => s0,
	s1 => s1,
	u0 => u0,
	u1 => u1,
	v0 => v0,
	v1 => v1,
	v2 => v2,
	v3 => v3,
	w => w,
	x0 => x0,
	y0 => y0,
	y1 => y1,
	y2 => y2,
	y3 => y3,
	z0 => z0
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

clear <= '1', '0' after 1.5 ns;
start <= '0', '1' after 3 ns;

stimulus_in: process 
	variable inline: line;
	--
	variable out0: std_logic_vector(8 downto 0);
	variable str_out0: string(9 downto 1);
	variable outline: line;	
		--
	variable num: string(8 downto 1);
	variable blank: string(2 downto 1);
	
	variable counter: integer;
	variable innerCounterIn, innerCounterOut: integer;
	
    begin
		counter := 0;
		
    
		FILE_OPEN(input, "hadamard_input.txt", READ_MODE);
		FILE_OPEN(output, "pipeline1sample_output.txt", WRITE_MODE);
						
		wait until (start = '1');
		while counter <= 400 loop
		
			--READING INPUTS
			if not endfile(input) then
				innerCounterIn := 0;
			
				readline(input, inline);
				while (innerCounterIn < 4) loop
					
					read(inline, num);
					w <= str_to_stdvec(num);
				
					read(inline, blank(1)); --le o espaco vazio entre os valores de cada linha de entrada
					
					innerCounterIn := innerCounterIn + 1;
					wait until(clock'event and clock = '1');
				end loop;
				
				
			end if;
			
			
			
--			--wait until(clk'event and clk = '1');
			--wait until(clk'event and clk = '1');
			--wait until(clk'event and clk = '1');
			
			
			--WRITING OUTPUTS
			if counter >= 10 then
			
				out0 := s;
				str_out0 := stdvec_to_str(out0);
				write(outline, str_out0);
				write(outline, blank(1));
				
				
				if (innerCounterOut = 3) then
					writeline(output, outline);
				end if;
				
			end if;
			
			counter := counter + 1;
			innerCounterOut := innerCounterOut + 1;
		end loop;		
		
		file_close(input);
		file_close(output);
		wait;
	end process;  
	
END HadamardPipeline1SamplePerCycle_arch;
