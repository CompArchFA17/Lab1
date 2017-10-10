`define AND and #20
`define OR or #20
`define XOR xor #20 //????
`define NOT not #10
`define NAND nand #10
`define NOR nor #10

`include "multiplexer.v"
`include "AddSub.v"

module BitSliceALU
(
  output ALUout,
  output Cout,
  input invertB,
  input Cin,
  input[2:0] addr,
  input bit1, bit2
);
  wire Cout;
  wire [7:0] out;

  structAddSub structadder(out[0], Cout, bit1, bit2, invertB, Cin);

  wire nored, nanded;

  `XOR (out[1], bit1, bit2);

  `NAND (nanded, bit1, bit2);
  `XOR (out[2], invertB, nanded);

  `NOR (nored, bit1, bit2);
  `XOR (out[3], invertB, nored);

  //`XOR (out[2], bit1, bit2);
  /*wire sum, Cout;

  structAddSub structadder(out[2], Cout, bit1, bit2, invertB, Cin);

  assign out[0] = bit1;
  assign out[1] = bit2;*/
  //assign out[7:0] = 8'b0;

  structuralMultiplexer opmux(ALUout, addr, out); //Can potentially change the mux to be 4 input
endmodule


module ALUcontrolLUT
(
output reg[2:0] muxindex,
output reg	invertB,
output reg	flagger,
input[2:0]	ALUcommand
);

  always @(ALUcommand) begin
    case (ALUcommand)
      `opADD:  begin muxindex = 0; invertB=0; flagger = 1; end
      `opSUB:  begin muxindex = 0; invertB=1; flagger = 1; end
      `opXOR:  begin muxindex = 1; invertB=0; flagger = 0; end
      `opSLT:  begin muxindex = 0; invertB=0; flagger = 0; end
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
input[2:0]    command,
//input         invertB,
//input         flagger
);
  //wire control2;
  wire overflow;
  wire[31:0] Cout;
  reg invertB; 
  reg flagger; 
  reg muxindex;
  //integer i = 0;
  //for the 0th bit slice, pass in invertB for Cin too (add one if subtracting)
  BitSliceALU bit0(result[0], Cout[0], invertB, invertB, mux, operandA[0], operandB[0]);
  ALUcontrolLUT ctrl(muxindex, invertB, flagger, command);
  genvar i;
  generate
    for (i = 1; i < 32; i = i+1)
    begin: ripple
      BitSliceALU bit(result[i], Cout[i], invertB, Cout[i-1], mux, operandA[i], operandB[i]);
    end
  endgenerate
  //BitSliceALU bit31(result[31], Cout[31], invertB, Cout[30], mux, operandA[31], operandB[31]);

  assign zero = ^result; //a bit wise OR on all bits of result, might not be allowed to do this
  `XOR (overflow, Cout[31], Cout[30]);
endmodule
