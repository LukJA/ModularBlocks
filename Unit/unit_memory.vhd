/* unit_memory .vhd */
/* memory unit definitions */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains the memory units available for use  */

------------------------

/* Ram page - 1 port*/
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity U_mem_page1p is

	generic (	
		word_width		: integer := 16;
		addr_width		: integer := 16;
		mem_size			: integer := 16
		);
		
	port(	
		DataIn 		: in array_t(0 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		AddressIn	: in vector_t(addr_width-1 downto 0) := (others=>'0');
		ControlIn 	: in vector_t(0 downto 0) := (others=>'0');
		Enable		: in bit_t := '0';
		
		DataOut 		: out array_t(0 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		AddressOut	: out vector_t(addr_width-1 downto 0) := (others=>'0');
		ControlOut 	: out bit_t;
		Reset			: in  bit_t := '0'
		);
		
		/* DataIn 		: 1 vector holding data in */
		/* AddressIn 	: 1 vector holding address in */
		/* controlIn	: 1 bit wide clock */
		/* Enable 		: 1 bit enable port */
		
		/* DataOut 		: 1 vector output containing the data */
		/* AddressOut 	: 1 vector address followthrough */
		/* controlOut	: disabled */
		/* Reset 		: 1 bit reset port */
		
end U_mem_page1p;

architecture logical of U_mem_page1p is

signal regDs, regQs 	: array_t(mem_size-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
signal regClock		: vector_t(mem_size-1 downto 0) := (others => '0');

begin

	GEN_REG:
	for k in 0 to mem_size-1 generate
      REGX : work.F_mem_register generic map (word_width) port map (regClock(k) and ControlIn(0) , regDs(k), regQs(k));
   end generate GEN_REG;
	
	/* clock one hot encoder */ 
	clk_mux: entity work.F_onehot_enc generic map (addr_width, mem_size) port map (AddressIn, regClock);
	
	/* input demultiplexer */
	in_mux: entity work.F_demux_array generic map (mem_size, word_width, addr_width) port map (DataIn(0), AddressIn, regDs);
	/* output multiplexer */
	out_mux: entity work.F_mux_array generic map (mem_size, word_width, addr_width) port map (regQs, AddressIn, DataOut(0));

	addressOut <= addressIn;
	
end logical;

----------------------------

/* Ram page - 2 port*/
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity U_mem_page2p is

	generic (	
		word_width		: integer := 16;
		addr_width		: integer := 16;
		mem_size			: integer := 16
		);
		
	port(	
		DataIn 		: in array_t(1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		AddressIn	: in array_t(1 downto 0)(addr_width-1 downto 0) := (others=> (others=>'0'));
		ControlIn 	: in vector_t(1 downto 0) := (others=>'0');
		Enable		: in bit_t := '0';
		
		DataOut 		: out array_t(1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
		AddressOut	: out array_t(1 downto 0)(addr_width-1 downto 0) := (others=> (others=>'0')); 
		ControlOut 	: out bit_t;
		Reset			: in  bit_t := '0'
		);
		
		/* DataIn 		: 2 vector holding data in (A,B) */
		/* AddressIn 	: 2 vector holding address in (A,B) */
		/* controlIn	: 2 bit wide clock (A,B) */
		/* Enable 		: 1 bit enable port */
		
		/* DataOut 		: 2 vector output containing the data */
		/* AddressOut 	: 2 vector address followthrough */
		/* controlOut	: disabled */
		/* Reset 		: 1 bit reset port */
		
end U_mem_page2p;

architecture logical of U_mem_page2p is

signal regDs, regQs 	: array_t(mem_size-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
signal regDA, regDB	: array_t(mem_size-1 downto 0)(word_width-1 downto 0) := (others=> (others=>'0'));
signal regClockA		: vector_t(mem_size-1 downto 0) := (others => '0');
signal regClockB		: vector_t(mem_size-1 downto 0) := (others => '0');


begin
	
	/* registers */
	GEN_REG:
	for k in 0 to mem_size-1 generate
      REGX : work.F_mem_register generic map (word_width) port map ((regClockB(k) and ControlIn(0)) or (regClockA(k) and ControlIn(1)) , regDs(k), regQs(k));
   end generate GEN_REG;
	
	---- PORT A ----
	/* clock one hot encoder */ 
	clk_mux: entity work.F_onehot_enc generic map (addr_width, mem_size) port map (AddressIn(1), regClockA);	
	/* input demultiplexer */
	in_mux: entity work.F_demux_array generic map (mem_size, word_width, addr_width) port map (DataIn(1), AddressIn(1), regDA);
	/* output multiplexer */
	out_mux: entity work.F_mux_array generic map (mem_size, word_width, addr_width) port map (regQs, AddressIn(1), DataOut(1));
	
		---- PORT B ----
	/* clock one hot encoder */ 
	clk_muxM: entity work.F_onehot_enc generic map (addr_width, mem_size) port map (AddressIn(0), regClockB);	
	/* input demultiplexer */
	in_muxM: entity work.F_demux_array generic map (mem_size, word_width, addr_width) port map (DataIn(0), AddressIn(0), regDB);
	/* output multiplexer */
	out_muxM: entity work.F_mux_array generic map (mem_size, word_width, addr_width) port map (regQs, AddressIn(0), DataOut(0));
	
	/* connection */
	reg_or: entity work.OP_array_or generic map (mem_size, word_width) port map (regDA, regDB, regDs);

	AddressOut <= AddressIn;
	
end logical;
