`include "logic32bits.v"
`include "multiplexer.v"
`include "adder.v"
`include "slt.v"

// define gates with delays
`define AND and #30
`define OR or #30
`define NOT not #10
`define NAND nand #20
`define NOR nor #20
`define XOR xor #30

module ALU
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);
wire[31:0] add_out, sub_out, xor_out, slt_out, and_out, nand_out, nor_out, or_out;
FullAdder32bit get_add_out(add_out, carryout, overflow, operandA, operandB);
Subtractor32bit get_sub_out(operandA, operandB, sub_out, carryout, overflow);
xor32 get_xor( xor_out, operandA, operandB);
SLT get_slt_out(operandA, operandB, slt_out);
and32 get_and(and_out, operandA, operandB);
nand32 get_nand(nand_out, operandA, operandB);
nor32 get_nor(nor_out, operandA, operandB);
or32 get_or(or_out, operandA, operandB);

behavioralMultiplexer mux (result, command, add_out, sub_out, xor_out, slt_out, and_out, nand_out, nor_out, or_out); // Swap after testing


endmodule