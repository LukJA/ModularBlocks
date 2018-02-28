/* maths_logical .vhd */
/* logical maths functions */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains logical maths of all types  */

--------------------------------

/* rotate left */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_logical_rotleft is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end M_logical_rotleft;

architecture logical of M_logical_rotleft is
begin

	output <= Q1 rol unsigned(Q2);

end logical;

--------------------------------

/* rotate right */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_logical_rotright is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);

end M_logical_rotright;

architecture logical of M_logical_rotright is
begin

	output <= Q1 ror unsigned(Q2);

end logical;

--------------------------------

/* shift left */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_logical_shiftleft is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);

end M_logical_shiftleft;

architecture logical of M_logical_shiftleft is
begin

	output <= Q1 sll unsigned(Q2);

end logical;

--------------------------------

/* shift right */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_logical_shiftright is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);

end M_logical_shiftright;

architecture logical of M_logical_shiftright is
begin

	output <= Q1 srl unsigned(Q2);

end logical;

