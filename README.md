# ModularBlocks
An array of vhdl modules designed for modular general use under the K1 standard 
Applicable to softcore processor projects from scratch
(c) Luke Andrews 2017
All software is written under the MIT license and available on Github

Modules are divided into 4 sub categories, and each Module exists in both .vhd and .bsf files for straight HDL design and Quartus schematic design support. Modules have been tested on the Altera DE0-Nano and DE0-CV development boards available from Terasic at a low cost.
Modules are designed to work with the global packagae (pack_global) and use its types:
+ bit_t (std_logic)
+ vector_t (std_logic_vector)
+ array_t (array of std_logic_vector)

## Operations
This folder contains Modules that perform bit-level operations (bitwise etc)
The available modules are:
- OP_and (array, vector, bit)
- OP_nand (array, vector, bit)
- OP_or (array, vector, bit)
- OP_xor (array, vector, bit)

## Functions
This folder contains Modules that perform function-level operations (multiplexers etc)
The available modules are:
- F_mux (array, vector)
- F_demux (array, vector)
- F_latch_dff
- F_latch_sr
- F_onehotdecoder
- F_onehotencoder
- F_mem_register
- F_mem_sr

## Maths
This folder contains Modules that perform mathematic-level operations (signed addition etc)
The available modules are:
- M_iterative_sin_inc
- M_iterative_sin_dec
- M_iterative_uns_inc
- M_iterative_uns_dec
- M_logical_shiftleft
- M_logical_shiftright
- M_logical_rotateleft
- M_logical_rotateright
- M_signed_add
- M_signed_sub
- M_signed_multi
- M_unsigned_add
- M_unsigned_sub
- M_unsigned_multi


## Units
This folder contains Modules that perform bit-level operations (ALU etc)
The available modules are:
- U_ALU_signed
- U_ALU_unsigned
- U_ALU_super
- U_incrementer
- U_decremente
- U_adjustcounter
- U_mem_page1p
- U_mem_page2p
- U_pipe_buffer
- U_Expander
