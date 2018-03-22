/* unit_alu .vhd */
/* alu unit definitions */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains the alu units available for use  */

--------------------------------

/* Unsigned ALU */
/* designed for 4 bit control interface */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity U_ALU_unsigned is

	generic (	
		word_width		: integer := 16;
		control_width	: integer := 4
		);
		
	port(	
		DataIn_0 	: in vector_t(word_width-1 downto 0) := (others=>'0');
		DataIn_1 	: in vector_t(word_width-1 downto 0) := (others=>'0');
		AddressIn	: in vector_t(control_width-1 downto 0) := (others=>'0');
		ControlIn 	: in vector_t(0 downto 0) := (others=>'0');
		Enable		: in bit_t := '0';
		
		DataOut_0 	: out vector_t(word_width-1 downto 0) := (others=>'0');
		DataOut_1 	: out vector_t(word_width-1 downto 0) := (others=>'0');
		AddressOut	: out vector_t(control_width-1 downto 0) := (others=>'0');
		ControlOut 	: out vector_t(3 downto 0) := (others=>'0');
		Reset		: in  bit_t := '0'
		);
		
		/* DataIn0,1 	: 2 vectors holding the data to be computed */
		/* AddressIn 	: 4 bit wide vector selecting the chosen operation */
		/* controlIn	: 1 bit wide carry in vector for addition */
		/* Enable 		: 1 bit enable port */
		
		/* DataOut0,1 		: 1 vector output containing the data */
		/* AddressOut 	: 4 bit wide vector - follows through */
		/* controlOut	: 2 bit carry out vector */
		/* Reset 		: 1 bit reset port */
		
end U_ALU_unsigned;

architecture logical of U_ALU_unsigned is

signal carry_in 	: bit_t := '0';
signal carry_out 	: bit_t := '0';
signal sub_out 		: bit_t := '0';
signal multi_out	: vector_t(2*(word_width)-1 downto 0) := (others => '0');

signal outputMux	: array_t(15 downto 0)(word_width-1 downto 0);

begin
	
	/* unsigned maths */
	u_add: entity work.M_unsigned_add generic map (word_width) port map (DataIn_0, DataIn_1, carry_in, carry_out, outputMux(0));
	u_sub: entity work.M_unsigned_sub generic map (word_width) port map (DataIn_0, DataIn_1, sub_out, outputMux(1));
	u_mul: entity work.M_unsigned_multi generic map (word_width) port map (DataIn_0, DataIn_1, multi_out);
	outputMux(3) <= multi_out(word_width-1 downto 0);
	outputMux(4) <= multi_out(2*(word_width)-1 downto word_width);
	
	/* bitwise operations */
	op_and: entity work.OP_vector_and generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(5));
	op_orr: entity work.OP_vector_or generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(6));
	op_nan: entity work.OP_vector_nand generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(7));
	op_xor: entity work.OP_vector_xor generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(8));
	
	/* iterative maths */
	uns_inc: entity work.M_iterative_uns_inc generic map (word_width) port map (DataIn_0, outputMux(9));
	uns_dec: entity work.M_iterative_uns_dec generic map (word_width) port map (DataIn_0, outputMux(10));
	
	/* logical maths */
	log_rol: entity work.M_logical_rotleft generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(11));
	log_ror: entity work.M_logical_rotright generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(12));
	log_sll: entity work.M_logical_shiftleft generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(13));
	log_srl: entity work.M_logical_shiftright generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(14));
	
	
	/* Misc */
	outputMux(15) <= DataIn_0;
	
	/* output multiplexer */
	out_mux: entity work.F_mux_array generic map (16, word_width, control_width) port map (outputMux, AddressIn, DataOut_0);
	
	/* control signals */
	carry_in <= ControlIn(0);
	ControlOut(0) <= carry_out;
	ControlOut(1) <= sub_out;
	AddressOut <= AddressIn;
	
	process(DataOut_0)begin
		if unsigned(DataOut_0) = 0 then 
			ControlOut(2) <= '1';
		else 
			ControlOut(2) <= '0';
		end if;
		
		if DataIn_0 = DataIn_1 then
			ControlOut(3) <= '1';
		else 
			ControlOut(3) <= '0';
		end if;
	end process;

end logical;


--------------------------------

