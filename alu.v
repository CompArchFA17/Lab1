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
