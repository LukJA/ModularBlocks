/* maths_iterative .vhd */
/* iterative maths functions */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains iterative maths of all types  */

--------------------------------

/* Unsigned Incrementer */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_iterative_uns_inc is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end M_iterative_uns_inc;

architecture logical of M_iterative_uns_inc is
begin

	output <= std_logic_vector(unsigned(Q1) + 1);

end logical;

--------------------------------

/* Signed Incrementer */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_iterative_sin_inc is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end M_iterative_sin_inc;

architecture logical of M_iterative_sin_inc is
begin

	output <= std_logic_vector(signed(Q1) + 1);

end logical;

--------------------------------

/* Unsigned Decrementer */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_iterative_uns_dec is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end M_iterative_uns_dec;

architecture logical of M_iterative_uns_dec is
begin

	output <= std_logic_vector(unsigned(Q1) - 1);

end logical;

--------------------------------

/* Signed Decrementer */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_iterative_sin_dec is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end M_iterative_sin_dec;

architecture logical of M_iterative_sin_dec is
begin

	output <= std_logic_vector(signed(Q1) - 1);

end logical;