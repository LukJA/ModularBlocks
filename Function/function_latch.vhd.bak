/* function_latch .vhd */
/* function_latch coders */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains latches of all types  */

-------------------------------

/* S-R latch */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

/* sets latch if both lines are raised at the same time */
/* otherwise sets and resets on rising edges */
entity F_latch_sr
		
	port(
		S 			: in  bit_t := '0';
		R			: in  bit_t := '0';
		output	: out bit_t := '0'
		);
		
end F_latch_sr;

architecture logical of F_latch_sr is
begin

	process(S,R)begin 
		/* set the latch if s and r is rising */
		if rising_edge(S) and rising_edge(R) then
			output <= '1';
			
		else if rising_edge(S) then
			output <= '1';
		
		else if rising_edge(R) then
			output <= '0';
			
		end if;
		
	end process; 
	
end logical;

-------------------------------

/* d flip flop rising edge */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;


entity F_latch_dff
		
	port(
		clk		: in  bit_t := '0';
		D			: in  bit_t := '0';
		output	: out bit_t := '0'
		);
		
end F_latch_dff;

architecture logical of F_latch_dff is
begin

	process(clk) begin
	/* lock data on rising edge */
		if (rising_edge(clk)) then 
				output <= D;
		end if;
	end process;
	
end logical;