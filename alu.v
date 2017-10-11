`include "adder.v"
`include "multiplexer.v"
`include "lut.v"

`define AND and #30
`define OR or #30
`define NOT not #10
`define XOR xor #50
`define NAND nand #20
`define NOR nor #20

module oneBitALU
(
	input bNegate,
	input a,
	input b,
	input [2:0] operation,
	input carryin,
	output result,
	output carryout,

);
	wire b, bNeagate;
	
	`NOT (nB, b);


    wire a, b, nB, aAndB, AOrB;

endmodule

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

endmodule