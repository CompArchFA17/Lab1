`define AND and #20
`define OR or #20
`define XOR xor #20 //????
`define NOT not #10
`define NAND nand #10
`define NOR nor #10

`define opADD  3'd0
`define opSUB  3'd1
`define opXOR  3'd2
`define opSLT  3'd3
`define opAND  3'd4
`define opNAND 3'd5
`define opNOR  3'd6
`define opOR   3'd7

`include "multiplexer.v"
`include "AddSub.v"
`include "TheBigOR.v"

module BitSliceALU
(
  output ALUout,
  output Cout,
  input invertB,
  input Cin,
  input[1:0] addr,
  input bit1, bit2
);
  //wire Cout;
  wire [3:0] out;

  structAddSub structadder(out[0], Cout, bit1, bit2, invertB, Cin);

  wire nored, nanded;

  `XOR (out[1], bit1, bit2);

  `NAND (nanded, bit1, bit2);
  `XOR (out[2], invertB, nanded);

  `NOR (nored, bit1, bit2);
  `XOR (out[3], invertB, nored);

  Multiplexer2 opmux(ALUout, addr, out); //Can potentially change the mux to be 4 input
endmodule


module ALUcontrolLUT
(
output reg[1:0] muxindex,
output reg	invertB,
output reg	flagger,
input[2:0]	ALUcommand
);

  always @(ALUcommand) begin
    case (ALUcommand)
      `opADD:  begin muxindex = 0; invertB=0; flagger = 1; end
      `opSUB:  begin muxindex = 0; invertB=1; flagger = 1; end
      `opXOR:  begin muxindex = 1; invertB=0; flagger = 0; end
      `opSLT:  begin muxindex = 0; invertB=1; flagger = 0; end
      `opAND:  begin muxindex = 2; invertB=1; flagger = 0; end
      `opNAND: begin muxindex = 2; invertB=0; flagger = 0; end
      `opNOR:  begin muxindex = 3; invertB=0; flagger = 0; end
      `opOR:   begin muxindex = 3; invertB=1; flagger = 0; end
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
//input         invertB,
//input         flagger
);
  //wire control2;
  wire[31:0] Cout;
  wire slt;
  wire isSlt;
  wire nSlt;
  wire invertB;
  wire flagger;
  wire[1:0] muxindex;
  wire muxidec;
  wire[31:0] preresult;
  wire preflow;
  wire nzero;

  //integer i = 0;
  //for the 0th bit slice, pass in invertB for Cin too (add one if subtracting)
  ALUcontrolLUT ctrl(muxindex, invertB, flagger, command);
  BitSliceALU bit0(preresult[0], Cout[0], invertB, invertB, muxindex, operandA[0], operandB[0]);

  genvar i;
  generate
    for (i = 1; i < 32; i = i+1)
    begin: ripple
      BitSliceALU bitany(preresult[i], Cout[i], invertB, Cout[i-1], muxindex, operandA[i], operandB[i]);
    end
  endgenerate
  //BitSliceALU bit31(result[31], Cout[31], invertB, Cout[30], mux, operandA[31], operandB[31]);
  TheBigOR bigger(nzero, preresult); //a bit wise OR on all bits of result, might not be allowed to do this
  `XOR (preflow, Cout[31], Cout[30]); //determine overflow

  `NOT (zero, nzero); //set zero for each operation
  `AND (carryout, flagger, Cout[31]); //set carryout if flagger
  `AND (overflow, flagger, preflow); //set overflow if flagger
  //`OR(overflow, preflow, 1'b0);

  //Set SLT if the mux command is 3
  bitMultiplexer sltSL(slt, preflow, {operandA[31], preresult[31]}); //compute is less than
  `OR (muxidec, muxindex[0], muxindex[1]); //test if muxindex is 0
  `NOR (isSlt, flagger, muxidec); //test if muxindex and flagger is zero, in which case it is SLT
  bitMultiplexer sltOut(result[0], isSlt, {slt, preresult[0]}); //Set the first bit to be SLT value 

  //Change the rest of the bits to 0 if SLT
  `NOT (nSlt, isSlt);
  genvar j;
  generate
  	for (j = 1; j < 32; j = j + 1)
  	begin: SLTSet
  		`AND (result[j], nSlt, preresult[j]); //This and operation changes the bit to 0 if nSlt is false, and keeps the result otherwise.
  	end
  endgenerate
endmodule
