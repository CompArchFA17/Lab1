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
	wire cout_ADD;
	// Add
	FullAdder1Bit adder(res_ADD, cout_ADD, a, b, cin);

	// Subtract
	wire res_SUB;
	wire cout_SUB;
	FullSubtractor1Bit subtractor(res_SUB, cout_SUB, a, b, cin);

	// Xor
	wire res_XOR;
	xor(res_XOR, a, b);

	// SLT
	wire res_SLT;
	wire cout_SLT;

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
	wire[7:0] muxRes = {res_OR, res_NOR, res_NAND, res_AND, res_SLT, res_XOR, res_SUB, res_ADD};
	wire[2:0] muxCout = {cout_SLT, cout_SUB, cout_ADD};
	behavioralMultiplexer mux1(out, op, muxRes);
	behavioralMultiplexer mux2(cout, op, muxCout);

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

module FullSubtractor1Bit
(
    output diff,
    output borrowout,
    input a,
    input b,
    input borrowin
);
    wire axorb;
    xor(axorb, a, b);
    xor(diff, axorb, borrowin);
    wire nota, noteaandb, notaxorb, notaxorbandborrowin;
    not(nota, a);
    and(notaandb, nota, b);
    not(notaxorb, axorb);
    and(notaxorbandborrowin, notaxorb, borrowin);
    or(borrowout, notaandb, notaxorbandborrowin);
endmodule