/* Signed ALU */
/* designed for 4 bit control interface */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity U_ALU_signed is

	generic (	
		word_width		: integer := 16;
		control_width	: integer := 4
		);
		
	port(	
		DataIn_0 	: in vector_t(word_width-1 downto 0) := (others=>'0');
		DataIn_1 	: in vector_t(word_width-1 downto 0) := (others=>'0');
		AddressIn	: in vector_t(control_width-1 downto 0) := (others=>'0');
		ControlIn 	: in vector_t(control_width-1 downto 0) := (others=>'0');
		Enable		: in bit_t := '0';
		
		DataOut_0 	: out vector_t(word_width-1 downto 0) := (others=>'0');
		DataOut_1 	: out vector_t(word_width-1 downto 0) := (others=>'0');
		AddressOut	: out vector_t(control_width-1 downto 0) := (others=>'0');
		ControlOut 	: out vector_t(3 downto 0) := (others=>'0');
		Reset		: in  bit_t := '0'
		
		/* DataIn0,1	: 2 vectors holding the data to be computed */
		/* AddressIn 	: 4 bit wide vector selecting the chosen operation */
		/* controlIn	: unused */
		/* Enable 		: 1 bit enable port */
		
		/* DataOut0,1	: 1 vector output containing the data */
		/* AddressOut 	: 4 bit wide vector - follows through */
		/* controlOut	: 2 bit carry out vector */
		/* Reset 		: 1 bit reset port */
		
		);
		
end U_ALU_signed;

architecture logical of U_ALU_signed is

signal overflowA 	: bit_t := '0';
signal overflowB 	: bit_t := '0';
signal multi_out	: vector_t(word_width-1 downto 0) := (others => '0');

signal outputMux	: array_t(15 downto 0)(word_width-1 downto 0);

begin
	
	/* signed maths */
	u_add: entity work.M_signed_add generic map (word_width) port map (DataIn_0, DataIn_1, overflowA, outputMux(0));
	u_sub: entity work.M_signed_sub generic map (word_width) port map (DataIn_0, DataIn_1, overflowB, outputMux(1));
	u_mul: entity work.M_signed_multi generic map (word_width) port map (DataIn_0, DataIn_1, multi_out);
	outputMux(3) <= multi_out(word_width-1 downto 0);
	outputMux(4) <= multi_out(2*(word_width)-1 downto word_width);
	
	/* bitwise operations */
	op_and: entity work.OP_vector_and generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(5));
	op_orr: entity work.OP_vector_or generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(6));
	op_nan: entity work.OP_vector_nand generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(7));
	op_xor: entity work.OP_vector_xor generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(8));
	
		/* iterative maths */
	sin_inc: entity work.M_iterative_sin_inc generic map (word_width) port map (DataIn_0, outputMux(9));
	sin_dec: entity work.M_iterative_sin_dec generic map (word_width) port map (DataIn_0, outputMux(10));
	
		/* logical maths */
	log_rol: entity work.M_logical_rotleft generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(11));
	log_ror: entity work.M_logical_rotright generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(12));
	log_sll: entity work.M_logical_shiftleft generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(13));
	log_srl: entity work.M_logical_shiftright generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(14));
	
	/* Misc */
	outputMux(15) <= DataIn_0;
	
	/* output multiplexer */
	out_mux: entity work.F_mux_array generic map (16, word_width, control_width) port map (outputMux, AddressIn, DataOut_0);
	
	/* control signals */
	ControlOut(0) <= overflowA;
	ControlOut(1) <= overflowB;
	AddressOut <= AddressIn;

	process(DataOut_0)begin
		if unsigned(DataOut_0) = 0 then 
			ControlOut(2) <= '1';
		else 
			ControlOut(2) <= '0';
		end if;
		
		if DataIn_0 = DataIn_0 then
			ControlOut(3) <= '1';
		else 
			ControlOut(3) <= '0';
		end if;
	
end logical;

--------------------------------

