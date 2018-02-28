/* maths_unsigned .vhd */
/* unsigned maths functions */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains unsigned maths of all types  */

--------------------------------

/* unsigned add */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_unsigned_add is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		c_in	: in  bit_t := '0'; 
		c_out	: out bit_t := '0'; 
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end M_unsigned_add;

architecture logical of M_unsigned_add is 

signal temp : vector_t(word_width downto 0);

begin
	
	temp   <= std_logic_vector((unsigned(Q1) + unsigned(Q2)) + unsigned(std_to_vec(c_in)));
	c_out   <= temp(word_width);
	output <= temp(word_width-1 downto 0);
		
end logical;

--------------------------------

/* unsigned sub */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_unsigned_sub is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		c_out	: out bit_t := '0'; 
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end M_unsigned_sub;

architecture logical of M_unsigned_sub is 

signal temp : vector_t(word_width downto 0);

begin
	
	temp   <= std_logic_vector(unsigned(Q1) - unsigned(Q2));
	c_out   <= temp(word_width);
	output <= temp(word_width-1 downto 0);
		
end logical;

--------------------------------

/* unsigned multi */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_unsigned_multi is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		output: out	vector_t(2*(word_width)-1 downto 0) := (others=>'0')
		);
		
end M_unsigned_multi;

architecture logical of M_unsigned_multi is 

signal temp : vector_t(word_width downto 0);

begin
	
	temp   <= std_logic_vector(unsigned(Q1) * unsigned(Q2));
	output <= temp;
		
end logical;

