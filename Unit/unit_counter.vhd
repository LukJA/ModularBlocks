/* unit_counter .vhd */
/* counter unit definitions */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains the counter units available for use  */

--------------------------------

/* incrementer */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity U_incrementer is

	generic (	
		word_width		: integer := 16
		);
		
	port(	
		output		: out vector_t(word_width-1 downto 0) := (others=>'0');
		clock		: in bit_t := '0';
		reset		: in bit_t := '0';
		enable		: in bit_t := '0'
		);
		
end U_incrementer;

architecture logical of U_incrementer is

signal plus_one : vector_t(word_width-1 downto 0) := (others=>'0');

begin

	INC_reg: entity work.F_mem_register generic map (word_width) port map (clock and enable, plus_one, output);
	plus_one <= std_logic_vector(unsigned(output) + 1) when reset = '0' else (others=>'0');

end logical;

--------------------------------

/* decrementer */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity U_decrementer is

	generic (	
		word_width		: integer := 16
		);
		
	port(	
		output		: out vector_t(word_width-1 downto 0) := (others=>'0');
		clock		: in bit_t := '0';
		reset		: in bit_t := '0';
		enable		: in bit_t := '0'
		);
		
end U_decrementer;

architecture logical of U_decrementer is

signal plus_one : vector_t(word_width-1 downto 0) := (others=>'0');

begin

	DEC_reg: entity work.F_mem_register generic map (word_width) port map (clock and enable, plus_one, output);
	plus_one <= std_logic_vector(unsigned(output) - 1) when reset = '1' else (others=>'0');

end logical;

--------------------------------

/* adjustable counter (PC) */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity U_adjustcounter is

	generic (	
		word_width		: integer := 16
		);
		
	port(	
		DataIn 		: in bit_t := '0';
		AddressIn	: in vector_t(word_width-1 downto 0) := (others=>'0');
		ControlIn 	: in vector_t(1 downto 0) := (others=>'0');
		Enable		: in bit_t := '0';
		
		DataOut 	: out bit_t := '0';
		AddressOut	: out vector_t(word_width-1 downto 0) := (others=>'0');
		ControlOut 	: out bit_t := '0';
		Reset		: in  bit_t := '0'
		);
		
		/* DataIn 		: diabled */
		/* AddressIn 	: 1 vector containing the input address */
		/* controlIn	: 2 bit jump enable, clock input*/
		/* Enable 		: 1 bit enable port */
		
		/* DataOut 		: disabled */
		/* AddressOut 	: 1 vector containing the output address  */
		/* controlOut	: disabled */
		/* Reset 		: 1 bit reset port */
		
end U_adjustcounter;

architecture logical of U_adjustcounter is

signal plus_one : vector_t(word_width-1 downto 0) := (others=>'0');
signal temp 	 : vector_t(1 downto 0);

begin

	PC_reg: entity work.F_mem_register generic map (word_width) port map (ControlIn(1) and enable, plus_one, AddressOut);
	
	temp <= (reset) & (ControlIn(0));
	with temp select plus_one <=
		std_logic_vector(unsigned(AddressOut) + 1) when "00", /* normal */ 
									  (others => '0') when "1-", /* reset */  
										     AddressIn when "01";/* adjust */
	
end logical;