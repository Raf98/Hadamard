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

ENTITY HadamardPipeline1SamplePerCycle_vhd_tst IS
END HadamardPipeline1SamplePerCycle_vhd_tst;
ARCHITECTURE HadamardPipeline1SamplePerCycle_arch OF HadamardPipeline1SamplePerCycle_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clear : STD_LOGIC;
SIGNAL clock : STD_LOGIC;

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
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END HadamardPipeline1SamplePerCycle_arch;
