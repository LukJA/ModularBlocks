/* maths_signed .vhd */
/* signed maths functions */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains signed maths of all types  */

--------------------------------

/* signed add */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_signed_add is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		OV		: out bit_t := '0';
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end M_unsigned_add;

architecture logical of M_unsigned_add is 

-- create locale signals with suffix '_s' for signed with one xtrea bit
signal Q1_s  	 : SIGNED(word_width downto 0);
signal Q2_s  	 : SIGNED(word_width downto 0);
signal output_s : SIGNED(word_width downto 0);
signal temp     : std_logic_vector(2 downto 0);

begin

-- convert type and perform a sign-extension
Q1_s <= resize(signed(Q1), Q1_s'length);
Q2_s <= resize(signed(Q2), Q2_s'length);

-- addition of two 1 larger bit values
output_s <= Q1_s + Q2_s;

-- resize to require size and type conversion
output <= std_logic_vector(resize(output_s, output'length));

-- concat the three relevant sign-bits from a,b and sum to one vector
temp  <= Q1_s(Q1_s'high) & Q2_s(Q2_s'high) & output_s(output_s'high);
OV 	<= (temp = "001") or (temp = "110");
		
end logical;

--------------------------------

/* signed sub */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_signed_sub is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		OV		: out bit_t := '0'; 
		output: out	vector_t(word_width-1 downto 0) := (others=>'0')
		);
		
end M_signed_sub;

architecture logical of M_signed_sub is

-- create locale signals with suffix '_s' for signed with one xtrea bit
signal Q1_s  	 : SIGNED(word_width downto 0);
signal Q2_s  	 : SIGNED(word_width downto 0);
signal output_s : SIGNED(word_width downto 0);
signal temp     : std_logic_vector(2 downto 0);

begin

-- convert type and perform a sign-extension
Q1_s <= resize(signed(Q1), Q1_s'length);
Q2_s <= resize(signed(Q2), Q2_s'length);

-- addition of two 1 larger bit values
output_s <= Q1_s - Q2_s;

-- resize to require size and type conversion
output <= std_logic_vector(resize(output_s, output'length));

-- concat the three relevant sign-bits from a,b and sum to one vector
temp  <= Q1_s(Q1_s'high) & Q2_s(Q2_s'high) & output_s(output_s'high);
OV 	<= (temp = "001") or (temp = "110");
		
end logical;

--------------------------------

/* signed multi */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity M_signed_multi is

	generic (	
		word_width	: integer := 16
		);
		
	port(	
		Q1		: in  vector_t(word_width-1 downto 0) := (others=>'0');
		Q2		: in 	vector_t(word_width-1 downto 0) := (others=>'0');
		output: out	vector_t(2*(word_width)-1 downto 0) := (others=>'0')
		);
		
end M_signed_multi;

architecture logical of M_signed_multi is 

signal temp : vector_t(word_width downto 0);

begin
	
	temp   <= std_logic_vector(unsigned(Q1) * unsigned(Q2));
	cout   <= temp(2*(word_width)-1 downto word_width);
	output <= temp(word_width-1 downto 0);
		
end logical;

