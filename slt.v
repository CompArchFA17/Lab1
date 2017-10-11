// `include "adder.v"

// define gates with delays
`define AND and #30
`define OR or #30
`define NOT not #10
`define NAND nand #20
`define NOR nor #20
`define XOR xor #30

 /* 
Module: SLT
Applies the Subtractor32bit to get the sum from input variable a SUB input variable b
Based on this subtraction sum's significant bit, this module outputs whether input a is numerically less than b by
XORing the signed bit with the subtraction's overflow. This XOR output gives us 1'b1 if a is less than b, and 1'b0 if b is less than a 
The last 'assign' statement helps us add additional zeroes to ensure a 32-bit output
*/
module SLT 
(
	input[31:0] a, b,
	output[31:0] result
);
wire overflow, carryout, less_than;
wire[31:0] subtractoroutput;
Subtractor32bit compare(a, b, subtractoroutput, carryout, overflow);
`XOR getsign(less_than, subtractoroutput[31], overflow); 
assign result = {30'b0, less_than};

endmodule