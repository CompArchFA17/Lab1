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

`include "alu1bit.v"
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
  wire[31:0] cout;
  ALU1bit a1(result[0], cout[0], operandA[0], operandB[0], 0, command);
  ALU1bit a2(result[1], cout[1], operandA[1], operandB[1], cout[0], command);
  ALU1bit a3(result[2], cout[2], operandA[2], operandB[2], cout[1], command);
  ALU1bit a4(result[3], cout[3], operandA[3], operandB[3], cout[2], command);
  ALU1bit a5(result[4], cout[4], operandA[4], operandB[4], cout[3], command);
  ALU1bit a6(result[5], cout[5], operandA[5], operandB[5], cout[4], command);
  ALU1bit a7(result[6], cout[6], operandA[6], operandB[6], cout[5], command);
  ALU1bit a8(result[7], cout[7], operandA[7], operandB[7], cout[6], command);
  ALU1bit a9(result[8], cout[8], operandA[8], operandB[8], cout[7], command);
  ALU1bit a10(result[9], cout[9], operandA[9], operandB[9], cout[8], command);
  ALU1bit a11(result[10], cout[10], operandA[10], operandB[10], cout[9], command);
  ALU1bit a12(result[11], cout[11], operandA[11], operandB[11], cout[10], command);
  ALU1bit a13(result[12], cout[12], operandA[12], operandB[12], cout[11], command);
  ALU1bit a14(result[13], cout[13], operandA[13], operandB[13], cout[12], command);
  ALU1bit a15(result[14], cout[14], operandA[14], operandB[14], cout[13], command);
  ALU1bit a16(result[15], cout[15], operandA[15], operandB[15], cout[14], command);
  ALU1bit a17(result[16], cout[16], operandA[16], operandB[16], cout[15], command);
  ALU1bit a18(result[17], cout[17], operandA[17], operandB[17], cout[16], command);
  ALU1bit a19(result[18], cout[18], operandA[18], operandB[18], cout[17], command);
  ALU1bit a20(result[19], cout[19], operandA[19], operandB[19], cout[18], command);
  ALU1bit a21(result[20], cout[20], operandA[20], operandB[20], cout[19], command);
  ALU1bit a22(result[21], cout[21], operandA[21], operandB[21], cout[20], command);
  ALU1bit a23(result[22], cout[22], operandA[22], operandB[22], cout[21], command);
  ALU1bit a24(result[23], cout[23], operandA[23], operandB[23], cout[22], command);
  ALU1bit a25(result[24], cout[24], operandA[24], operandB[24], cout[23], command);
  ALU1bit a26(result[25], cout[25], operandA[25], operandB[25], cout[24], command);
  ALU1bit a27(result[26], cout[26], operandA[26], operandB[26], cout[25], command);
  ALU1bit a28(result[27], cout[27], operandA[27], operandB[27], cout[26], command);
  ALU1bit a29(result[28], cout[28], operandA[28], operandB[28], cout[27], command);
  ALU1bit a30(result[29], cout[29], operandA[29], operandB[29], cout[28], command);
  ALU1bit a31(result[30], cout[30], operandA[30], operandB[30], cout[29], command);
  ALU1bit a32(result[31], carryout, operandA[31], operandB[31], cout[30], command);
  xor(overflow, carryout, cout[30]);

endmodule
