/* operation_xor .vhd */
/* XOR operations */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains XOR operations  */

-------------------------------

/* array sized XOR operation */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity OP_array_xor is

	generic (	
		word_no 		: integer := 32;
		word_width	: integer := 16
		);
		
	port(	
		output: out array_t(word_no-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		Q1		: in 	array_t(word_no-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		Q2		: in 	array_t(word_no-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'))
		);
		
end OP_array_xor;

architecture logical of OP_array_xor is 
begin
	process(all) begin

		-- process to combine arrays on input 
		for j in 0 to word_no-1 loop
			output(j) <= Q1(j) xor Q2(j);
		end loop;
		
	end process;
end logical;

--------------------------------

/* Vector sized xor operation */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity OP_vector_xor is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		output: out vector_t(word_width-1 downto 0) := (others=>'0');
		Q1		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end OP_vector_xor;

architecture logical of OP_vector_xor is 
begin
	process(all) begin

		-- process to combine vectors on input 
		for j in 0 to word_no-1 loop
			output(j) <= Q1(j) xor Q2(j);
		end loop;
		
	end process;
end logical;

--------------------------------

/* Bit sized xor operation */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity OP_bit_xor is

	port(	
		output: out bit_t := '0';
		Q1		: in 	bit_t := '0';
		Q2		: in 	bit_t := '0'
		);
		
end OP_bit_xor;

architecture logical of OP_bit_xor is 
begin
			output <= Q1 xor Q2

end logical;