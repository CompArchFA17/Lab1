// ALU is a 32-Bit arithmetic logic unit
// It performs the following operations:
// b000 -> ADD
// b001 -> SUB
// b010 -> XOR
// b011 -> SLT
// b100 -> AND
// b101 -> NAND

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
  // Your code here
endmodule
