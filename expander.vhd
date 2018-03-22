/* expansionIF .vhd */
/* A protoype expansion interface */
/* --designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pack_global.all;

entity U_expansionIF is 

	port (
		Enable			: in std_logic := '0'; -- active high
		addressData		: in std_logic := '0'; -- 0 address, 1 data
		ReadWrite		: in std_logic := '0'; -- 0 Write, 1 read
		Clock				: in std_logic := '0'; 
		
		dataIn			: in std_logic_vector(7 downto 0) := (others => '0');
		dataOut			: out std_logic_vector(7 downto 0) := (others => '0');
		AddressIn		: in std_logic_vector(15 downto 0) := (others => '0');
		
		streamIn			: in std_logic_vector(7 downto 0) := (others => '0');
		streamOut		: out std_logic_vector(7 downto 0) := (others => '0');
		AddressOut		: out std_logic_vector(15 downto 0) := (others => '0');
		clkO				: out std_logic := '0'
	);

end U_expansionIF;

architecture func of U_expansionIF is

	signal bufferIn, bufferOut	: std_logic_vector(7 downto 0) := (others => '0');
	signal outClockEn	:	std_logic := '0';
	signal Addr_plus_one, AddressR : std_logic_vector(15 downto 0);

begin

	-- setup the offset output clock
	clkO <= (not Clock) and outClockEn;
	
	-- setup the address register combinationally
	addressStorage: entity work.F_mem_register generic map (16) port map (not((not addressData) and Clock and enable), AddressR, AddressOut);
	Addr_plus_one <= std_logic_vector(unsigned(AddressOut) + 1);
	
	-- connect buffer lines to memory bus
	streamOut <= bufferIn;
	bufferOut <= streamIn;

	-- enabling data paths
	process(enable) begin
		if enable = '0' then 
			-- ignore data paths
			dataOut <= dataIn;
		else 
			bufferIn <= dataIn;
			dataOut <= bufferOut;
		end if;
	end process;
	
	process(Clock)begin
		if rising_edge(Clock) then
		-- this is the clock edge where we control data
		if outClockEn = '1' then outClockEn <= '0'; end if;
		-- reset the address input
		AddressR <= (others => '0');
		if addressData = '1' then
			-- its data
			-- connect add one to address
			AddressR <= Addr_plus_one;
			
			if ReadWrite = '0' then 
				-- its write
				-- enable the clock
				outClockEn <= '1';
			end if;
		else 
			-- its address so conect in the address line
			AddressR <= AddressIn;
		end if;
		end if;
				
	end process;
	
	
end func;
	

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pack_global.all;

/* a memory based Peripheral Access Layer */
/* fixed precision */
/* provides an array of registers where each address features both an input and output register */

entity U_PAL is 
	port( clk: in std_logic := '0';
			Address: in std_logic_vector(15 downto 0) := (others => '0');
			DataIn: in std_logic_vector(7 downto 0) := (others => '0');
			DataOut: out std_logic_vector(7 downto 0) := (others => '0');
			
			strIN1, strIN2, strIN3, strIN4, strIN5 : in std_logic_vector(15 downto 0);
			strOUT1, strOUT2, strOUT3, strOUT4, strOUT5 : out std_logic_vector(15 downto 0);
			
			hi : in std_logic_vector(0 downto 0) := "1"
			);
		
end U_PAL;

architecture versionone of U_PAL is 

	signal reg_clocks : std_logic_vector(9 downto 0);

	signal out_stream_raw : array_p(9 downto 0)(7 downto 0);
	signal in_stream_raw : array_p(9 downto 0)(7 downto 0);
	
	signal in_stream_reg : array_p(9 downto 0)(7 downto 0);

begin

	/* this version uses 10 addresses */
	
	/* create the onehot register mux */ 
	--clockmux: entity work.demux generic map (10,1,16) port map (hi, Address, reg_clocks);
	clockmux: entity work.F_onehot_enc generic map (4, 10) port map(Address(3 downto 0), reg_clocks);
	
	/* outputting registers */
	GEN_REG_sOut: 
   for k in 0 to 9 generate
      REGX : work.F_mem_register generic map (8) port map ((reg_clocks(k) and clk), DataIn, out_stream_raw(k));
   end generate GEN_REG_sOut;
	/* wire up the double width outputs */
	strOUT1 <= out_stream_raw(1) & out_stream_raw(0);
	strOUT2 <= out_stream_raw(3) & out_stream_raw(2);
	strOUT3 <= out_stream_raw(5) & out_stream_raw(4);
	strOUT4 <= out_stream_raw(7) & out_stream_raw(6);
	strOUT5 <= out_stream_raw(9) & out_stream_raw(8);
	
	/* inputting registers */
	/* input registers */
	GEN_REG_sIn: 
   for k in 0 to 9 generate
      REGX : work.F_mem_register generic map (8) port map (clk, in_stream_raw(k), in_stream_reg(k));
   end generate GEN_REG_sIn;
	/* wire up the double width inputs */
	in_stream_raw(0) <= strIN1(7 downto 0);
	in_stream_raw(1) <= strIN1(15 downto 8);
	in_stream_raw(2) <= strIN2(7 downto 0);
	in_stream_raw(3) <= strIN2(15 downto 8);
	in_stream_raw(4) <= strIN3(7 downto 0);
	in_stream_raw(5) <= strIN3(15 downto 8);
	in_stream_raw(6) <= strIN4(7 downto 0);
	in_stream_raw(7) <= strIN4(15 downto 8);
	in_stream_raw(8) <= strIN5(7 downto 0);
	in_stream_raw(9) <= strIN5(15 downto 8);
	
	/* setup the selection mux for ths data */
	
	outputmux: entity work.F_mux_array generic map (10,8,4) port map (in_stream_reg, Address, DataOut);
	

end versionone;

