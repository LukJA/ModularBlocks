/* pack_global .vhd */
/* global package */
/* designed for modular general use under the K1 standard */
/* (c) Luke Andrews 2017 */
/* All software is written under the MIT license and available on Github */

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
	function to_std (constant val : in boolean) return std_logic;
	function to_bool (constant val : in std_logic) return boolean;
	function to_unsig (x: in std_logic) return unsigned;
  
end package;

package body global is

	function to_std (constant val : in boolean) return std_logic is
	begin
		if val then
			return '1';
		else
			return '0';
		end if; 
	end function to_std;
	
	function to_bool (constant val : in std_logic) return boolean is
	begin
		if val then
			return true;
		else
			return false;
		end if; 
	end function to_bool;
	
	function to_unsig (x: in std_logic) return unsigned is
	begin
		if x='1' then
			return "1";
		else 
			return "0"; 
		end if;
	end function to_unsig;

end package body global;