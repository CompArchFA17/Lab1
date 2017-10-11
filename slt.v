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
wire overflow, carryout, less_than;
wire[31:0] subtractoroutput;
Subtractor32bit compare(a, b, subtractoroutput, carryout, overflow);
`XOR getsign(less_than, subtractoroutput[31], overflow); 
assign result = {30'b0, less_than};

endmodule