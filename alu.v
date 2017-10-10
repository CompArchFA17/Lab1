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
  wire[31:0] res_premux;
  ALU1bit a1(res_premux[0], cout[0], operandA[0], operandB[0], 0, command);
  ALU1bit a2(res_premux[1], cout[1], operandA[1], operandB[1], cout[0], command);
  ALU1bit a3(res_premux[2], cout[2], operandA[2], operandB[2], cout[1], command);
  ALU1bit a4(res_premux[3], cout[3], operandA[3], operandB[3], cout[2], command);
  ALU1bit a5(res_premux[4], cout[4], operandA[4], operandB[4], cout[3], command);
  ALU1bit a6(res_premux[5], cout[5], operandA[5], operandB[5], cout[4], command);
  ALU1bit a7(res_premux[6], cout[6], operandA[6], operandB[6], cout[5], command);
  ALU1bit a8(res_premux[7], cout[7], operandA[7], operandB[7], cout[6], command);
  ALU1bit a9(res_premux[8], cout[8], operandA[8], operandB[8], cout[7], command);
  ALU1bit a10(res_premux[9], cout[9], operandA[9], operandB[9], cout[8], command);
  ALU1bit a11(res_premux[10], cout[10], operandA[10], operandB[10], cout[9], command);
  ALU1bit a12(res_premux[11], cout[11], operandA[11], operandB[11], cout[10], command);
  ALU1bit a13(res_premux[12], cout[12], operandA[12], operandB[12], cout[11], command);
  ALU1bit a14(res_premux[13], cout[13], operandA[13], operandB[13], cout[12], command);
  ALU1bit a15(res_premux[14], cout[14], operandA[14], operandB[14], cout[13], command);
  ALU1bit a16(res_premux[15], cout[15], operandA[15], operandB[15], cout[14], command);
  ALU1bit a17(res_premux[16], cout[16], operandA[16], operandB[16], cout[15], command);
  ALU1bit a18(res_premux[17], cout[17], operandA[17], operandB[17], cout[16], command);
  ALU1bit a19(res_premux[18], cout[18], operandA[18], operandB[18], cout[17], command);
  ALU1bit a20(res_premux[19], cout[19], operandA[19], operandB[19], cout[18], command);
  ALU1bit a21(res_premux[20], cout[20], operandA[20], operandB[20], cout[19], command);
  ALU1bit a22(res_premux[21], cout[21], operandA[21], operandB[21], cout[20], command);
  ALU1bit a23(res_premux[22], cout[22], operandA[22], operandB[22], cout[21], command);
  ALU1bit a24(res_premux[23], cout[23], operandA[23], operandB[23], cout[22], command);
  ALU1bit a25(res_premux[24], cout[24], operandA[24], operandB[24], cout[23], command);
  ALU1bit a26(res_premux[25], cout[25], operandA[25], operandB[25], cout[24], command);
  ALU1bit a27(res_premux[26], cout[26], operandA[26], operandB[26], cout[25], command);
  ALU1bit a28(res_premux[27], cout[27], operandA[27], operandB[27], cout[26], command);
  ALU1bit a29(res_premux[28], cout[28], operandA[28], operandB[28], cout[27], command);
  ALU1bit a30(res_premux[29], cout[29], operandA[29], operandB[29], cout[28], command);
  ALU1bit a31(res_premux[30], cout[30], operandA[30], operandB[30], cout[29], command);
  ALU1bit a32(res_premux[31], carryout, operandA[31], operandB[31], cout[30], command);
  xor(overflow, carryout, cout[30]);


  wire[7:0] resMux0 = {res_premux[0], res_premux[0], res_premux[0], res_premux[0], res_premux[31], res_premux[0], res_premux[0], res_premux[0]};
  MUX3bit mux0(result[0], command, resMux0);
  wire[7:0] resMux1 = {res_premux[1], res_premux[1], res_premux[1], res_premux[1], 1'b0, res_premux[1], res_premux[1], res_premux[1]};
  MUX3bit mux1(result[1], command, resMux1);
  wire[7:0] resMux2 = {res_premux[2], res_premux[2], res_premux[2], res_premux[2], 1'b0, res_premux[2], res_premux[2], res_premux[2]};
  MUX3bit mux2(result[2], command, resMux2);
  wire[7:0] resMux3 = {res_premux[3], res_premux[3], res_premux[3], res_premux[3], 1'b0, res_premux[3], res_premux[3], res_premux[3]};
  MUX3bit mux3(result[3], command, resMux3);
  wire[7:0] resMux4 = {res_premux[4], res_premux[4], res_premux[4], res_premux[4], 1'b0, res_premux[4], res_premux[4], res_premux[4]};
  MUX3bit mux4(result[4], command, resMux4);
  wire[7:0] resMux5 = {res_premux[5], res_premux[5], res_premux[5], res_premux[5], 1'b0, res_premux[5], res_premux[5], res_premux[5]};
  MUX3bit mux5(result[5], command, resMux5);
  wire[7:0] resMux6 = {res_premux[6], res_premux[6], res_premux[6], res_premux[6], 1'b0, res_premux[6], res_premux[6], res_premux[6]};
  MUX3bit mux6(result[6], command, resMux6);
  wire[7:0] resMux7 = {res_premux[7], res_premux[7], res_premux[7], res_premux[7], 1'b0, res_premux[7], res_premux[7], res_premux[7]};
  MUX3bit mux7(result[7], command, resMux7);
  wire[7:0] resMux8 = {res_premux[8], res_premux[8], res_premux[8], res_premux[8], 1'b0, res_premux[8], res_premux[8], res_premux[8]};
  MUX3bit mux8(result[8], command, resMux8);
  wire[7:0] resMux9 = {res_premux[9], res_premux[9], res_premux[9], res_premux[9], 1'b0, res_premux[9], res_premux[9], res_premux[9]};
  MUX3bit mux9(result[9], command, resMux9);
  wire[7:0] resMux10 = {res_premux[10], res_premux[10], res_premux[10], res_premux[10], 1'b0, res_premux[10], res_premux[10], res_premux[10]};
  MUX3bit mux10(result[10], command, resMux10);
  wire[7:0] resMux11 = {res_premux[11], res_premux[11], res_premux[11], res_premux[11], 1'b0, res_premux[11], res_premux[11], res_premux[11]};
  MUX3bit mux11(result[11], command, resMux11);
  wire[7:0] resMux12 = {res_premux[12], res_premux[12], res_premux[12], res_premux[12], 1'b0, res_premux[12], res_premux[12], res_premux[12]};
  MUX3bit mux12(result[12], command, resMux12);
  wire[7:0] resMux13 = {res_premux[13], res_premux[13], res_premux[13], res_premux[13], 1'b0, res_premux[13], res_premux[13], res_premux[13]};
  MUX3bit mux13(result[13], command, resMux13);
  wire[7:0] resMux14 = {res_premux[14], res_premux[14], res_premux[14], res_premux[14], 1'b0, res_premux[14], res_premux[14], res_premux[14]};
  MUX3bit mux14(result[14], command, resMux14);
  wire[7:0] resMux15 = {res_premux[15], res_premux[15], res_premux[15], res_premux[15], 1'b0, res_premux[15], res_premux[15], res_premux[15]};
  MUX3bit mux15(result[15], command, resMux15);
  wire[7:0] resMux16 = {res_premux[16], res_premux[16], res_premux[16], res_premux[16], 1'b0, res_premux[16], res_premux[16], res_premux[16]};
  MUX3bit mux16(result[16], command, resMux16);
  wire[7:0] resMux17 = {res_premux[17], res_premux[17], res_premux[17], res_premux[17], 1'b0, res_premux[17], res_premux[17], res_premux[17]};
  MUX3bit mux17(result[17], command, resMux17);
  wire[7:0] resMux18 = {res_premux[18], res_premux[18], res_premux[18], res_premux[18], 1'b0, res_premux[18], res_premux[18], res_premux[18]};
  MUX3bit mux18(result[18], command, resMux18);
  wire[7:0] resMux19 = {res_premux[19], res_premux[19], res_premux[19], res_premux[19], 1'b0, res_premux[19], res_premux[19], res_premux[19]};
  MUX3bit mux19(result[19], command, resMux19);
  wire[7:0] resMux20 = {res_premux[20], res_premux[20], res_premux[20], res_premux[20], 1'b0, res_premux[20], res_premux[20], res_premux[20]};
  MUX3bit mux20(result[20], command, resMux20);
  wire[7:0] resMux21 = {res_premux[21], res_premux[21], res_premux[21], res_premux[21], 1'b0, res_premux[21], res_premux[21], res_premux[21]};
  MUX3bit mux21(result[21], command, resMux21);
  wire[7:0] resMux22 = {res_premux[22], res_premux[22], res_premux[22], res_premux[22], 1'b0, res_premux[22], res_premux[22], res_premux[22]};
  MUX3bit mux22(result[22], command, resMux22);
  wire[7:0] resMux23 = {res_premux[23], res_premux[23], res_premux[23], res_premux[23], 1'b0, res_premux[23], res_premux[23], res_premux[23]};
  MUX3bit mux23(result[23], command, resMux23);
  wire[7:0] resMux24 = {res_premux[24], res_premux[24], res_premux[24], res_premux[24], 1'b0, res_premux[24], res_premux[24], res_premux[24]};
  MUX3bit mux24(result[24], command, resMux24);
  wire[7:0] resMux25 = {res_premux[25], res_premux[25], res_premux[25], res_premux[25], 1'b0, res_premux[25], res_premux[25], res_premux[25]};
  MUX3bit mux25(result[25], command, resMux25);
  wire[7:0] resMux26 = {res_premux[26], res_premux[26], res_premux[26], res_premux[26], 1'b0, res_premux[26], res_premux[26], res_premux[26]};
  MUX3bit mux26(result[26], command, resMux26);
  wire[7:0] resMux27 = {res_premux[27], res_premux[27], res_premux[27], res_premux[27], 1'b0, res_premux[27], res_premux[27], res_premux[27]};
  MUX3bit mux27(result[27], command, resMux27);
  wire[7:0] resMux28 = {res_premux[28], res_premux[28], res_premux[28], res_premux[28], 1'b0, res_premux[28], res_premux[28], res_premux[28]};
  MUX3bit mux28(result[28], command, resMux28);
  wire[7:0] resMux29 = {res_premux[29], res_premux[29], res_premux[29], res_premux[29], 1'b0, res_premux[29], res_premux[29], res_premux[29]};
  MUX3bit mux29(result[29], command, resMux29);
  wire[7:0] resMux30 = {res_premux[30], res_premux[30], res_premux[30], res_premux[30], 1'b0, res_premux[30], res_premux[30], res_premux[30]};
  MUX3bit mux30(result[30], command, resMux30);
  wire[7:0] resMux31 = {res_premux[31], res_premux[31], res_premux[31], res_premux[31], 1'b0, res_premux[31], res_premux[31], res_premux[31]};
  MUX3bit mux31(result[31], command, resMux31);
endmodule
