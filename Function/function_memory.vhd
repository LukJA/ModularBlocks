/* function_memory .vhd */
/* function_memory coders */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains memories of all types  */

-------------------------------

/* Register (flip flop array) */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity F_mem_register is

	generic( 
		word_width: integer := 1	-- width
		);
		
	port( 
		clk	: in  bit_t := '0';
		D		: in  vector_t(word_width-1 downto 0) := (others => '0');
		Q		: out vector_t(word_width-1 downto 0) := (others => '0')
		);
		
end F_mem_register;

architecture logical of F_mem_register is 
begin

	process(clk) begin
		if (rising_edge(clk)) then -- clock rising edge
			Q <= D;
		end if;
	end process;
	
end logical;

-------------------------------

/* S-R latch */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

/* sets latch if both lines are raised at the same time */
/* otherwise sets and resets on rising edges */
entity F_mem_sr is

	generic( 
		word_width: integer := 1	-- width
		);
		
	port(
		S 			: in  vector_t(word_width-1 downto 0) := (others => '0');
		R			: in  vector_t(word_width-1 downto 0) := (others => '0');
		output	: out vector_t(word_width-1 downto 0) := (others => '0')
		);
		
end F_mem_sr;

architecture logical of F_mem_sr is
begin

	process(S,R)begin 
		/* set the latch if s and r is rising */
		for i in 0 to word_width-1 loop 
			if rising_edge(S(i)) and rising_edge(R(i)) then
				output(i) <= '1';
				
			elsif rising_edge(S(i)) then
				output(i) <= '1';
			
			elsif rising_edge(R(i)) then
				output(i) <= '0';
				
			end if;
		end loop;
	end process; 
	
end logical;