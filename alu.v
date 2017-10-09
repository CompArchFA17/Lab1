// ALU is a 32-Bit arithmetic logic unit
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
 	
  // supose we're jsut doing Addition for now
  /*wire[31:0] cout;
  initial begin
  	for (index = 0; index < 32; index = index + 1)
  		//ALU1bit(result[index], cout[index], operandA[index], operandB[index], cin //(result[index], carryout, operandA[index], operandB[index], carryout);
  end*/
  // TODO: XOR(overflow, carryout, )


  // ALU1bit alu()
  // not sure how to use this yet
endmodule


module ALUcontrolLUT
(
output reg[2:0] 	muxindex,
output reg	invertB,
output reg	othercontrolsignal,
input[2:0]	ALUcommand
)

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin muxindex = 0; invertB=0; othercontrolsignal = ?; end    
      `SUB:  begin muxindex = 0; invertB=1; othercontrolsignal = ?; end
      `XOR:  begin muxindex = 1; invertB=0; othercontrolsignal = ?; end    
      `SLT:  begin muxindex = 2; invertB=?; othercontrolsignal = ?; end
      `AND:  begin muxindex = 3; invertB=0; othercontrolsignal = ?; end    
      `NAND: begin muxindex = 3; invertB=0; othercontrolsignal = ?; end
      `NOR:  begin muxindex = ?; invertB=0; othercontrolsignal = ?; end    
      `OR:   begin muxindex = ?; invertB=0; othercontrolsignal = ?; end
    endcase
  end
endmodule