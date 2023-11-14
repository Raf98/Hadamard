LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FullAdder IS 
PORT 
(
	cin, a, b: 	IN STD_LOGIC;
	s, cout: 	OUT STD_LOGIC
);
END FullAdder;

ARCHITECTURE behavior OF FullAdder IS 
	BEGIN 
		s <= a XOR b XOR cin;
		cout <= (a AND b) OR (a AND cin) OR (b AND cin);
	END behavior;