/* SUPER ALU */
/* designed for X bit control interface */
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity U_ALU_super is

	generic (	
		word_width		: integer := 16;
		control_width	: integer := 5
		);
		
	port(	
		DataIn_0 	: in vector_t(word_width-1 downto 0) := (others=>'0');
		DataIn_1 	: in vector_t(word_width-1 downto 0) := (others=>'0');
		AddressIn	: in vector_t(control_width-1 downto 0) := (others=>'0');
		ControlIn 	: in vector_t(0 downto 0) := (others=>'0');
		Enable		: in bit_t := '0';
		
		DataOut_0 	: out vector_t(word_width-1 downto 0) := (others=>'0');
		DataOut_1 	: out vector_t(word_width-1 downto 0) := (others=>'0');
		AddressOut	: out vector_t(control_width-1 downto 0) := (others=>'0');
		ControlOut 	: out vector_t(5 downto 0) := (others=>'0');
		Reset		: in  bit_t := '0'
		
		/* DataIn0,1 		: 2 vectors holding the data to be computed */
		/* AddressIn 	: 5 bit wide vector selecting the chosen operation */
		/* controlIn	: 1 bit carry in*/
		/* Enable 		: 1 bit enable port */
		
		/* DataOut0,1 		: 1 vector output containing the data */
		/* AddressOut 	: 5 bit wide vector - follows through */
		/* controlOut	: 4 bit carry out vector */
		/* Reset 		: 1 bit reset port */
		);
		
end U_ALU_super;

architecture logical of U_ALU_super is

signal carry_in 	: bit_t := '0';
signal carry_out 	: bit_t := '0';
signal sub_out 	: bit_t := '0';
signal multi_outU	: vector_t(word_width-1 downto 0) := (others => '0');

signal overflowA 	: bit_t := '0';
signal overflowB 	: bit_t := '0';
signal multi_outS	: vector_t(word_width-1 downto 0) := (others => '0');


signal outputMux	: array_t(22 downto 0)(word_width-1 downto 0);

begin
	
	/* unsigned maths */
	u_add: entity work.M_signed_add generic map (word_width) port map (DataIn_0, DataIn_1, overflowA, outputMux(0));
	u_sub: entity work.M_signed_sub generic map (word_width) port map (DataIn_0, DataIn_1, overflowB, outputMux(1));
	u_mul: entity work.M_signed_multi generic map (word_width) port map (DataIn_0, DataIn_1, multi_outU);
	outputMux(3) <= multi_outU(word_width-1 downto 0);
	outputMux(4) <= multi_outU(2*(word_width)-1 downto word_width);
	
	/* signed maths */
	u_addM: entity work.M_signed_add generic map (word_width) port map (DataIn_0, DataIn_1, overflowA, outputMux(5));
	u_subM: entity work.M_signed_sub generic map (word_width) port map (DataIn_0, DataIn_1, overflowB, outputMux(6));
	u_mulM: entity work.M_signed_multi generic map (word_width) port map (DataIn_0, DataIn_1, multi_outS);
	outputMux(8) <= multi_outS(word_width-1 downto 0);
	outputMux(9) <= multi_outS(2*(word_width)-1 downto word_width);
	
	/* bitwise operations */
	op_and: entity work.OP_vector_and generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(10));
	op_orr: entity work.OP_vector_or generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(11));
	op_nan: entity work.OP_vector_nand generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(12));
	op_xor: entity work.OP_vector_xor generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(13));
	
	/* logical maths */
	log_rol: entity work.M_logical_rotleft generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(14));
	log_ror: entity work.M_logical_rotright generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(15));
	log_sll: entity work.M_logical_shiftleft generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(16));
	log_srl: entity work.M_logical_shiftright generic map (word_width) port map (DataIn_0, DataIn_1, outputMux(17));
	
	/* iterative maths */
	uns_inc: entity work.M_iterative_uns_inc generic map (word_width) port map (DataIn_0, outputMux(18));
	sin_inc: entity work.M_iterative_sin_inc generic map (word_width) port map (DataIn_0, outputMux(19));
	uns_dec: entity work.M_iterative_uns_dec generic map (word_width) port map (DataIn_0, outputMux(20));
	sin_dec: entity work.M_iterative_sin_dec generic map (word_width) port map (DataIn_0, outputMux(21));
	
	/* Misc */
	outputMux(22) <= DataIn_0;
	
	
	/* output multiplexer */
	out_mux: entity work.F_mux_array generic map (32, word_width, control_width) port map (outputMux, AddressIn, DataOut_0);
	
	/* control signals */
	carry_in <= ControlIn(0);
	ControlOut(0) <= carry_out;
	ControlOut(1) <= sub_out;
	ControlOut(2) <= overflowA;
	ControlOut(3) <= overflowB;
	AddressOut <= AddressIn;
	
	process(DataOut_0)begin
		if unsigned(DataOut_0) = 0 then 
			ControlOut(4) <= '1';
		else 
			ControlOut(4) <= '0';
		end if;
		
		if DataIn_0 = DataIn_0 then
			ControlOut(5) <= '1';
		else 
			ControlOut(5) <= '0';
		end if;
	end process;

end logical;




