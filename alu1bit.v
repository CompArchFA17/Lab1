// ALU1bit is a 31-Bit arithmetic logic unit
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
  output      result,
  output      carryout,
  input       operandA,
  input       operandB,
  input[2:0]  command
);
  // Your code here
endmodule
