/* operation_or .vhd */
/* or operations */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains or operations  */

-------------------------------

/* array sized or operation */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity OP_array_or is

	generic (	
		word_no 		: integer := 32;
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in 	array_t(word_no-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		Q2		: in 	array_t(word_no-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		output: out array_t(word_no-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'))
		);
		
end OP_array_or;

architecture logical of OP_array_or is 
begin
	process(all) begin

		-- process to combine arrays on input 
		for j in 0 to word_no-1 loop
			output(j) <= Q1(j) or Q2(j);
		end loop;
		
	end process;
end logical;

--------------------------------

/* Vector sized or operation */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity OP_vector_or is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		output: out vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end OP_vector_or;

architecture logical of OP_vector_or is 
begin
			output <= Q1 or Q2;
end logical;

--------------------------------

/* Bit sized or operation */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity OP_bit_or is

	port(	
		output: out bit_t := '0';
		Q1		: in 	bit_t := '0';
		Q2		: in 	bit_t := '0'
		);
		
end OP_bit_or;

architecture logical of OP_bit_or is 
begin
			output <= Q1 or Q2;

end logical;