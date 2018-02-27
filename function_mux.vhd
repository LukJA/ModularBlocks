/* function_mux .vhd */
/* multiplexers */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains multiplexers of all types  */

-------------------------------

/* array sized multiplexer */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity F_mux_array is

	generic (	
		word_no 		: integer := 32;
		word_width	: integer := 16;
		addr_width	: integer := 8
		);
		
	port(	
		Q1  		: in  array_t(word_no-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		addr   	: in  vector_t(addr_width-1 downto 0) := (others => '0');
		output 	: out vector_t(word_width-1 downto 0) := (others => '0')
		);
		
end F_mux_array;

architecture logical of F_mux_array is 
begin

	process(all) begin
	
		/* clean the output of any values */
		output <= (others => '0');
		
		/* interate though every location */
		/* if the address is matching, copy the output */
		for i in 0 to word_no-1 loop
			if addr = (std_logic_vector(to_unsigned(i, addr_width))) then
				output <= Q1(i);
			end if;
			
		end loop;
	end process;
	
end logical;

--------------------------------

/* Vector sized multiplexer */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity F_mux_vector is

	generic (	
		word_width	: integer := 16;
		addr_width	: integer := 8
		);
		
	port(	
		Q1  		: in  vector_t(word_width-1 downto 0) := (others => '0');
		addr   	: in  vector_t(addr_width-1 downto 0) := (others => '0');
		output 	: out bit_t := '0'
		);
		
end F_mux_vector;

architecture logical of F_mux_vector is 
begin

	process(all) begin
	
		/* clean the output of any values */
		output <= '0';
		
		/* interate though every location */
		/* if the address is matching, copy the output */
		for i in 0 to word_width-1 loop
			if addr = (std_logic_vector(to_unsigned(i, addr_width))) then
				output <= Q1(i);
			end if;
			
		end loop;
	end process;
	
end logical;

--------------------------------

/* Bit sized and operation 
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity OP_bit_and is

	port(	
		output: out bit_t := '0';
		Q1		: in 	bit_t := '0';
		Q2		: in 	bit_t := '0'
		);
		
end OP_bit_and;

architecture logical of OP_bit_and is 
begin
			output <= Q1 and Q2

end logical;*/