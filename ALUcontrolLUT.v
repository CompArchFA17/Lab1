// `define ADD  3'd0
// `define SUB  3'd1
// `define XOR  3'd2
// `define SLT  3'd3
// `define AND  3'd4
// `define NAND 3'd5
// `define NOR  3'd6
// `define OR   3'd7

module ALUcontrolLUT
(
output reg ADD, SUB, XOR, SLT, AND, NAND, NOR, OR,
input[2:0] ALUcommand
);

  always @(ALUcommand) begin
    case (ALUcommand)
      3'd0: begin {ADD, SUB, XOR, SLT, AND, NAND, NOR, OR} = 8'b10000000; end
      3'd1: begin {ADD, SUB, XOR, SLT, AND, NAND, NOR, OR} = 8'b01000000; end
      3'd2: begin {ADD, SUB, XOR, SLT, AND, NAND, NOR, OR} = 8'b00100000; end
      3'd3: begin {ADD, SUB, XOR, SLT, AND, NAND, NOR, OR} = 8'b00010000; end
      3'd4: begin {ADD, SUB, XOR, SLT, AND, NAND, NOR, OR} = 8'b00001000; end
      3'd5: begin {ADD, SUB, XOR, SLT, AND, NAND, NOR, OR} = 8'b00000100; end
      3'd6: begin {ADD, SUB, XOR, SLT, AND, NAND, NOR, OR} = 8'b00000010; end
      3'd7: begin {ADD, SUB, XOR, SLT, AND, NAND, NOR, OR} = 8'b00000001; end
    endcase
  end
endmodule
