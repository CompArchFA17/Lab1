// `include "adder.v"
// define gates with delays

// define gates with delays
`define AND and #30
`define OR or #30
`define NOT not #10
`define NAND nand #20
`define NOR nor #20
`define XOR xor #30

module SLT 
(
	input[31:0] a, b,
	output[31:0] result
);
wire overflow, carryout;
wire[31:0] subtractoroutput;
Subtractor32bit compare(a, b, subtractoroutput, carryout, overflow);
and32 zeros (result, 32'd0, 32'd0);
`XOR getsign(result[0], subtractoroutput[31], overflow); 

endmodule