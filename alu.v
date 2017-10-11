`define NOR nor #10
`define OR or #20
`define AND and #20
`define XOR xor #20


// Implementation of a 1-bit full adder.
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

    `XOR b0xorsubtract(b, b0, subtract);
    `XOR AxorB(sumAB, a, b);
    `XOR sumABxorCin(sum, sumAB, carryin);

    `AND AandB(cout1, a, b);
    `AND sumABandCin(cout2, sumAB, carryin);

    `OR orcarries(carryout, cout1, cout2);
endmodule

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

wire carryoutmid[30:0];
wire zeromid[30:0];
FullAdder1bit adderinit (result[0], carryoutmid[0], operandA[0], operandB[0], subtract, subtract);
genvar i;
for (i = 1; i < 31; i = i + 1) begin
	FullAdder1bit addermid (result[i], carryoutmid[i], operandA[i], operandB[i], subtract, carryoutmid[i- 1]);
end
FullAdder1bit adderfinal (result[31], carryout, operandA[31], operandB[31], subtract, carryout);

`XOR overflowdetection(overflow, carryoutmid[30], carryout);

`NOR zeroinit(zeromid[0], result[0], result[1]);

genvar j;
for (j = 0; j < 29; j = j + 1) begin
	`NOR (zeromid[j + 1],  zeromid[j], result[j + 1]);
end

`NOR (zero, zeromid[30], result[31]);
endmodule

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

//doesn't need to set a flag
assign carryout = 0;
assign zero = 0;
assign overflow = 0;

endmodule

//the set-less-than command, uses the 32-bit subtractor
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

//set invertB to 1 because subtraction is needed
AddSub subtractor (subresult, subcarryout, subzero, suboverflow, operandA, operandB, 1);

assign result = 32'b0;

`XOR final (result[0], subresult[0], suboverflow);

//doesn't need to set a flag
assign carryout = 0;
assign zero = 0;
assign overflow = 0;

endmodule

module alu32bitandn
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input         othercontrolsignal
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
    `XOR final (result[j], othercontrolsignal, interresult[j]);
  end
endgenerate

//doesn't need to set a flag
assign carryout = 0;
assign zero = 0;
assign overflow = 0;

endmodule

module NOROR
(
output[31:0] result,
output carryout,
output zero,
output overflow,
input[31:0] operandA,
input[31:0] operandB,
input invertnor
);

wire norres[31:0];
genvar i;
for (i = 0; i < 32; i = i + 1) begin
	`NOR norgate (norres[i], operandA[i], operandB[i]);
end

genvar j;
for (j = 0; j < 32; j = j + 1) begin
	`XOR final (result[j], invertnor, norres[j]);
end

buf setcarryout (carryout, 'b0);
buf setzero (zero, 'b0);
buf setoverflow (overflow, 'b0);
endmodule

// defining command numbers
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

// implementing a control logic LUT to determine ALU operation
module ALUcontrolLUT
(
output reg[2:0] 	muxindex,
output reg	invertB,
output reg	othercontrolsignal,
input[2:0]	ALUcommand
);

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin muxindex = 0; invertB=0; othercontrolsignal = 0; end
      `SUB:  begin muxindex = 0; invertB=1; othercontrolsignal = 0; end
      `XOR:  begin muxindex = 1; invertB=0; othercontrolsignal = 0; end
      `SLT:  begin muxindex = 2; invertB=0; othercontrolsignal = 0; end
      `AND:  begin muxindex = 3; invertB=0; othercontrolsignal = 0; end
      `NAND: begin muxindex = 3; invertB=0; othercontrolsignal = 1; end
      `NOR:  begin muxindex = 4; invertB=0; othercontrolsignal = 1; end
      `OR:   begin muxindex = 4; invertB=0; othercontrolsignal = 0; end
    endcase
  end
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
	// Your code here
endmodule
