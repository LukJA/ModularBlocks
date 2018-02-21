/* function_onehot .vhd */
/* function_onehot coders */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains onehot coders of all types  */

-------------------------------

/* one hot encoder */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;


entity F_onehot_enc

	generic (	
		addr_width	: integer := 8;
		word_width	: integer := 16
		);
		
	port(
		Q1 		: in  vector_t(addr_width-1 downto 0);
		output	: out vector_t(word_width-1 downto 0)
		);
		
end F_onehot_enc;

architecture logical of F_onehot_enc is
begin

	process(all)begin 
		/* clear the data and put a one in the corresponding location */
		output  <= (others => '0'); 
		output(TO_INTEGER (UNSIGNED (Q1)))  <= '1'; 
	end process; 
	
end logical;

-------------------------------

/* one hot decoder */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;


entity F_onehot_enc

	generic (	
		word_width	: integer := 16
		addr_width	: integer := 8;
		);
		
	port(
		output 	: out vector_t(addr_width-1 downto 0);
		Q1			: in 	vector_t(word_width-1 downto 0)
		);
		
end F_onehot_enc;

architecture logical of F_onehot_enc is
begin

	process(all)begin 
		/* clear the data */
		data  <= (others => '0'); 
		
		/* iterate, if we find a 1, send the current position to the output */
		for i in 0 to (word_width - 1) loop
		
			if Q1(i) = "1" then
				output <= std_logic_vector(to_unsigned(i, addr_width)); 
			end if;
			
		end loop;
	end process; 
	
end logical;