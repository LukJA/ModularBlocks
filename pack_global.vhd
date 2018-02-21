/* pack_global .vhd */
/* global package */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

/* this package contains the types and functions needed to implement the K1 standard */

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
package global is

	/* some types have to be implemeted for the array functionality */
	
	/* This type allows for parametric vector ports */
   type array_t is array (natural range <>) of std_logic_vector;
   /* this type cleans the look of the ports */
   type vector_t is std_logic_vector;
  
   -- functions to convert between boolean / std_[u]logic.
	function bool_to_std (constant val : in boolean) return std_logic;
	function std_to_bool (constant val : in std_logic) return boolean;
	function std_to_unsig (x: in std_logic) return unsigned;
	function std_to_vec (x: in std_logic) return std_logic_vector;
	function vec_to_std (x: in std_logic_vector) return std_logic;
	
	
  
end package;

package body global is

	/* function to convert boolean value to std_logic */
	function bool_to_std (constant val : in boolean) return std_logic is
	begin
		if val then
			return '1';
		else
			return '0';
		end if; 
	end function bool_to_std;
	
	/* function to convert std_logic value to bool */
	function std_to_bool (constant val : in std_logic) return boolean is
	begin
		if val then
			return true;
		else
			return false;
		end if; 
	end function std_to_bool;
	
	/* function to convert std_logic value to unsigned */
	function std_to_unsig (x: in std_logic) return unsigned is
	begin
		if x='1' then
			return "1";
		else 
			return "0"; 
		end if;
	end function std_to_unsig;

	
	/* function to convert std_logic value to std_logic_vector */
	function std_to_vec (x: in std_logic) return std_logic_vector is
	begin
		if x='1' then
			return "1";
		else 
			return "0"; 
		end if;
	end function std_to_vec;
	
	/* function to convert std_logic_vector value to std_logic */
	function vec_to_std (x: in std_logic_vector) return std_logic is
	begin
		if x="1" then
			return '1';
		else 
			return '0'; 
		end if;
	end function vec_to_std;
end package body global;