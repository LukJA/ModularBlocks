/* operation_nand .vhd */
/* nand operations */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains nand operations  */

-------------------------------

/* array sized nand operation */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity OP_array_nand is

	generic (	
		word_no 		: integer := 32;
		word_width	: integer := 16
		);
		
	port(	
		output: out array_t(word_no-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		Q1		: in 	array_t(word_no-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		Q2		: in 	array_t(word_no-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'))
		);
		
end OP_array_nand;

architecture logical of OP_array_nand is 
begin

	process(all) begin
		-- process to combine arrays on input 
		for j in 0 to word_no-1 loop
			output(j) <= Q1(j) nand Q2(j);
		end loop;
		
	end process;
end logical;

--------------------------------

/* Vector sized nand operation */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity OP_vector_nand is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		output: out vector_t(word_width-1 downto 0) := (others=>'0');
		Q1		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end OP_vector_nand;

architecture logical of OP_vector_nand is 
begin

		output <= Q1 nand Q2;

end logical;

--------------------------------

/* Bit sized nand operation */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity OP_bit_nand is

	port(	
		output: out bit_t := '0';
		Q1		: in 	bit_t := '0';
		Q2		: in 	bit_t := '0'
		);
		
end OP_bit_nand;

architecture logical of OP_bit_nand is 
begin
			output <= Q1 nand Q2;

end logical;