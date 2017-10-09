// ALU1bit is a 1-Bit arithmetic logic unit
// It performs the following operations:
// b000 -> ADD
// b001 -> SUB
// b010 -> XOR
// b011 -> SLT
// b100 -> AND
// b101 -> NAND
// b110 -> NOR
// b111 -> OR

`define AND and #30
`define OR or #30
`define NOT not #10

module ALU1bit
(
  output      out,
  output      cout,
  input       a,
  input       b,
  input       cin,
  input[2:0]  op
);
	wire res_ADD;
	// Add
	FullAdder1Bit adder(out, cout, a, b, cin);

	// Subtract
	wire res_SUB;

	// Xor
	wire res_XOR;
	xor(res_XOR, a, b);

	// SLT
	wire  res_SLT;

	// And
	wire res_AND;
	and(res_AND, a, b);

	// Nand
	wire res_NAND;
	nand(res_NAND, a, b);

	// Nor
	wire res_NOR;
	nor(res_NOR, a, b);

	// Or
	wire res_OR;
	or(res_OR, a, b);

	// Use a behavioral mux to select operation
	wire[7:0] muxIn = {res_ADD, res_SUB, res_XOR, res_SLT, res_AND, res_NAND, res_NOR, res_OR};
	behavioralMultiplexer mux(out, op, muxIn);
endmodule
  


module behavioralMultiplexer
(
    output out,
    input[2:0] address,
    input[7:0] inputs
);
    assign out = inputs[address];
endmodule


module FullAdder1Bit
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    wire aandb, aorb;
    wire s, _carryin;
    wire outputIfCarryin, outputIf_Carryin;
    xor(s, a, b);
    xor(sum, s, carryin);
    and(aandb, a, b);
    or(aorb, a, b);
    not(_carryin, carryin);
    and(outputIfCarryin, aandb, _carryin);
    and(outputIf_Carryin, aorb, carryin);
    or(carryout, outputIfCarryin, outputIf_Carryin);
endmodule
