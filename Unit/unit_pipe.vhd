/* unit_pipe .vhd */
/* pipe unit definitions */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains the pipe units available for use  */

------------------------

/* buffer unit */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity U_pipe_buffer is

	generic (	
		word_width		: integer := 16
		);
		
	port(	
		DataIn 		: in vector_t(word_width-1 downto 0) := (others=>'0');
		AddressIn	: in bit_t;
		ControlIn 	: in vector_t(0 downto 0) := (others=>'0');
		Enable		: in bit_t := '0';
		
		DataOut 		: out vector_t(word_width-1 downto 0) := (others=>'0');
		AddressOut	: out bit_t;
		ControlOut 	: out bit_t;
		Reset			: in  bit_t := '0'
		);
		
		/* DataIn 		: 1 vector holding data in */
		/* AddressIn 	: disabled */
		/* controlIn	: 1 bit wide clock */
		/* Enable 		: 1 bit enable port */
		
		/* DataOut 		: 1 vector output containing the data */
		/* AddressOut 	: disabled */
		/* controlOut	: disabled */
		/* Reset 		: 1 bit reset port */
		
end U_pipe_buffer;

architecture logical of U_pipe_buffer is
signal buff	: vector_t(word_width-1 downto 0) := (others=>'0');
begin

	process(controlIn(0))begin
		if rising_edge(controlIn(0)) then 
			buff <= DataIn;
		end if;
		if falling_edge(controlIn(0)) then 
			DataOut <= buff;
		end if;
	end process;

end logical;
