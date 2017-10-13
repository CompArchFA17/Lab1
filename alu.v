`include "gates.v"
`include "alu1bit.v"

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module ALUcontrolLUT
(
  output reg[2:0] muxindex,
  output reg      invertA,
  output reg      invertB,
  input[2:0]      ALUcommand
);
  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin muxindex = 0; invertA = 0; invertB = 0; end    
      `SUB:  begin muxindex = 0; invertA = 0; invertB = 1; end
      `XOR:  begin muxindex = 1; invertA = 0; invertB = 0; end    
      `SLT:  begin muxindex = 2; invertA = 0; invertB = 1; end
      `AND:  begin muxindex = 3; invertA = 0; invertB = 0; end    
      `NOR:  begin muxindex = 3; invertA = 1; invertB = 1; end    
      `OR:   begin muxindex = 4; invertA = 0; invertB = 0; end
      `NAND: begin muxindex = 4; invertA = 1; invertB = 1; end
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

  wire set;
  wire invertA;
  wire invertB;
  wire[2:0] operation;
  wire[31:0] carryins;

  ALUcontrolLUT control(operation, invertA, invertB, command);

  generate
    genvar i;
    for (i=0; i<31; i=i+1) begin
      if (i == 0)
        ALU1bit bitSliceALU(
          result[i],
          carryins[i+1],
          operation,
          operandA[i],
          operandB[i],
          invertA,
          invertB,
          invertB,
          set
        );
      else
        ALU1bit bitSliceALU(
          result[i],
          carryins[i+1],
          operation,
          operandA[i],
          operandB[i],
          invertA,
          invertB,
          carryins[i],
          1'b0
        );
    end
  endgenerate

  ALU1bitMSB lastBit(
    result[31],
    carryout,
    overflow,
    set,
    operation,
    operandA[31],
    operandB[31],
    invertA,
    invertB,
    carryins[31],
    1'b0
  );

endmodule
