`define NOR nor #10
`define OR or #20
`define AND and #20
`define XOR xor #20
`define NOT not #10

// Implementation of a 1-bit full adder. When true, subtract inverts input B.
module FullAdder1bit
(
    output sum,
    output carryout,
    input a,
    input b0,
    input carryin,
    input subtract
);
    wire cout1;
    wire cout2;
    wire sumAB;
    wire b;

    // B is inverted for subtraction operations.
    `XOR b0xorsubtract(b, b0, subtract);
    `XOR AxorB(sumAB, a, b);
    `XOR sumABxorCin(sum, sumAB, carryin);

    `AND AandB(cout1, a, b);
    `AND sumABandCin(cout2, sumAB, carryin);

    `OR orcarries(carryout, cout1, cout2);
endmodule

// Implementation of a 32 bit adder/subtractor.
module AddSub
(
output[31:0] result,
output carryout,
output zero,
output overflow,
input[31:0] operandA,
input[31:0] operandB,
input subtract
);

wire[30:0] carryoutmid;
wire nzero;

FullAdder1bit adderinit (result[0], carryoutmid[0], operandA[0], operandB[0], subtract, subtract);

genvar i;
generate
  for (i = 1; i < 31; i = i + 1)
  begin: ripple
  	FullAdder1bit addermid (result[i], carryoutmid[i], operandA[i], operandB[i], carryoutmid[i- 1], subtract);
  end
endgenerate

FullAdder1bit adderfinal (result[31], carryout, operandA[31], operandB[31], carryoutmid[30], subtract);

`XOR overflowdetection(overflow, carryoutmid[30], carryout);

`OR orbits(nzero, result[31:0], 32'b0);
`NOT norbits(zero, nzero);

endmodule

// Implementation of a 32 bit XOR operation.
module alu32bitxor
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB
);

genvar i;
generate
  for (i = 0; i < 32; i = i + 1)
  begin: ripple
    `XOR xorgate (result[i], operandA[i], operandB[i]);
  end
endgenerate

endmodule

// Implementation of the set-less-than operation. Uses the 32-bit subtractor.
module alu32bitslt
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB
);
wire[31:0] subresult;
wire subcarryout;
wire subzero;
wire suboverflow;

// Set invertB to 1 because subtraction is needed.
AddSub subtractor (subresult, subcarryout, subzero, suboverflow, operandA, operandB, 1'b1);

assign result[31:1] = 31'b0;

`XOR final (result[0], subresult[31], suboverflow);

// Doesn't need to set a flag.
assign carryout = 0;
assign zero = 0;
assign overflow = 0;

endmodule


// Implementation of a 32 bit NAND or AND operation. 
// When 1, the invertand input indicates a NAND operation. 
// When invertand is 0, this module performs an AND operation.
module alu32bitandn
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input         invertand
);
wire interresult[31:0];

genvar i;
generate
  for (i = 0; i < 32; i = i + 1)
  begin: ripple0
    `AND andgate (interresult[i], operandA[i], operandB[i]);
  end
endgenerate

genvar j;
generate
  for (j = 0; j < 32; j = j + 1)
  begin: ripple1
    `XOR final (result[j], invertand, interresult[j]);
  end
endgenerate

// Doesn't need to set a flag.
assign carryout = 0;
assign zero = 0;
assign overflow = 0;

endmodule

// Implementation of a 32 bit NOR or OR operation. 
// When 1, the invertnor input indicates a NOR operation. 
// When invertor is 0, this module performs an OR operation.
module NOROR
(
output[31:0] result,
output carryout,
output zero,
output overflow,
input[31:0] operandA,
input[31:0] operandB,
input invertor
);

wire norres[31:0];
genvar i;
generate
  for (i = 0; i < 32; i = i + 1)
  begin: ripple0
	`NOR norgate (norres[i], operandA[i], operandB[i]);
  end
endgenerate

genvar j;
generate
  for (j = 0; j < 32; j = j + 1)
  begin: ripple1
	`XOR final (result[j], invertor, norres[j]);
  end
endgenerate

buf setcarryout (carryout, 'b0);
buf setzero (zero, 'b0);
buf setoverflow (overflow, 'b0);
endmodule