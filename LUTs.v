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

`define ADD/SUB 3'd0
`define XOR 3'd1
`define SLT 3'd2
`define AND/NAND 3'd3
`define NOR/OR 3'd4

module ALUoutputLUT
(
input[2:0] muxindex,
input invertB,
input othercontrolsignal,
output[31:0] result,
output carryout,
output overflow,
output zero
);
wire resAddsub[31:0];
wire resXor[31:0];
wire resSlt[31:0];
wire resAndnand[31:0];
wire resNoror[31:0];

32bit_addsub dut (resAddsub, carryout, zero, overflow, operandA, operandB, invertB);
32bit_xor dut (resXor, carryout, zero, overflow, operandA, operandB);
32bit_slt dut (resSlt, carryout, zero, overflow, operandA, operandB);
32bit_andnand dut (resAndnand, carryout, zero, overflow, operandA, operandB, othercontrolsignal);
32bit_andnand dut (resNoror, carryout, zero, overflow, operandA, operandB, othercontrolsignal);

  always @(muxindex) begin
    case(muxindex)
      `ADD/SUB: begin result = resAddsub; end
      `XOR: begin result = ; end
      `SLT: begin result = ; end
      `AND/NAND: begin result = ; end
      `NOR/OR: begin result = ; end
    endcase
  end
endmodule
